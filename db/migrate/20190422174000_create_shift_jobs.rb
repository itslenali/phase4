class CreateShiftJobs < ActiveRecord::Migration[5.2]
  def change
    create_table :shift_jobs do |t|
      t.integer :job_id
      t.integer :shift_id

      t.timestamps
    end
  end
end
