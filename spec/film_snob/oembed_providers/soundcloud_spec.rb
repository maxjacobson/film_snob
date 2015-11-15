describe FilmSnob::Soundcloud do
  it "should parse normal Soundcloud URLs" do
    snob = FilmSnob.new(
      "https://soundcloud.com/theweeknd/the-weeknd-king-of-the-fall"
    )
    expect(snob).to be_embeddable
    expect(snob.id).to eq "theweeknd/the-weeknd-king-of-the-fall"
    expect(snob.site).to eq :soundcloud
    VCR.use_cassette("soundcloud/theweeknd") do
      expect(snob.title).to eq "The Weeknd - King Of The Fall by The Weeknd"
    end
  end

  it "should parse http url patterns" do
    snob = FilmSnob.new(
      "http://soundcloud.com/theweeknd/the-weeknd-king-of-the-fall"
    )
    expect(snob).to be_embeddable
    expect(snob.id).to eq "theweeknd/the-weeknd-king-of-the-fall"
    expect(snob.site).to eq :soundcloud
    VCR.use_cassette("soundcloud/theweeknd-http") do
      expect(snob.title).to eq "The Weeknd - King Of The Fall by The Weeknd"
    end
  end

  it "should parse mobile URL patterns" do
    snob = FilmSnob.new(
      "https://m.soundcloud.com/theweeknd/the-weeknd-king-of-the-fall"
    )
    expect(snob).to be_embeddable
    expect(snob.id).to eq "theweeknd/the-weeknd-king-of-the-fall"
    expect(snob.site).to eq :soundcloud
    VCR.use_cassette("soundcloud/theweeknd-mobile") do
      expect(snob.title).to eq "The Weeknd - King Of The Fall by The Weeknd"
    end
  end

  it "should not parse a page that does not contain an embedded song" do
    snob = FilmSnob.new("https://soundcloud.com/david_rees")
    expect(snob).to_not be_embeddable
  end

  it "should parse an ID from an extended URI" do
    snob = FilmSnob.new(
      "https://soundcloud.com/coxncrendor/youtube-rewind?utm_source=feedburner"
    )
    expect(snob).to be_embeddable
    expect(snob.id).to eq "coxncrendor/youtube-rewind"
  end

  context "with oembed configuration" do
    it "should allow user to set the iframe width" do
      snob = FilmSnob.new(
        "https://soundcloud.com/theweeknd/the-weeknd-king-of-the-fall",
        :maxwidth => 500
      )
      VCR.use_cassette("soundcloud/maxwidth") do
        expect(snob.html).to match(/width="500"/)
      end
    end

    it "should allow user to set autoplay" do
      snob = FilmSnob.new(
        "https://soundcloud.com/theweeknd/the-weeknd-king-of-the-fall",
        :auto_play => true
      )
      VCR.use_cassette("soundcloud/autoplay") do
        expect(snob.html).to match(/auto_play=true/)
      end
    end
  end
end
