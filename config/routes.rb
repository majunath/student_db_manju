Rails.application.routes.draw do
  root to: "students#index"
  resources :students
  resources :institutions
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
