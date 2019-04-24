class User < ApplicationRecord
    
#     Users must:

# 1. have all proper relationships specified
  belongs_to :employee

# # 2. when created, must be connected to an employee who is active in the system
   validate :employee_active_verified, on: :create

# # 3. have values which are the proper data type and within proper ranges
   validates_presence_of :password_digest, on: :create
   validates_format_of :email, :with => /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i
   validates_confirmation_of :password_digest, message: "passwords don't match"
   validates_length_of :password_digest, minimum: 1
  
  
# # 4. have email addresses that are unique in the system (case doesn't matter)

   validates_uniqueness_of :email, case_sensitive: false
  #on create

# 5. are deleted automatically if the employee is deleted
    before_destroy :destroyable?
    after_rollback :destroy

ROLES = [['Administrator', :admin],['Manager', :manager],['Employee', :employee]]

  def role?(authorized_role)
    return false if (self.employee.nil? || self.employee.role.nil?)
    self.employee.role.to_sym == authorized_role
  end
  
  
  def employee_active_verified
    return true if Employee.active == true
  end
  

end