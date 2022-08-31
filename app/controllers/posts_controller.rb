# frozen_string_literal: true

class PostsController < BaseController
    def index
        res = {id: 1, attr1: 'test1', attr2: 'test2'}
        # send_response(res)
        send_response()
        # send_error_response()
    end
end