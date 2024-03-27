ActiveAdmin.register Product do
  permit_params :name, :description, :price, :category_id, :quantity,:active, :new, :image

  filter :name
  filter :description
  filter :price
  filter :category

  index do
    selectable_column
    id_column
    column :name
    column :description
    column :price
    column :category
    column :quantity
    column :active
    column :new
    column "Image" do |product|
      if product.image.attached?
        image_tag product.image, width: "50px", height: "50px"
      else
        "No Image"
      end
    end
    actions
  end

  form do |f|
    f.inputs do
      f.input :name
      f.input :description
      f.input :price
      f.input :category
      f.input :quantity
      f.input :active
      f.input :new
      f.input :image, as: :file
    end
    f.actions
  end
end
