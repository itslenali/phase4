class Assignment < ApplicationRecord
  
  
#   Assignments (in addition to previous requirements) must:

# Callbacks
  before_create :end_previous_assignment
  before_update :remove_future_shifts
  before_destroy :destroyable?
  after_rollback :terminate_assignment
  
# 1. have an appropriate relationship with new entities
  # Relationships
  belongs_to :employee
  belongs_to :store
  has_many :shifts
  
  # Validations
  validates_numericality_of :pay_level, only_integer: true, greater_than: 0, less_than: 7
  validates_date :start_date, on_or_before: lambda { Date.current }, on_or_before_message: "cannot be in the future"
  validates_date :end_date, after: :start_date
  validate :employee_is_active_in_system, on: :create
  validate :store_is_active_in_system, on: :create
  validates_presence_of :employee_id, on: :update
  validates_presence_of :store_id, on: :create
  
  # Scopes
  scope :current,       -> { where(end_date: nil) }
  scope :past,          -> { where.not(end_date: nil) }
  scope :by_store,      -> { joins(:store).order('name') }
  scope :by_employee,   -> { joins(:employee).order('last_name, first_name') }
  scope :chronological, -> { order('start_date DESC, end_date DESC') }
  scope :for_store,     ->(store_id) { where("store_id = ?", store_id) }
  scope :for_employee,  ->(employee_id) { where("employee_id = ?", employee_id) }
  scope :for_pay_level, ->(pay_level) { where("pay_level = ?", pay_level) }
  scope :for_role,      ->(role) { joins(:employee).where("role = ?", role) }

  # Private methods for callbacks and custom validations
  private  
  
  def end_previous_assignment
    current_assignment = Employee.find(self.employee_id).current_assignment
    if current_assignment.nil?
      return true 
    else
      current_assignment.update_attribute(:end_date, self.start_date.to_date)
    end
  end
  
  # Again, these are not DRY
  def employee_is_active_in_system
    all_active_employees = Employee.active.all.map{|e| e.id}
    unless all_active_employees.include?(self.employee_id)
      errors.add(:employee_id, "is not an active employee at the creamery")
    end
  end
  
  def store_is_active_in_system
    all_active_stores = Store.active.all.map{|s| s.id}
    unless all_active_stores.include?(self.store_id)
      errors.add(:store_id, "is not an active store at the creamery")
    end
  end
  
  # 2. when assignments are terminated (end date set to now or in the past), any future/upcoming shifts associated with the assignment are deleted.

# 3. may be terminated but never destroyed if there are shifts that have been worked during that assignment

  public
  
  def destroyable?
    @destroyable = self.shifts.past.empty?
  end
  
  def terminate_assignment
    remove_future_shifts if @destroyable == false
    self.update_attribute(:end_date, Date.current) if @destroyable == false
    return "Removed successfully"
  end
  
  def remove_future_shifts
    @future_shifts = self.shifts.upcoming
    @future_shifts.each {|s| s.destroy}
  end
  
end


