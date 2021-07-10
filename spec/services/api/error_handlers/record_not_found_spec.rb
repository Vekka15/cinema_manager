require 'rails_helper'

describe Api::ErrorHandlers::RecordNotFound do
  subject(:handler) { described_class.new(exception).respond }

  let(:exception) { ActiveRecord::RecordNotFound.new }

  before do
    allow(exception).to receive(:backtrace).and_return([])
  end

  it 'returns exception message' do
    expect(
      JSON.parse(handler.body[0])['error']
    ).to eq '404 Not Found'
  end

  it 'returns status' do
    expect(handler.status).to eq 404
  end
end