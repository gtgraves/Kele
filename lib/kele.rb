require 'httparty'
require 'json'
require './lib/roadmap'

class Kele
  include HTTParty
  include Roadmap
  base_uri 'https://www.bloc.io/api/v1'

  def initialize(email, pass)
    @auth = {email: email, password: pass}
    response = self.class.post('/sessions', body: @auth)
    @auth_token = response["auth_token"]
    raise "Invalid login information" if @auth_token.nil?
  end

  def get_me
    response = self.class.get('/users/me', headers: auth_header)
    JSON.parse(response.body)
  end

  def get_mentor_availability(mentor_id)
    response = self.class.get("/mentors/#{mentor_id}/student_availability", headers: auth_header)
    JSON.parse(response.body)
  end

  def get_messages(page_number = nil)
    if page_number != nil
      @page = {page: page_number}
      response = self.class.get('/message_threads', headers: auth_header, body: @page)
    else
      response = self.class.get('/message_threads', headers: auth_header)
    end
    JSON.parse(response.body)
  end

  def create_message(sender, recipient, token, subject, text)
    @body = {"sender" => sender, "recipient_id" => recipient, "token" => token, "subject" => subject, "stripped-text" => text}
    if @body["token"] == nil
      @body.delete("token")
    end
    response = self.class.post('/messages', headers: auth_header, body: @body)
  end

  private

  def auth_header
    { authorization: @auth_token }
  end

end
