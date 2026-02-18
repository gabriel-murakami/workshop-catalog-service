module Web
  module Controllers
    module Api
      class ProductsController < Web::Controllers::ApplicationController
        def index
          products = if product_params[:search_params].present?
            Application::Catalog::ProductApplication.new.find_products_by_skus(product_params[:search_params])
          else
            Application::Catalog::ProductApplication.new.find_all
          end

          render json: products, each_serializer: ::Serializers::Domain::Catalog::ProductSerializer
        end

        def show
          render json: Application::Catalog::ProductApplication.new.find_by_id(product_params[:id]),
            serializer: ::Serializers::Domain::Catalog::ProductSerializer
        end

        def create
          product = Application::Catalog::ProductApplication.new.create_product(
            Application::Catalog::Commands::CreateProductCommand.new(product: product_params)
          )

          render json: product, status: :created, serializer: ::Serializers::Domain::Catalog::ProductSerializer
        end

        def update
          command = Application::Catalog::Commands::UpdateProductCommand.new(product_attributes: update_params)
          product = Application::Catalog::ProductApplication.new.update_product(command)

          render json: product, serializer: ::Serializers::Domain::Catalog::ProductSerializer
        end

        def add_products
          product = Application::Catalog::ProductApplication.new.add_product(stock_control_command)

          render json: product, serializer: ::Serializers::Domain::Catalog::ProductSerializer
        end

        def remove_products
          product = Application::Catalog::ProductApplication.new.remove_product(stock_control_command)

          render json: product, serializer: ::Serializers::Domain::Catalog::ProductSerializer
        end

        def destroy
          command = Application::Catalog::Commands::DeleteProductCommand.new(product_id: product_params[:id])

          Application::Catalog::ProductApplication.new.delete_product(command)

          head :ok
        end

        private

        def stock_control_command
          Application::Catalog::Commands::StockControlCommand.new(
            product_id: product_params[:id],
            stock_change: product_params[:stock_change]
          )
        end

        def product_params
          params.permit(
            :id,
            :name,
            :description,
            :stock_quantity,
            :base_price,
            :sku,
            :stock_change,
            search_params: []
          )
        end

        def update_params
          product_params.except(:stock_quantity)
        end
      end
    end
  end
end
