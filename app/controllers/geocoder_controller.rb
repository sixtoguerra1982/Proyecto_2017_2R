class GeocoderController < ApplicationController
  def findaddress

    # @ubicacion = "Zenteno 1490"


   @ubicacion = Geocoder.address([params[:latitude], params[:longitude]])


    @HeaderOrder = HeaderOrder.find_by(user_id: current_user, date: Date.today, payed: false)
    unless @HeaderOrder.nil?
      @HeaderOrder.destroy
    end
    HeaderOrder.create(user: current_user, payment_address: @ubicacion, total: 0, date: Date.today, way_to_pay: 1)
  end
end
