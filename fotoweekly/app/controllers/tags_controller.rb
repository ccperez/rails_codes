class TagsController < ApplicationController

  def index
    cloud
    render('cloud')
  end

  def cloud
    @page_title = 'cloud'
    @wksTheme = Theme.sorted.first
    @tags = Tag.find_tags
  end

end

