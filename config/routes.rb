Rails.application.routes.draw do
  resources :beer_clubs
  resources :users
  resources :beers
  resources :breweries do
    post 'toggle_activity', on: :member
  end
  resources :users do
    post 'toggle_activity', on: :member
  end
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  root 'breweries#index'

  get 'kaikki_bisset', to: 'beers#index'
  get 'signup', to: 'users#new'
  get 'signin', to: 'sessions#new'
  delete 'signout', to: 'sessions#destroy'

  # get 'places', to: 'places#index'
  resources :places, only: [:index, :show]
  post 'places', to: 'places#search'
  
  # get 'ratings', to: 'ratings#index'
  # get 'ratings/new', to:'ratings#new'
  # post 'ratings', to: 'ratings#create'
  resources :ratings, only: [:index, :new, :create, :destroy]
  resource :session, only: [:new, :create, :destroy]
  resources :memberships, only: [:new, :create, :destroy]
  resources :styles # , only: [:index, :show, :new, :create, :destroy]

  get 'beerlist', to: 'beers#list'
  get 'brewerylist', to: 'breweries#list'
end
