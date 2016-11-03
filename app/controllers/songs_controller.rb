
#############################################################################
# The SongsController class is responsible for managing songs
# resources associated with the web service. It is the primary resource
# to which other records are related such as Artist and Album
#############################################################################


class SongsController < ApplicationController

  ## CALL BACKS --------------------------------------------------------
  before_action :set_song, only: [:show, :edit, :update, :destroy]

  ## Needed for AJax response
  respond_to :html, :js


  # GET /songs
  # GET /songs.json
  def index
    @songs = Song.all.paginate(:per_page => 20, :page => params[:page])
  end

  # GET /songs/1
  # GET /songs/1.json
  def show
  end

######################################################################
# List - used to display the results of the search for songs based on
# either song name, artist, or album title.
######################################################################

  def list
  end

######################################################################
# Search - used to extract the search criteria elements from the
# search form. Then the pass the information to the search_songs
# model method to extract the list of songs, artists, and albums that
# match that criteria.
######################################################################

  def search

    ## Set the list of songs to empty

    @song_list = []

   ## Call the search_songs presenter method

    @song_list = SongSearchType.new.search_songs(params[:song], params[:artist], params[:album], search_type_song())

  end

  # GET /songs/new
  def new
    @song = Song.new
    @song.build_artist
    @song.build_album
  end

  # GET /songs/1/edit
  def edit
  end

  # POST /songs
  # POST /songs.json
  def create
    @song = Song.new(song_params)

    respond_to do |format|
      if @song.save
        format.html { redirect_to @song, notice: 'Song was successfully created.' }
        format.json { render :show, status: :created, location: @song }
      else
        format.html { render :new }
        format.json { render json: @song.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /songs/1
  # PATCH/PUT /songs/1.json
  def update
    respond_to do |format|
      if @song.update(song_params)
        format.html { redirect_to @song, notice: 'Song was successfully updated.' }
        format.json { render :show, status: :ok, location: @song }
      else
        format.html { render :edit }
        format.json { render json: @song.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /songs/1
  # DELETE /songs/1.json
  def destroy
    @song.destroy
    respond_to do |format|
      format.html { redirect_to songs_url, notice: 'Song was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_song
      @song = Song.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def song_params
      params.require(:song).permit(:song_name, album_attributes: [:id , :album_name], artist_attributes: [:id , :artist_name])
    end

    ######################################################################
    # Search_type_song - determine search_type based on information
    # provided: song name, artist, or album title.
    ######################################################################

    def search_type_song

      ## Set default search type to no fields selected in the event none are
      ## provided.

      search_type = NO_FIELDS_SELECTED


      if params[:song].present?
       search_type = SONG_ONLY
     end

     if params[:artist].present? && search_type == 0
       search_type = ARTIST_ONLY
     elsif params[:artist].present?
       search_type = SONG_AND_ARTIST
     end

     if params[:album].present? && search_type == 0
       search_type = ALBUM_ONLY
     elsif params[:album].present?
       search_type += 4
     end

     return search_type

    end
end
