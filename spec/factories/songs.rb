################################################################################
# Factory used to define the instance of Song which includes Artist and Album..
################################################################################

FactoryGirl.define do
  factory :song, class: Song do
    song_name "Eleanor Rigby"
    artist
    album
  end
end
