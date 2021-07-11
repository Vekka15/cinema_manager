require 'rails_helper'

describe Timeshows::Retrieve do
  subject(:retriever) { described_class.call(user_id: user_id, movie_id: movie.id) }

  let!(:user) do
    create :user, username: 'test_user', password_digest: BCrypt::Password.create('test_password')
  end
  let!(:movie) { create :movie }
  let!(:timeshow) { create :timeshow, movie: movie, user: user }
  let!(:other_movie) { create :movie }
  let!(:other_timeshow) { create :timeshow, movie: other_movie, user: user }

  context 'with user id' do
    let(:user_id) { user.id }

    it 'returns timeshows' do
      expect(retriever).to include timeshow
    end
  end

  context 'without user id' do
    let(:user_id) { nil }

    it 'returns timeshows' do
      expect(retriever).to include timeshow
    end
  end
end
