class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :invitable

  attr_accessor :invited_group_id

  has_and_belongs_to_many :groups, join_table: :groups_users
  has_many :interests

  accepts_nested_attributes_for :interests

  default_scope { includes(:groups, :interests) }

  def friendly_title
    self.name.present? ? self.name : self.email
  end
end
