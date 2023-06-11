Rails.application.routes.draw do
  mount Payify::Engine => "/payify"
end
