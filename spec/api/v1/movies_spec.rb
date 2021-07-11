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
end
