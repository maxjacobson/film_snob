# this is a generic parent class for sharing code
describe FilmSnob::OembedProvider do
  describe "initialization" do
    let(:film) { FilmSnob::YouTube.new(url, options) }

    context "when you assure it the URL is a good match" do
      let(:url) { "https://www.youtube.com/watch?v=st21dIMaGMs" }
      let(:options) { { :matched => true } }

      it "can look up the title, but the URL better be related to this site" do
        VCR.use_cassette "youtube/continental breakfast" do
          expect(film.title).to include "Continental Breakfast"
        end
      end
    end

    context "when you do not assure it the URL is a good match" do
      let(:url) { "this just is not a YouTube URL" }
      let(:options) { {} }

      it "will yell at you" do
        expect { film.title }.to raise_error(FilmSnob::NotSupportedURLError,
                                             /can not handle/)
      end
    end
  end
end
