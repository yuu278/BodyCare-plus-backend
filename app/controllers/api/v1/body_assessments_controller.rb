class Api::V1::BodyAssessmentsController < ApplicationController
  before_action :authenticate_user

  def index
    @body_assessments = current_user.body_assessments.order(created_at: :desc)
    render json: @body_assessments.as_json(
      only: [:id, :pain_area, :pain_types, :duration, :job_types, :exercise_habits, :posture_habits, :created_at]
    )
  end

  def create
    @body_assessment = current_user.body_assessments.build(assessment_params)

    if @body_assessment.save
      render json: @body_assessment, status: :created
    else
      render json: { errors: @body_assessment.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def assessment_params
    params.require(:body_assessment).permit(
      :pain_area,
      :pain_types,
      :duration,
      :job_types,
      :exercise_habits,
      :posture_habits
    )
  end
end
