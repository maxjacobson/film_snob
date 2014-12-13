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

  it "should support http url patterns" do 
    snob = FilmSnob.new("http://soundcloud.com/david_rees/we-are-never-ever-getting-girl-boygether")
    expect(snob).to be_embeddable
    expect(snob.id).to eq "david_rees/we-are-never-ever-getting-girl-boygether"
    expect(snob.site).to eq :soundcloud
    VCR.use_cassette("soundcloud/taylor-swift") do
      expect(snob.title).to eq "APHEX SWIFT: We Are Never Ever Getting Girl/Boygether by David_Rees"
    end
  end

end