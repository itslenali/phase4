class StoreFlavor < ApplicationRecord
    
#     StoreFlavors must:
# 1. have all proper relationships specified

  belongs_to :store
  belongs_to :flavor
  validates_presence_of :store_id, :flavor_id
 

end
