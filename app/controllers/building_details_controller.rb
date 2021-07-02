class BuildingDetailsController < ApplicationController
  before_action :set_building_detail, only: %i[ show edit update destroy ]

  # GET /building_details or /building_details.json
  def index
    load_buildingmarkers

    @building_details = BuildingDetail.all
  end

  # GET /building_details/1 or /building_details/1.json
  def show
  end

  # GET /building_details/new
  def new
    @building_detail = BuildingDetail.new
  end

  # GET /building_details/1/edit
  def edit
  end

  # POST /building_details or /building_details.json
  def create
    @building_detail = BuildingDetail.new(building_detail_params)

    respond_to do |format|
      if @building_detail.save
        format.html { redirect_to @building_detail, notice: "Building detail was successfully created." }
        format.json { render :show, status: :created, location: @building_detail }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @building_detail.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /building_details/1 or /building_details/1.json
  def update
    respond_to do |format|
      if @building_detail.update(building_detail_params)
        format.html { redirect_to @building_detail, notice: "Building detail was successfully updated." }
        format.json { render :show, status: :ok, location: @building_detail }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @building_detail.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /building_details/1 or /building_details/1.json
  def destroy
    @building_detail.destroy
    respond_to do |format|
      format.html { redirect_to building_details_url, notice: "Building detail was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  
  def load_buildingmarkers
    @building_detail_default = Gmaps4rails.build_markers(BuildingDetail.all) do |building_detail, marker|  
      building1 = Building.where(id: building_detail.building_id).first
      address1 = Address.where(id: building1.address_id).first
      customer1 = Customer.where(id: building1.customer_id).first
      results = AddressGeocode.fromAddress(address1.NumberAndStreet)

      clientname = customer1.CompanyName
      numoffloors = 0
      numofbatteries = 0
      numofcolumns = 0
      numofelevators = 0
      fullnameofcontact = customer1.NameOfContact

      batteries = Battery.where(building_id: building_detail.building_id)
      batteries.each do |battery|
        numofbatteries += 1
        columns = Column.where(battery_id: battery.id)
        columns.each do |column|
          numofcolumns += 1
          elevators = Elevator.where(column_id: column.id)
          elevators.each do |elevator|
            numofelevators += 1
          end
        end
      end

      if results then
        coords = results
        marker.lat coords[0]
        marker.lng coords[1]
        
        # marker.picture({  
        #   "url" => url_alert,  
        #   "width" => 35,  
        #   "height" => 30  
        # })  
        
        marker.infowindow render_to_string(:partial => "/building_details/info",  :locals => 
          {
            :numbersoffloors => numoffloors,
            :clientname => clientname,
            :numberofbatteries => numofbatteries,
            :numberofcolumns => numofcolumns,
            :numberofelevators => numofelevators,
            :fullnameofcontact => fullnameofcontact
          }
        )  
      end
    end  
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_building_detail
      @building_detail = BuildingDetail.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def building_detail_params
      params.require(:building_detail).permit(:InformationKey, :Value)
    end
end
