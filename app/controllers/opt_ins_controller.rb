class OptInsController < ApplicationController

  # POST /opt_ins
  def create
    @opt_in = OptIn.new(opt_in_params)

    respond_to do |format|
      if @opt_in.save
        puts "@opt_in.email #{@opt_in.email}"
        puts "#{Rails.application.secrets.intercom_access_token}"
        intercom = Intercom::Client.new(token: Rails.application.secrets.intercom_access_token)
        intercom.contacts.create(:email => @opt_in.email)
        
        format.js { render :nothing => true }
      else
        format.js { render :nothing => true, :status => 400 }
      end
    end
  end

  private
    def opt_in_params
      params.require(:opt_in).permit(:email)
    end
end
