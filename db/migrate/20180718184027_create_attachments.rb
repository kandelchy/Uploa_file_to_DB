class CreateAttachments < ActiveRecord::Migration[5.2]
  def change
    create_table :attachments do |t|
      t.string :name
      t.binary :data
      t.string :filename
      t.string :mime_type

      t.timestamps
    end
  end
end
