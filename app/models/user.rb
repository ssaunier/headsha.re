class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  # devise :database_authenticatable,
  #        :recoverable, :rememberable, :trackable, :validatable

  has_many :shares, dependent: :nullify

  validates_presence_of :name

  def share_count
    shares.count
  end
end
