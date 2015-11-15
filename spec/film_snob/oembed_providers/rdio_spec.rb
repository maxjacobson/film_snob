describe FilmSnob::Rdio do
  describe "rdio URLs" do
    let(:url) { "http://www.rdio.com/#{path}" }

    context "when the URL is an album" do
      let(:path) { "artist/Sam_Smith/album/In_The_Lonely_Hour/" }

      it "should parse" do
        snob = FilmSnob.new(url)
        expect(snob).to be_embeddable
        expect(snob.site).to eq :rdio
        VCR.use_cassette("rdio/in the lonely hour") do
          expect(snob.title).to eq "In The Lonely Hour"
          expect(snob.html).to include "iframe"
        end
      end
    end

    context "a song" do
      let(:path) do
        "artist/Sam_Smith/album/In_The_Lonely_Hour/track/Stay_With_Me"
      end
      it "should parse normal track rdio URLs" do
        snob = FilmSnob.new(url)
        expect(snob).to be_embeddable
        expect(snob.site).to eq :rdio
        VCR.use_cassette("rdio/stay with me") do
          expect(snob.title).to eq "Stay With Me"
        end
      end
    end

    it "should not allow weak matches for rdio urls" do
      snob = FilmSnob.new("google.com/q=rdio")
      expect(snob).to_not be_embeddable
    end
  end
end
