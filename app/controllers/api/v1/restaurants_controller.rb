class Api::V1::RestaurantsController < Api::V1::BaseController
  acts_as_token_authentication_handler_for User, except: [ :index, :show ]
  before_action :set_and_authorize_restaurant, except: [ :index, :create ]

  def index
    @restaurants = policy_scope(Restaurant)
  end

  def show; end

  def update
    if @restaurant.update(restaurant_params)
      render :show
    else
      render_error
    end
  end

  def create
    @restaurant = Restaurant.new(restaurant_params)
    @restaurant.user = current_user
    authorize @restaurant

    if @restaurant.save
      render :show, status: :created
    else
      render_error
    end
  end

  def destroy
    @restaurant.destroy
    head :no_content
  end

  private

  def render_error
    render json: {
      errors: @restaurant.errors.full_messages
    }, status: :unprocessable_entity
  end

  def restaurant_params
    params.require(:restaurant).permit(:name, :address)
  end

  def set_and_authorize_restaurant
    @restaurant = Restaurant.find(params[:id])
    authorize @restaurant
  end
end
