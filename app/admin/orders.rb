
  ActiveAdmin.register Order do
    index do
      column :id
      column :customer
      column :total
      column :tax
      column :created_at
      actions
    end

    filter :customer
    filter :total
    filter :created_at

    form do |f|
      f.inputs 'Order Details' do
        f.input :customer
        f.input :total
        f.input :tax
      end
      f.actions
    end

    show do
      attributes_table do
        row :customer
        row :total
        row :tax
      end
      active_admin_comments
    end

    permit_params :customer_id, :total, :tax # 根据实际模型字段进行调整
  end

