Rails.application.routes.draw do
  resources :attendances do
    post :gowing_leaving_work, on: :member
  end  
  resources :users do
    member do
      get :attendances_edit
      patch :attendance_update
     
    end  
  end  
  root "users#index"

end
