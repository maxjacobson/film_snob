describe FilmSnob::Coub do
  it "should parse coub URLs" do
    film = FilmSnob.new("http://coub.com/view/rcd14cm")
    expect(film.id).to eq "rcd14cm"
    expect(film.site).to eq :coub
    VCR.use_cassette "coub/voodoo_people" do
      expect(film.title).to eq "voodoo people"
      expect { film.html }.not_to raise_error
    end
  end
end
