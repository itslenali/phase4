require 'test_helper'

class StoreFlavorTest < ActiveSupport::TestCase
  should belong_to(:store)
  should belong_to(:flavor)
  should validate_presence_of(:store_id)
  should validate_presence_of(:flavor_id)

  context "Creating a context for store_flavors" do
    setup do
      create_stores
      create_flavors
    end
  
    teardown do
      remove_stores
      remove_flavors
    end
  end
end
