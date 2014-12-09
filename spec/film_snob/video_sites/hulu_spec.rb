describe FilmSnob::Hulu do
  it "should parse hulu URLs" do
    snob = FilmSnob.new("http://www.hulu.com/watch/285095")
    expect(snob.id).to eq "285095"
    expect(snob.site).to eq :hulu
    VCR.use_cassette("hulu/harmon") do
      expect(snob.title).to eq "Remedial Chaos Theory (Community)"
      expect { snob.html }.not_to raise_error
    end
  end
end

