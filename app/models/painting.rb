class Painting < ActiveRecord::Base
    
    
    attr_accessible :name, :image, :remote_image_url
    
    belongs_to :user
    
    validates :user_id, :presence => true
    
    mount_uploader :image, ImageUploader
    
    # set current_user[:user_id] = @painting[:user_id]
    
end
