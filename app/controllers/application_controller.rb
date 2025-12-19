class ApplicationController < ActionController::API
  include ActionController::Cookies

  before_action :authenticate_user

  protected

  def authenticate_user
    header = request.headers['Authorization']
    token = header&.split(' ')&.last

    if token.blank?
      render json: { error: 'トークンが見つかりませんでした' }, status: :unauthorized and return
    end

    begin
      @decoded = JsonWebToken.decode(token)
      @current_user = User.find(@decoded[:user_id])
    rescue ActiveRecord::RecordNotFound => e
      render json: {
        error: 'ユーザーが見つかりません',
        details: e.message
      }, status: :unauthorized
    rescue JWT::DecodeError => e
      render json: {
        error: 'トークンが無効です',
        details: e.message
      }, status: :unauthorized
    end
  end

  def current_user
    @current_user
  end
end
