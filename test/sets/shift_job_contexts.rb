module Contexts
  module ShiftJobContexts
    def create_shift_jobs
      @shift_job1 = FactoryBot.create(:shift_job, shift: @upcoming1, job: @baking)
      @shift_job2 = FactoryBot.create(:shift_job, shift: @upcoming2, job: @baking)
      @shift_job3 = FactoryBot.create(:shift_job, shift: @upcoming3, job: @dishwashing)
    end

    def remove_shift_jobs
      @shift_job1.destroy
      @shift_job2.destroy
      @shift_job3.destroy
    end
  end
end
