require_relative 'spec_helper'

describe FilmSnob do
  describe 'not supported URLs' do
    it 'should handle non-supported URLs gracefully' do
      snob = FilmSnob.new("http://hardscrabble.net")
      expect(snob).to_not be_watchable
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
      expect(snob.id).to eq '7q5Ltr0qc8c'
      expect(snob.site).to eq :youtube
      VCR.use_cassette('youtube/billy') do
        expect(snob.title).to eq 'Billy on the Street: Amateur Speed Sketching!'
      end
    end

    it 'should parse YouTube URLs with dashes' do
      snob = FilmSnob.new("https://www.youtube.com/watch?v=xa-KBqOFgDQ")
      expect(snob).to be_watchable
      expect(snob.id).to eq 'xa-KBqOFgDQ'
      expect(snob.site).to eq :youtube
    end

    it 'should parse YouTube URLs with underscores' do
      # first video I could find with an underscore
      snob = FilmSnob.new("https://www.youtube.com/watch?v=HPR3PB_VGVs")
      expect(snob).to be_watchable
      expect(snob.id).to eq 'HPR3PB_VGVs'
      expect(snob.site).to eq :youtube
    end

    it 'should parse mobile YouTube URLs' do
      snob = FilmSnob.new("https://m.youtube.com/watch?v=6dyeFalOjw0&feature=youtu.be")
      expect(snob.id).to eq '6dyeFalOjw0'
      expect(snob.site).to eq :youtube
      expect(snob.clean_url).to eq 'https://www.youtube.com/watch?v=6dyeFalOjw0'
    end

    it 'should parse short YouTube URLs' do
      snob = FilmSnob.new("http://youtu.be/1Ee4bfu_t3c")
      expect(snob.id).to eq '1Ee4bfu_t3c'
      expect(snob.site).to eq :youtube
      expect(snob.clean_url).to eq 'https://www.youtube.com/watch?v=1Ee4bfu_t3c'
    end

    it 'should raise a not embeddable error for a missing video URL' do
      VCR.use_cassette('youtube/missing video') do
        snob = FilmSnob.new("https://youtube.com/watch?v=malformedid")
        expect{snob.title}.to raise_error(FilmSnob::NotEmbeddableError)
      end
    end
  end

  describe 'rdio URLs' do
    it 'should parse normal album rdio URLs' do
      snob = FilmSnob.new("http://www.rdio.com/artist/Sam_Smith/album/In_The_Lonely_Hour/")
      expect(snob).to be_watchable
      expect(snob.site).to eq :rdio
      VCR.use_cassette('rdio/in_the_lonely_hour') do
        expect(snob.title).to eq 'In The Lonely Hour'
      end
    end

    it 'should parse normal track rdio URLs' do
      snob = FilmSnob.new("http://www.rdio.com/artist/Sam_Smith/album/In_The_Lonely_Hour/track/Stay_With_Me")
      expect(snob).to be_watchable
      expect(snob.id).to_not be_nil
      expect(snob.site).to eq :rdio
      VCR.use_cassette('rdio/in_the_lonely_hour_stay_with_me') do
        expect(snob.title).to eq 'Stay With Me'
      end
    end
    
    it 'should not allow weak matches for rdio urls' do 
      snob = FilmSnob.new("google.com/q=rdio")
      expect(snob).to_not be_watchable
    end
  end

  describe 'vimeo URLs' do
    it 'should parse https vimeo URLs' do
      snob = FilmSnob.new("https://vimeo.com/16010689")
      expect(snob.id).to eq '16010689'
      expect(snob.site).to eq :vimeo
      VCR.use_cassette('vimeo/stephen') do
        expect(snob.title).to eq 'Days Like Today'
      end
    end

    it 'should parse http vimeo URLs' do
      snob = FilmSnob.new("http://vimeo.com/16010689")
      expect(snob.id).to eq '16010689'
      expect(snob.site).to eq :vimeo
    end

    it 'should parse mobile vimeo URLs' do
      snob = FilmSnob.new("http://vimeo.com/m/16010689")
      expect(snob.id).to eq '16010689'
      expect(snob.site).to eq :vimeo
      expect(snob.clean_url).to eq 'https://vimeo.com/16010689'
    end

    it 'should parse couchmode vimeo URLs' do
      snob = FilmSnob.new("https://vimeo.com/couchmode/staffpicks/sort:date/91157088")
      expect(snob.id).to eq '91157088'
      expect(snob.site).to eq :vimeo
      expect(snob.clean_url).to eq 'https://vimeo.com/91157088'

      snob2 = FilmSnob.new('https://vimeo.com/couchmode/watchlater/sort:date/51020067')
      expect(snob2.id).to eq '51020067'
      expect(snob2.site).to eq :vimeo
      expect(snob2.clean_url).to eq 'https://vimeo.com/51020067'
    end

    it 'should allow oembed configuration' do
      snob = FilmSnob.new("http://vimeo.com/31158841", width: 400)
      VCR.use_cassette('vimeo/murmuration') do
        expect(snob.html).to match %r{width="400"}
      end

      snob2 = FilmSnob.new('http://vimeo.com/31158841', width: 500)
      VCR.use_cassette('vimeo/murmuration2') do
        expect(snob2.html).to match %r{width="500"}
      end
    end
  end


  describe 'dailymotion URLs' do
    it 'should parse https dailymotion URLs' do
      snob = FilmSnob.new("https://www.dailymotion.com/video/xf02xp_uffie-difficult_music")
      expect(snob.id).to eq 'xf02xp_uffie-difficult_music'
      expect(snob.site).to eq :dailymotion
      VCR.use_cassette('dailymotion/music') do
        expect(snob.title).to eq 'Uffie - Difficult'
      end
    end

    it 'should parse http dailymotion URLs' do
      snob = FilmSnob.new("http://www.dailymotion.com/video/xf02xp_uffie-difficult_music")
      expect(snob.id).to eq 'xf02xp_uffie-difficult_music'
      expect(snob.site).to eq :dailymotion
    end

    it 'should parse mobile dailymotion URLs' do
      snob = FilmSnob.new("http://touch.dailymotion.com/video/xf02xp_uffie-difficult_music")
      expect(snob.id).to eq 'xf02xp_uffie-difficult_music'
      expect(snob.site).to eq :dailymotion
      expect(snob.clean_url).to eq 'https://www.dailymotion.com/video/xf02xp_uffie-difficult_music'
    end

    it 'should allow oembed configuration' do
      snob = FilmSnob.new("http://www.dailymotion.com/video/xf02xp_uffie-difficult_music", maxwidth: 400)
      VCR.use_cassette('dailymotion/music1') do
        expect(snob.html).to match %r{width="400"}
      end

      snob2 = FilmSnob.new('http://www.dailymotion.com/video/xf02xp_uffie-difficult_music', maxwidth: 500)
      VCR.use_cassette('dailymotion/music500') do
        expect(snob2.html).to match %r{width="500"}
      end
    end
  end


  describe 'hulu URLs' do
    it 'should parse hulu URLs' do
      snob = FilmSnob.new("http://www.hulu.com/watch/285095")
      expect(snob.id).to eq '285095'
      expect(snob.site).to eq :hulu
      VCR.use_cassette('hulu/harmon') do
        expect(snob.title).to eq 'Remedial Chaos Theory (Community)'
        expect{snob.html}.not_to raise_error
      end
    end
  end

  describe 'funny or die URLs' do
    it 'should parse funny or die URLs' do
      film = FilmSnob.new('http://www.funnyordie.com/videos/8db066d2e0/the-live-read-of-space-jam-with-blake-griffin')
      expect(film.id).to eq '8db066d2e0'
      expect(film.site).to eq :funnyordie
      VCR.use_cassette 'funnyordie/space jam' do
        expect(film.title).to eq 'The Live Read of Space Jam with Blake Griffin'
        expect{film.html}.not_to raise_error
      end
    end
  end

  describe 'instagram URLs' do
    it 'should parse normal instagram URLs' do
      film = FilmSnob.new("http://instagram.com/p/oBkLq7hnDP/")
      expect(film.id).to eq 'oBkLq7hnDP'
      expect(film.site).to eq :instagram
      VCR.use_cassette 'instagram/sphynx cat' do
        expect(film.title).to match "Very stupid package!"
        expect{film.html}.not_to raise_error
      end
    end
    it 'should handle https urls' do
      film = FilmSnob.new("https://instagram.com/p/otxnbOocqJ/")
      expect(film).to be_watchable
      expect(film.site).to eq :instagram
      expect(film.id).to eq 'otxnbOocqJ'
    end
    it 'should handle instagr.am urls' do
      film = FilmSnob.new("http://instagr.am/p/otxnbOocqJ/")
      expect(film).to be_watchable
      expect(film.site).to eq :instagram
      expect(film.id).to eq 'otxnbOocqJ'
    end
    it 'should handle https instagr.am urls' do
      film = FilmSnob.new("https://instagr.am/p/otxnbOocqJ/")
      expect(film).to be_watchable
      expect(film.site).to eq :instagram
      expect(film.id).to eq 'otxnbOocqJ'
    end
    it 'should raise error when the URL is not embeddable' do
      film = FilmSnob.new('http://instagram.com/p/nothinghere/')
      VCR.use_cassette 'instagram/nothing' do
        expect { film.html }.to raise_error FilmSnob::NotEmbeddableError
        expect { film.title }.to raise_error FilmSnob::NotEmbeddableError
      end
    end
  end

  describe 'coub URLs' do
    it 'should parse coub URLs' do
      film = FilmSnob.new('http://coub.com/view/rcd14cm')
      expect(film.id).to eq 'rcd14cm'
      expect(film.site).to eq :coub
      VCR.use_cassette 'coub/voodoo_people' do
        expect(film.title).to eq 'voodoo people'
        expect{film.html}.not_to raise_error
      end
    end
  end
end
