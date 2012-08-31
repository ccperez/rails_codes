class AdminUser < ActiveRecord::Base

  attr_accessor :password

  before_save :encrypt_password
  after_save :clear_password

  has_and_belongs_to_many :pages
  has_many :section_edits
  has_many :sections, :through => :section_edits

  EMAIL_REGEX = /^[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,4}$/i

  validates :first_name, :presence => true, :length => { :maximum => 25 }
  validates :last_name, :presence => true, :length => { :maximum => 50 }
  validates :username, :length => { :within => 8..25 }, :uniqueness => true
  validates :email, :presence => true, :length => { :maximum => 100 },
    :format => EMAIL_REGEX, :confirmation => true

  # only on create, so other attributes of this user can be changed
  validates_length_of :password, :within => 8..25, :on => :create

  attr_accessible :first_name, :last_name, :username, :email, :password

  scope :searh_by_name, lambda {|first, last| where(:first_name => first, :last_name => last)}
  scope :sorted, order("admin_users.last_name ASC, admin_users.first_name ASC")

  def full_name
    "#{first_name} #{last_name}"
  end

  def name
    self.full_name
  end

  def self.authenticate(username_or_email="", login_password="")
    user = EMAIL_REGEX.match(username_or_email) ? AdminUser.find_by_email(username_or_email) : AdminUser.find_by_username(username_or_email)
    return (user && user.match_password?(login_password)) ? user : false
  end

  def match_password?(login_password="")
    encrypted_password == BCrypt::Engine.hash_secret(login_password, salt)
  end

  private #-

  def encrypt_password
    unless password.blank?
      self.salt = BCrypt::Engine.generate_salt
      self.encrypted_password = BCrypt::Engine.hash_secret(password, salt)
    end
  end

  def clear_password
    self.password = nil
  end

end

