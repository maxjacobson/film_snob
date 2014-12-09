describe FilmSnob::Rutube do
  it "should parse rutube URLs" do
    url = "http://rutube.ru/video/586afc0f5c652439a2dca8b34d19a086/"
    film = FilmSnob.new(url)
    expect(film.id).to eq "586afc0f5c652439a2dca8b34d19a086"
    expect(film.site).to eq :rutube
    VCR.use_cassette "rutube/rabbit_eat_raspberry" do
      expect(film.title).to eq "Кролик ест малину"
      expect { film.html }.not_to raise_error
    end
  end
end

