ActiveAdmin.register Page do
  permit_params :title, :content

  form do |f|
    f.inputs 'Contact Page Details' do
      f.input :title
      f.input :content, as: :string
    end
    f.actions
  end
end
