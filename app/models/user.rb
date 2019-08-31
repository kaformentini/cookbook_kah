class User < ApplicationRecord
  has_many :recipes
  
  
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
         
  #def user_owner?(recipe)
   # (recipe && self == recipe.user)
  #end
  
end
