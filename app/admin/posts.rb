ActiveAdmin.register Post do

  permit_params :title, :description, :user_id

  index do
    column :id
    column :title
    column :description
    column :user
    actions
  end

  form title: 'Create post' do |f|
    inputs 'Details' do
      input :user_id
      input :title
      input :description
      f.actions
    end
  end
  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  # permit_params :title, :description, :user_id
  #
  # or
  #
  # permit_params do
  #   permitted = [:title, :description, :user_id]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end
  
end
