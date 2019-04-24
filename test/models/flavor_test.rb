require 'test_helper'

class FlavorTest < ActiveSupport::TestCase
  should have_many(:store_flavors)
  should have_many(:stores).through(:store_flavors)

  should validate_presence_of(:name)

  context "Creating a context for flavors" do
    setup do 
      create_flavors
    end
    
    teardown do
      remove_flavors
    end
    
#SCOPE TESTS
#1. active
#2. inactive
#3. alphabetical
#4. not be able to destroy 

    # 1) test active scope
    should "show active flavors" do
      assert_equal 5, Flavor.active.size
      assert_equal ["Chocolate", "Cookies 'n Cream", "Mint Chocolate Chip", "Strawberry", "Vanilla"], Flavor.active.map{|f| f.name}.sort
    end
    
    # 2) test inactive scope
    should "show inactive flavor" do
      assert_equal 1, Flavor.inactive.size
      assert_equal ["Cherry Vanilla"], Flavor.inactive.map{|f| f.name}.sort
    end
    
    # 3) test alphabetical
    should "be in alphabetical order" do
      assert_equal ["Cherry Vanilla", "Chocolate", "Cookies 'n Cream", "Mint Chocolate Chip", "Strawberry", "Vanilla"], Flavor.alphabetical.map{|f| f.name}
    end
    
    # 4) not be able to destroy
    should "not be able to destroy flavors" do
      assert_equal "Denied", @chocolate.destroyable?
 
    end

    should "make a flavor inactive" do
      assert_equal "Changed to inactive", @chocolate.convert_inactive
 
    end
  end


end
