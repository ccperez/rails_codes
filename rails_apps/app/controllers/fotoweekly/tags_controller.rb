class Fotoweekly::TagsController < ApplicationController

  layout("fotoweekly")

  def index
    cloud
    render('cloud')
  end

  def cloud
    @page_title = 'cloud'
    @wksTheme = Fotoweekly::Theme.sorted.first
    @tags = Fotoweekly::Tag.find_tags
  end
end

