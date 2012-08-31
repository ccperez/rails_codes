class PhotosController < ApplicationController
  def theme
    @theme = Theme.find(decode(params[:id]))
    # render(:text => decode(params[:id]))
    render_page('theme', @theme.id)
  end

  def show
    if decode(params[:id]) == "by_tag"
      by_tag
    else
      Photo.photo_vote(params[:id], request.remote_ip) if params[:vote]
      photo
    end
  end

  def by_tag
    render_page('by_tag', params[:tag])
  end

  def photo
    @photo = Photo.find(params[:id])
    @tags = Photo.photo_tags(@photo.id)
    render_page('show', @photo.theme_id)
  end

  def new
    @page_title = "new"
    @wksTheme = Theme.sorted.first
    @photo = Photo.new
  end

  def create
    @wksTheme = Theme.sorted.first
    @photo = Photo.new(params[:photo])
    if @photo.save
      @page_title = "created"
      Photo.create_photo_tag(params[:tags], @photo.id)
      redirect_to(photo_path(@photo.id))
      flash[:notice] = "Photo successfully created!"
    else
      @page_title = "new"
      render('new')
    end
  end

  private #-

  def render_page(page, params)
    @page_title = page
    @wksTheme = Theme.sorted.first
    photos(page, params)
    render(page)
  end

  def photos(page, params)
    if page == "by_tag"
      @photos = Photo.find_photos_by_tag(params)
    else
      @photos = Photo.find_photos_by_theme(params)
    end
  end

end

