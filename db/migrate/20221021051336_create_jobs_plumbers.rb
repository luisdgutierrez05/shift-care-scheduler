class CreateJobsPlumbers < ActiveRecord::Migration[7.0]
  def change
    create_table :job_plumbers do |t|
      t.belongs_to :job
      t.belongs_to :plumber

      t.timestamps
    end
  end
end
