class CreateSubmissions < ActiveRecord::Migration
  def change
    create_table :submissions do |t|
    	t.references :user, index: true
    	t.references :problem, index: true
    	t.string :language
    	t.text :code

      	t.timestamps
    end
  end
end
