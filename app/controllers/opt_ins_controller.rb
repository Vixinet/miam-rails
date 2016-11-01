class OptInsController < ApplicationController

  # POST /opt_ins
  def create
    @opt_in = OptIn.new(opt_in_params)

    respond_to do |format|
      if @opt_in.save
        puts "**** opt_in_params[:visitor_id]=#{opt_in_params[:visitor_id]}"
        
        if opt_in_params[:visitor_id].blank?
          intercom = Intercom::Client.new(token: Rails.application.secrets.intercom_access_token)
          intercom.contacts.create(:email => @opt_in.email)
        else
          # Convert user to Leaed
          response = HTTParty.post(
            'https://api.intercom.io/visitors/convert', 
            :body => { 
              :visitor => { 
                :user_id => lead.user_id 
              }, 
              :type => "lead" 
            }.to_json,
            :basic_auth => {
              :username => Rails.application.secrets.intercom_access_token
            },
            :headers => {
              'Content-Type' => 'application/json', 
              'Accept' => 'application/json'
            }
          )

          puts response.inspect
          puts response.user_id

          # Update Lead with email
          contact = intercom.contacts.find(:user_id => response.user_id)
          contact.email = @opt_in.email
          intercom.contacts.save(contact)
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
