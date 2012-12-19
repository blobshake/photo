class Transaction < ActiveRecord::Base
    attr_accessible :buyer_id, :photo_id, :seller_id, :name, :image
    belongs_to :user
    belongs_to :painting
    
   
    
end
