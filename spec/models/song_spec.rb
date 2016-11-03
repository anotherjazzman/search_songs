################################################################################
# Model Test For Song
################################################################################

require 'spec_helper'
require 'rails_helper'

describe Song, :type => :model do
  include_context 'song_setup'

  let(:song_search_term) { 'Eleanor Rigby' }
  let(:artist_search_term) {'The Beatles'}
  let(:album_search_term) {'Revolver'}


# CREATE A LIST OF Songs ------------------------------------------------

 let(:find_a_song) {
    create_songs
    @song = Song.last
  }

# SETUP FOR EACH TEST  ------------------------------------------------

   before(:each) {
    find_a_song
   }

   after(:each) {
    Song.destroy_all
   }

 ## METHOD CHECKS -----------------------------------------------------

      describe "Should respond to all accessor methods" do
                  it { is_expected.to respond_to(:song_name) }
                  it { is_expected.to respond_to(:artist) }
                  it { is_expected.to respond_to(:album) }
       end

  ## VALIDATION TESTS ---------------------------------------------------

         describe "Validation tests" do

            asong = FactoryGirl.create(:song)

           it "With all fields, model should be valid" do
             expect(asong).to be_valid
           end

           it "Should not be valid, if name is missing" do
             @song.song_name = nil
             expect(@song).not_to be_valid
           end
         end

    ## SEARCH TESTS ---------------------------------------------------

       describe "Search tests" do

         it "Should return Zero Song Entry" do
           song_test = FactoryGirl.create(:song)
           song_test.save
           expect(Song.song_only(nil).count).to eq(0)
         end

         it "Should return a Non-Zero Song Entry" do
           song_test = FactoryGirl.create(:song)
           song_test.save
           expect(Song.song_only(song_search_term).count).not_to eq(0)
         end

         it "Should return a Nil Song/Artist Entry with all fields Nil" do
           song_test = FactoryGirl.create(:song)
           song_test.save
           expect(Song.song_artist(nil,nil).count).to eq(0)
         end

         it "Should return a Non-Zero Song/Artist Entry" do
           song_test = FactoryGirl.create(:song)
           song_test.save
           expect(Song.song_artist(song_search_term,artist_search_term)).not_to eq(0)
         end

         it "Should return Zero Song/Album Entry with all fields Nil" do
           song_test = FactoryGirl.create(:song)
           song_test.save
           expect(Song.song_album(nil,nil).count).to eq(0)
         end

         it "Should return a Non-Zero song/Album Entry" do
           song_test = FactoryGirl.create(:song)
           song_test.save
           expect(Song.song_album(song_search_term,album_search_term)).not_to eq(0)
         end

         it "Should return Zero Song/Artist/Album Entry with all fields Nil" do
           song_test = FactoryGirl.create(:song)
           song_test.save
           expect(Song.song_all(nil,nil,nil).count).to eq(0)
         end

         it "Should return a Non-Zero Song/Artist/Album Entries" do
           song_test = FactoryGirl.create(:song)
           song_test.save
           expect(Song.song_all(song_search_term,artist_search_term,album_search_term)).not_to eq(0)
         end
       end

   end
