class AddVinfoToSubmissions < ActiveRecord::Migration
  def change
  	add_column :submissions, :verdict, :string
  	add_column :submissions, :timeConsumedMillis, :integer
  	add_column :submissions, :memoryConsumedBytes, :integer
  end
end
