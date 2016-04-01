describe FilmSnob::YouTube do
  it "should parse normal YouTube URLs" do
    snob = FilmSnob.new("https://www.youtube.com/watch?v=7q5Ltr0qc8c")
    expect(snob).to be_embeddable
    expect(snob.id).to eq "7q5Ltr0qc8c"
    expect(snob.site).to eq :youtube
    VCR.use_cassette("youtube/billy") do
      expect(snob.title).to eq "Billy on the Street: Amateur Speed Sketching!"
    end
  end

  it "should parse YouTube URLs with dashes" do
    snob = FilmSnob.new("https://www.youtube.com/watch?v=xa-KBqOFgDQ")
    expect(snob).to be_embeddable
    expect(snob.id).to eq "xa-KBqOFgDQ"
    expect(snob.site).to eq :youtube
  end

  it "should parse YouTube URLs with underscores" do
    # first video I could find with an underscore
    snob = FilmSnob.new("https://www.youtube.com/watch?v=HPR3PB_VGVs")
    expect(snob).to be_embeddable
    expect(snob.id).to eq "HPR3PB_VGVs"
    expect(snob.site).to eq :youtube
  end

  it "should parse mobile YouTube URLs" do
    url = "https://m.youtube.com/watch?v=6dyeFalOjw0&feature=youtu.be"
    snob = FilmSnob.new(url)
    expect(snob.id).to eq "6dyeFalOjw0"
    expect(snob.site).to eq :youtube
    expect(snob.clean_url).to eq "https://www.youtube.com/watch?v=6dyeFalOjw0"
  end

  it "should parse short YouTube URLs" do
    snob = FilmSnob.new("http://youtu.be/1Ee4bfu_t3c")
    expect(snob.id).to eq "1Ee4bfu_t3c"
    expect(snob.site).to eq :youtube
    expect(snob.clean_url).to eq "https://www.youtube.com/watch?v=1Ee4bfu_t3c"
  end

  it "should raise a not embeddable error for a missing video URL" do
    VCR.use_cassette("youtube/missing video") do
      snob = FilmSnob.new("https://youtube.com/watch?v=malformedid")
      expect { snob.title }.to raise_error(FilmSnob::NotEmbeddableError)
    end
  end

  it "may not be embeddable" do
    VCR.use_cassette("youtube/bad_youtube_url") do
      snob = FilmSnob.new("http://youtube.com/watch?v=malformedid")
      expect { snob.html }.to raise_error(FilmSnob::NotEmbeddableError)
    end
  end

  it "can handle junked up URLs" do
    VCR.use_cassette("youtube/oliver") do
      url = "http://www.youtube.com/watch?feature=youtube_gdata&v=vU8dCYocuyI"
      title = "Last Week Tonight with John Oliver: Border Wall (HBO)"
      film = FilmSnob.new(url)
      expect(film).to be_embeddable
      expect(film.id).to eq "vU8dCYocuyI"
      expect { film.html }.to_not raise_error
      expect(film.title).to eq title
    end
  end

  it "can handle even more junked up URLs" do
    VCR.use_cassette("youtube/dilla") do
      url = "http://www.youtube.com/watch?feature=youtu.be&v=lC0JFXw_6kQ"
      title = "BINKBEATS Beats Unraveled #6: J. Dilla Live Mixtape"
      film = FilmSnob.new(url)

      expect(film).to be_embeddable
      expect(film.id).to eq "lC0JFXw_6kQ"
      expect { film.html }.to_not raise_error
      expect(film.title).to eq title
    end
  end

  # I forget where I even saw this URL. I think in my RSS reader.
  it "should parse direct embed URLs" do
    snob = FilmSnob.new("https://www.youtube.com/v/sLSFOCyNC8Q")
    expect(snob.id).to eq "sLSFOCyNC8Q"
    expect(snob.site).to eq :youtube
    expect(snob.clean_url).to eq "https://www.youtube.com/watch?v=sLSFOCyNC8Q"
  end

  it "should allow specifying the width of the video" do
    film = FilmSnob.new("https://www.youtube.com/watch?v=ky9Ro9pP2gc",
                        :maxwidth => 350)
    VCR.use_cassette "youtube/joanna1" do
      expect(film.title).to include "Joanna"
      expect(film.html).to include "350"
    end
  end

  it "should allow specifying the width of the video via width option" do
    film = FilmSnob.new("https://www.youtube.com/watch?v=ky9Ro9pP2gc",
                        :width => 350)
    VCR.use_cassette "youtube/joanna2" do
      expect(film.title).to include "Joanna"
      expect(film.html).to include "350"
    end
  end
end
