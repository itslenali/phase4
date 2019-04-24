class Shift < ApplicationRecord
 
 
#Shifts must:

#7. new shifts should have a callback which automatically sets the end time 
#to three hours after the start time
  before_create :set_end_time

  def set_end_time
    three_hours = 3600*3
    self.end_time = self.start_time + three_hours
  end


# 1. have all proper relationships specified
  belongs_to :assignment
  has_one :employee, through: :assignment
  has_many :shift_jobs
  has_many :jobs, through: :shift_jobs
  has_one :store, through: :assignment

# 2. have a date, start time and associated assignment
# 3. values which are the proper data type and within proper ranges
  validates_presence_of :date
  validates_presence_of :start_time
  validates_time :start_time
  validates_time :end_time, after: :start_time, allow_blank: true
#  validate :assignment_must_be_current

#4. be added to only current assignments, not past assignments 
  # def assignment_must_be_current
  #   unless self.assignment.nil? || self.assignment.end_time.nil?
  #     errors.add(:assignment_id, "is not a current assignment at the creamery")
  #   end
  # end
  
#5. can only be deleted if the shift is scheduled for today or in the future
  before_destroy :destroyable?
  after_rollback :destroy
  
#6. have a method called 'completed?' which returns true or false depending
#on whether or not there are any jobs associated with that particular shift
  def completed?
    return self.shift_jobs.count > 0
  end
  
#8. should have a method called 'start_now' which updates the shift's start
#time to be the current time in the database
  def start_now
    self.update_attribute(:start_time, Time.current)
  end

#9. should have a method called 'end_now' which updates the shift's end 
#time to be the current time in the database
  def end_now
    #self.update_attribute(name, value)
    self.update_attribute(:end_time, Time.current)
  end

#10. have the following scopes:

#a) 'completed' -- which returns all shifts in the system that have at least one job associated with them
  scope :completed, -> { joins(:shift_jobs).group(:shift_id) }

#b) 'incomplete' -- which returns all shifts in the system that have do not have at least one job associated with them
  scope :incomplete, -> { joins("left join shift_jobs on shifts.id = shift_jobs.shift_id").where('shift_jobs.job_id is null') }

#c) 'for_store' -- which returns all shifts that are associated with a given store (parameter: store_id)
  scope :for_store, ->(store_id) { joins(:assignment, :store).where("assignments.store_id = ?", store_id) }

#d) 'for_employee' -- which returns all shifts that are associated with a given employee (parameter: employee_id)
  scope :for_employee, ->(employee_id) { joins(:assignment).where("assignments.employee_id = ?", employee_id) }

#e) 'past' -- which returns all shifts which have a date in the past
  scope :past, -> { where('date < ?', Date.current) }

#f) 'upcoming' -- which returns all shifts which have a date in the present or future
  scope :upcoming, -> { where('date >= ?', Date.current) }

#g) 'for_next_days' -- which returns all the upcoming shifts in the next 'x' days (parameter: x)
  scope :for_next_days, ->(x) { where('date between ? and ?', Date.today, x.days.from_now.to_date) }

#h) 'for_past_days' -- which returns all the past shifts in the previous 'x' days (parameter: x)'chronological' -- which orders values chronologically in ascending order
  scope :for_past_days, ->(x) { where('date between ? and ?', x.days.ago.to_date, 1.day.ago.to_date) }

#i) 'by_store' -- which orders values by store name
  scope :by_store, -> { joins(:assignment, :store).order('stores.name') }

#j) 'by_employee' -- which orders values by employee's last, first names
  scope :by_employee, -> { joins(:assignment, :employee).order('employees.last_name, employees.first_name') }

#----HELPER FUNCTIONS----


  def assignment_start
    return self.assignment.start_date.to_date.to_s
  end
  
  def destroyable?
    @destroyable = true if self.date >= Date.today
    @destroyable = false
  end
  
  def destroy
    self.destroy if @destroyable 
    @destroyable = nil
    return "Expected nil"
  end
  
end