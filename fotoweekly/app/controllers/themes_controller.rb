class ThemesController < ApplicationController

  def index
    theme_archives('home')
  end

  def show
    archives
  end

  def archives
    theme_archives('archives')
  end

  private #-

  def theme_archives(page)
    @page_title = page

    @themes = Theme.sorted
    @wksTheme = @themes.first

    render(page)
  end

end

