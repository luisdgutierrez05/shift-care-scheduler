# frozen_string_literal: true

class CreateJobs < ActiveRecord::Migration[7.0]
  def change
    create_table :jobs do |t|
      t.integer :status, default: 0
      t.text :description
      t.date :date
      t.belongs_to :client, null: false, foreign_key: { to_table: :users }

      t.timestamps
    end
  end
end
