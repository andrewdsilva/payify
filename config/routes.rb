::Payify::Engine.routes.draw do
  resources :payments do
    member do
      get "new"
      post "create"
    end
  end
end
