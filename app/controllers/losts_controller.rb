class LostsController < ApplicationController
  # GET /losts
  # GET /losts.json
  def index
    @losts = Lost.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @losts }
    end
  end

  # GET /losts/1
  # GET /losts/1.json
  def show
    @lost = Lost.find(params[:id])
    @matches = Found.tagged_with(@lost.tag_list, :any => true)

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @lost }
    end
  end

  # GET /losts/new
  # GET /losts/new.json
  def new
    @lost = Lost.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @lost }
    end
  end

  # GET /losts/1/edit
  def edit
    @lost = Lost.find(params[:id])
  end

  # POST /losts
  # POST /losts.json
  def create
    @lost = Lost.new(params[:lost])

    respond_to do |format|
      if @lost.save
        @lost.parse_desc
        @lost.remove_extra
        format.html { redirect_to @lost, notice: 'Lost was successfully created.' }
        format.json { render json: @lost, status: :created, location: @lost }
      else
        format.html { render action: "new" }
        format.json { render json: @lost.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /losts/1
  # PUT /losts/1.json
  def update
    @lost = Lost.find(params[:id])

    respond_to do |format|
      if @lost.update_attributes(params[:lost])
        format.html { redirect_to @lost, notice: 'Lost was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @lost.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /losts/1
  # DELETE /losts/1.json
  def destroy
    @lost = Lost.find(params[:id])
    @lost.destroy

    respond_to do |format|
      format.html { redirect_to losts_url }
      format.json { head :no_content }
    end
  end
end
