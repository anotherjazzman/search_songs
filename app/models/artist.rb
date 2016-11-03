#######################################################################
# The Album class is the model for holding information about an album
# which belongs to an Artist and contains many songs.
#######################################################################

class Artist < ActiveRecord::Base

## RELATIONSHIPS ----------------------------------------------------

has_many :albums, dependent: :destroy
has_many :songs, dependent: :destroy

    #accepts_nested_attributes_for :artist

## DELEGATIONS ------------------------------------------------------

## VALIDATIONS ------------------------------------------------------

  validates_presence_of :artist_name

  ## CLASS METHODS ----------------------------------------------------

#####################################################################
# Class method to return the correct set of songs based on artist
# search request.
#####################################################################


  def self.artist_search(artist_term)

    ## Verify that the fields actually have values before doing the search

     return [] unless artist_term.present?

     ## Return the results of the search
     ## Eventually, need to adjust the associations to use Artist to get the
     ## list of songs.

     Song.includes(:artist).where("artist_name LIKE ?",  "%#{artist_term.upcase}%").references(:artist)

  end

 #####################################################################
 # Class method to return the correct set of songs based on artist
 # and album search request.
 #####################################################################


  def self.artist_album_search(artist_term, album_term)

    ## Verify that the fields actually have values before doing the search

      return [] unless (artist_term.present? && album_term.present?)

      ## Return the results of the search
      ## Eventually, need to adjust the associations to use Artist to get the
      ## list of songs.

      Song.includes(:artist, :album).where("artist_name LIKE ?",  "%#{artist_term.upcase}%")
                                    .where("album_name LIKE ?",  "%#{album_term.upcase}%").references(:artist, :album)

  end

end
