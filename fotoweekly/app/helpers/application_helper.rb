require 'base64'

module ApplicationHelper
  # format output function
  def photo(photo)
    (photo) ? photo.id : 'default'
  end

  def format_date(mysql_timestamp)
    mysql_timestamp.to_formatted_s(:long)
  end

  # form validation
  def error_messages_for(object)
    render(:partial => 'shared/error_messages', :locals => {:object => object})
  end

  def encode(id)
    Base64.encode64(id)
  end

end

