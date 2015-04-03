class PokemonsController < ApplicationController
  def capture
  	@pokemon = Pokemon.find(params[:id])
  	@pokemon.trainer_id = current_trainer.id
  	if @pokemon.save
      redirect_to root_path
    end
  end

  def damage
    @pokemon = Pokemon.find(params[:id])
    @pokemon.health -= 10
    if @pokemon.health <= 0
    	@pokemon.destroy
    	redirect_to trainer_path(params[:trainer])
    elsif @pokemon.save
    	redirect_to trainer_path(params[:trainer])
    end
  end

  def new
    @pokemon = Pokemon.new
  end

  def create
    @pokemon = Pokemon.create(pokemon_params)
    @pokemon.health = 100;
    @pokemon.level = 1;
    @pokemon.trainer_id = current_trainer.id
    if @pokemon.save 
      redirect_to trainer_path(id:current_trainer.id) 
    else
      flash[:error] = @pokemon.errors.full_messages.to_sentence
      redirect_to pokemons_new_path
    end
  end

  def pokemon_params
    params.require(:pokemon).permit(:name)
  end


end
