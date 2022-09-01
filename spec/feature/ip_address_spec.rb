# frozen_string_literal: true

RSpec.describe 'ip address endpoint' do
  before do
    @response = HTTParty.get("#{APP_URL}/ip_addresses")
  end

  it 'is valid' do
    expect(@response.code).to eq(200)
  end
end
