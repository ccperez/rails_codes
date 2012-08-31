class Fotoweekly::ThemesController < ApplicationController

  layout("fotoweekly")

  def index
    theme_archives('home')
  end

  def show
    theme_archives('archives')
  end

  private #-

  def theme_archives(page)
    @page_title = page

    @themes = Fotoweekly::Theme.sorted
    @wksTheme = @themes.first

    render(page)
  end

end

