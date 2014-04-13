require 'film_snob'

describe FilmSnob do

  describe 'not supported URLs' do

    it 'should handle non-supported URLs gracefully' do
      snob = FilmSnob.new("http://hardscrabble.net")
      expect(snob.video).to be_nil
    end

    it 'should raise an exception if you push your luck' do
      snob = FilmSnob.new("http://hardscrabble.net")
      expect(snob).to_not be_watchable
      expect{snob.id}.to raise_error(FilmSnob::NotSupportedURLError)
    end

  end

  describe 'YouTube URLs' do

    it 'should parse normal YouTube URLs' do
      snob = FilmSnob.new("https://www.youtube.com/watch?v=7q5Ltr0qc8c")
      expect(snob).to be_watchable
      expect(snob.id).to eq "7q5Ltr0qc8c"
      expect(snob.site).to eq :youtube
    end

    it 'should parse YouTube URLs with dashes' do
      snob = FilmSnob.new("https://www.youtube.com/watch?v=xa-KBqOFgDQ")
      expect(snob).to be_watchable
      expect(snob.id).to eq "xa-KBqOFgDQ"
      expect(snob.site).to eq :youtube
    end

    it 'should parse YouTube URLs with underscores' do
      # first video I could find with an underscore
      snob = FilmSnob.new("https://www.youtube.com/watch?v=HPR3PB_VGVs")
      expect(snob).to be_watchable
      expect(snob.id).to eq "HPR3PB_VGVs"
      expect(snob.site).to eq :youtube
    end

    it 'should parse mobile YouTube URLs' do
      snob = FilmSnob.new("https://m.youtube.com/watch?v=6dyeFalOjw0&feature=youtu.be")
      expect(snob.id).to eq "6dyeFalOjw0"
      expect(snob.site).to eq :youtube
      expect(snob.clean_url).to eq "https://www.youtube.com/watch?v=6dyeFalOjw0"
    end

    it 'should parse short YouTube URLs' do
      snob = FilmSnob.new("http://youtu.be/1Ee4bfu_t3c")
      expect(snob.id).to eq "1Ee4bfu_t3c"
      expect(snob.site).to eq :youtube
      expect(snob.clean_url).to eq "https://www.youtube.com/watch?v=1Ee4bfu_t3c"
    end

  end

  describe 'vimeo URLs' do
    it 'should parse https vimeo URLs' do
      snob = FilmSnob.new("https://vimeo.com/16010689")
      expect(snob.id).to eq "16010689"
      expect(snob.site).to eq :vimeo
    end

    it 'should parse http vimeo URLs' do
      snob = FilmSnob.new("http://vimeo.com/16010689")
      expect(snob.id).to eq "16010689"
      expect(snob.site).to eq :vimeo
    end

    it 'should parse mobile vimeo URLs' do
      snob = FilmSnob.new("http://vimeo.com/m/16010689")
      expect(snob.id).to eq "16010689"
      expect(snob.site).to eq :vimeo
      expect(snob.clean_url).to eq "https://vimeo.com/16010689"
    end

    it 'should parse couchmode vimeo URLs' do
      snob = FilmSnob.new("https://vimeo.com/couchmode/staffpicks/sort:date/91157088")
      expect(snob.id).to eq "91157088"
      expect(snob.site).to eq :vimeo

      snob2 = FilmSnob.new("https://vimeo.com/couchmode/watchlater/sort:date/51020067")
      expect(snob2.id).to eq "51020067"
      expect(snob2.site).to eq :vimeo
    end


  end

  describe 'hulu URLs' do
    it 'should parse hulu URLs' do
      snob = FilmSnob.new("http://www.hulu.com/watch/285095")
      expect(snob.id).to eq '285095'
      expect(snob.site).to eq :hulu
    end
  end

end
