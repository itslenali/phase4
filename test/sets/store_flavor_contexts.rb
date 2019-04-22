module Contexts
  module StoreFlavorContexts
    # Context for flavors 
    def create_store_flavors
      @vanilla_cmu = FactoryBot.create(:store_flavor, flavor: @mint_chip, store: @oakland)
      @chocolate_cmu = FactoryBot.create(:store_flavor, flavor: @chocolate, store: @cmu)
      @strawberry_cmu = FactoryBot.create(:store_flavor, flavor: @strawberry, store: @cmu)
      @mint_cmu = FactoryBot.create(:store_flavor, flavor: @strawberry, store: @cmu)
      @vanilla_oakland = FactoryBot.create(:store_flavor, flavor: @mint_chip, store: @oakland)
    end
    
    def remove_store_flavors
      @chocolate_cmu.destroy
      @strawberry_cmu.destroy
      @mint_cmu.destroy
      @vanilla_oakland.destroy
    end
  end
end