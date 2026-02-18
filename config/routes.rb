Rails.application.routes.draw do
  unless Rails.env.production?
    mount Rswag::Ui::Engine => "/api-docs"
    mount Rswag::Api::Engine => "/api-docs"
  end

  # Health Check
  get "up" => "rails/health#show", as: :rails_health_check

  scope module: "web" do
    scope module: "controllers" do
      namespace :api do
        scope controller: :services do
          resources :services, only: %i[index create update destroy show]
        end

        scope controller: :products do
          resources :products, only: %i[index create update destroy show]
          post "products/:id/add", action: :add_products
          post "products/:id/remove", action: :remove_products
        end
      end
    end
  end
end
