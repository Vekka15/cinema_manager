require 'rails_helper'

describe JsonWebToken do
  subject { described_class }

  let(:user) { create :user }

  before do
    Timecop.freeze
  end

  describe '#encode' do
    it 'encodes data' do
      expect(subject.encode(user_id: user.id)).to eq jwt_token_for_user(user)
    end
  end

  describe '#decode' do
    let(:token) { jwt_token_for_user(user) }

    it 'decodes data' do
      expect(subject.decode(token)).
        to eq(
          { 'user_id' => user.id, 'exp' => 24.hours.from_now.to_i }
        )
    end
  end
end
