module Contexts
  module UserContexts
    def create_users
      @alex_user = FactoryBot.create(:user, employee: @alex, email: "alex@example.com")
      @cindy_user = FactoryBot.create(:user, employee: @cindy, email: "rachel@example.com")
      @kathryn_user = FactoryBot.create(:user, employee: @kathryn, email: "kathryn@example.com")
    end
    
    def remove_users
      @alex_user.delete
      @cindy_user.delete
      @kathryn_user.delete
    end
  end
end