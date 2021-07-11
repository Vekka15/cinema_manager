require 'rails_helper'

describe Timeshows::Create do
  subject(:creator) { described_class.call(user: user, params: params) }

  let!(:user) do
    create :user, username: 'test_user', password_digest: BCrypt::Password.create('test_password')
  end
  let!(:movie) { create :movie }

  context 'with correct params' do
    let(:params) do
      {
        timeshow: {
          start_time: Time.current,
          price: 1111,
          movie_id: movie.id
        }
      }
    end

    it 'returns timeshow' do
      expect { creator }.to change { user.timeshows.count }.by(1)
    end
  end

  context 'with incorrect params' do
    let(:params) do
      {
        timeshow: {
          start_time: Time.current
        }
      }
    end

    it 'raises error' do
      expect { creator }.to raise_error(ActiveRecord::RecordInvalid)
    end
  end
end
