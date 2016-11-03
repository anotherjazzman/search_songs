########################################################################
# Provide shared macros for testing song
########################################################################
shared_context 'song_setup' do

  # Song Create Setup -------------------------------------------------
  let(:create_songs) {
    5.times.each { FactoryGirl.build(:song) }
  }

  # Song Search Terms -------------------------------------------------

  let(:no_fields_selected) {NO_FIELDS_SELECTED}
  let(:song_only_term) {SONG_ONLY}
  let(:artist_only_term) {ARTIST_ONLY}
  let(:album_only_term) {ALBUM_ONLY}
  let(:song_and_artist_term) {SONG_AND_ARTIST}
  let(:song_and_album_term) {SONG_AND_ALBUM}
  let(:artist_and_album_term) {ARTIST_AND_ALBUM}
  let(:all_fields_term) {ALL_FIELDS}
  
end
