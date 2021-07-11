require 'rails_helper'

describe Timeshows::Destroy do
  subject(:destroyer) { described_class.call(id: timeshow_id, user: user) }

  let!(:user) do
    create :user, username: 'test_user', password_digest: BCrypt::Password.create('test_password')
  end
  let(:movie) { create :movie }

  context 'with existing timeshow' do
    let!(:timeshow) { create :timeshow, movie: movie, user: user }
    let(:timeshow_id) { timeshow.id }

    it 'returns timeshow' do
      expect { destroyer }.to change { user.timeshows.reload.count }.by(-1)
    end
  end

  context 'with missing timeshow' do
    let(:timeshow_id) { 1 }

    it 'raises error' do
      expect { destroyer }.to raise_error(ActiveRecord::RecordNotFound)
    end
  end
end
