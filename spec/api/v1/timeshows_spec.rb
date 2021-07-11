require 'rails_helper'

describe V1::Timeshows, type: :request do
  let!(:user) do
    create :user, username: 'test_user', password_digest: BCrypt::Password.create('test_password')
  end
  let(:movie) { create :movie }

  let(:params) { { username: username, password: password } }

  describe 'POST /' do
    subject(:post_action) { post_with_token basic_path, params: params }

    let(:basic_path) { '/api/v1/timeshows' }
    let(:params) do
      {
        timeshow: {
          start_time: Time.current,
          movie_id: movie.id,
          price: 1111
        }
      }
    end

    context 'with valid params' do
      it 'creates provider' do
        expect { post_action }.to change { user.timeshows.count }.by 1
      end

      it 'returns timeshow' do
        post_action
        expect(parsed_body).to eq Api::V1::TimeshowSerializer.new(Timeshow.last).as_json
      end

      it 'returns success' do
        post_action
        expect(response).to be_created
      end
    end

    context 'with timeshow missing' do
      let(:params) do
        {}
      end

      it 'does not create timeshow' do
        expect { post_action }.not_to change { user.timeshows.count }
      end

      it 'return failure' do
        post_action
        expect(response.status).to eq 400
      end

      it 'return errors' do
        post_action
        expect(parsed_body).to include(
          'errors' => array_including(
            { 'field' => 'base', 'message' => 'is missing' },
            { 'field' => 'start_time', 'message' => 'is missing' },
            { 'field' => 'price', 'message' => 'is missing' },
            { 'field' => 'movie_id', 'message' => 'is missing' }
          )
        )
      end
    end

    context 'with fields missing in patient' do
      let(:params) do
        { timeshow: { price: 2222 } }
      end

      it 'does not create patient' do
        expect { post_action }.not_to change { user.timeshows.count }
      end

      it 'return failure' do
        post_action
        expect(response.status).to eq 400
      end

      it 'return errors' do
        post_action
        expect(parsed_body).to include(
          'errors' => array_including(
            { 'field' => 'start_time', 'message' => 'is missing' },
            { 'field' => 'movie_id', 'message' => 'is missing' }
          )
        )
      end
    end
  end

  describe 'PATCH /:id' do
    subject(:patch_action) { patch_with_token basic_path, params: params }

    let(:timeshow) { create :timeshow, price: 2222, user: user, movie: movie }
    let(:basic_path) { "/api/v1/timeshows/#{timeshow.id}" }
    let(:params) do
      {
        timeshow: {
          price: 1111
        }
      }
    end

    context 'with valid params' do
      it 'creates provider' do
        expect { patch_action }.to change { timeshow.reload.price }.from(2222).to(1111)
      end

      it 'returns timeshow' do
        patch_action
        expect(parsed_body).to eq Api::V1::TimeshowSerializer.new(timeshow.reload).as_json
      end

      it 'returns success' do
        patch_action
        expect(response.status).to eq 200
      end
    end

    context 'with invalid params' do
      let(:params) do
        { timeshow: { price: '' } }
      end

      it 'does not update patient' do
        expect { patch_action }.not_to change { timeshow.reload.price }
      end

      it 'returns failure' do
        patch_action
        expect(response.status).to eq 400
      end

      it 'returns error' do
        patch_action
        expect(parsed_body).
          to include 'error' => "Validation failed: Price can't be blank"
      end
    end
  end

  describe 'DELETE /:id' do
    subject(:delete_action) { delete_with_token basic_path }

    let!(:timeshow) { create :timeshow, price: 2222, user: user, movie: movie }
    let(:basic_path) { "/api/v1/timeshows/#{timeshow.id}" }

    it 'deletes patient' do
      expect { delete_action }.to change { user.timeshows.count }.by -1
    end

    it 'returns success' do
      delete_action
      expect(response.status).to eq 204
    end
  end
end
