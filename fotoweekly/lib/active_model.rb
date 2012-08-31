module ActiveModel

  def paginated(per_page, page)
    paginate(:per_page => per_page, :page => page)
  end

end
