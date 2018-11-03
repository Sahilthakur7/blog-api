class V2::CategoriesController < ApplicationController
    def index
        json_response({ message: 'Hello there'})
    end
end
