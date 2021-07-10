require 'rails_helper'

describe Api::ErrorHandlers::GrapeValidation do
  subject(:handler) { described_class.new(exception).respond }

  let(:exception) { double(errors: { ['password'] => [grape_exception] }) }
  let(:grape_exception) { double(Grape::Exceptions::Validation) }

  before do
    allow(grape_exception).to receive(:message).and_return('is missing')
  end

  it 'returns exception message' do
    expect(
      JSON.parse(handler.body[0])['errors']
    ).to eq [{'field' => 'password', 'message' => 'is missing' }]
  end

  it 'returns status' do
    expect(handler.status).to eq 400
  end
end