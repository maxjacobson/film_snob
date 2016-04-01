describe FilmSnob::Vine do
  it "should parse URLs" do
    film = FilmSnob.new("https://vine.co/v/OMqDr7r0bKI")
    expect(film.id).to eq "OMqDr7r0bKI"
    expect(film.site).to eq :vine
    VCR.use_cassette "vine/barbie" do
      expect(film.title).to eq "BarbieQ 🙅🔥🔥 #suicidefairy"
      expect { film.html }.not_to raise_error
    end
  end
end
