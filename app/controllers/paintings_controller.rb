class PaintingsController < ApplicationController
    before_filter :authorize, only: [:edit, :update, :new, :save, :destroy]
    
  # GET /paintings
  # GET /paintings.json
  def index
    @paintings = Painting.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @paintings }
    end
  end

  # GET /paintings/1
  # GET /paintings/1.json
  def show
    @painting = Painting.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @painting }
    end
  end

  # GET /paintings/new
  # GET /paintings/new.json
  def new
    @painting = Painting.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @painting }
    end
  end

  # GET /paintings/1/edit
  def edit
    @painting = Painting.find(params[:id])
  end

  # POST /paintings
  # POST /paintings.json
  def create
      #code to set the painting user id to current user id
     
      #@painting = Painting.new(params[:user_id => current_user_id])
      #@painting = Painting.new(params[:@user_id => @current_user_id])
      #@painting = Painting.new(params[:@user_id => @user_id])
      #@painting = Painting.new(params[:@user_id => session[:user_id]])
      #@painting = Painting.new(params[:@user_id => session.user_id])
      # @painting = Painting.new(params[:@user_id => @current_user[session[:user_id]]])
      #@painting = Painting.new(params[:@user_id => @current_user_id])
      #@user = User.find(session[:user_id])
      #@painting = Painting.new(params[:@user_id => current_user.id])
      #@painting = Painting.new(params[:@user_id => current_user.id])
      # this code works but not the right way @painting = Painting.new(:@user_id => current_user.id)
      #user.paintings.create(user_id = current_user.id)
      @painting = current_user.paintings.build(params[:painting])
      #@painting = Painting.new(params[:painting])

    respond_to do |format|
      if @painting.save
        format.html { redirect_to @painting, notice: 'Painting was successfully created.' }
        format.json { render json: @painting, status: :created, location: @painting }
      else
        format.html { render action: "new" }
        format.json { render json: @painting.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /paintings/1
  # PUT /paintings/1.json
  def update
    @painting = Painting.find(params[:id])

    respond_to do |format|
      if @painting.update_attributes(params[:painting])
        format.html { redirect_to @painting, notice: 'Painting was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @painting.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /paintings/1
  # DELETE /paintings/1.json
  def destroy
    @painting = Painting.find(params[:id])
    @painting.destroy

    respond_to do |format|
      format.html { redirect_to paintings_url }
      format.json { head :no_content }
    end
  end
end
