require 'rails_helper'

describe Timeshow, type: :model do
  let(:movie) { create :movie }
  let(:user) { create :user }
  let(:record) { build :timeshow, start_time: Time.current, price: 2222, movie: movie, user: user }

  describe 'validations' do
    it 'is valid' do
      expect(record).to be_valid
    end

    context 'with missing start time' do
      before do
        record.start_time = nil
      end

      it_behaves_like 'invalid'
    end

    context 'with missing imdb_id' do
      before do
        record.price = nil
      end

      it_behaves_like 'invalid'
    end

    context 'with missing movie' do
      before do
        record.movie_id = nil
      end

      it_behaves_like 'invalid'
    end

    context 'with missing user' do
      before do
        record.user_id = nil
      end

      it_behaves_like 'invalid'
    end
  end
end
