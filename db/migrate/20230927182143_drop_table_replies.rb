class DropTableReplies < ActiveRecord::Migration[7.0]
  def change
    def up
      drop_table :table_replies_to_drop
    end
  
    def down
      raise ActiveRecord::IrreversibleMigration
    end
  end
end
