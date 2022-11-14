ActiveAdmin.register Order do
  includes :user, :order_products, :products

  # , :payment_id, :pst, :gst, :hst
  permit_params :user_id, :order_status_id, order_products_attributes: [:quantity]

  index do
    selectable_column
    column :id
    column :user
    column :order_status
    column :products do |order|
      order.products.map { |p| p.name }.join(', ').html_safe
    end
    column :pst
    column :gst
    column :hst
    column :grand_total do |order|
      total_before_tax = 0
      order.order_products.each do |op|
        total_before_tax += op.price * op.quantity
      end
      total_tax = order.pst + order.gst + order.hst
      grand_total = total_before_tax + (total_before_tax * total_tax)
      number_to_currency grand_total
    end
    actions
  end

  show do |order|
    attributes_table do
      row :user
      row :order_status_id
      row :products do |order|
        order.products.map { |p| p.name }.join(', ').html_safe
      end
    end
  end

  form do |f|
    f.semantic_errors

    f.inputs "Order" do
      f.input :user
      f.input :order_status
      f.has_many :order_products, allow_destroy: true do |n_f|
        n_f.input :product
        n_f.input :price
        n_f.input :quantity
      end
    end

    f.actions
  end

end
