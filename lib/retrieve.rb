module Retrieve
  private

  def auth_header
    { authorization: @auth_token }
  end

  def get_response(path, body = nil)
    response = self.class.get(path, headers: auth_header, body: body)
    JSON.parse(response.body)
  end

  def post_response(path, body)
    response = self.class.post(path, headers: auth_header, body: body)
  end
end
