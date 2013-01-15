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
    get_associated_image

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
      @date_taken = []
    end

    respond_to do |format|
      
      format.js
    end
  end

  # EDIT
  def edit
  	@user = current_user
    get_associated_image
    @date_taken = @image.date_taken
    # @image_id = params[:id]
    respond_to do |format|

      # format.html {  render "images/crop" }
      format.js 
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
        # format.html { render ("images/crop") }
        parameters = "beg_range=#{@image.date_taken}&end_range=#{@image.date_taken}"
        format.html { redirect_to root_path+"users/"+@user.id.to_s+"/scrapbook/day?"+parameters }
      else
        format.html { render action: "new" }
        format.json { render json: @image.errors, status: :unprocessable_entity }
      end
    end
  end

  def z_index
    @user = current_user
    get_associated_image
   
    respond_to do |format|
      if @image.update_attributes(params[:image])
        format.js
      end
    end

  end

  # UPDATE
  def update 

    @user = current_user
    get_associated_image
   
    respond_to do |format|
      if @image.update_attributes(params[:image])
        # if params[:image][:crop_x].present?
        #   format.html { render ("images/crop") }
        
        if params[:image][:week] || params[:image][:month] || params[:image][:year]
          if params[:image][:week] 
            @range = 1
            @string = "week"
            @boolean = params[:image][:week]
            format.js  
          elsif params[:image][:month]
            @range = 2
            @string = "month"
            @boolean = params[:image][:month]
            format.js 
          elsif params[:image][:year]
            @range = 3
            @string = "year"
            @boolean = params[:image][:year]
            format.js
          end 
        else
          parameters = "beg_range=#{@image.date_taken}&end_range=#{@image.date_taken}"
          # format.html { redirect_to root_path+"users/"+@user.id.to_s+"/scrapbook/day?"+parameters }
          @boolean = 2
          format.js
          # format.html { redirect_to :back }
        end
      else
        format.js { render alert("error")}
      end
    end
  end

  # DESTROY
  def destroy
    @user = current_user
    get_associated_image
    @image.destroy

    respond_to do |format|
      format.js
    end
  end

  def resize
    @user = current_user
    get_associated_image
    respond_to do |format|
      if @image.update_attributes(params[:image])
        format.js
      end
    end
  end 

  def drag
    @user = current_user
    get_associated_image
    respond_to do |format|
      if @image.update_attributes(params[:image])
        format.js
      end
    end
  end 

  def get_associated_image
    @image = @user.images.find(params[:id])
  end

end
