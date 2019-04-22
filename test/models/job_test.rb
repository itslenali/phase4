require 'test_helper'

class JobTest < ActiveSupport::TestCase
  should have_many(:shift_jobs)
  should have_many(:shifts).through(:shift_jobs)
  should validate_presence_of(:name)

  context "Creating a context for jobs" do
    setup do 
      create_jobs
    end
    
    teardown do
      remove_jobs
    end
  
#SCOPE TESTS
#1. active
#2. inactive
#3. alphabetical

    #1. active
    # test the scope 'active'
    should "show active jobs" do
      assert_equal 4, Job.active.size
      assert_equal ["Baking", "Dishwashing", "Scooping ice cream", "Washing Ice Cream Counters"], Job.active.map{|job| job.name}.sort
    end
    
    #2. inactive
    should "show inactive jobs" do
      assert_equal 1, Job.inactive.size
      assert_equal ["Mopping"], Job.inactive.map{|job| job.name}.sort
    end    
    
    #3. alphabetical
    should "be in alphabetical order" do
      assert_equal ["Baking", "Dishwashing", "Mopping", "Scooping ice cream", "Washing Ice Cream Counters"], Job.alphabetical.map{|job| job.name}
    end
  end

end
