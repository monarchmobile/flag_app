class ScrapbooksController < ApplicationController
  # Index 
  def index
    @user = current_user
    @scrapbooks = @user.scrapbooks.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @scrapbooks }
    end
  end

  # Show
  def show
    @user = User.find(params[:id])
    @scrapbook = @user.scrapbooks.find([:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @scrapbook }
    end
  end

  # New
  def new
    @user = current_user
    @scrapbook = @user.scrapbooks.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @scrapbook }
    end
  end

  # Edit
  def edit
    @user = current_user
    @scrapbook = Scrapbook.find(params[:id])
  end

  # Create
  def create
    @user = current_user
    @scrapbook = Scrapbook.new(params[:scrapbook])

    respond_to do |format|
      if @scrapbook.save
        format.html { redirect_to @scrapbook, notice: 'Scrapbook was successfully created.' }
        format.json { render json: @scrapbook, status: :created, location: @scrapbook }
      else
        format.html { render action: "new" }
        format.json { render json: @scrapbook.errors, status: :unprocessable_entity }
      end
    end
  end

  # Update
  def update
    @scrapbook = Scrapbook.find(params[:id])

    respond_to do |format|
      if @scrapbook.update_attributes(params[:scrapbook])
        format.html { redirect_to @scrapbook, notice: 'Scrapbook was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @scrapbook.errors, status: :unprocessable_entity }
      end
    end
  end

  # Delete
  def destroy
    @scrapbook = Scrapbook.find(params[:id])
    @scrapbook.destroy

    respond_to do |format|
      format.html { redirect_to scrapbooks_url }
      format.json { head :no_content }
    end
  end
end
