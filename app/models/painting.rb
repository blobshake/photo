class Painting < ActiveRecord::Base
    
    
    attr_accessible :name, :image, :remote_image_url, :tag_list
    acts_as_taggable
    
    belongs_to :user
    has_many :transactions
    
    validates :user_id, :presence => true
    validates :image, :presence => true
    validates :name, :presence => true
    #validates :authorized_user
    
    mount_uploader :image, ImageUploader
    
    # set current_user[:user_id] = @painting[:user_id]
    
    def self.search(search)
    if search
    find(:all, :conditions => ['name LIKE ?', "%#{search}%"])
    else
    find(:all, :limit => 20, :order => "downloads DESC")
end
end
    
end
