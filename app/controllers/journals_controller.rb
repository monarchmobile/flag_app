class JournalsController < ApplicationController
  # INDEX
  respond_to :html, :json
  def index
    @user = current_user
    @journals = @user.journals.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @journals }
    end 
  end

  # SHOW
  def show
    @user = current_user
    @journal = @user.journals.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @journal }
    end
  end

  # NEW
  def new
    @user = current_user
    @journal = @user.journals.new 
    @entry_date = params[:journal][:entry_date]
    if params[:journal][:day] 
            @range = "day"
            @boolean = params[:journal][:day]
    elsif params[:journal][:week] 
            @range = "week"
            @boolean = params[:journal][:week]
    elsif params[:journal][:month]
            @range = "month"
            @boolean = params[:journal][:month]
    elsif params[:journal][:year]
            @range = "year"
            @boolean = params[:journal][:year]
    end
    
    respond_to do |format|
      format.js
    end
  end

  # EDIT
  def edit
    
    @user = current_user
    @journal = @user.journals.find(params[:id])

  end

  # CREATE
  def create
  	@user = current_user
    @journal = @user.journals.build(params[:journal])

    respond_to do |format|
      if @journal.save
        format.html { redirect_to scrapbook_path, notice: 'Journal was successfully created.' }
        format.js
      else
        format.html { render action: "new" }
        format.json { render json: @journal.errors, status: :unprocessable_entity }
      end
    end
  end

  # UPDATE
  def update
    @user = current_user
    @journal = @user.journals.find(params[:id])
    @journal.update_attributes(params[:journal])

    respond_with @journal
  end

  # DELETE
  def destroy
    @user = current_user
    @journal = @user.journals.find(params[:id])
    @journal.destroy

    respond_to do |format|
      format.html { redirect_to journals_url }
      format.js
    end
  end
end
