class ChampionsController < ApplicationController
  before_action :set_champion, only: [:show, :edit, :update, :destroy]
  #skip_before_action :verify_authenticity_token, only: [ :update, :create, :destroy]
  protect_from_forgery :except => [:create,:update,:destroy]
  
  # GET /champions
  # GET /champions.json
  def index
    @champions =  Champion._get_list_page(params)

    respond_to do |format|
        format.html { }
        format.json {

          if params[:detail] == 'true'
            _result = []
            @champions.each do |champ|
              _tmp = champ.attributes
              _tmp['tags'] = champ.tags.select('id,name')
              _result.push(_tmp)
            end
            render json: {:info => Champion._get_list_page_stats(params), :data =>_result }
          else
            render json: {:info => Champion._get_list_page_stats(params), :data =>@champions }
          end

        }

    end
  end

  # GET /champions/1
  # GET /champions/1.json
  def show
  end

  # GET /champions/new
  def new
    @champion = Champion.new
    @tags = Tag.all
    @selected_tags = []
  end

  # GET /champions/1/edit
  def edit
    @tags = Tag.all
    @selected_tags = @champion.tags.pluck(:id)
  end

  # POST /champions
  # POST /champions.json
  def create
    @champion = Champion.new(champion_params)

    respond_to do |format|
      if @champion.save
        _tmp_tags = (params['tags'].present?) ? params['tags'] : params['champion']['tags']
        _tags = Tag.where(:name => _tmp_tags).all
        @champion.tags << _tags
        format.html { redirect_to champions_path, notice: 'Champion was successfully created.' }
        format.json { render :show, status: :created, location: @champion }
      else
        format.html { render :new }
        format.json { render json: @champion.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /champions/1
  # PATCH/PUT /champions/1.json
  def update

    respond_to do |format|
      if @champion.update(champion_params)

        if params['champion']['tags'].present? || params['tags'].present?
          _tmp_tags = (params['tags'].present?) ? params['tags'] : params['champion']['tags']
          @champion.tags.delete_all
          _tags = Tag.where(:name => _tmp_tags).all
          @champion.tags << _tags
        end

        format.html { redirect_to champions_path, notice: 'Champion was successfully updated.' }
        format.json { render :show, status: :ok, location: @champion }
      else
        format.html { render :edit }
        format.json { render json: @champion.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /champions/1
  # DELETE /champions/1.json
  def destroy

    if @champion
      @champion.destroy
    end
    respond_to do |format|
      format.html { redirect_to champions_url, notice: 'Champion was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_champion
    @champion = Champion.find(params[:id]) rescue false
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def champion_params
    params.require(:champion).permit(:name, :description)
  end

end
