class AddPrefectureToEvents < ActiveRecord::Migration[5.2]
  def change
    add_column :events, :prefecture, :string
  end
end
