class EventsController < ApplicationController
  before_action :set_event, only: [:show, :edit, :update, :destroy]

  # GET /events
  # GET /events.json
  def index
    @events = Event.all
  end

  # GET /events/1
  # GET /events/1.json
  def show
  end

  # GET /events/new
  def new
    @event = Event.new
  end

  # GET /events/1/edit
  def edit
  end

  # POST /events
  # POST /events.json
  def create
    @event = Event.new(event_params)

    respond_to do |format|
      if @event.save
        format.html { redirect_to @event, notice: 'Event was successfully created.' }
        format.json { render :show, status: :created, location: @event }
      else
        format.html { render :new }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /events/1
  # PATCH/PUT /events/1.json
  def update
    respond_to do |format|
      if @event.update(event_params)
        format.html { redirect_to @event, notice: 'Event was successfully updated.' }
        format.json { render :show, status: :ok, location: @event }
      else
        format.html { render :edit }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /events/1
  # DELETE /events/1.json
  def destroy
    @event.destroy
    respond_to do |format|
      format.html { redirect_to events_url, notice: 'Event was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def search
    @keyword = params[:keyword]
    @start_date_from = params[:start_date_from]
    @start_date_to = params[:start_date_to]
    @prefecture_to = params[:prefecture_to]
    if params[:keyword].blank? && params[:start_date_from].blank? && params[:start_date_to].blank? && params[:prefecture_to].blank?
      @events = Event.all
    else
      @events = Event.all
      @events = @events.where('title LIKE ?', "%#{params[:keyword]}%") if params[:keyword].present?
      @events = @events.where('prefecture = ?', "#{params[:prefecture_to]}") if params[:prefecture_to].present?
      if params[:start_date_from].present? && params[:start_date_to].present?
        @events = @events.where(start_datetime: "#{params[:start_date_from]}".."#{params[:start_date_to]+' 23:59:59'}")
      elsif params[:start_date_from].present?
          @events = @events.where('start_datetime >= ?',"#{params[:start_date_from]}")
      elsif params[:start_date_to].present?
          @events = @events.where('start_datetime <= ?',"#{params[:start_date_to] +' 23:59:59'}")
      end
      flash.now[:notice] = "イベントは見つかりませんでした" if @events.blank?
    end
    render "index"
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_event
      @event = Event.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def event_params
      params.require(:event).permit(:title, :start_datetime, :end_datetime, :prefecture)
    end
end
