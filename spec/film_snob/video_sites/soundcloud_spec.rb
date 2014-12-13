describe FilmSnob::Soundcloud do 

  it "should parse normal Soundcloud URLs" do
    snob = FilmSnob.new("https://soundcloud.com/david_rees/we-are-never-ever-getting-girl-boygether")
    expect(snob).to be_embeddable
    expect(snob.id).to eq "david_rees/we-are-never-ever-getting-girl-boygether"
    expect(snob.site).to eq :soundcloud
    VCR.use_cassette("soundcloud/taylor-swift") do
      expect(snob.title).to eq "APHEX SWIFT: We Are Never Ever Getting Girl/Boygether by David_Rees"
    end
  end

  it "should parse http url patterns" do 
    snob = FilmSnob.new("http://soundcloud.com/david_rees/we-are-never-ever-getting-girl-boygether")
    expect(snob).to be_embeddable
    expect(snob.id).to eq "david_rees/we-are-never-ever-getting-girl-boygether"
    expect(snob.site).to eq :soundcloud
    VCR.use_cassette("soundcloud/taylor-swift") do
      expect(snob.title).to eq "APHEX SWIFT: We Are Never Ever Getting Girl/Boygether by David_Rees"
    end
  end

  it "should parse mobile URL patterns" do 
    snob = FilmSnob.new("https://m.soundcloud.com/david_rees/we-are-never-ever-getting-girl-boygether")
    expect(snob).to be_embeddable
    expect(snob.id).to eq "david_rees/we-are-never-ever-getting-girl-boygether"
    expect(snob.site).to eq :soundcloud
    VCR.use_cassette("soundcloud/taylor-swift") do
      expect(snob.title).to eq "APHEX SWIFT: We Are Never Ever Getting Girl/Boygether by David_Rees"
    end
  end

  it "should not parse a page that does not contain an embedded song" do 
    snob = FilmSnob.new("https://soundcloud.com/david_rees")
    expect(snob).to_not be_embeddable
  end

  context "with oembed configuration" do 

    it "should allow user to set the iframe width" do 
      snob = FilmSnob.new(
        "https://soundcloud.com/david_rees/we-are-never-ever-getting-girl-boygether",
        maxwidth: 500
      )
      VCR.use_cassette("soundcloud/maxwidth") do
        expect(snob.html).to match(/width="500"/)
      end
    end

    it "should allow user to set autoplay" do 
      snob = FilmSnob.new(
        "https://soundcloud.com/david_rees/we-are-never-ever-getting-girl-boygether",
        auto_play: true
      )
      VCR.use_cassette("soundcloud/autoplay") do
        expect(snob.html).to match(/auto_play=true/)
      end
    end

  end

end