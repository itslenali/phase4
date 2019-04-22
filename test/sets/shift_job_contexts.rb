module Contexts
  module ShiftJobContexts
    def create_shift_jobs
      @shift_job1 = FactoryBot.create(:shift_job, shift: @upcoming2, job: @scooping_icecream)
      @shift_job2 = FactoryBot.create(:shift_job, shift: @past2, job: @dishwashing)
      @shift_job3 = FactoryBot.create(:shift_job, shift: @upcoming3, job: @counterwashing)
    end

    def remove_shift_jobs
      @shift_job1.destroy
      @shift_job2.destroy
      @shift_job3.destroy
    end
  end
end
