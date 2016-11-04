require 'date'

class EentriesController < ApplicationController
  before_action :set_eentry, only: [:show, :edit, :update, :destroy]

  # GET /eentries
  # GET /eentries.json
  def index
    @eentries = Eentry.all.order_by(:created.asc)
  end

  # GET /eentries/1
  # GET /eentries/1.json
  def show
  end

  # GET /eentries/new
  def new
    @eentry = Eentry.new
  end

  # GET /eentries/1/edit
  def edit
  end

  # GET /eentries/1/weekview
  def weekview

    @first_day = (DateTime.now - 1.month).beginning_of_month
    @week_tags = []
    for i in 0..7
      @week_tags << (@first_day+i).strftime('%Y-%m-%d')
    end

    @eentries = Eentry.in(tags: @week_tags).order_by(:created.asc)

  end

  # POST /eentries
  # POST /eentries.json
  def create

    @eentry = Eentry.create
    @eentry.user_id = params[:eentry][:user_id]
    @eentry.amount = params[:eentry][:amount]
    @eentry.tags = params[:eentry][:tags].split(',').reject(&:empty?)
    @eentry.details = params[:eentry][:details]
    @eentry.created = Time.now.strftime("%Y-%m-%d %H:%M:%S")
    @eentry.updated = Time.now.strftime("%Y-%m-%d %H:%M:%S")

    respond_to do |format|
      if @eentry.save
        format.html { redirect_to @eentry, notice: 'The entry was successfully created.' }
        format.json { render :show, status: :created, location: @eentry }
      else
        format.html { render :new }
        format.json { render json: @eentry.errors, status: :unprocessable_entity }
      end
    end
  end


  # PATCH/PUT /eentries/1
  # PATCH/PUT /eentries/1.json
  def update
    respond_to do |format|

      @eentry = Eentry.find(params[:id])
      @eentry.user_id = params[:eentry][:user_id]
      @eentry.amount = params[:eentry][:amount]
      @eentry.tags = params[:eentry][:tags].split(',').reject(&:empty?)
      @eentry.details = params[:eentry][:details]
      @eentry.updated = Time.now.strftime("%Y-%m-%d %H:%M:%S")

      if @eentry.save
        format.html { redirect_to @eentry, notice: 'The entry was successfully updated.' }
        format.json { render :show, status: :ok, location: @eentry }
      else
        format.html { render :edit }
        format.json { render json: @eentry.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /eentries/1
  # DELETE /eentries/1.json
  def destroy
    @eentry.destroy
    respond_to do |format|
      format.html { redirect_to eentries_url, notice: 'The entry was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    def set_eentry
      @eentry = Eentry.find(params[:id])
    end

    def eentry_params
      params.require(:eentry).permit(:user_id, :amount, :tags, :details)
    end
end
