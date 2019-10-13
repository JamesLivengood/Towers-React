require 'rails_helper'

RSpec.describe Broadcast, type: :model do
  it { should respond_to(:tags) }
  it { should respond_to(:send_at) }
  it { should respond_to(:markdown_body) }
end
