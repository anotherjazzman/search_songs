#######################################################################
# The Album class is the model for holding information about an album
# which belongs to an Artist and contains many songs.
#######################################################################

class Album < ActiveRecord::Base

## RELATIONSHIPS ----------------------------------------------------

    belongs_to :artist
    has_many :songs

## DELEGATIONS ------------------------------------------------------

## VALIDATIONS ------------------------------------------------------

  validates_presence_of :album_name

  ## INDICES & SCOPES -------------------------------------------------

  ## CLASS METHODS ----------------------------------------------------

#####################################################################
# Class method to return the correct set of songs based on album
# search request.
#####################################################################

 def self.album_search(album_term)


  ## Verify that the fields actually have values before doing the search

    return [] unless album_term.present?

    ## Return the results of the search
    ## Eventually, need to adjust the associations to use Album to get the
    ## list of songs.

    Song.includes(:album).where("album_name LIKE ?",  "%#{album_term.upcase}%").references(:album)

 end

 end
