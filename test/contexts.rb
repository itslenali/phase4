# require needed files

require './test/sets/store_contexts'
require './test/sets/employee_contexts'
require './test/sets/assignment_contexts'
require './test/sets/flavor_contexts'
require './test/sets/store_flavor_contexts'
require './test/sets/job_contexts'
require './test/sets/shift_contexts'
require './test/sets/shift_job_contexts'
require './test/sets/user_contexts'

module Contexts
  # explicitly include all sets of contexts used for testing 
  include Contexts::StoreContexts
  include Contexts::EmployeeContexts
  include Contexts::AssignmentContexts
  include Contexts::FlavorContexts
  include Contexts::StoreFlavorContexts
  include Contexts::JobContexts
  include Contexts::ShiftContexts
  include Contexts::ShiftJobContexts
  include Contexts::UserContexts

  
 def create_contexts
    create_employees
    create_stores
    create_assignments
    create_flavors
    create_store_flavors
    create_jobs
    create_shifts
    create_shift_jobs
    create_users
  end
  
  def destroy_contexts
    destroy_employees
    destroy_stores
    destroy_assignments
    destroy_flavors
    destroy_store_flavors
    destroy_jobs
    destroy_shifts
    destroy_shift_jobs
    destroy_users
  end
  
end