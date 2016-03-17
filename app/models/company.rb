class Company < ActiveRecord::Base

	  has_many :stalked_pages	
	  has_many :pins
	  has_many :stats
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable


end
