class Painting < ActiveRecord::Base
    
    
    attr_accessible :name, :image, :remote_image_url
    
    belongs_to :user
    
    validates :user_id, :presence => true
    #validates :authorized_user
    
    mount_uploader :image, ImageUploader
    
    # set current_user[:user_id] = @painting[:user_id]
    
    def self.search(search)
    if search
    find(:all, :conditions => ['name LIKE ?', "%#{search}%"])
    else
    find(:all, :limit => 20, :order => "created_at DESC")
end
end
    
end
