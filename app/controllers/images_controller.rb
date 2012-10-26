class ImagesController < ApplicationController

  # INDEX
  def index
    @images = Image.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @images }
    end
  end

  # SHOW
  def show
  	@current_user = @user 
    @image = Image.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @image }
    end
  end

  # NEW
  def new
    @image = Image.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @image }
    end
  end

  # EDIT
  def edit
  	@user = User.find(params[:id])
  	
    @image = Image.find(params[:id])
  end

  # CREATE
  def create
  	@user = User.find(params[:image][:user_id])
    @image = @user.images.build(params[:image])

    respond_to do |format|
      if @image.save
        format.html { redirect_to root_path(@user.id), notice: 'Image was successfully created.' }
        format.json { render json: @image, status: :created, location: @image }
      else
        format.html { render action: "new" }
        format.json { render json: @image.errors, status: :unprocessable_entity }
      end
    end
  end

  # UPDATE
  def update
  
    @image = Image.find(params[:id])

    respond_to do |format|
      if @image.update_attributes(params[:image])
        format.html { redirect_to @image, notice: 'Image was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @image.errors, status: :unprocessable_entity }
      end
    end
  end

  # DESTROY
  def destroy
  
    @image = Image.find(params[:id])
    @image.destroy

    respond_to do |format|
      format.html { redirect_to scrapbook_url }
      format.json { head :no_content }
    end
  end
end
