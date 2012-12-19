class PaintingsController < ApplicationController
    
    before_filter :authorized_user, only: [:destroy, :update, :edit]
    
    before_filter :authorize, only: [:index, :new, :save]
    
    def index
    @paintings = Painting.search(params[:search])
        end
    
    def newest
        @paintings = Painting.order("created_at DESC")
    end
    
    def index_admin
        @paintings = Painting.order("downloads DESC")
        
        respond_to do |format|
            format.html # index_admin.html.erb
            format.json { render json: @paintings }
        end
    end
    
    def my_paintings
        @paintings = Painting.where(:user_id => current_user.id)
        
        respond_to do |format|
            format.html # mypaintings.html.erb
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
      
      @painting = current_user.paintings.build(params[:painting])

    respond_to do |format|
      if @painting.save
          # PhotoMailer.photo_email.deliver
          
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
    
    def download
        painting = Painting.find(params[:id])
        painting.increment(:downloads)
        painting.save
        
        Transaction.create(:photo_id => painting.id,:seller_id => painting.user_id,:buyer_id => current_user.id,:name => painting.name, :image => painting.image)
        
        send_file(painting.image.path, :filename => "#{painting.name}.jpg", :type => "image/jpeg")
    
    end
    
    private
    
    def authorized_user
        @painting = Painting.find(params[:id])
        #redirect_to root_path unless current_user?(@painting.user)
        #redirect_to root_path unless current_user.id(@painting.user)
        redirect_to root_path, alert: "Not authorized"  unless current_user.id = @painting.user
        #current_user.id = @painting.user
    end
    
end
