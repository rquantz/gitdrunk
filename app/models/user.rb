class User < ActiveRecord::Base
  has_one :bar

  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  
  validates :username, presence: true
  
  before_create :add_bar

  def add_bar
    self.bar = Bar.create
  end
end
