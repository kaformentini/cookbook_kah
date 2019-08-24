class CuisinesController < ApplicationController
    def show
        @cuisine = Cuisine.find(params[:id])
    end

    def new
        @cuisine = Cuisine.new
    end

    def create
        @cuisine = Cuisine.new(params_cuisine)
        
        if @cuisine.save
          flash[:alert] = 'Regitro efetuado com sucesso!'
          redirect_to @cuisine
        else
          #flash.now[:error] = "Você deve preencher o campo TIPO"
          render :new
        end


    end


private

    def params_cuisine
        params.require(:cuisine).permit(:cuisine_name)
    end
end
