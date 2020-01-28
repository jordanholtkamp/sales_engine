class RenameQuantityInInvoiceItems < ActiveRecord::Migration[5.2]
  def change
    rename_column :invoice_items, :quanity, :quantity 
  end
end
