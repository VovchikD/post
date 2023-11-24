# frozen_string_literal: true

class CreateLikes < ActiveRecord::Migration[7.0]
  def change
    create_table :likes do |t|
      t.references :user, null: false, foreign_key: true
      t.references :target, polymorphic: true

      t.timestamps
    end

    add_index :likes, [:user_id, :target_id, :target_type], unique: true
  end
end
