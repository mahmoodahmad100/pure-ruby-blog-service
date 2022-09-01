# frozen_string_literal: true

class BaseController
  attr_reader :method, :params, :router_params

  def initialize(method)
    @method = method
  end

  def call(env)
    @params = Rack::Request.new(env).params
    @router_params = env['router.params']
    public_send(@method)
  end

  def send_response(result = [], message = 'Success.', is_success = true, status_code = 200)
    result_key = is_success ? 'data' : 'errors'

    response = {
      is_success:,
      status_code:,
      message:,
      result_key => result
    }

    [status_code, { 'Content-Type' => 'application/json' }, [response.to_json]]
  end

  def send_error_response(errors = [], message = 'OOPS! there is a problem.', status_code = 422)
    send_response(errors, message, false, status_code)
  end
end
