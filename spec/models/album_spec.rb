################################################################################
# Model Test For Album
################################################################################

require 'spec_helper'
require 'rails_helper'

describe Song, :type => :model do
  include_context 'song_setup'

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

         it "Should return Zero Album Entry" do
           album_test = FactoryGirl.create(:album)
           album_test.save
           expect(Album.album_search(nil).count).to eq(0)
         end

         it "Should return a Non-Zero Album Entry" do
           album_test = FactoryGirl.create(:album)
           album_test.save
           expect(Album.album_search(album_search_term).count).not_to eq(0)
         end
       end

   end
