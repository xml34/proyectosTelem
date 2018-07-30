class AddUserIdToGeolocalisations < ActiveRecord::Migration[5.2]
  def change
    add_reference :geolocalisations, :user, foreign_key: true
  end
end
