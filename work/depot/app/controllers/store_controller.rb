class StoreController < ApplicationController

  before_filter :prepare_time_for_display

  def index
    @products = Product.find_products_for_sale
    @cart = find_cart
  end

  
  def prepare_time_for_display
    @current_time = Time.now
  end

  
  def add_to_cart
    begin 
      product = Product.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      logger.error("Attempt to access invalid product #{params[:id]}")
      redirect_to_index("Invalid product")
    else
      @cart = find_cart
      @current_item = @cart.add_product(product)
      if request.xhr?
        respond_to { |format| format.js }
      else
        redirect_to_index
      end
    end
  end

  def empty_cart
    session[:cart] = nil
    redirect_to_index
  end

  def checkout
    @cart = find_cart
    if @cart.items.empty?
      redirect_to_index("Your cart is empty")
    else
      @order = Order.new
    end
  end



  private

  def find_cart
    session[:cart] ||= Cart.new
  end

  def redirect_to_index(msg = nil)
    flash[:notice] = "YOUR CART is currentlyyy empty"
    redirect_to :action => :index
  end

end
