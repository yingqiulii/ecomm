ActiveAdmin.register AboutPage do
    permit_params :title, :content

    form do |f|
      f.inputs 'About Page Details' do
        f.input :title
        f.input :content, as: :text
      end
      f.actions
    end
  end
