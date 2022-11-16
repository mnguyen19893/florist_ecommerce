ActiveAdmin.register Product do
  permit_params :name, :description_url, :containers, :flower_time, :sale, :price, :category_id, :image

  form do |f|
    f.semantic_errors
    f.inputs
    f.inputs do
      f.input :image, as: :file, hint: f.object.image.present? ? image_tag(f.object.image, size: '200x200') : ""
    end
    f.actions
  end
end
