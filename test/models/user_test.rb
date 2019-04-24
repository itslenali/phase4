require 'test_helper'

class UserTest < ActiveSupport::TestCase
  should belong_to(:employee)
  should allow_value("lenal@andrew.cmu.edu").for(:email)
  should_not allow_value("lenal@@andrew.cmu.edu").for(:email)
  should_not allow_value("bad").for(:email)
  should_not allow_value("123").for(:email)
  should validate_uniqueness_of(:email).case_insensitive

  context "Creating a context for users" do
    setup do 
      create_employees
      create_users
    end
    
    teardown do
      remove_employees
      remove_users
    end
   end
  
  
end
