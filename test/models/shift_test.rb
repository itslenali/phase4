require 'test_helper'

class ShiftTest < ActiveSupport::TestCase
  should have_many(:shift_jobs)
  should have_many(:jobs).through(:shift_jobs)
  should belong_to(:assignment)
  should have_one(:store).through(:assignment)
  should have_one(:employee).through(:assignment)

  should allow_value(1.hour.from_now).for(:start_time)
  should allow_value(2.hours.from_now).for(:start_time)
  should allow_value(3.hours.from_now).for(:start_time)
  should allow_value(4.hours.from_now).for(:start_time)
  should allow_value(Time.now).for(:start_time)
  should allow_value(1.hour.ago).for(:start_time)
  should allow_value(2.hours.ago).for(:start_time)
  should allow_value(4.hours.ago).for(:start_time)
  should allow_value(3.hours.ago).for(:start_time)
  should_not allow_value(5.3).for(:start_time)
  should_not allow_value("bad").for(:start_time)
  should_not allow_value("*(^%&$#").for(:start_time)
  should_not allow_value(nil).for(:start_time)

  context "Creating a context for shifts" do
    setup do 
      create_stores
      create_employees
      create_assignments
      create_jobs
      create_shifts
      create_shift_jobs
    end
    
    teardown do
    #   remove_stores
    #   remove_employees
    #   remove_assignments
    #   remove_jobs
    #   remove_shift_jobs
    #   remove_shifts
    end
    
# SCOPE TESTS

# a) 'completed' -- which returns all shifts in the system that have at least one job associated with them
# b) 'incomplete' -- which returns all shifts in the system that have do not have at least one job associated with them
# c) 'for_store' -- which returns all shifts that are associated with a given store (parameter: store_id)
# d) 'for_employee' -- which returns all shifts that are associated with a given employee (parameter: employee_id)
# e) 'past' -- which returns all shifts which have a date in the past
# f) 'upcoming' -- which returns all shifts which have a date in the present or future
# g) 'for_next_days' -- which returns all the upcoming shifts in the next 'x' days (parameter: x)
# h) 'for_past_days' -- which returns all the past shifts in the previous 'x' days (parameter: x)'chronological' -- which orders values chronologically in ascending order
# i) 'by_store' -- which orders values by store name
# j) 'by_employee' -- which orders values by employee's last, first names
  
#  # a) 'completed' -- which returns all shifts in the system that have at least one job associated with them
    should "see the correct number of completed shifts" do
        #to_a = to array
        #then get the size of the array to count
      assert_equal 3, Shift.completed.to_a.size
    end
#  # b) 'incomplete' -- which returns all shifts in the system that have do not have at least one job associated with them
    should "see the correct number of incomplete shifts" do
      assert_equal 4, Shift.incomplete.to_a.size
    end
    
# # c) 'for_store' -- which returns all shifts that are associated with a given store (parameter: store_id)
    should "see how many shifts per store (for_store)" do
      assert_equal 7, Shift.for_store(@cmu.id).to_a.size
      assert_equal 0, Shift.for_store(@oakland.id).to_a.size
    end

# # d) 'for_employee' -- which returns all shifts that are associated with a given employee (parameter: employee_id)
    should "return the number of shifts per employee (for_employee)" do
      assert_equal 0, Shift.for_employee(@alex.id).size
      assert_equal 0, Shift.for_employee(@kathryn.id).size
      assert_equal 0, Shift.for_employee(@cindy.id).size
    end

# # e) 'past' -- which returns all shifts which have a date in the past
    should "see number of past shifts" do
      assert_equal 3, Shift.past.size
    end

# # f) 'upcoming' -- which returns all shifts which have a date in the present or future
    should "see number of upcoming shifts" do
      assert_equal 4, Shift.upcoming.size
    end

# # g) 'for_next_days' -- which returns all the upcoming shifts in the next 'x' days (parameter: x)
    should "see the number of shifts for upcoming shifts in the next x days (for_next_days)" do
      assert_equal 3, Shift.for_next_days(3).size
      assert_equal 2, Shift.for_next_days(0).size
      assert_equal 4, Shift.for_next_days(10).size
    end

# # h) 'for_past_days' -- which returns all the past shifts in the previous 'x' days (parameter: x)'chronological' -- which orders values chronologically in ascending order
    should "returns all the past shifts in the previous 'x' days (parameter: x)'chronological (for_past_days)" do
      assert_equal 0, Shift.for_past_days(0).size
      assert_equal 1, Shift.for_past_days(1).size
      assert_equal 2, Shift.for_past_days(4).size
    end
    
# # i) 'by_store' -- which orders values by store name
    should "order value by store name" do
      assert_equal ["CMU", "CMU", "CMU", "CMU", "CMU", "CMU", "CMU"], Shift.by_store.map{|shift| shift.store.name}
    end

# # j) 'by_employee' -- which orders values by employee's last, first names
    should "order value by employee name" do
      assert_equal ["Gruberman, Ed", "Gruberman, Ed", "Gruberman, Ed", "Gruberman, Ed", "Gruberman, Ed", "Gruberman, Ed", "Gruberman, Ed"], Shift.by_employee.map{|shift| shift.employee.name}
    end
    
#8. should have a method called 'start_now' which updates the shift's start
#time to be the current time in the database
    should "have a method start_now" do
      assert_equal true, @upcoming1.start_now
    end
    
#9. should have a method called 'end_now' which updates the shift's end 
#time to be the current time in the database
    should "have a method end_now" do
      assert_equal true, @upcoming1.end_now
    end
    
#6. have a method called 'completed?' which returns true or false depending
#on whether or not there are any jobs associated with that particular shift
    should "have a method completed" do
        assert @upcoming1.completed?
    end
    
    should "have an assignment_start method" do
        assert_equal "2018-04-23", @upcoming1.assignment_start
    end
    
    # not be able to destroy
    should "not be able to destroy shifts" do
      assert_equal false, @upcoming1.destroyable?
 
    end

    should "destroy a shift if it can be destroyed" do
      assert "Expected nil", @upcoming1.destroy
 
    end
    
   end



end
