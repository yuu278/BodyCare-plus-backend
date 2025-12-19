class Api::V1::UserStretchesController < ApplicationController
  before_action :authenticate_user

  def recommended
    latest_assessment = current_user.body_assessments.order(created_at: :desc).first

    unless latest_assessment
      render json: [], status: :ok and return
    end

    stretches = Stretch.flexible_matching(latest_assessment)

    render json: stretches.as_json(
      only: [:id, :name, :description, :target_area, :muscle_info, :video_url]
    )
  end
end
