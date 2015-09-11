describe FilmSnob::Dailymotion do
  it "should parse https dailymotion URLs" do
    url = "https://www.dailymotion.com/video/xf02xp_uffie-difficult_music"
    snob = FilmSnob.new(url)
    expect(snob.id).to eq "xf02xp_uffie-difficult_music"
    expect(snob.site).to eq :dailymotion
    VCR.use_cassette("dailymotion/music") do
      expect(snob.title).to eq "Uffie - Difficult"
    end
  end

  it "should parse http dailymotion URLs" do
    url = "http://www.dailymotion.com/video/xf02xp_uffie-difficult_music"
    snob = FilmSnob.new(url)
    expect(snob.id).to eq "xf02xp_uffie-difficult_music"
    expect(snob.site).to eq :dailymotion
  end

  it "should parse mobile dailymotion URLs" do
    url = "http://touch.dailymotion.com/video/xf02xp_uffie-difficult_music"
    clean = "https://www.dailymotion.com/video/xf02xp_uffie-difficult_music"
    snob = FilmSnob.new(url)
    expect(snob.id).to eq "xf02xp_uffie-difficult_music"
    expect(snob.site).to eq :dailymotion
    expect(snob.clean_url).to eq clean
  end

  it "should allow oembed configuration" do
    snob = FilmSnob.new(
      "http://www.dailymotion.com/video/xf02xp_uffie-difficult_music",
      maxwidth: 400
    )
    VCR.use_cassette("dailymotion/music1") do
      expect(snob.html).to match(/width="400"/)
    end

    snob2 = FilmSnob.new(
      "http://www.dailymotion.com/video/xf02xp_uffie-difficult_music",
      maxwidth: 500
    )
    VCR.use_cassette("dailymotion/music500") do
      expect(snob2.html).to match(/width="500"/)
    end
  end
end
