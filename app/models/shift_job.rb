class ShiftJob < ApplicationRecord
    
    
# #     Shift Jobs must:
# # 1. have all proper relationships specified
   belongs_to :shift
   belongs_to :job
   validates_presence_of :shift_id, :job_id
  
  
   
end