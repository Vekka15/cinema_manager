require 'rails_helper'

describe V1::Movies, type: :request do
  let!(:user) do
    create :user, username: 'test_user', password_digest: BCrypt::Password.create('test_password')
  end
  let!(:movie) { create :movie }
  let!(:other_movie) { create :movie }
  let!(:timeshow) { create :timeshow, movie: movie, user: user }
  let!(:other_timeshow) { create :timeshow, movie: other_movie, user: user }

  let(:params) { { username: username, password: password } }

  describe 'GET /:id/timeshows' do
    subject(:get_action) { get_with_token basic_path }

    let(:basic_path) { "/api/v1/movies/#{movie.id}/timeshows" }

    context 'without owner id' do
      before { get_action }

      it 'returns movie timeshows' do
        expect(parsed_body).
          to eq Api::V1::TimeshowSerializer.new([timeshow]).as_json
      end

      it 'does not return other movie timeshows' do
        expect(parsed_body).
          not_to eq Api::V1::TimeshowSerializer.new([other_timeshow]).as_json
      end

      it 'returns success' do
        get_action
        expect(response.status).to eq 200
      end
    end
  end

  describe 'GET /:id/details' do
    subject(:get_action) { get_with_token basic_path }

    let(:basic_path) { "/api/v1/movies/#{movie.id}/details" }
    let(:stubbed_request) do
      stub_request(
        :get,
        ENV['OPEN_MOVIE_URL'] + "?apikey=#{ENV['OPEN_MOVIE_API_KEY']}&i=#{ENV['MOVIE_IMDB_ID']}"
      ).to_return(status: 200, headers: {}, body: body.to_json)
    end

    before do
      stubbed_request
      get_action
    end

    context 'with existing movie' do
      let(:body) { { 'Title' => 'Movie title', 'Response' => 'True' } }

      it 'returns success' do
        expect(response).to be_successful
      end

      it 'return movie' do
        expect(parsed_body['data']['attributes']).to include('title' => 'Movie title')
      end
    end

    context 'with missing movie' do
      let(:body) { { 'Title' => 'Movie title', 'Response' => 'False' } }

      it 'returns failure' do
        expect(response.status).to eq 404
      end

      it 'return error' do
        expect(parsed_body).to eq('error' => 'Movie was not found in Open Movie Database.')
      end
    end
  end
end
