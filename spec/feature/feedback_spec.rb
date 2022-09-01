# frozen_string_literal: true

RSpec.describe 'feedbacks endpoint' do

  def set_data(feedbackable, owner_id)
    data = {
      feedbackable:,
      feedback: {
        owner_id: owner_id,
        comment: 'test comment'
      }
    }
  end

  # there is a problem here will look into it later on
  # it 'is valid' do
  #   @user = User.create({username: "test-username-from-test-#{Time.now.to_i}"})
  #   puts @user.inspect
  #   @response = HTTParty.post("#{APP_URL}/feedbacks", body: set_data({ user_id: 1 }, @user.id),   headers: { 
  #     'Content-Type' => 'application/x-www-form-urlencoded'
  #   })

  #   expect(@response.code).to eq(200)
  # end

  it 'already exists for the user' do
    @response = HTTParty.post("#{APP_URL}/feedbacks", body: set_data({ user_id: 1 }, 10),   headers: { 
      'Content-Type' => 'application/x-www-form-urlencoded'
    })

    expect(@response.code).to eq(422)
  end

  it 'already exists for the post' do
    @response = HTTParty.post("#{APP_URL}/feedbacks", body: set_data({ post_id: 1 }, 10),   headers: { 
      'Content-Type' => 'application/x-www-form-urlencoded'
    })

    expect(@response.code).to eq(422)
  end
end
