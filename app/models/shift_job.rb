class ShiftJob < ApplicationRecord
    
    
# #     Shift Jobs must:
# # 1. have all proper relationships specified
   belongs_to :shift
   belongs_to :job
   validates_presence_of :shift_id, :job_id
  
  
 #  validates :shift_is_active_in_system, on: :create
#   validates :job_is_active_in_system, on: :create

  private  
  
  def shift_is_active_in_system
    is_active_shift(:shift)
  end

  def job_is_active_in_system
    is_active_job(:job)
  end
  
  def is_active_shift(shift)
    if Shift.active == true
      return true
    else
      return false
  end
      
  def is_active_job(job)
    if Job.active == true
      return true
    else
      return false
  end

end
end
end