 class EventsController < ApplicationController 
  layout :resolve_layout
  authorize_resource
  def index
    all_event_states
    reset_current_state(Event)

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @events }
    end
  end
  
  def show
    find_event

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @event }
    end
  end

  def event_partial
    reset_current_state(Event)
    @events_partial = Describe.new(Event).partial.published
    @model_name = "Event"
    render 'shared/quick_partial_view', model_name: @model_name
  end

  def new
    @event = Event.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @event }
    end
  end

 
  def edit
    find_event
    authorize! :edit, @event
   
  end

  def create
    authorize! :create, @event
    @event = Event.new(params[:event])
    @event.starts_at = params[:event][:starts_at].blank? ? Date.today : params[:event][:starts_at] 
    respond_to do |format|
      if @event.save
        format.html { redirect_to @event, notice: 'event was successfully created.' }
        format.json { render json: @event, status: :created, location: @event }
      else
        format.html { render action: "new" }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

 
  def update
    find_event
    authorize! :update, @event
    all_event_states
    position = params[:event][:position]
    current_state = params[:event][:current_state]
    published = Status.find_by_status_name("published").id
    @event.check_current_state
    respond_to do |format|
      if @event.update_attributes(params[:event])
        format.html { redirect_to @event, notice: 'event was successfully updated.' }
        format.js { @event }
      else
        format.html { render action: "edit" }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    find_event 
    authorize! :destroy, @event
    @event.destroy

    respond_to do |format|
      format.html { redirect_to events_url }
      format.json { head :no_content }
    end
  end

  def find_event
    @event = Event.find(params[:id])
  end

  def sort
    all_event_states
    params[:event].each_with_index do |id, index|
      Event.update_all({position: index+1}, {id: id})
    end
    render "update.js"
  end

  def event_status
    all_event_states
    find_event
    current_state = params[:event][:current_state]
    total_published = Event.published.count
    published = Status.find_by_status_name("published").id
    if (current_state ==  published) 
      @event.update_attributes({current_state: current_state, position: total_published + 1})
    else
      @event.update_attributes({current_state: current_state, position: nil })
    end

    Event.published.each_with_index do |id, index|
      Event.published.update_all({position: index+1}, {id: id})
    end
    render "update.js"
    
  end

  def event_starts_at
    
    find_event
    starts_at = params[:event][:starts_at]
    current_state = params[:event][:current_state]
    total_published = Event.published.count

    @event.update_attributes({starts_at: starts_at})
    published = Status.find_by_status_name("published").id
    if (current_state ==  published) 
      Event.published.each_with_index do |id, index|
        Event.published.update_all({position: index+1}, {id: id})
      end
    end
    
    all_event_states
    render "update.js"
  end

  def event_ends_at
    
    find_event
    ends_at = params[:event][:ends_at]
    current_state = params[:event][:current_state]
    total_published = Event.published.count
    
    @event.update_attributes({ends_at: ends_at})
    published = Status.find_by_status_name("published").id
    if (current_state ==  published) 
      Event.published.each_with_index do |id, index|
        Event.published.update_all({position: index+1}, {id: id})
      end
    end
    all_event_states
    render "update.js"
    
  end

  def all_event_states
    @published_events = Event.published.order_by_position
    @scheduled_events = Event.scheduled.order_by_position
    @draft_events = Event.draft.order_by_position
  end
end
