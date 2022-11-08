class AddressController < ApplicationController
  before_action :authenticate_user!

  def edit; end

  def update
    respond_to do |format|
      if current_user.address.update(address_params)
        puts "Hoang updates"
        format.html { redirect_to root_path, notice: "Address was successfully updated." }

      else
        puts "Hoang cannot update"
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end

  private
  def address_params
    params[:address][:province_id] = Integer(params[:address][:province_id])
    params.require(:address).permit(:number, :street, :city, :postal_code, :province_id)
  end
end
