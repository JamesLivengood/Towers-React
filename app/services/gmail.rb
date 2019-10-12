require "google/apis/gmail_v1"
require "googleauth"
require "googleauth/stores/redis_token_store"
require "fileutils"

class Gmail
    OOB_URI = "urn:ietf:wg:oauth:2.0:oob".freeze
    APPLICATION_NAME = "Gmail API Ruby Quickstart".freeze
    SCOPE = Google::Apis::GmailV1::AUTH_GMAIL_READONLY

    def self.labels
        result = new.service.list_user_labels("me")
        puts "Labels:"
        puts "No labels found" if result.labels.empty?
        result.labels.each { |label| puts "- #{label.name}" }
    end

    def service
        service = Google::Apis::GmailV1::GmailService.new
        service.client_options.application_name = APPLICATION_NAME
        service.authorization = credentials
        service
    end

    def self.messages_with_email(email, limit = 3)
        new.service.list_user_messages('me', q: "from:#{email} OR to:#{email}", max_results: 3).try(:messages)
    end

    def self.first_message_with_email(email)
        message_id = messages_with_email(email).first.try(:id)
        return unless message_id
        new.service.get_user_message('me', message_id)
    end

    private

    def credentials
        return @credentials unless !@credentials
        user_id = "mr.nick.oneill@gmail.com"
        @credentials = authorizer.get_credentials user_id
        if credentials.nil?
            url = authorizer.get_authorization_url base_url: OOB_URI
            puts "Open the following URL in the browser and enter the " \
                "resulting code after authorization:\n" + url
            code = gets
            @credentials = authorizer.get_and_store_credentials_from_code(
                user_id: user_id, code: code, base_url: OOB_URI
            )
        end
        @credentials
    end

    def client_id
        @client_id ||= Google::Auth::ClientId.new(
            Rails.application.credentials.dig(:gmail, :api_client, :id),
            Rails.application.credentials.dig(:gmail, :api_client, :secret)
        )
    end

    def token_store
        @token_store ||= Google::Auth::Stores::RedisTokenStore.new(redis: $redis)
    end

    def authorizer
        @authorizer ||= Google::Auth::UserAuthorizer.new client_id, SCOPE, token_store
    end
end

