GaTest::Application.routes.draw do
  root :to => "home#index"

  match "/auth/:provider/callback" => "sessions#create"
  match "/auth/failure" => "sessions#failure"

  devise_for :users
end
