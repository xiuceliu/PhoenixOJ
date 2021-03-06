class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable

  has_many :duties
  has_many :messages,:through => :duties
  
  devise :database_authenticatable, :registerable,:timeoutable,
         :recoverable, :rememberable, :trackable, :validatable,
         :authentication_keys=>[:username]
         
  has_many :discusses
  has_many :submissions
  # Setup accessible (or protected) attributes for your model
  attr_accessible :username, :email, :password, :password_confirmation, :remember_me
  validates_presence_of :username
  validates :email, uniqueness: true
  validates :username, uniqueness: true

  # attr_accessible :title, :body

  serialize :arr_prosolved, Array
  serialize :arr_profailed, Array


end
