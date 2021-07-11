require 'rails_helper'

describe OpenMovieFetcher do
  subject(:fetcher) { described_class.call(movie: movie) }

  let!(:movie) { create :movie }
  let(:stubbed_request) do
    stub_request(
      :get,
      ENV['OPEN_MOVIE_URL'] + "?apikey=#{ENV['OPEN_MOVIE_API_KEY']}&i=#{ENV['MOVIE_IMDB_ID']}"
    ).to_return(status: 200, headers: {}, body: body.to_json)
  end

  before do
    stubbed_request
  end

  context 'with existing movie' do
    let(:body) { { 'Title' => 'Movie title', 'Response' => 'True' } }

    it 'returns movie body' do
      expect(fetcher).to eq body
    end
  end

  context 'with missing movie' do
    let(:body) { { 'Title' => 'Movie title', 'Response' => 'False' } }

    it 'raises error' do
      expect { fetcher }.to raise_error(::MovieNotFoundError)
    end
  end
end
