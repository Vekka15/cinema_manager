require 'rails_helper'

describe Api::ErrorHandlers::Base do
  subject(:handler) { described_class.new(exception).respond }

  let(:exception) { double(message: 'Custom message', status: status) }
  let(:status) { nil }

  it 'returns exception message' do
    expect(
      JSON.parse(handler.body[0])['error']
    ).to eq 'Custom message'
  end

  context 'with exception status' do
    let(:status) { 401 }

    it 'returns status' do
      expect(handler.status).to eq status
    end
  end

  context 'with default status' do
    it 'returns status' do
      expect(handler.status).to eq 400
    end
  end
end