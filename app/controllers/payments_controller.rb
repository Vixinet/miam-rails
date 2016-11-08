class PaymentsController < ApplicationController
  before_action :logged_in_user_and_fill_in

  layout 'account'

  # GET /payments
  def index
    Stripe.api_key =  Rails.application.secrets.stripe_api_key
    @payments = Stripe::Customer.retrieve(current_user.stripe_id).sources.all(:limit => 100, :object => "card")
  end

  # GET /payments/new
  def new
  end

  # POST /payments
  def create
    begin
      Stripe.api_key =  Rails.application.secrets.stripe_api_key
      customer = Stripe::Customer.retrieve(current_user.stripe_id)
      customer.sources.create(:source => {
        :object => "card",
        :exp_month => payment_params['cc_exp'].split('/')[0].strip,
        :exp_year => payment_params['cc_exp'].split('/')[1].strip,
        :cvc => payment_params['cc_cvc'],
        :number => payment_params['cc_number'].delete(' '),
        :name => current_user.name
      })

      flash[:success] = 'Address ajoutée!'
      redirect_to payments_url
    # rescue Stripe::CardError => e
      # Since it's a decline, Stripe::CardError will be caught
      # body = e.json_body
      # err  = body[:error]

      # puts "Status is: #{e.http_status}"
      # puts "Type is: #{err[:type]}"
      # puts "Code is: #{err[:code]}"
      # # param is '' in this case
      # puts "Param is: #{err[:param]}"
      # puts "Message is: #{err[:message]}"
    # rescue Stripe::RateLimitError => e
      # Too many requests made to the API too quickly
    # rescue Stripe::InvalidRequestError => e
      # Invalid parameters were supplied to Stripe's API
    # rescue Stripe::AuthenticationError => e
      # Authentication with Stripe's API failed
      # (maybe you changed API keys recently)
    # rescue Stripe::APIConnectionError => e
      # Network communication with Stripe failed
    # rescue Stripe::StripeError => e
      # Display a very generic error to the user, and maybe send
      # yourself an email
    rescue => e
      flash[:error] = 'Problème avec votre carte, vérifiez votre saisie.'
      render :new
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_address
      @address = Address.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def payment_params
      params.require(:payment).permit(:cc_exp, :cc_number, :cc_cvc)
    end
end
