class Post < ActiveRecord::Base
  has_many :comments, :dependent => :destroy

  WM_TS = "must have at least %{count} words"
  WM_TL = "must have at most %{count} words"

  validates_presence_of :title, :body

  validates_length_of :title, :minimum  => 5, :maximum=> 50,
    :too_short => WM_TS, :too_long  => WM_TL

  validates_length_of :body, :minimum  => 5, :maximum=> 255,
    :too_short => WM_TS, :too_long  => WM_TL

  scope :search, lambda {|query| where(["title LIKE ?", "%#{query}%"])}
end

