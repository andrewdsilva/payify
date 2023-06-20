Rails.application.routes.draw do
  root to: "payify/payments#new", id: 1

  mount Payify::Engine => "payify"
end
