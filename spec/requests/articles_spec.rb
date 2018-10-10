require 'rails_helper'

Rspec.describe 'Articles API', type: :request do
    let!(:articles) { create_list(:article, 10) }
    let(:article_id) { articles.first.id }


    describe 'GET /articles' do
        before { get '/todos'}

        it 'returns articles' do
            expect(json).not_to be_empty
            expect(json.size).to eq(10)
        end

        it 'returns status code 200' do
            expect(response).to have_http_status(200)
        end
    end


    describe 'GET /articles/:id' do
        before { get "/articles/#{article_id}"}

        context 'when the article exists' do
            it 'returns the article' do
                expect(json).to_not be_empty
                expect(json['id']).to eq(article_id)
            end

            it 'returns status code 200' do
                expect(response).to have_http_status(200)
            end
        end

        context 'when the article does not exist' do
            let(:article_id) {100}

            it 'returns the status code 404' do
                expect(response).to have_http_status(404)
            end

            it 'returns the not found message' do
                expect(response.body).to match(/Couldn't find article/)
            end
        end
    end

    describe 'POST /articles' do
        let(:category_id) { 30 }
        let(:valid_attributes) { {title: 'Animal Farm',content: 'lsdkfj',category: category_id}}

        context 'when the request is valid' do
            before { post '/todos', params: valid_attributes}

            it 'creates an article' do
                expect(json['title']).to eq('Animal Farm')
            end

            it 'returns status code 201' do
                expect(response).to have_http_status(201)
            end
        end

        context 'when the request is invalid' do
            before {post '/articles', params: {title: 'KV'}}

            it 'return the statsu code 402' do
                expect(response).to have_http_status(422)
            end

            it 'returns a validation failure message' do
                expect(response.body).to match(/Validation failed/)
            end
        end
    end

    describe 'PUT /articles/:id' do
        let(:valid_attributes) { {title: '1984'}}

        conext 'when the article exists' do
            before { put "/articles/#{article_id}", params: valid_attributes}

            it 'updates the article' do
                expect(response.body).to be_empty
            end

            it 'returns status code 204' do
                expect(response).to have_http_status(204)
            end
        end
    end

    describe 'DELETE /articles/:id' do
        before { delete "/todos/#{todo_id}"}

        it 'returns status code 204' do
            expect(response).to have_http_status(204)
        end
    end
end
