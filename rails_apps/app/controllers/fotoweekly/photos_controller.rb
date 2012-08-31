class Fotoweekly::PhotosController < ApplicationController

  layout("fotoweekly")

  def theme
    @theme = Fotoweekly::Theme.find(params[:id])
    render_page('theme', @theme.id)
  end

  def show
    if params[:id] == "by_tag"
      by_tag
    else
      Fotoweekly::Photo.photo_vote(params[:id], request.remote_ip) if params[:vote]
      photo
    end
  end

  def by_tag
    render_page('by_tag', params[:tag])
  end

  def photo
    @photo = Fotoweekly::Photo.find(params[:id])
    @tags = Fotoweekly::Photo.photo_tags(@photo.id)
    render_page('show', @photo.theme_id)
  end

  def new
    @page_title = "new"
    @wksTheme = Fotoweekly::Theme.sorted.first
    @photo = Fotoweekly::Photo.new
  end

  def create
    @wksTheme = Fotoweekly::Theme.sorted.first
    @photo = Fotoweekly::Photo.new(params[:fotoweekly_photo])
    if @photo.save
      @page_title = "created"
      Fotoweekly::Photo.create_photo_tag(params[:tags], @photo.id)
      redirect_to(fotoweekly_photo_path(@photo.id), :notice => "Photo successfully created!")
    else
      @page_title = "new"
      render('new')
    end
  end

  private #-

  def render_page(page, params)
    @page_title = page
    @wksTheme = Fotoweekly::Theme.sorted.first
    photos(page, params)
    render(page)
  end

  def photos(page, params)
    if page == "by_tag"
      @photos = Fotoweekly::Photo.find_photos_by_tag(params)
    else
      @photos = Fotoweekly::Photo.find_photos_by_theme(params)
    end
  end
end

