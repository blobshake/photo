class User < ActiveRecord::Base
    attr_accessible :email, :password, :password_confirmation
    has_many :paintings, :dependent => :destroy
    has_secure_password
    
    validates_uniqueness_of :email
    
end
