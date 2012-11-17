class JournalsController < ApplicationController
  # INDEX
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

    respond_to do |format|
      format.html # new.html.erb
      format.js
    end
  end

  # EDIT
  def edit
    
    @user = User.find(params[:user_id])	
    @journal = @user.journals.find(params[:id])

    respond_to do |format|
      format.js
    end
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

    respond_to do |format|
      if @journal.update_attributes(params[:journal])
        format.html { redirect_to @journal, notice: 'Journal was successfully updated.' }
        format.js
      else
        format.html { render action: "edit" }
        format.json { render json: @journal.errors, status: :unprocessable_entity }
      end
    end
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
