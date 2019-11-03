class ActiveSupport::TestCase
  include FactoryBot::Syntax::Methods
  include ActiveJob::TestHelper
  include Rack::Mime
  extend MiniTest::Spec::DSL

  ActiveRecord::Migration.check_pending!

  def self.context(*args, &block)
    describe(*args, &block)
  end

  def setup
    Draper::ViewContext.clear!
  end

  def self.has_routes
    include Rails.application.routes.url_helpers
  end

  def self.let!(name, &block)
    let(name, &block)
    instance_eval { setup { send(name) } }
  end

  def self.partner_suite!(employer_options = {})
    let(:employer) { create :employer, :with_company, employer_options }
    let(:employment) { employer.employments.first }
    let(:company) { provider.companies.first }
    let(:provider) { employer.providers.first }
    let(:provider_accounts) { provider.provider_accounts }
    let(:employees) { provider.employees }
    let(:employee) { employees.first }
    let(:provider_account) { employee.provider_accounts.first }
    let(:first_provider_account) { provider_account }
    let(:employee_profile) { provider_account.profile }
    let(:payroll_journal) { create :payroll_journal, provider: provider }
    let(:payroll_headers) do
      [create(:synonym, key: :net_pay, synonyms: ['net_pay']),
       create(:synonym, key: :gross_pay, synonyms: ['gross_pay']),
       create(:synonym, key: :external_id, synonyms: ['external_id']),
       create(:synonym, key: :pay_group, synonyms: ['pay_group'])]
    end
    let(:preference_manager) { employer.preference_manager }
    let(:transmission) { create :transmission, company: company, creator: employer, spreadsheet_earnings_type: company.spreadsheet_earnings_type }
    let(:brick_account) { BrickAccount.stub_instances(create_user_account!: true) { create :brick_account, provider: provider, username: 'terry@trydailypay.com', external_id: 1, sandbox_external_id: 2 } }
    let(:transmission) { create :transmission, provider: provider, creator: employer, spreadsheet_earnings_type: provider.spreadsheet_earnings_type }
    let(:add_paid_advance) { create :advance, provider_account: provider_account, pay_period: pay_period, status: :paid }
    let(:pay_period) { create :pay_period, provider_account: provider_account }
  end

  def random_phone_number
    rand(2_000_000_000..9_999_999_999).to_s
  end

  def spreadsheet_transmission_current_at
    '2017-01-15 12:00:00'.to_time
  end

  def spreadsheet_transmission_archived_at
    '2017-01-21 12:00:00'.to_time
  end

  def teardown
    WebMock.reset!
    Rails.cache.clear
  end

  def mailer_jobs
    enqueued_jobs.select { |j| j[:job] == ActionMailer::DeliveryJob }
  end

  def assert_enqueued
    assert enqueued_jobs.count.positive?
  end

  def refute_enqueued
    assert_equal 0, enqueued_jobs.count
  end

  def login_as(user, two_factor_authenticate: true)
    @request.session[:auth_session_token] = user.auth_session_token

    # This will make sure the tests always get around two factor authentication.
    user.update(two_factor_authenticated_at: 10.minutes.ago) if two_factor_authenticate

    if user.admin?
      @request.session[:admin_user_id] = user.id
    elsif user.auditor?
      @request.session[:auditor_user_id] = user.id
    elsif user.employer?
      @request.session[:employer_user_id] = user.id
      @request.session[:partner_portal] = {}
    else
      @request.session[:user_id] = user.id
    end
  end

  # use this for all ActionDispatch test
  def login_as_session(user)
    params = { session: { email: user.email, password: user.password } }
    url = user.strong_admin? ? backend_test_env_sessions_url : sessions_url
    post url, params: params
  end

  def login_as_adp_session(user)
    pa = user.provider_accounts.first
    pa.update(external_id: 'ABC000123')
    pa.company.update(pay_group: 'ABC')
    pa.provider.update(adp_organization_oid: 'OOID')
    resp = { body: { associate_oid: 'AOID', organization_oid: 'OOID', work_assignments: [{ "user_id" => "ABC000123", "pay_group" => "ABC", "payroll_file_number" => "000123", "annual_salary" => 50000.0, "employment_start_date" => "2019-01-01", "status" => "active" }] } }
    ADPRise::Request.stub_any_instance :fetch_consumer_info, resp do
      ADPRise::Request.stub_any_instance :fetch_earnings, status: 200 do
        get sessions_adp_url(subdomain: 'myadp'), params: { code: 'SSO_TOKEN' }
      end
    end
  end

  def logout_of_session
    get logout_url
  end

  def add_product_fees_to(provider)
    fees = {
      auto_next: 0.99,
      auto_now: 2.49,
      manual_next: 0.99,
      manual_now: 2.99
    }.with_indifferent_access

    Product.all.each do |product|
      FactoryBot.create(:product_fee, product: product, provider: provider, total_amount: fees[product.code].to_money, description: "#{product.description} Fee")
    end
  end

  def add_ach_debit_to_provider
    debit = employee.payments.ach.create(total_amount: -1000, status: 'paid')
    provider_account.advances.paid.create(total_amount: -1000, pay_period_id: pay_period.id, payment_id: debit.id)
  end

  def add_account_to_profile(employee_profile)
    employee_profile.provider_accounts.create(provider: employee_profile.provider, user: employee_profile.user)
  end

  def add_document_to_provider(provider)
    document = File.open Rails.root.join('test', 'mocks', 'document.zip')
    create :document, provider: provider, file: document, category: "partner_resource"
  end

  def add_icon_to_provider(provider)
    provider.update_attributes(icon: File.open(Rails.root.join('test', 'mocks', 'test-image.png')))
  end

  def add_company_to_provider(provider)
    create :company, provider: provider
  end

  def add_provider_to_employer(employer, provider_accounts: 0)
    first_provider = employer.providers.first
    second_provider = begin
      second_employer = create(:employer, :with_company, provider_accounts: provider_accounts)
      second_provider = second_employer.providers.first
      employer.providers << second_provider
      second_provider
    end
    second_provider.update_attributes(product_type: first_provider.product_type) if first_provider.present?
    second_provider
  end

  def set_to_demo_account(provider_account)
    provider_account.update_attributes(external_id: 'demo')
    provider_account.user.update_attributes(first_name: 'demo', last_name: 'user', email: "demo@#{provider.name.parameterize}.trydailypay.com")
  end

  def set_to_employer_cancelable(provider_account)
    provider_account.update_attributes(status: :canceled, bank_link_status: :verified)
    provider_account.user.update_attributes(status: :canceled)
    provider_account.profile.update_attributes(direct_deposit_confirmed_at: Time.current, direct_deposit_canceled_at: nil)
  end

  def add_parsing_to_provider(provider)
    provider.update_attributes(operator: '+', missing_headers: ['date'], transmission_regex: (create :transmission_regex))
  end

  def set_to_employer_activatable(provider_account, status: :active, pay_period_status: :unsettled)
    provider_account.update_attributes(status: status)
    provider_account.user.update_attributes(status: status)
    provider_account.profile.update_attributes(direct_deposit_confirmed_at: nil, direct_deposit_canceled_at: nil)
    pay_period = create :pay_period, provider_account: provider_account, ends_at: 4.working.days.ago, status: pay_period_status
    create :advance, status: :paid, pay_period: pay_period
  end

  def set_to_reactivatable(provider_account)
    provider_account.update_attributes(status: :canceled, activated_at: 1.year.ago, login_status: :verified, bank_link_status: :unverified)
    provider_account.user.update_attributes(status: :canceled, activated_at: 1.year.ago)
    provider_account.profile.update_columns(direct_deposit_confirmed_at: 1.year.ago, direct_deposit_canceled_at: 1.year.ago)
  end

  def set_to_self_signup_activatable(provider_account)
    provider_account.user.update_columns(activated_at: nil, status: :pending, terms_accepted_at: Time.current)
    provider_account.update_attributes(status: :pending, login_status: :verified, bank_link_status: :pre_verified, external_id: '12345', created_at: 4.working.days.ago)
  end

  def set_to_activatable(provider_account, user_status = :pending)
    provider_account.update_columns(status: :pending, login_status: :verified, activated_at: nil, bank_link_status: :verified)
    provider_account.user.update_columns(status: user_status, activated_at: nil)
  end

  def set_to_advanceable(provider_account)
    provider_account.update_attributes(activated_at: Time.current, login_status: :verified, bank_link_status: :verified, status: :active)
  end

  def set_to_randomized_actionable(provider_account)
    [-> { set_to_employer_activatable(provider_account) }, -> { set_to_employer_cancelable(provider_account) }].
      sample.call
  end

  def set_to_company_employment(employer)
    provider # init
    provider = employer.providers.first
    provider.employments.destroy_all
    employer.companies << provider.companies.first
  end

  def attachment_image
    image = Rack::Test::UploadedFile.new(Rails.root.join('app', 'assets', 'images', 'with_dp.png'))
    image.content_type = 'image/png'
    image
  end

  def attachment_document
    document = Rack::Test::UploadedFile.new(Rails.root.join('test', 'mocks', 'document.zip'))
    document.content_type = 'application/zip'
    document
  end

  def attachment_transmission
    transmission = Rack::Test::UploadedFile.new(Rails.root.join('test', 'mocks', 'spreadsheet', 'transmissions', 'vandelay.csv'))
    transmission.content_type = 'text/csv'
    transmission
  end

  def search_and_return(query, user, only_include = false, is_for_nonhuman = false)
    process :search, method: :get, params: { q: query }, format: :json
    query_result = JSON[response.body].map do |i|
      i['id']
    end
    # remove any admins that have been returned if searching for users
    query_result -= Admin.pluck(:id) unless is_for_nonhuman
    if only_include
      query_result.must_include user.try(:id)
    else
      query_expectation = [user.try(:id)].compact
      assert_equal query_expectation, query_result
    end
  end

  def create_with_fixed_fields(attribute_assignments = {})
    create( :user, { email: 'xxxxxxxxxx@xxxxx.biz', first_name: 'xxxxxxxx', last_name: 'xxxxxxxxx', phone_number: '2453324533' }
                    .merge(attribute_assignments))
  end

  def authorize(user, password)
    @request.env['HTTP_AUTHORIZATION'] = ActionController::HttpAuthentication::Basic.encode_credentials(user, password)
  end

  def authenticate_provider(provider)
    @request.headers['X-API-Key'] = provider.api_key
  end

  def stub_request_json(path, body, status: 200)
    WebMock.stub_request(:get, path).
      to_return(status: status, headers: { 'Content-Type' => 'application/json' }, body: body)
  end

  def stub_slack_request
    WebMock.stub_request(:post, ENV['EXCEPTION_NOTIFIER_URL']).
      to_return(status: 200, body: '', headers: {})
  end

  def stub_pagerduty_request
    WebMock.stub_request(:post, "https://events.pagerduty.com/generic/2010-04-15/create_event.json").
      to_return(status: 200, body: { status: 'success' }.to_json, headers: {})
  end

  def stub_brick_valid_request(remote_url, destination_path)
    ENV['BRICK_FTP_API_KEY'] = 'brick_key'
    WebMock.stub_request(:get, "https://app.brickftp.com/api/rest/v1/files/#{destination_path}")
           .with(basic_auth: ['brick_key', "x"])
           .to_return(status: 200, headers: { 'Content-Type' => 'text/json' }, body: "{\"download_uri\":\"#{remote_url}\"}")
  end

  def stub_amazon_valid_request(remote_url, file_path)
    WebMock.stub_request(:get, remote_url).
      to_return(status: 200, body: File.read(file_path))
  end

  def stub_geocoder_request
    WebMock.stub_request(:get, "http://api.geocod.io/v1.2/geocode?api_key=#{ENV['GEOCODIO_KEY']}&fields=timezone&q=27-55%20Jackson%20Avenue,%20New%20York,%2011101").
      to_return(status: 200, body: File.read(Rails.root.join('test', 'mocks', 'geocoder_results.json')))
  end

  def stub_geocoder_request_without_address
    WebMock.stub_request(:get, "http://api.geocod.io/v1.2/geocode?api_key=877752d7d6352282ec5ecce266876dfe27766a7&fields=timezone&q=blank,%20New%20York,%20NY%2010005").
      to_return(status: 200, body: File.read(Rails.root.join('test', 'mocks', 'geocoder_results_without_address.json')))
  end

  def stub_pacific_geocoder_request
    WebMock.stub_request(:get, "http://api.geocod.io/v1.2/geocode?api_key=#{ENV['GEOCODIO_KEY']}&fields=timezone&q=209%20Sanchez,%20San%20Francisco%20CA,%2094117").
      to_return(status: 200, body: File.read(Rails.root.join('test', 'mocks', 'geocoder_results_pacific.json')))
  end

  def process_without_geocode(*args)
    User.stub_any_instance :geocode, nil do
      process(*args)
    end
  end

  def with_dup_checker_callbacks
    $run_dup_callbacks = true
    yield
    $run_dup_callbacks = false
  end

  def assert_enqueued_job(job_type)
    assert enqueued_jobs.any? { |ej| ej[:job] == job_type }, "#{job_type} not enqueued"
  end

  def refute_enqueued_job(job_type)
    refute enqueued_jobs.any? { |ej| ej[:job] == job_type }, "#{job_type} was enqueued"
  end

  def assert_rendered(string)
    assert response.body.include?(string), "#{string} not rendered"
  end

  def refute_rendered(string)
    refute response.body.include?(string), "#{string} was rendered"
  end

  def assert_enqueued_mailer(mail_type, with: {})
    enqueued_mailer = enqueued_jobs.detect { |ej| ej[:args].include?(mail_type.to_s) }
    assert_predicate enqueued_mailer, :present?
    if with.present?
      args = enqueued_mailer[:args].last.with_indifferent_access
      with.each { |k, v| assert_equal v, args[k] }
    end
  end

  def refute_enqueued_mailer(mail_type)
    refute enqueued_jobs.any? { |ej| ej[:args].include? mail_type.to_s }
  end

  def assert_enqueued_mailer_text(search_text)
    all_mailer_text = enqueued_jobs.map { |job| job[:args] }.join(" ")
    assert_includes all_mailer_text, search_text
  end

  def refute_enqueued_mailer_text(search_text)
    all_mailer_text = enqueued_jobs.map { |job| job[:args] }.join(" ")
    refute_includes all_mailer_text, search_text
  end

  def refute_text_rendered(text, elem: 'html')
    refute Nokogiri::HTML.parse(response.body).search(elem).text.include?(text), "#{text} text was rendered"
  end

  def assert_text_rendered(text, elem: 'html')
    assert Nokogiri::HTML.parse(response.body).search(elem).text.include?(text), "#{text} text was not rendered"
  end

  def assert_elem_rendered(elem)
    assert Nokogiri::HTML.parse(response.body).search(elem).any?, "#{elem} elem was not rendered"
  end

  def refute_elem_rendered(elem)
    refute Nokogiri::HTML.parse(response.body).search(elem).any?, "#{elem} elem was rendered"
  end

  def assert_notification(name)
    assert enqueued_jobs.any? { |job| job[:job] == SlackNotificationJob && job[:args].second['name'] == name }
  end

  def refute_notification(name)
    refute enqueued_jobs.any? { |job| job[:job] == SlackNotificationJob && job[:args].second['name'] == name }
  end

  def slack_jobs
    enqueued_jobs.select { |j| j[:job] == SlackNotificationJob }
  end

  def assert_slacked(message)
    assert_includes slack_jobs.map { |j| j[:args][0] }.join(" "), message
  end

  def refute_slacked(message)
    refute_includes slack_jobs.map { |j| j[:args][0] }.join(" "), message
  end

  def assert_equal_time(time1, time2)
    assert_in_delta time1, time2, 1.second
  end

  # assert that this mailer can be delivered later and delivered now
  def assert_deliverable(mail_type, mailer)
    mailer.deliver_later
    assert_enqueued_mailer mail_type.to_s
    mailer.deliver_now
    assert_not_nil ActionMailer::Base.deliveries.last
  end

  def assert_changes_true(*changes, &block)
    assert_changes(changes.shift, to: true) do
      changes.any? ? assert_changes_true(*changes, &block) : yield
    end
  end

  def check_called(method_path, assert_or_refute)
    # method name taken as Class#instance_method
    class_name, method_name = *method_path.split('#')
    classy = class_name.constantize
    methy = classy.instance_method(method_name)
    called = false
    classy.class_eval do
      # prepends method to set 'called' to true
      define_method(method_name) { |*args| called = true; methy.bind(self).call(*args) }
    end
    yield
    send(assert_or_refute, called, "#{method_path}#{' not' if assert_or_refute == :assert} called")
  end

  def assert_called(method_path, &block)
    check_called(method_path, :assert, &block)
  end

  def refute_called(method_path, &block)
    check_called(method_path, :refute, &block)
  end

  def stub_referrer(path)
    PartnerPortal::ApplicationController.stub_any_instance :referrer, "http://test.host/#{path}" do
      yield
    end
  end

  def assert_employee_created
    assert_difference -> { User.count } => 1,
                      -> { ProviderAccount.count } => 1,
                      -> { EmployeeProfile.count } => 1,
                      -> { BankAccount.count } => 1 do
      yield
    end
  end

  def assert_attachment_path(attachment)
    # --
    # eg: 2018-01-17_18_59_01_-0500-133606-transmission.csv
    # ++
    postfix = attachment.model.class.model_name.singular
    assert attachment.to_s =~ /#{Time.current.to_s.gsub(/( |:)/, '_')}-\d+-#{ postfix }.(csv|xlsx)/
  end

  def action_dispatch_file(path:)
    UploadedFileCreator.new(
      contents: Rails.root.join(*path.split('/')).read,
      filename: File.basename(path),
      content_type: mime_type(File.extname(File.basename(path)))
    ).create!
  end

  def stub_onboard
    stub_slack_request
    BankNameFetcherJob.stub_any_instance(:perform, nil) do
      yield
    end
  end

  def stub_spreadsheet_invoice
    Spreadsheet::V1::Invoice.stub_instances(company: company, provider_account: provider_account) do
      yield
    end
  end

  def create_archived_payroll_entry(net_pay_amount:, gross_pay_amount:, period_ends_at: Date.current, external_id: '12345', status: nil)
    PresettlementCreatorJob.stub_any_instance(:perform, true) do
      create(:archived_payroll_entry, payroll_journal: payroll_journal, company: company, net_pay_amount: net_pay_amount, gross_pay_amount: gross_pay_amount, period_ends_at: period_ends_at, external_id: external_id, status: status)
    end
  end

  def create_payroll_headers
    [create(:synonym, key: :net_pay, synonyms: ['net_pay']),
     create(:synonym, key: :gross_pay, synonyms: ['gross_pay']),
     create(:synonym, key: :external_id, synonyms: ['external_id']),
     create(:synonym, key: :pay_group, synonyms: ['pay_group']),
     create(:synonym, key: :payday, synonyms: ['payday']),
     create(:synonym, key: :last_four, synonyms: ['last_four'])]
  end

  def create_wells_ach_return_entry(payment: nil, addendum: nil, reason_code: nil)
    OpenStruct.new(
      descriptive_date:  payment&.created_at&.to_date || Date.current,
      user_id:           payment&.user_id || Faker::Number.number(digits: 5),
      user_name:         payment&.user&.name || Faker::Name.first_name + Faker::Name.last_name,
      routing_number:    payment&.receiving_account&.routing_number || VALID_ABA,
      account_number:    payment&.receiving_account&.account_number || Faker::Number.number(digits: 17),
      trace_number:      Faker::Number.number(digits: 6),
      full_trace_number: Faker::Number.number(digits: 8),
      total_amount:      payment&.total_amount || Faker::Number.number(digits: 2),
      addendum:          addendum,
      reason_code:       reason_code || ACHReturnReason::REASONS.keys.sample
    )
  end

  def stub_wells_ach_return_batch_entries(payments)
    entries = payments.map do |payment|
      create_wells_ach_return_entry(payment: payment)
    end
    ACHReturn.stub_any_instance :batch_entries, entries do
      yield
    end
  end

  def stubbed_identity(attributes)
    OpenStruct.new(attributes)
  end

  def add_upload_error_comment(provider)
    comment =
      {
        creator: employer.id,
        ftp: true,
        model_name: 'Transmission',
        errors: {
          attachment: [{ error: "Screen Shot 2018-09-17 at 9.40.50 PM.png is missing the following headers: Name, Amount, Primary Location, and Number" }]
        },
        comment_type: 'upload_error',
        comment_created_at: Time.current.to_s,
        comment_id: SecureRandom.uuid
      }
    provider.write_upload_error_comment(comment)
  end

  def perform_api_invoice_job_now(&block)
    API::InvoiceCreatorJob.stub(:perform_later, -> (opts) { API::InvoiceCreatorJob.perform_now(provider_id: opts[:provider_id],
                                                                                               external_id: opts[:external_id],
                                                                                               pay_group: opts[:pay_group],
                                                                                               shift_body: opts[:shift_body],
                                                                                               run_once_token: opts[:run_once_token] ) }, &block)
  end

  def set_adp_session(sso_token: nil, associate_oid: nil, organization_oid: nil, expires_at: nil, work_assignments: nil)
    session[:adp_session] = { sso_token: sso_token || 'SSO_TOKEN',
                              associate_oid: associate_oid || 'AOID',
                              organization_oid: organization_oid || 'OOID',
                              work_assignments: work_assignments || [{ "user_id" => "ABC000123", "pay_group" => "ABC", "payroll_file_number" => "000123", "annual_salary" => 50000.0, "employment_start_date" => "2019-01-01", "status" => "active" }],
                              expires_at: expires_at || 55.minutes.from_now }
  end
end

require 'rake_task_test_case'
