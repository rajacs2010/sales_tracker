class KdDetailsController < ApplicationController
  # GET /kd_details
  # GET /kd_details.json
  def index
    @kd_details = KdDetail.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @kd_details }
    end
  end

  # GET /kd_details/1
  # GET /kd_details/1.json
  def show
    @kd_detail = KdDetail.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @kd_detail }
    end
  end

  # GET /kd_details/new
  # GET /kd_details/new.json
  def new
    @kd_detail = KdDetail.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @kd_detail }
    end
  end

  # GET /kd_details/1/edit
  def edit
    @kd_detail = KdDetail.find(params[:id])
  end

  # POST /kd_details
  # POST /kd_details.json
  def create
    @kd_detail = KdDetail.new(params[:kd_detail])

    respond_to do |format|
      if @kd_detail.save
        format.html { redirect_to @kd_detail, notice: 'Kd detail was successfully created.' }
        format.json { render json: @kd_detail, status: :created, location: @kd_detail }
      else
        format.html { render action: "new" }
        format.json { render json: @kd_detail.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /kd_details/1
  # PUT /kd_details/1.json
  def update
    @kd_detail = KdDetail.find(params[:id])

    respond_to do |format|
      if @kd_detail.update_attributes(params[:kd_detail])
        format.html { redirect_to @kd_detail, notice: 'Kd detail was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @kd_detail.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /kd_details/1
  # DELETE /kd_details/1.json
  def destroy
    @kd_detail = KdDetail.find(params[:id])
    @kd_detail.destroy

    respond_to do |format|
      format.html { redirect_to kd_details_url }
      format.json { head :no_content }
    end
  end
end
