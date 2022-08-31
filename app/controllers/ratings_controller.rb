# frozen_string_literal: true

class RatingsController < BaseController
    def create
        rating = Rating.new(rating_params);

        if rating.save
            send_response({ average: Rating.avg() })
        else
            send_error_response(rating.errors.full_messages)
        end
    end

    def rating_params
        params['rating']
    end
end