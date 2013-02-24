class FoundsController < ApplicationController
  before_filter :getMe
  before_filter CASClient::Frameworks::Rails::Filter, :unless => :skip_login?
  # GET /founds
  # GET /founds.json
  def index
    @founds = Found.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @founds }
    end
  end

  # GET /founds/1
  # GET /founds/1.json
  def show
    @found = Found.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @found }
    end
  end

  # GET /founds/new
  # GET /founds/new.json
  def new
    @found = Found.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @found }
    end
  end

  # GET /founds/1/edit
  def edit
    @found = Found.find(params[:id])
  end

  # POST /founds
  # POST /founds.json
  def create
    @found = Found.new(params[:found])

    respond_to do |format|
      if @found.save
        @found.parse_desc
        format.html { redirect_to thanks_path, notice: 'Found was successfully created.' }
        format.json { render json: thanks_path, status: :created, location: thanks_path }
      else
        format.html { render action: "new" }
        format.json { render json: @found.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /founds/1
  # PUT /founds/1.json
  def update
    @found = Found.find(params[:id])

    respond_to do |format|
      if @found.update_attributes(params[:found])
        format.html { redirect_to @found, notice: 'Found was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @found.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /founds/1
  # DELETE /founds/1.json
  def destroy
    @found = Found.find(params[:id])
    @found.destroy

    respond_to do |format|
      format.html { redirect_to founds_url }
      format.json { head :no_content }
    end
  end
end
