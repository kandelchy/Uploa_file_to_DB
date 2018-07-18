Rails.application.routes.draw do
  resources :attachments do
    get "serve", :on => :member
  end
end
