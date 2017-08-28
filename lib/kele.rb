require 'httparty'

class Kele
  include HTTParty
  base_uri 'https://www.bloc.io/api/v1'

  def initialize(email, pass)
    @auth = {email: email, password: pass}
    sessions = self.class.post('/sessions', body: @auth)
    @auth_token = sessions["auth_token"]
    raise "Invalid login information" if @auth_token.nil?
  end

end
