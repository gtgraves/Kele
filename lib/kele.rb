require 'httparty'
require 'json'

class Kele
  include HTTParty
  base_uri 'https://www.bloc.io/api/v1'

  def initialize(email, pass)
    @auth = {email: email, password: pass}
    response = self.class.post('/sessions', body: @auth)
    @auth_token = response["auth_token"]
    raise "Invalid login information" if @auth_token.nil?
  end

  def get_me
    response = self.class.get('/users/me', headers: { "authorization" => @auth_token })
    JSON.parse(response.body)
  end

end
