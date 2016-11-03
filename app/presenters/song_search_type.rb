#######################################################################
# The Song presenter class is used to interface between the Song,
# Artist, and Album models to perform searches.
#######################################################################
class SongSearchType

  ## CLASS METHODS ----------------------------------------------------

  #####################################################################
  # Class method to return the correct set of songs from a
  # search request.
  #####################################################################

  # PUBLIC MTHODS --------------------------------------------------------

  #####################################################################
  # Class method to return the correct set of songs from the appropriate
  # model search request.
  #####################################################################


 def search_songs (song_term, artist_term, album_term, search_type)

   ## Verify that the arguments have a value

  return [] unless (song_term.present? || artist_term.present? || album_term.present?)

   case search_type
    when SONG_ONLY
     return Song.song_only(song_term)
    when ARTIST_ONLY
      return Artist.artist_search(artist_term)
    when ALBUM_ONLY
      return Album.album_search(album_term)
    when ARTIST_AND_ALBUM
      return Artist.artist_album_search(artist_term, album_term)
    when SONG_AND_ARTIST
     return Song.song_artist(song_term, artist_term)
    when SONG_AND_ALBUM
     return Song.song_album(song_term, album_term)
    when ALL_FIELDS
     return Song.song_all(song_term, artist_term, album_term)
    else
     return []
   end # End Case
 end # End search_songs
end
