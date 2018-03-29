class EventsController < ApplicationController
  before_action :set_event, only: %i[show edit update destroy]

  # GET /events
  # GET /events.json
  def index
    if request.headers['HTTP_ACCEPT'] == "application/vnd.api+json"
      super
    else
      @events = Event.all
    end
  end

  # GET /events/1
  # GET /events/1.json
  def show
    super if request.headers['HTTP_ACCEPT'] == "application/vnd.api+json"
  end

  # GET /events/new
  def new
    if request.headers['HTTP_ACCEPT'] == "application/vnd.api+json"
      super
    else
      @event = Event.new
    end
  end

  # GET /events/1/edit
  def edit; end

  # POST /events
  # POST /events.json
  def create
    if request.headers['HTTP_ACCEPT'] == "application/vnd.api+json"
      super
    else
      @event = Event.new(event_params)

      if @event.save
        redirect_to @event, notice: 'Event was successfully created.'
      else
        render :new
      end
    end
  end

  # PATCH/PUT /events/1
  # PATCH/PUT /events/1.json
  def update
    if request.headers['HTTP_ACCEPT'] == "application/vnd.api+json"
      super
    else
      if @event.update(event_params)
        redirect_to @event, notice: 'Event was successfully updated.'
      else
        render :edit
      end
    end
  end

  # DELETE /events/1
  # DELETE /events/1.json
  def destroy
    if request.headers['HTTP_ACCEPT'] == "application/vnd.api+json"
      super
    else
      @event.destroy
      redirect_to events_url, notice: 'Event was successfully destroyed.'
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_event
    @event = Event.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def event_params
    params.require(:event).permit(:description)
  end
end
