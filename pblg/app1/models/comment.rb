class Comment < ActiveRecord::Base
  belongs_to :post

  WM_TS = "must have at least %{count} letters"
  WM_TL = "must have at most %{count} letters"

  validates_presence_of :title, :body

  validates_length_of :title, :minimum  => 5, :maximum=> 50,
    :too_short => WM_TS, :too_long  => WM_TL

  validates_length_of :body, :minimum  => 5, :maximum=> 255,
    :too_short => WM_TL, :too_long  => WM_TL

  validates_uniqueness_of :title

end

