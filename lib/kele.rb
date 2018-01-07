require 'httparty'
require 'json'
require './lib/roadmap'
require './lib/retrieve'

class Kele
  include HTTParty
  include Roadmap
  include Retrieve
  base_uri 'https://www.bloc.io/api/v1'

  def initialize(email, pass)
    @auth = {email: email, password: pass}
    response = self.class.post('/sessions', body: @auth)
    @auth_token = response["auth_token"]
    raise "Invalid login information" if @auth_token.nil?
  end

  def get_me
    get_response('/users/me')
  end

  def get_mentor_availability(mentor_id)
    get_response("/mentors/#{mentor_id}/student_availability")
  end

  def get_messages(page_number = nil)
    if page_number != nil
      @page = {page: page_number}
    else
      @page = nil
    end
    get_response('/message_threads', @page)
  end

  def create_message(sender, recipient, token, subject, text)
    @body = {"sender" => sender, "recipient_id" => recipient, "token" => token, "subject" => subject, "stripped-text" => text}
    @body.delete("token") if @body["token"].nil?
    post_response('/messages', @body)
  end

end
