ActiveAdmin.register User do
  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  # permit_params :name, :email, :biography, :birthday, :encrypted_password, :reset_password_token, :reset_password_sent_at, :remember_created_at, :confirmation_token, :confirmed_at, :confirmation_sent_at, :unconfirmed_email
  #
  # or
  #
  # permit_params do
  #   permitted = [:name, :email, :biography, :birthday, :encrypted_password, :reset_password_token, :reset_password_sent_at, :remember_created_at, :confirmation_token, :confirmed_at, :confirmation_sent_at, :unconfirmed_email]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end
  permit_params :name, :email, :biography, :birthday, :reset_password_sent_at, :remember_created_at, :confirmed_at, :confirmation_sent_at, :unconfirmed_email
  index do
    selectable_column
    id_column
    column :name
    column :email
    actions
  end

  show do
    attributes_table do
      row :name
      row :email
      row :biography
      row :birthday
      row :reset_password_sent_at
      row :remember_created_at
      row :confirmed_at
      row :confirmation_sent_at
      row :unconfirmed_email
    end
  end

  form do |f|
    f.inputs do
      f.input :name
      f.input :email
      f.input :biography
      f.input :birthday
    end
    f.actions
  end

  filter :name
  filter :email
  filter :birthday
  filter :reset_password_sent_at
  filter :remember_created_at
  filter :confirmed_at
  filter :confirmation_sent_at
  filter :unconfirmed_email

  csv do
    column :name
    column :email
    column :biography
    column :birthday
    column :reset_password_sent_at
    column :remember_created_at
    column :confirmed_at
    column :confirmation_sent_at
    column :unconfirmed_email
  end
end
