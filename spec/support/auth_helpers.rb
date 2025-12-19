# spec/support/auth_helpers.rb
module AuthHelpers
  def auth_headers(user)
    token = generate_token(user)
    { 'Authorization' => "Bearer #{token}" }
  end

  def generate_token(user)
    JsonWebToken.encode(user_id: user.id)
  end
end

RSpec.configure do |config|
  config.include AuthHelpers, type: :system
  config.include AuthHelpers, type: :request
end
