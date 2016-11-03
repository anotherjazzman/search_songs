################################################################################
# Model Test For Artist
################################################################################

require 'spec_helper'
require 'rails_helper'

describe Song, :type => :model do
  include_context 'song_setup'

  let(:artist_search_term) {'The Beatles'}
  let(:album_search_term) {'Revolver'}


# CREATE A LIST OF Songs ------------------------------------------------

 let(:find_a_song) {
    create_songs
  }

# SETUP FOR EACH TEST  ------------------------------------------------

   before(:each) {
    find_a_song
   }

   after(:each) {
    Song.destroy_all
   }

    ## SEARCH TESTS ---------------------------------------------------

       describe "Search tests" do

        it "Should return Zero Artist Entry" do
            artist_test = FactoryGirl.create(:artist)
            artist_test.save
            expect(Artist.artist_search(nil).count).to eq(0)
        end

        it "Should return a Non-Zero Artist Entry" do
            artist_test = FactoryGirl.create(:artist)
            artist_test.save
            expect(Artist.artist_search(artist_search_term).count).not_to eq(0)
        end

        it "Should return Zero Artist/Album Entry" do
            artist_test = FactoryGirl.create(:artist)
            artist_test.save
            expect(Artist.artist_album_search(nil,nil).count).to eq(0)
        end

        it "Should return a Non-Zero Artist/Album Entry" do
            artist_test = FactoryGirl.create(:artist)
            artist_test.save
            expect(Artist.artist_album_search(artist_search_term,album_search_term).count).not_to eq(0)
        end
       end
   end
