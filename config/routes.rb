::Payify::Engine.routes.draw do
  resources :payments do
    member do
      get "new"
      get "complete", as: "complete"
    end
  end
end
