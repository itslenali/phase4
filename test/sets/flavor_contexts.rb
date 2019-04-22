module Contexts
    module FlavorContexts
        def create_flavors
            @vanilla = FactoryBot.create(:flavor)
            @chocolate = FactoryBot.create(:flavor, name: "Chocolate", active: true)
            @strawberry = FactoryBot.create(:flavor, name: "Strawberry", active: true)
            @mint = FactoryBot.create(:flavor, name: "Mint Chocolate Chip", active: true)
            @cookies_and_cream = FactoryBot.create(:flavor, name: "Cookies 'n Cream", active: true)
            @cherry_vanilla = FactoryBot.create(:flavor, name: "Cherry Vanilla", active: false)
        end
        
        def remove_flavors
            @vanilla.destroy
            @chocolate.destroy
            @strawberry.destroy
            @mint.destroy
            @cookies_and_cream.destroy
            @cherry_vanilla.destroy
        end
    end
end