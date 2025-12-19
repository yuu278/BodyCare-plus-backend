class Api::V1::UsersController < ApplicationController
  before_action :authenticate_user

  # 現在のユーザー情報を返す専用エンドポイント
  def me
    render json: current_user.as_json(except: :password_digest)
  end

  # 既存の show は ID付きURL用
  def show
    @user = User.find(params[:id])
    render json: @user.as_json(except: :password_digest)
  end

  def update
    @user = current_user
    if @user.update(user_params)
      render json: @user
    else
      render json: { errors: @user.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :age, :gender)
  end
end
