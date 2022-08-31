# frozen_string_literal: true

class BaseController
    attr_reader :method, :request

    def initialize(method)
        @method = method
    end
  
    def call(env)
        @request = Rack::Request.new(env)
        public_send(@method)
    end

    def send_response(result = [], message = 'Success.', is_success = true, status_code = 200)
        result_key = is_success ? 'data' : 'errors';

        response = {
            is_success: is_success,
            status_code: status_code,
            message: message,
            result_key => result
        };

        [status_code, { 'Content-Type' => 'application/json' }, [response.to_json]]
    end

    def send_error_response(errors = [], message = 'OOPS! there is a problem.', status_code = 422)
        send_response(errors, message, false, status_code);
    end
end