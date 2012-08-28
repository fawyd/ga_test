class User < ActiveRecord::Base
  ROLES = %w(user_a user_b)
  #rolify
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :name, :email, :password, :password_confirmation, :remember_me, :role
  
  validates :role, presence: true, inclusion: ROLES


  def can_view_visits
    role == 'user_b'
  end
end
