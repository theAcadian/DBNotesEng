Rails.application.routes.draw do
    get "model_info/DBNotes"

  #get "model_info/index"

  get "DBNotes" => "ModelInfo#DBNotes"

  match 'tables/:table/columns/:column', to: "ModelInfo#show_notes_for_column", as: "table_column"

  match 'add_note', to: "ModelInfo#add_note"

  match 'add_comment', to: "ModelInfo#add_comment"

  match 'get_login_status', to: "ModelInfo#user_logged_in"

  match 'user_authenticate', to: "ModelInfo#user_authenticate"

  match 'is_user_logged_in', to: "ModelInfo#is_user_logged_in"

  match 'get_author_name', to: "ModelInfo#get_author_name"

  match 'get_table_notes_count', to: "ModelInfo#get_table_notes_count"

  match 'get_column_notes_count', to: "ModelInfo#get_column_notes_count"

  match 'get_column_notes_count_within_a_table', to: "ModelInfo#get_column_notes_count_within_a_table"

  resources :notes do 
  	resources :comments
  end
end
