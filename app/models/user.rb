class User < ActiveRecord::Base
    attr_accessible :email, :password, :password_confirmation, :photo
    has_many :paintings, :dependent => :destroy
    has_many :transactions
    has_secure_password
    
    validates_uniqueness_of :email
    mount_uploader :photo, PhotoUploader
end
