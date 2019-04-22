class User < ApplicationRecord
    
#     Users must:

# 1. have all proper relationships specified
  belongs_to :employee

# 2. when created, must be connected to an employee who is active in the system
  validate :employee_is_active_in_system, on: :update

# 3. have values which are the proper data type and within proper ranges
  validates_presence_of :password, on: :create
  validates_confirmation_of :password, message: "passwords don't match"
  validates_length_of :password, minimum: 1
  
  
# 4. have email addresses that are unique in the system (case doesn't matter)

  validates_uniqueness_of :email, case_sensitive: false, on: :create

# 5. are deleted automatically if the employee is deleted
    before_destroy :destroyable?
    after_rollback :destroy

ROLES = [['Administrator', :admin],['Manager', :manager],['Employee', :employee]]

  def role?(authorized_role)
    return false if (self.employee.nil? || self.employee.role.nil?)
    self.employee.role.to_sym == authorized_role
  end
  
  private
  
  
  def destroyable?
    @destroyable = false if employee_active_verified
    else
        @destroyable = true
  end
  
  def destroy
    self.destroy if @destroyable?
    @destroyable = nil
  end
  
  def employee_active_verified
    is_active_employee(:employee)
  end
  
  def is_active_employee(employee)
    return true if Employee.active == true
    return false
  end
end