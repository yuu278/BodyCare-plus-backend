require 'rails_helper'

RSpec.describe "Stretch Recommendation Flow", type: :system do
  before do
    driven_by(:rack_test)
    @user = create(:user)
  end

  it "診断を POST → recommended API で提案ストレッチが返ること" do
    assessment_params = {
      body_assessment: {
        pain_area: "neck",
        pain_types: ["痛み"],
        duration: ["1ヶ月未満"],
        job_types: ["sitting_work"],
        exercise_habits: ["some_exercise"],
        posture_habits: ["hunched_shoulders"]
      }
    }

    post "/api/v1/body_assessments",
         params: assessment_params,
         headers: auth_headers(@user)

    expect(response).to have_http_status(:created)

    stretch1 = create(:stretch,
      target_area: "neck",
      pain_type: ["痛み"],
      duration: ["1ヶ月未満"],
      job_type: ["sitting_work"],
      exercise_habit: ["some_exercise"],
      posture_habit: ["hunched_shoulders"],
      body_part: "neck",
      muscle_info: "首の筋肉説明",
      video_url: "/videos/neck.mp4"
    )

    get "/api/v1/user_stretches/recommended",
        headers: auth_headers(@user)

    expect(response).to have_http_status(:ok)
    json = JSON.parse(response.body)
    expect(json).not_to be_empty
    expect(json.first["id"]).to eq(stretch1.id)
    expect(json.first["target_area"]).to eq("neck")
    expect(json.first["muscle_info"]).to eq("首の筋肉説明")
    expect(json.first["video_url"]).to eq("/videos/neck.mp4")
  end
end