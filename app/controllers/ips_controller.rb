# frozen_string_literal: true

class IpsController < BaseController
  def index
    send_response(Post.ip_addresses_info)
  end
end
