# frozen_string_literal: true

class FeedbacksController < BaseController
    def create
        feedbackable = get_feedbackable

        feedback = feedbackable.feedbacks.create(feedback_params)

        if feedback.check_existence
            return send_error_response([], 'feadback already exists!')
        end

        if feedback.save
            send_response(feedback.owner.my_feedbacks)
        else
            send_error_response(feedback.errors.full_messages)
        end
    end

    def get_feedbackable
        if feedbackable_params.key?('user_id')
            User::find(feedbackable_params['user_id'])
        else
            Post::find(feedbackable_params['post_id'])
        end
    end

    def feedbackable_params
        params['feedbackable']
    end

    def feedback_params
        params['feedback']
    end
end