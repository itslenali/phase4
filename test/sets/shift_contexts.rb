module Contexts
  module ShiftContexts
    
    def create_shifts
      create_upcoming_shifts
      create_past_shifts
    end

    def remove_shifts
      remove_upcoming_shifts
      remove_past_shifts
    end

#can also be current
    def create_upcoming_shifts
      @upcoming1 = FactoryBot.create(:assignment, employee: @alex, store: @cmu, start_date: 2.months.ago.to_date, end_date: nil, pay_level: 1)
      @upcoming2 = FactoryBot.create(:shift, assignment: @alex)
      @upcoming3 = FactoryBot.create(:shift, assignment: @alex, date: 1.day.from_now.to_date)
      @upcoming4 = FactoryBot.create(:shift, assignment: @alex, date: 7.days.from_now.to_date)
    end

    def remove_upcoming_shifts
      @upcoming1.destroy
      @upcoming2.destroy
      @upcoming3.destroy
      @upcoming4.destroy
    end

    def create_past_shifts
      @past1  = FactoryBot.create(:assignment, employee: @ed, store: @cmu, start_date: 1.month.ago.to_date, end_date: nil, pay_level: 2)
      @past2 = FactoryBot.create(:shift, assignment: @assign_ed_2, date: 3.days.ago.to_date)
      @past3 = FactoryBot.create(:shift, assignment: @assign_ed_2, date: 1.day.ago.to_date)
    end

    def remove_past_shifts
      @past1.destroy
      @past2.destroy
      @past3.destroy
    end

  end
end
