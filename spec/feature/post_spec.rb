# frozen_string_literal: true

RSpec.describe 'posts endpoint' do

  def set_data(feedbackable, owner_id)
    data = {
      feedbackable:,
      feedback: {
        owner_id: owner_id,
        comment: 'test comment'
      }
    }
  end


  it 'list is valid with pagination' do
    @response = HTTParty.get("#{APP_URL}/posts?pagination=10")
    @body = JSON.parse(@response.body)

    expect(@response.code).to eq(200)
    expect(@body['data'].length).to be <= 10
  end

  it 'list is valid without pagination' do
    @response = HTTParty.get("#{APP_URL}/posts")
    @body = JSON.parse(@response.body)

    expect(@response.code).to eq(200)
    expect(@body['data'].length).to be <= 50
  end

  it 'is creating valid post' do
    @data = {
      user: { username: "test-username-from-test-#{Time.now.to_i}" },
      post: {
        title: 'test title',
        content: 'test content',
        ip_address: '127.0.0.1'
      }
    }

    @response = HTTParty.post("#{APP_URL}/posts", body: @data, headers: { 
      'Content-Type' => 'application/x-www-form-urlencoded'
    })

    expect(@response.code).to eq(200)
  end

  it 'is not creating valid post' do
    @data = {
      user: { username: "test-username-from-test-#{Time.now.to_i}" },
      post: {
        content: 'test content',
        ip_address: '127.0.0.1'
      }
    }

    @response = HTTParty.post("#{APP_URL}/posts", body: @data, headers: { 
      'Content-Type' => 'application/x-www-form-urlencoded'
    })

    expect(@response.code).to eq(422)
  end

  it 'is creating valid rating for a post' do
    @data = {
      rating: { value: 5 }
    }

    @response = HTTParty.post("#{APP_URL}/posts/1/ratings", body: @data, headers: { 
      'Content-Type' => 'application/x-www-form-urlencoded'
    })

    expect(@response.code).to eq(200)
  end

  it 'is not creating valid rating for a post' do
    @data = {
      rating: { value: 100 }
    }

    @response = HTTParty.post("#{APP_URL}/posts/1/ratings", body: @data, headers: { 
      'Content-Type' => 'application/x-www-form-urlencoded'
    })

    expect(@response.code).to eq(422)
  end
end
