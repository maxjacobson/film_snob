require_relative 'spec_helper'

describe FilmSnob::YouTube do
  it 'may not be embeddable' do
    VCR.use_cassette('bad_youtube_url') do
      snob = FilmSnob.new('http://youtube.com/watch?v=malformedid')
      video = snob.video
      expect{video.html}.to raise_error(FilmSnob::NotEmbeddableError)
    end
  end
end
