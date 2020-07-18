class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy, :attendances_edit, :attendance_update]

  # GET /users
  # GET /users.json
  def index
    @users = User.all
  end

  # GET /users/1
  # GET /users/1.json
  def show
    if params[:day].present?
      @sixteen_day = Date.parse( params[:day] )
    else
      first_day = Date.today.beginning_of_month
      @sixteen_day = first_day + 15
    end    
    @next_fifteenth_day = @sixteen_day.beginning_of_month.next_month + 14 
    (@sixteen_day .. @next_fifteenth_day).each do |day|
       unless @user.attendances.any?{|attendance| attendance.worked_on == day}
         record = @user.attendances.build(worked_on: day)
         record.save
       end 
    end
    @days = @user.serchDay(@sixteen_day, @next_fifteenth_day)
    @week = %w(日 月 火 水 木 金 土)
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(user_params)

    respond_to do |format|
      if @user.save
        format.html { redirect_to @user, notice: 'User was successfully created.' }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url, notice: 'User was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def attendances_edit
    @sixteen_day = Date.parse( params[:day] )
    @next_fifteenth_day = @sixteen_day.beginning_of_month.next_month + 14 
    @days = @user.serchDay(@sixteen_day, @next_fifteenth_day)
    @week = %w(日 月 火 水 木 金 土)
  end

  def attendance_update
    attendance_params.each do |id, item|
      attendance = Attendance.find id
      attendance.update_attributes(item)
    end  
    redirect_to user_url(@user, params:{day: params[:day]})
  end
  
  

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def user_params
      params.require(:user).permit(:name)
    end
    def attendance_params
      params.require(:user).permit(attendances:[ :start, :finish])[:attendances]
    end

end
