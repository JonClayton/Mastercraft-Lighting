class ChannelsController < ApplicationController
  before_action :set_production, only: [:show, :update, :destroy, :create, :edit]
  before_action :set_channel, only: [:show, :update, :destroy, :edit]


  def create
    @new_thing = Equipment.new(channel: params[:channel], instrument_type: params[:instrument_type],position: params[:position], unit_number: params[:unit_number], purpose: params[:purpose], wattage: params[:wattage], color: params[:color], dimmer: params[:dimmer], address: params[:address], universe:params[:universe], circuit_number: params[:circuit_number],circuit_name: params[:circuit_name], gobo_1: params[:gobo_1], gobo_2: params[:gobo_2], focus: params[:focus], accessories: params[:accessories], production_id: params[:production_id])
    if @new_thing.save
       @equipment = @production.equipment.sort_by &:channel
      redirect_to production_path(id: params[:production_id])
    else
      render :index
    end
  end

  def new
    @channel = Equipment.new
  end

  def edit
    @channel
    if request.xhr?
      p "*" * 40
      p render_to_string('_edit_form', :layout => false, :locals => { :channel => @channel })
      p "*" * 40
      render :json => { :attachmentPartial =>
                        render_to_string('_edit_form',
                        :layout => false, :locals => { :channel => @channel }),
                        :item_id => @channel.id }
    else
      #do something else...
    end
  end

  def show
    @equipment = @production.equipment.sort_by &:channel
  end

  def update
    p "-" * 40
    p params.inspect
    p "-" * 40
  end


  def destroy
    item = @production.equipment.find(params[:id])
    item.destroy
    if request.xhr?
      render json: {rowNumber: item.id}
    else
      redirect back
    end
  end


  private

  def set_channel
    @channel = @production.equipment.find(params[:id])
  end

  def set_production
      @production = Production.find(params[:production_id])
  end
  # def channel_params
  #   channel: params[:channel], instrument_type: params[:instrument_type],position: params[:position], unit_number: params[:unit_number], purpose: params[:purpose], wattage: params[:wattage], color: params[:color], dimmer: params[:dimmer], address: params[:address], universe:params[:universe], circuit_number: params[:circuit_number],circuit_name: params[:circuit_name], gobo_1: params[:gobo_1], gobo_2: params[:gobo_2], focus: params[:focus], accessories: params[:accessories], production_id: params[:production_id]
  # end
end


