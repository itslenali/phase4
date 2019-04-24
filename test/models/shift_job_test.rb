require 'test_helper'

class ShiftJobTest < ActiveSupport::TestCase
  should belong_to(:shift)
  should belong_to(:job)
  should validate_presence_of(:shift_id)
  should validate_presence_of(:job_id)

  context "Creating a context for shift_jobs" do
    setup do
      create_stores
      create_employees
      create_assignments
      create_shifts
      create_jobs
    end

    teardown do
      remove_stores
      remove_employees
      remove_assignments
      remove_shifts
      remove_jobs
    end
  end
end
