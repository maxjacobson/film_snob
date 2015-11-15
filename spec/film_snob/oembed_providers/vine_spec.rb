describe FilmSnob::Vine do
  it "should parse URLs" do
    film = FilmSnob.new("https://vine.co/v/1")
    expect(film.id).to eq "1"
    expect(film.site).to eq :vine
    VCR.use_cassette "vine/dom hofman" do
      expect(film.title).to eq "Dom Hofmann's post on Vine"
      expect { film.html }.not_to raise_error
    end
  end
end
