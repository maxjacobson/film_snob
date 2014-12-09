describe FilmSnob do
  describe "not supported URLs" do
    it "should handle non-supported URLs gracefully" do
      snob = FilmSnob.new("http://hardscrabble.net")
      expect(snob).to_not be_embeddable
    end

    it "should raise an exception if you push your luck" do
      snob = FilmSnob.new("http://hardscrabble.net")
      expect(snob).to_not be_embeddable
      expect { snob.id }.to raise_error(FilmSnob::NotSupportedURLError)
    end
  end
end

