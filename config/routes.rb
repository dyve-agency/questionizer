require File.expand_path("../../lib/logged_in_constraint", __FILE__)

Rails.application.routes.draw do

  resources :questions

  resources :lists do
    collection do
      post "preview"
    end
    member do
      get "clone"
      post "notify"
    end
  end

  devise_for :users, :controllers => {
    :confirmations => "users/confirmations",
    :passwords     => "users/passwords",
    :registrations => "users/registrations",
    :sessions      => "users/sessions",
    :unlocks       => "users/unlocks",
  }

  match "/page/:action" => "static#:action", :via => :all, :as => 'page'
  match "/dev/:action" => "dev#:action", :via => :all, :as => 'dev'

  get '/' => "static#landing", :as => "root"

  # get '/' => "static#landing",           :constraints => LoggedInConstraint::User.new(false), :as => "root"
  # get '/' => "static#dashboard_example", :constraints => LoggedInConstraint::User.new(true),  :as => "dashboard_example"
end
