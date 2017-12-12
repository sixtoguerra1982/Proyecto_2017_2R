ActiveAdmin.register User do
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
  permit_params :name, :email, :phone, :cook, :role, :password,
                :password_confirmation

  index do
    column :id
    column :email
    column :name
    column :phone
    column :role
    column :created do |user|
      user.created_at
    end
    column :member_since do |user|
      time_ago_in_words(user.created_at)
    end
    actions
  end

  form do |f|
    inputs 'User' do
      input :name
      input :email
      input :cook
      input :role
      input :password
      input :password_confirmation
    end
    actions
  end

  controller do
   def update
     if (params[:user][:password].blank? && params[:user][:password_confirmation].blank?)
       params[:user].delete("password")
       params[:user].delete("password_confirmation")
     end
     super
   end
  end

  filter :role, as: :select, collection: {'Visita' => 0, 'Admin' => 1, 'Cocinero' => 2}
  filter :email
  filter :created_at

end
