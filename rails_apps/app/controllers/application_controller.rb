class ApplicationController < ActionController::Base
  protect_from_forgery

  def decode(string)
    key = "a0b9c8d7e6f5g4h3i2j1k"
    Base64.decode64(string).sub(key,"")
  end

end

