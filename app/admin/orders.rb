ActiveAdmin.register Order do
  # includes :user, :order_products, :products

  permit_params :user_id, :order_status_id, order_products_attributes: [:id, :order_id, :product_id, :price, :quantity, :_destroy]

  index do
    selectable_column
    column :id
    column :user
    column :order_status
    column :products do |order|
      order.order_products.map { |op| "#{op.product.name} - #{number_to_currency op.price}" }.join('<br>').html_safe
    end
    column :price_before_tax do |order|
      total_before_tax = 0
      order.order_products.each do |op|
        total_before_tax += op.price * op.quantity
      end
      number_to_currency total_before_tax
    end
    column :tax do |order|
      number_to_percentage (order.pst + order.gst + order.hst) * 100
    end
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
      row :order_status
      row :order_products do |order|
        order.order_products.map { |op| "#{op.product.name} - #{number_to_currency op.price}" }.join('<br>').html_safe
      end
      row :total_before_tax do |order|
        total_before_tax = 0
        order.order_products.each do |op|
          total_before_tax += op.price * op.quantity
        end
        number_to_currency total_before_tax
      end
      row :tax do |order|
        number_to_percentage (order.pst + order.gst + order.hst) * 100
      end
      row :grand_total do |order|
        total_before_tax = 0
        order.order_products.each do |op|
          total_before_tax += op.price * op.quantity
        end
        total_tax = order.pst + order.gst + order.hst
        grand_total = total_before_tax + (total_before_tax * total_tax)
        number_to_currency grand_total
      end
    end
  end

  form do |f|
    f.semantic_errors

    f.inputs 'Order' do
      f.input :user, required: true
      #, as: :select, required: true, collection: User.all.pluck(:email)
      #, :collection => User.all.map { |u| u.email}
      f.input :order_status
      f.has_many :order_products, heading: false, allow_destroy: true do |n_f|
        n_f.input :order#, :collection => Order.all.map { |order| "##{order.id}"}
        n_f.input :product
        n_f.input :quantity
        n_f.input :price
      end
    end

    f.actions
  end
end
