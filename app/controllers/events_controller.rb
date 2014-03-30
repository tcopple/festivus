class EventsController < ApplicationController
  respond_to :html, :xml, :json

  def index
    @events = Event.all

    if !@events.empty?
      respond_with(@events)
    else
      render :empty
    end
  end

  def show
    @event = Event.find(params[:id])
    respond_with(@event)
  end

  def new
    @event = Event.new
    respond_with(@event)
  end

  def create
    @when = params[:event][:when]
    @date = DateTime.strptime(@when, "%m/%d/%Y")

    @event = Event.new(params[:event].merge({when: @date}))
    @event.user = current_user

    respond_with(@event) do |format|
      if @event.save
        flash[:notice] = 'Event was succesfully created.'
        format.html { redirect_to @event }
        format.json { render json: @event, status: :created, location: @event }
      else
        flash[:error] = @event.errors
        format.html { render action: "new" }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @event = Event.find(params[:id])
    @event.destroy

    respond_with(@event)
  end
end
