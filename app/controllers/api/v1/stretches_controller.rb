class Api::V1::StretchesController < ApplicationController
  skip_before_action :authenticate_user, only: [:index, :show]

  # 全ストレッチを取得
  def index
    stretches = Stretch.all

    # エリアでフィルタリング
    stretches = stretches.for_area(params[:area]) if params[:area].present?

    render json: stretches
  end

  # 特定のストレッチを取得
  def show
    stretch = Stretch.find(params[:id])
    render json: stretch
  end
end
