module Contexts
  module ShiftContexts
    
    def create_shifts
      @upcoming1      = FactoryBot.create(:shift, assignment: @assign_ed)
      @upcoming2 = FactoryBot.create(:shift, assignment: @assign_ed)
      @upcoming3 = FactoryBot.create(:shift, assignment: @assign_ed, date: 1.day.from_now.to_date)
      @upcoming4 = FactoryBot.create(:shift, assignment: @assign_ed, date: 7.days.from_now.to_date)
      @past1  = FactoryBot.create(:shift, assignment: @assign_ed, date: 1.month.ago.to_date)
      @past2 = FactoryBot.create(:shift, assignment: @assign_ed, date: 3.days.ago.to_date)
      @past3 = FactoryBot.create(:shift, assignment: @assign_ed, date: 1.day.ago.to_date)
    end

    def remove_shifts
      @upcoming1.destroy
      @upcoming2.destroy
      @upcoming3.destroy
      @upcoming4.destroy
      @past1.destroy
      @past2.destroy
      @past3.destroy
    end
  end
end
