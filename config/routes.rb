Rails.application.routes.draw do
  root 'home#index'
  get 'home/popup'=>'home#popup'
  get 'home/no_aside'=>'home#no_aside'
  get 'feed',:to=>'home#feed'

  resources :intro, :blogs, :galleries, :notices, :faq_categories,:faqs, :histories, :questions, :guest_books

  get 'tags/:tag', to: 'tags#index', as: :tag
  resources :comments, only: [:create, :destroy]


  # Admin 인증 라우트
  devise_for :users, :controllers => { :omniauth_callbacks => 'users/omniauth_callbacks', :sessions => "users/sessions", :registrations => "users/registrations", :passwords => "users/passwords" }, :path_names => { :sign_up => 'new', :sign_in => 'login', :sign_out => 'logout' }

  devise_scope :user do
    get '/login', to: 'users/sessions#new', as: :login_redirect
    delete '/logout', to: 'users/sessions#destroy', as: :logout_redirect
  end

  devise_for :admins,
             class_name: "User",
             skip: [:sessions, :registrations, :passwords, :omniauth_callbacks]

  devise_scope :admin do
    # ---- Sessions ----
    get    'admins/login',  to: 'admins/sessions#new',     as: :new_admin_session
    post   'admins/login',  to: 'admins/sessions#create',  as: :admin_session
    delete 'admins/logout', to: 'admins/sessions#destroy', as: :destroy_admin_session

    # ---- Registrations ----
    get    'admins/sign_up',    to: 'admins/registrations#new',    as: :new_admin_registration
    post   'admins',             to: 'admins/registrations#create', as: :admin_registration
    get    'admins/edit',        to: 'admins/registrations#edit',   as: :edit_admin_registration
    patch  'admins',             to: 'admins/registrations#update'
    put    'admins',             to: 'admins/registrations#update'
    delete 'admins',             to: 'admins/registrations#destroy'

    # ---- Passwords ----
    get   'admins/password/new',    to: 'admins/passwords#new',    as: :new_admin_password
    post  'admins/password',        to: 'admins/passwords#create', as: :admin_password
    get   'admins/password/edit',   to: 'admins/passwords#edit',   as: :edit_admin_password
    patch 'admins/password',        to: 'admins/passwords#update'
    put   'admins/password',        to: 'admins/passwords#update'

    # ---- Confirmations (optional, 이메일 확인 등) ----
    get   'admins/confirmation/new',  to: 'users/confirmations#new',    as: :new_admin_confirmation
    post  'admins/confirmation',      to: 'users/confirmations#create', as: :admin_confirmation
    get   'admins/confirmation',      to: 'users/confirmations#show'
  end

  namespace :admin do
    root to: 'home#index'

    resources :users
    resources :intro,:gallery_categories, :galleries, :faq_categories,:faqs, :blog_categories, :notices, :site, :intro, :contacts, :notices, :histories, :portfolios
    resources :questions do
      resources :question_comments
    end

    resources :blogs do
      resources :blog_comments
    end

    resources :questions do
      get 'password',:on=>:collection
      post 'password',:on=>:collection
      resources :question_comments
    end

    resources :guest_books do
      resources :guest_book_comments do
        get 'password',:on=>:collection
        post 'password',:on=>:collection
      end
    end
  end
end