 ActiveAdmin.register Customer do
    # 定义在列表视图中显示的列
    index do
      selectable_column
      id_column
      column :name
      column :address
      column :province
      column :email
      column :encrypted_password
      actions
    end

    # 过滤器
    filter :name
    filter :email
    filter :province

    # 定义表单的外观
    form do |f|
      f.inputs 'Customer Details' do
        f.input :name
        f.input :address
        f.input :province
        f.input :email
        f.input :encrypted_password
      end
      f.actions
    end

    # 定义显示页面的外观
    show do
      attributes_table do
        row :name
        row :address
        row :province
        row :email
        row :encrypted_password
        row :created_at
        row :updated_at
      end
      active_admin_comments
    end

    # 控制允许的参数
    permit_params :name, :address, :province, :email , :encrypted_password
  end


