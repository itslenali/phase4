module Contexts
  module JobContexts
    def create_jobs
      @scoop_icecream = FactoryBot.create(:job)
      @baking = FactoryBot.create(:job, name: "Baking")
      @dishwashing  = FactoryBot.create(:job, name: "Dishwashing")
      @counterwashing   = FactoryBot.create(:job, name: "Washing Ice Cream Counters", active: true)
      @mopping   = FactoryBot.create(:job, name: "Mopping", active: false)
    end

    def remove_jobs
      @scoop_icecream.destroy
      @baking.destroy
      @dishwashing.destroy
      @counterwashing.destroy
    end
  end
end