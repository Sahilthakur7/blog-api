require 'rails_helper'

RSpec.describe 'Articles API', type: :request do
    let(:user) {create(:user)}
    let!(:category) {create(:category)}
    let!(:articles) { create_list(:article, 10, category_id: category.id) }
    let(:article_id) { articles.first.id }
    let(:headers) { valid_headers }


    describe 'GET /articles' do
        before { get '/articles', params: {}, headers: headers}

        it 'returns articles' do
            expect(json).not_to be_empty
            expect(json.size).to eq(10)
        end

        it 'returns status code 200' do
            expect(response).to have_http_status(200)
        end
    end


    describe 'GET /articles/:id' do
        before { get "/articles/#{article_id}",params: {}, headers: headers}

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
                expect(response.body).to match(/Couldn't find Article/)
            end
        end
    end

    describe 'POST /articles' do
        let(:category) { create(:category) }
        let(:valid_attributes) { {title: 'Animal Farm',content: 'lsdkfj',category_id: category.id}.to_json}

        context 'when the request is valid' do
            before { post '/articles', params: valid_attributes,headers: headers}

            it 'creates an article' do
                expect(json['title']).to eq('Animal Farm')
            end

            it 'returns status code 201' do
                expect(response).to have_http_status(201)
            end
        end

        context 'when the request is invalid' do
            before {post '/articles', params: {},headers: headers}

            it 'return the status code 402' do
                expect(response).to have_http_status(422)
            end

            it 'returns a validation failure message' do
                expect(response.body).to match(/Validation failed/)
            end
        end
    end

    describe 'PUT /articles/:id' do
        let(:valid_attributes) { {title: '1984'}.to_json}

        context 'when the article exists' do
            before { put "/articles/#{article_id}", params: valid_attributes,headers: headers}

            it 'updates the article' do
                expect(response.body).to be_empty
            end

            it 'returns status code 204' do
                expect(response).to have_http_status(204)
            end
        end
    end

    describe 'DELETE /articles/:id' do
        before { delete "/articles/#{article_id}" , params: {}, headers: headers}

        it 'returns status code 204' do
            expect(response).to have_http_status(204)
        end
    end
end
