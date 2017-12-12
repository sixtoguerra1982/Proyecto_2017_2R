ActiveAdmin.register Cook do
# See permitted parameters documentation:
# https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
#
# permit_params :list, :of, :attributes, :on, :model
#
# or
#
# permit_params do
#   permitted = [:permitted, :attributes]
#   permitted << :other if params[:action] == 'create' && current_user.admin?
#   permitted
# end
  permit_params :name, :email, :phone, :address, :address_region,
                :address_commune, :address_city, :biography, :picture, :user_id

  index do
    column :id
    column :name
    column :email
    column :address
    column :user_id
    actions # agregamos acciones view, edit y delete
  end

  filter :email
  filter :created_at
end
