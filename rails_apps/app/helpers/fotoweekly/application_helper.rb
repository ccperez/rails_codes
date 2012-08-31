require 'base64'

module Fotoweekly::ApplicationHelper
  # format output function
  def photo(photo)
    (photo) ? photo.id : 'default'
  end

  def format_date(mysql_timestamp)
    mysql_timestamp.to_formatted_s(:long)
  end

end

