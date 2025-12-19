require 'rails_helper'

RSpec.describe 'BodyAssessment API Flow', type: :system do
  before do
    driven_by(:rack_test)
    @user = create(:user)
  end

  it 'BodyAssessment を POST → 正常に作成できること' do
    assessment_params = {
      body_assessment: {
        pain_area: 'neck',
        pain_types: ['痛み'],
        duration: ['1ヶ月未満'],
        job_types: ['sitting_work'],
        exercise_habits: ['some_exercise'],
        posture_habits: ['hunched_shoulders']
      }
    }

    post "/api/v1/body_assessments",
         params: assessment_params,
         headers: auth_headers(@user)

    # ✅ エラー内容を表示
    if response.status == 422
      puts "❌ Error Response:"
      puts JSON.pretty_generate(JSON.parse(response.body))
    end

    expect(response).to have_http_status(:created)
    json = JSON.parse(response.body)

    expect(json["pain_area"]).to eq("neck")
    expect(json["duration"]).to eq(["1ヶ月未満"])
  end
end
