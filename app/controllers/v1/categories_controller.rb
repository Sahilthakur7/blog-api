module V1
    class CategoriesController < ApplicationController
        before_action :set_category,only: [:show,:udpate,:destroy]

        def index
            @categories = Category.all
            json_response(@categories)
        end

        def create
            @category = Category.create!(category_params)
            json_response(@category,:created)
        end

        def show
            json_response(@category)        
        end

        def update
            @category = Category.find(params[:id])
            @category.update(category_params)
            head :no_content
        end

        def destroy
            @category.destroy
            head :no_content
        end

        private

        def category_params
            params.permit(:title)
        end

        def set_category
            @category = Category.find(params[:id])
        end
    end
end
