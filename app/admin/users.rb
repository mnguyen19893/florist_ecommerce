ActiveAdmin.register User do
  includes :orders

  index do
    selectable_column
    column :id
    column :email
    column :orders
    actions
  end

end
