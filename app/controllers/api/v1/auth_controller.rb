module Api
  module V1
    class AuthController < ApplicationController
      skip_before_action :authenticate_user, only: [:login, :register, :guest_login]

      def login
        user = User.find_by(email: auth_params[:email])

        if user&.authenticate(auth_params[:password])
          token = JsonWebToken.encode(user_id: user.id)
          render json: {
            token: token,
            user: user.as_json(except: :password_digest)
          }
        else
          render json: {
            error: '認証に失敗しました'
          }, status: :unauthorized
        end
      end

      def register
        user = User.new(user_params)

        if user.save
          token = JsonWebToken.encode(user_id: user.id)
          render json: {
            token: token,
            user: user.as_json(except: :password_digest)
          }, status: :created
        else
          render json: {
            errors: user.errors.full_messages
          }, status: :unprocessable_entity
        end
      end

      def guest_login
        # ゲストユーザーを探す or 作成
        guest_user = User.find_or_create_by(email: 'guest@example.com') do |user|
          user.password = 'guest_password_123'
          user.name = 'ゲストユーザー'
        end

        token = JsonWebToken.encode(user_id: guest_user.id)

        render json: {
          token: token,
          user: guest_user.as_json(only: [:id, :email, :name])
        }
      end

      private

      def auth_params
        source = params[:auth] || params
        source.permit(:email, :password)
      end

      def user_params
        source = params[:user] || params
        source.permit(
          :name,
          :email,
          :password,
          :password_confirmation,
          :age,
          :gender
        )
      end
    end
  end
end
