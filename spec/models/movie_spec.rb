require 'rails_helper'

describe Movie, type: :model do
  let(:record) { build :movie, title: 'test', imdb_id: 'test' }

  describe 'validations' do
    it 'is valid' do
      expect(record).to be_valid
    end

    context 'with missing title' do
      before do
        record.title = nil
      end

      it_behaves_like 'invalid'
    end

    context 'with missing imdb_id' do
      before do
        record.imdb_id = nil
      end

      it_behaves_like 'invalid'
    end
  end
end
