module ApplicationHelper

  def encode(string)
    key = "a0b9c8d7e6f5g4h3i2j1k"
    Base64.encode64("#{string}#{key}")
  end

  # form validation
  def error_messages_for(object)
    render(:partial => 'shared/error_messages', :locals => {:object => object})
  end

end

