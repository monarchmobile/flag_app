class ImagesController < ApplicationController

  # INDEX
  def index
    #@images = Image.all
    @user = current_user
    @images = @user.images.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @images }
    end
  end

  # SHOW
  def show
  	@user = current_user
    @image = @user.images.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @image }
    end
  end

  # NEW
  def new
    @user = current_user
    @image = @user.images.new
    if params[:image][:date_taken]
      @date_taken = params[:image][:date_taken]
    else 
      @date_taken = "nothing"
    end

    respond_to do |format|
      
      format.js
    end
  end

  # EDIT
  def edit
  	@user = current_user
    @image = @user.images.find(params[:id])
    
    respond_to do |format|
      format.html { render ("images/crop") }
    end
    #@user = User.find(params[:image][:user_id])
    #@image = @user.images.build(params[:image])

  end

  # CREATE
  def create
  	@user = current_user
    @image = @user.images.build(params[:image])

    respond_to do |format|
      if @image.save
        format.html { render ("images/crop") }
      else
        format.html { render action: "new" }
        format.json { render json: @image.errors, status: :unprocessable_entity }
      end
    end
  end

  # UPDATE
  def update

    @user = current_user
    @image = @user.images.find(params[:id])
    respond_to do |format|
      if @image.update_attributes(params[:image])
        if params[:image][:crop_x].present?
          format.html { render ("images/crop") }
        elsif params[:image][:week] || params[:image][:month] || params[:image][:year]
          if params[:image][:week] 
            @range = "week"
            @boolean = params[:image][:week]
            format.js  
          elsif params[:image][:month]
            @range = "month"
            @boolean = params[:image][:month]
            format.js 
          elsif params[:image][:year]
            @range = "year"
            @boolean = params[:image][:year]
            format.js 
          end
        end
      end
    end
  end

  # DESTROY
  def destroy
  
    @image = Image.find(params[:id])
    @image.destroy

    respond_to do |format|
      format.html { redirect_to scrapbook_path }
      format.json { head :no_content }
    end
  end

  def resize
    @user = current_user
    @image = @user.images.find(params[:id])
    respond_to do |format|
      if @image.update_attributes(params[:image])
        format.js
      end
    end
  end 

  def drag
    @user = current_user
    @image = @user.images.find(params[:id])
    respond_to do |format|
      if @image.update_attributes(params[:image])
        format.js
      end
    end
  end 
end
