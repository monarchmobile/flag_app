class JournalsController < ApplicationController
  # INDEX
  def index
    @journals = Journal.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @journals }
    end
  end

  # SHOW
  def show
    @journal = Journal.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @journal }
    end
  end

  # NEW
  def new
    @journal = Journal.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @journal }
    end
  end

  # EDIT
  def edit
    
    @user = User.find(params[:user_id])	
    @journal = @user.journals.find(params[:id])
  end

  # CREATE
  def create
  	@user = User.find(params[:journal][:user_id])
    @journal = @user.journals.build(params[:journal])

    respond_to do |format|
      if @journal.save
        format.html { redirect_to scrapbook_path, notice: 'Journal was successfully created.' }
        format.json { render json: @journal, status: :created, location: @journal }
      else
        format.html { render action: "new" }
        format.json { render json: @journal.errors, status: :unprocessable_entity }
      end
    end
  end

  # UPDATE
  def update
    @journal = Journal.find(params[:id])

    respond_to do |format|
      if @journal.update_attributes(params[:journal])
        format.html { redirect_to @journal, notice: 'Journal was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @journal.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE
  def destroy
    @journal = Journal.find(params[:id])
    @journal.destroy

    respond_to do |format|
      format.html { redirect_to journals_url }
      format.json { head :no_content }
    end
  end
end