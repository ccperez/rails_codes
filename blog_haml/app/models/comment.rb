class Comment < ActiveRecord::Base
  belongs_to :post

  EMAIL_REGEX = /^[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,4}$/i
  WM_TS = "must have at least %{count} words"
  WM_TL = "must have at most %{count} words"

  validates :title, :body, :email, :presence => true

  validates_length_of :title, :email, :minimum  => 5, :maximum=> 50,
    :too_short => WM_TS, :too_long  => WM_TL

  validates_length_of :body, :minimum  => 5, :maximum=> 50,
    :too_short => WM_TL, :too_long  => WM_TL

  validates_format_of :email, :with => EMAIL_REGEX

  validates_uniqueness_of :title

  scope :search, lambda {|post_id, created|
    where(["post_id = ? and created_at = ?",
      "#{post_id}","#{created}"])}
end

