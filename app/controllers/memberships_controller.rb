class MembershipsController < ApplicationController
  before_action :set_membership, only: %i[show edit update destroy]

  # GET /memberships or /memberships.json
  def index
    @memberships = Membership.all
    @applicants = Pending_membership.all
  end

  # GET /memberships/1 or /memberships/1.json
  def show
  end

  # GET /memberships/new
  def new
    @membership = Membership.new
    @beer_club_selection = BeerClub.all - current_user.beer_clubs
  end

  # GET /memberships/1/edit
  def edit
  end

  # POST /memberships or /memberships.json
  def create
    @membership = Membership.new(membership_params)
    @membership.user_id = current_user.id if current_user
    @beer_club = BeerClub.find([@membership.beer_club_id])
    # binding.pry

    respond_to do |format|
      if @membership.save
        format.html { redirect_to @beer_club, notice: "#{current_user.username} welcome to the club." }
        format.json { render :show, status: :created, location: current_user }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @membership.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /memberships/1 or /memberships/1.json
  def update
    respond_to do |format|
      if @membership.update(membership_params)
        format.html { redirect_to membership_url(@membership), notice: "Membership was successfully updated." }
        format.json { render :show, status: :ok, location: @membership }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @membership.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /memberships/1 or /memberships/1.json
  def destroy
    @beer_club = BeerClub.find(@membership.beer_club_id)
    # binding.pry
    @membership.destroy

    respond_to do |format|
      format.html { redirect_to user_path(current_user), notice: "Membership in #{@beer_club} ended." }
      format.json { head :no_content }
    end
  end

  # Toggle
  def toggle_activity
    membership = Membership.find(params[:id])
    membership.update_attribute :confirmed, !membership.confirmed

    new_status = membership.confirmed? ? "confirmed" : "pending"

    redirect_to membership.beer_club, notice: "membership status changed to #{new_status}"
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_membership
    @membership = Membership.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def membership_params
    params.require(:membership).permit(:beer_club_id, :user_id)
  end
end
