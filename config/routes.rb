::Payify::Engine.routes.draw do
  resources :payments do
    member do
      get "new"
      post "create", as: "create"
    end
  end
end
