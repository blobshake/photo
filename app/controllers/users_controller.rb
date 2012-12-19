class UsersController < ApplicationController
  before_filter :authorize, only: [:edit, :update, :destroy]  
    # before_filter :correct_user, only: [:edit, :update, :new, :save, :destroy]
    
  # GET /users
  # GET /users.json
  def index
    @users = User.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @users }
    end
  end
    
  def bought
      
     @match_id = Transaction.where(:buyer_id => current_user.id).pluck(:photo_id)
      #@paintings = Painting.where("id = ?", @match_id)
      @paintings = Painting.where(:id => @match_id)
      # @paintings = Painting.where(:id => @match_id)
      
      respond_to do |format|
          format.html # bought.html.erb
          format.json { render json: @paintings}
    end
  end
    
    def sold
        
        @seller_match_id = Transaction.where(:seller_id => current_user.id).pluck(:photo_id)
        #@paintings = Painting.where("id = ?", @match_id)
        @paintings = Painting.where(:id => @seller_match_id)
        # @paintings = Painting.where(:id => @match_id)
        
        respond_to do |format|
            format.html # bought.html.erb
            format.json { render json: @paintings}
        end
    end
    
    

  # GET /users/1
  # GET /users/1.json
  def show
    @user = User.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @user }
    end
  end
    
    #Get current user
    #Show name, number of paintings, profile pic
    
    def profile
      @user = current_user
    end
    

  # GET /users/new
  # GET /users/new.json
  def new
    @user = User.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @user }
    end
  end


  # GET /users/1/edit
  def edit
    @user = User.find(params[:id])
  end

  # POST /users
  # POST /users.json
    def create
        @user = User.new(params[:user])
        if @user.save
            session[:user_id] = @user.id
            redirect_to root_url, notice: "Thank you for signing up!"
            else
            render "new"
        end
    end

  # PUT /users/1
  # PUT /users/1.json
  def update
    @user = User.find(params[:id])

    respond_to do |format|
      if @user.update_attributes(params[:user])
          format.html { redirect_to '/users/profile', notice: 'User was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user = User.find(params[:id])
    @user.destroy

    respond_to do |format|
      format.html { redirect_to users_url }
      format.json { head :no_content }
    end
  end
end
