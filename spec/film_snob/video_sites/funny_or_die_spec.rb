describe "funny or die URLs" do
  it "should parse funny or die URLs" do
    film = FilmSnob.new("http://www.funnyordie.com/videos/8db066d2e0/" \
                        "the-live-read-of-space-jam-with-blake-griffin")
    expect(film.id).to eq "8db066d2e0"
    expect(film.site).to eq :funnyordie
    VCR.use_cassette "funnyordie/space jam" do
      expect(film.title).to eq "The Live Read of Space Jam with Blake Griffin"
      expect { film.html }.not_to raise_error
    end
  end
end

