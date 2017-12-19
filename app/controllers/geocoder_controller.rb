class GeocoderController < ApplicationController
  def findaddress
    # @ubicacion = Geocoder.address([params[:latitude], params[:longitude]])
    @ubicacion = "Zenteno 1490, Santiago, Región Metropolitana, Chile"
  end
end
