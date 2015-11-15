describe FilmSnob::Instagram do
  it "should parse normal instagram URLs" do
    film = FilmSnob.new("http://instagram.com/p/oBkLq7hnDP/")
    expect(film.id).to eq "oBkLq7hnDP"
    expect(film.site).to eq :instagram
    VCR.use_cassette "instagram/sphynx cat" do
      expect(film.title).to match "Very stupid package!"
      expect { film.html }.not_to raise_error
    end
  end
  it "should handle https urls" do
    film = FilmSnob.new("https://instagram.com/p/otxnbOocqJ/")
    expect(film).to be_embeddable
    expect(film.site).to eq :instagram
    expect(film.id).to eq "otxnbOocqJ"
  end
  it "should handle instagr.am urls" do
    film = FilmSnob.new("http://instagr.am/p/otxnbOocqJ/")
    expect(film).to be_embeddable
    expect(film.site).to eq :instagram
    expect(film.id).to eq "otxnbOocqJ"
  end
  it "should handle https instagr.am urls" do
    film = FilmSnob.new("https://instagr.am/p/otxnbOocqJ/")
    expect(film).to be_embeddable
    expect(film.site).to eq :instagram
    expect(film.id).to eq "otxnbOocqJ"
  end
  it "should raise error when the URL is not embeddable" do
    film = FilmSnob.new("http://instagram.com/p/nothinghere/")
    VCR.use_cassette "instagram/nothing" do
      expect { film.html }.to raise_error FilmSnob::NotEmbeddableError
      expect { film.title }.to raise_error FilmSnob::NotEmbeddableError
    end
  end
end
