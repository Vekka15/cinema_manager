# frozen_string_literal: true

module Api
  module V1
    class MovieSerializer < BaseSerializer
      context_attributes :title,
                         :year,
                         :rated,
                         :released,
                         :runtime,
                         :genre,
                         :director,
                         :writer,
                         :actors,
                         :plot,
                         :language,
                         :country,
                         :awards,
                         :poster,
                         :ratings,
                         :metascore,
                         :imdb_rating,
                         :imdb_votes,
                         :imdb_id,
                         :type,
                         :DVD,
                         :box_office,
                         :production,
                         :website,
                         :response
    end
  end
end
