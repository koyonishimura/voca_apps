Rails.application.routes.draw do
  get 'main_menu/index'
  get 'sessions/new'
  root 'static_pages#home'
  get  "/help",    to: "static_pages#help"
  get  "/about",   to: "static_pages#about"
  get  "/contact", to: "static_pages#contact"
  get  "/signup",  to: "users#new"
  get    "/login",   to: "sessions#new"
  post   "/login",   to: "sessions#create"
  get "/main_menu", to: "main_menu#index"
  delete "/logout",  to: "sessions#destroy"
  resources :users
  resources :account_activations
  resources :password_resets
  resources :questions
  get "search" => "searches#search"
  resources :question_books
  resources :work_books
  get 'question_test', to: "work_books#question_test"
  get 'question_test_user_answer', to: "work_books#question_test_user_answer"
  get 'question_test_answer', to: "work_books#question_test_answer"
  get 'ranking', to: "question_books#ranking"
  resources :question_tags
  resources :tags
  resources :ranking
  #get "questions", to: "questions#index"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
