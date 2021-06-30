class QuotesController < ApplicationController
  before_action :set_quote, only: %i[ show edit update destroy ]

  # GET /quotes or /quotes.json
  def index
    @quotes = Quote.all
  end

  # GET /quotes/1 or /quotes/1.json
  def show
  end

  # GET /quotes/new
  def new
    @quote = Quote.new
  end

  # GET /quotes/1/edit
  def edit
  end

  # POST /quotes or /quotes.json
  def create
    @quote = Quote.new(quote_params)

    if user_signed_in?
      userCustomerList = Customer.where(:user_id => current_user.id)
      if userCustomerList.present?
        customer = userCustomerList.first
        @quote.CompanyName = userCustomerList.first.CompanyName
        @quote.Email = userCustomerList.first.EmailOfTheCompany

        subject = "#{customer.NameOfContact} from #{customer.CompanyName}"
        comment = "The contact #{customer.NameOfContact} from company #{customer.CompanyName} can be reached at email  #{customer.EmailOfTheCompany} and at phone number #{customer.CompanyContactPhone}. #{@quote.BuildingType} has a project named [PROJECT] which would require contribution from Rocket Elevators."
        ZendeskAPI::Ticket.create($zenclient, :subject => subject, :comment => { :value => comment }, :priority => "normal", :type => "task" ) # :email_ccs => [{ :user_email => :Email, :action => "put"}],

      end
    end

    respond_to do |format|
      if @quote.save
        format.html { redirect_to @quote, notice: "Quote was successfully created." }
        format.json { render :show, status: :created, location: @quote }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @quote.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /quotes/1 or /quotes/1.json
  def update
    respond_to do |format|
      if @quote.update(quote_params)
        format.html { redirect_to @quote, notice: "Quote was successfully updated." }
        format.json { render :show, status: :ok, location: @quote }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @quote.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /quotes/1 or /quotes/1.json
  def destroy
    @quote.destroy
    respond_to do |format|
      format.html { redirect_to quotes_url, notice: "Quote was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_quote
      @quote = Quote.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def quote_params
      params.require(:quote).permit(:BuildingType, :NumberOfFloors, :NumberOfBasements, :NumberOfcompanies, :NumberOfParkingSpots, :NumberOfElevators, :NumberOfApartments, :NumberOfCorporations, :NumberOfOccupany, :NumberOfBusinessHours, :ElevatorAmount, :ColumnAmount, :ProductLine, :ElevatorUnitCost, :ElevatorTotalCost, :InstallationCost, :TotalPrice)
    end
end
