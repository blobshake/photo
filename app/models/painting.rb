class Painting < ActiveRecord::Base
    
    
  attr_accessible :name, :user_id, :image, :remote_image_url
    belongs_to :user
    mount_uploader :image, ImageUploader
    
    # set current_user[:user_id] = @painting[:user_id]
    
end
