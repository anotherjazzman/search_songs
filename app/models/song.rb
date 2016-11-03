#######################################################################
# The Song class is the model for holding information about a song
# which belongs to an Artist and can be contained in an Album.
#######################################################################
class Song < ActiveRecord::Base

  ## RELATIONSHIPS ----------------------------------------------------

  belongs_to :artist, class_name: 'Artist', foreign_key: :artist_id
  belongs_to :album,  class_name: 'Album',  foreign_key: :album_id
  accepts_nested_attributes_for :artist
  accepts_nested_attributes_for :album

  ## VALIDATIONS ------------------------------------------------------

  validates_presence_of :song_name

  ## CLASS METHODS ----------------------------------------------------

  #####################################################################
  # Class method to return the correct set of songs from a
  # search request.
  #####################################################################

  def self.song_only(song_term)

  ## Verify that the fields actually have values before doing the search

    return [] unless song_term.present?

    ## Return the results of the search

    Song.where("song_name LIKE ?",  "%#{song_term.upcase}%")
  end

   #####################################################################
   # Class method to return the correct set of songs and artist from a
   # search request.
   #####################################################################

   def self.song_artist(song_term, artist_term)

  ## Verify that the fields actually have values before doing the search

     return [] unless (song_term.present? && artist_term.present?)

       ## Return the results of the search

     Song.includes(:artist).where("song_name LIKE ?",  "%#{song_term.upcase}%")
                           .where("artist_name LIKE ?",  "%#{artist_term.upcase}%").references(:artist)
   end

    #####################################################################
    # Class method to return the correct set of songs and album from a
    # search request.
    #####################################################################

    def self.song_album(song_term, album_term)

    ## Verify that the fields actually have values before doing the search

      return [] unless (song_term.present? && album_term.present?)

    ## Return the results of the search

      Song.includes(:album).where("song_name LIKE ?",  "%#{song_term.upcase}%")
                           .where("album_name LIKE ?",  "%#{album_term.upcase}%").references(:album)

    end

     #####################################################################
     # Class method to return the correct set of songs and album from a
     # search request.
     #####################################################################

     def self.song_all(song_term, artist_term, album_term)

     ## Verify that the fields actually have values before doing the search

       return [] unless (song_term.present? && artist_term.present? && album_term.present?)

    ## Return the results of the search

       Song.includes(:artist, :album).where("song_name LIKE ?",  "%#{song_term.upcase}%")
                                     .where("artist_name LIKE ?",  "%#{artist_term.upcase}%")
                                     .where("album_name LIKE ?",  "%#{album_term.upcase}%").references(:artist, :album)
     end
end
