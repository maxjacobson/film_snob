require_relative "spec_helper"

describe FilmSnob::YouTube do
  it "may not be embeddable" do
    VCR.use_cassette("youtube/bad_youtube_url") do
      snob = FilmSnob.new("http://youtube.com/watch?v=malformedid")
      expect { snob.html }.to raise_error(FilmSnob::NotEmbeddableError)
    end
  end

  it "can handle junked up URLs" do
    VCR.use_cassette("youtube/pete") do
      url = "http://www.youtube.com/watch?feature=youtube_gdata&v=fq-xGD_thXo"
      title = "Pete Meets Olympic Freestyle Skier Torin Yater-Wallace"
      film = FilmSnob.new(url)
      expect(film).to be_watchable
      expect(film.id).to eq "fq-xGD_thXo"
      expect { film.html }.to_not raise_error
      expect(film.title).to eq title
    end
  end

  it "can handle even more junked up URLs" do
    VCR.use_cassette("youtube/dilla") do
      url = "http://www.youtube.com/watch?feature=youtu.be&v=lC0JFXw_6kQ"
      title = "BINKBEATS Beats Unraveled #6: J. Dilla Live Mixtape"
      film = FilmSnob.new(url)

      expect(film).to be_watchable
      expect(film.id).to eq "lC0JFXw_6kQ"
      expect { film.html }.to_not raise_error
      expect(film.title).to eq title
    end
  end
end

