class OptInsController < ApplicationController

  # POST /opt_ins
  def create
    @opt_in = OptIn.new(opt_in_params)

    respond_to do |format|
      if @opt_in.save
        puts "**** opt_in_params[:visitor_id]=#{opt_in_params[:visitor_id]}"
        
        intercom = Intercom::Client.new(token: Rails.application.secrets.intercom_access_token)
        lead = intercom.contacts.create(:email => @opt_in.email)
        
        unless opt_in_params[:visitor_id].blank?

          response = HTTParty.post(
            'https://api.intercom.io/visitors/convert', 
            :body => { 
              :visitor => { 
                :user_id => lead.user_id 
              }, 
              :type => "lead" 
            },
            :basic_auth => {
              :usernam => Rails.application.secrets.intercom_access_token
            },
            :headers => {
              'Content-Type' => 'application/json', 
              'Accept' => 'application/json'
            }
          )

          response.inspect
        end
        
        format.js { render :nothing => true }
      else
        format.js { render :nothing => true, :status => 400 }
      end
    end
  end

  private
    def opt_in_params
      params.require(:opt_in).permit(:email, :visitor_id)
    end
end
