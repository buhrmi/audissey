class CreateTranslations < ActiveRecord::Migration
  def change
    create_table :translations do |t|
      t.integer :translatable_id
      t.string :translatable_type
      t.string :translatable_field
      t.string :locale
      t.text :text

      t.timestamps null: false
    end
    add_index :translations, [:translatable_id, :translatable_type, :translatable_field, :locale], :name => 'the_index', :unique => true
  end
end
