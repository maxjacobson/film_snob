describe FilmSnob::Vimeo do
  it "should parse https vimeo URLs" do
    snob = FilmSnob.new("https://vimeo.com/16010689")
    expect(snob.id).to eq "16010689"
    expect(snob.site).to eq :vimeo
    VCR.use_cassette("vimeo/stephen") do
      expect(snob.title).to eq "Days Like Today"
    end
  end

  it "should parse http vimeo URLs" do
    snob = FilmSnob.new("http://vimeo.com/16010689")
    expect(snob.id).to eq "16010689"
    expect(snob.site).to eq :vimeo
  end

  it "should parse mobile vimeo URLs" do
    snob = FilmSnob.new("http://vimeo.com/m/16010689")
    expect(snob.id).to eq "16010689"
    expect(snob.site).to eq :vimeo
    expect(snob.clean_url).to eq "https://vimeo.com/16010689"
  end

  it "should parse staff picks vimeo URLs" do
    snob = FilmSnob.new("http://vimeo.com/channels/staffpicks/58511112")
    expect(snob.id).to eq "58511112"
    expect(snob.site).to eq :vimeo
    expect(snob.clean_url).to eq "https://vimeo.com/58511112"
    VCR.use_cassette("vimeo/staff") do
      expect(snob.title).to eq "DANGER ISLAND"
    end
  end

  it "should parse couchmode vimeo URLs" do
    url = "https://vimeo.com/couchmode/staffpicks/sort:date/91157088"
    snob = FilmSnob.new(url)
    expect(snob.id).to eq "91157088"
    expect(snob.site).to eq :vimeo
    expect(snob.clean_url).to eq "https://vimeo.com/91157088"

    url2 = "https://vimeo.com/couchmode/watchlater/sort:date/51020067"
    snob2 = FilmSnob.new(url2)
    expect(snob2.id).to eq "51020067"
    expect(snob2.site).to eq :vimeo
    expect(snob2.clean_url).to eq "https://vimeo.com/51020067"
  end

  it "should allow oembed configuration" do
    snob = FilmSnob.new("http://vimeo.com/31158841", width: 400)
    VCR.use_cassette("vimeo/murmuration") do
      expect(snob.html).to match(/width="400"/)
    end

    snob2 = FilmSnob.new("http://vimeo.com/31158841", width: 500)
    VCR.use_cassette("vimeo/murmuration2") do
      expect(snob2.html).to match(/width="500"/)
    end
  end
end

