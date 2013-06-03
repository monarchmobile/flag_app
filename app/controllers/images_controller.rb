class ImagesController < ApplicationController 
  authorize_resource
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

  def image_partial
    @images_partial = Image.order("RANDOM()").limit(10).last
    @model_name = "Image"
    render 'shared/quick_partial_view', model_name: @model_name
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

  # UPDATE
  def update 

    @user = current_user
    get_associated_image
   
    respond_to do |format|
      if @image.update_attributes(params[:image])
          format.js
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

  def time_frame
    @user = current_user
    get_associated_image
    respond_to do |format|
      if @image.update_attributes!(params[:image])
        format.js
      end
    end
  end 

  def z_index
    @user = current_user
    get_associated_image
    respond_to do |format|
      if @image.update_attributes!(params[:image])
        format.js
      end
    end
  end

  def get_associated_image
    @image = @user.images.find(params[:id])
  end

end
