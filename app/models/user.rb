class User < ActiveRecord::Base
  before_save :assign_role

  rolify
  resourcify
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable
  has_attached_file :avatar, styles: { medium: "300x300>", thumb: "100x100>" }, default_url: "missing.jpg"
  validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\Z/


  def assign_role
    self.add_role :user unless self.has_any_role?
  end


end
