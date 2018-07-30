class GeolocalisationsController < ApplicationController
	#before_action :validate_user, except: [:show, :index]
	before_action :authenticate_user!, except: [:show, :index]
	#GET /geolocalisations
	def index
		@geolocalisations = Geolocalisation.all
		@hash = Gmaps4rails.build_markers(@geolocalisations) do |geolocalisation, marker|
  			marker.lat geolocalisation.latitude
  			marker.lng geolocalisation.longitude
		end
	end
	#GET /geolocalisations/:id
	def show
		@geolocalisation = Geolocalisation.find(params[:id]) #Geolocalisation.where("ident LIKE ?","%articulo%")
	end #Geolocalisation.find(Article.all.size)
	#GET /geolocalisations/new
	def new
		@geolocalisation = Geolocalisation.new
	end

	def edit
		@geolocalisation = Geolocalisation.find(params[:id])
	end

	#POST /geolocalisations
	def create
		#@geolocalisation = Geolocalisation.new(ident: params[:geolocalisation][:ident],
		#	posx: params[:geolocalisation][:posx], posy: params[:geolocalisation][:posy])
		@geolocalisation = current_user.geolocalisations.new(geolocalisation_params)

		if @geolocalisation.save
			redirect_to @geolocalisation
		else
			render :new
		end
	end
	def destroy
		@geolocalisation = Geolocalisation.find(params[:id])
		@geolocalisation.destroy
		redirect_to geolocalisations_path 
	end
	#PUT /geolocalisations/:id
	def update
		# @geolocalisation.update_attributes({ident: '72373'})
		@geolocalisation = Geolocalisation.find(params[:id])
		if @geolocalisation.update(geolocalisation_params)#article_params trae con sigo todos los campos declarados en
			redirect_to @geolocalisation
		else
			render :edit
		end
	end

	private
	#def validate_user
	#	redirect_to new_user_session_path, notice: "Necesitas iniciar sesión"
	#end

	def geolocalisation_params
		params.require(:geolocalisation).permit(:lattitude,:longitude,:name,:address,:title)
	end
end
