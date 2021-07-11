require 'rails_helper'

describe Timeshows::Update do
  subject(:updater) { described_class.call(id: timeshow.id, user: user, params: params) }

  let!(:user) do
    create :user, username: 'test_user', password_digest: BCrypt::Password.create('test_password')
  end
  let!(:movie) { create :movie }
  let(:timeshow) { create :timeshow, movie: movie, user: user }

  context 'with correct params' do
    let(:params) do
      {
        timeshow: {
          price: 2222
        }
      }
    end

    it 'returns timeshow' do
      expect { updater }.to change { timeshow.reload.price }.to(2222)
    end
  end

  context 'with incorrect params' do
    let(:params) do
      {
        timeshow: {
          start_time: ''
        }
      }
    end

    it 'raises error' do
      expect { updater }.to raise_error(ActiveRecord::RecordInvalid)
    end
  end
end
