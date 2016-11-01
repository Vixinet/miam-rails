class OptInsController < ApplicationController

  # POST /opt_ins
  def create
    @opt_in = OptIn.new(opt_in_params)

    respond_to do |format|
      if @opt_in.save

        intercom = Intercom::Client.new(token: Rails.application.secrets.intercom_access_token)

        @visitor_id = opt_in_params[:visitor_id]        

        # It might happen the user clicks on submit the email before getting
        # the Intercom visitor Id (if Intercom isn't initialized)
        if @visitor_id.blank?  
          intercom.contacts.create(:email => @opt_in.email)
        else
          # Convert user to Leaed
          response = HTTParty.post(
            'https://api.intercom.io/visitors/convert', 
            :body => { 
              :visitor => { 
                :user_id => @visitor_id
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

          # If we don't find a visitor, it's a lead
          if response.code == 404
            puts "** Visitor not found"
            @lead_user_id = @visitor_id 
          else 
            puts "** Visitor not found"
            puts response.inspect
            puts response.body.inspect
            puts response.body[:user_id]
            response.body[:user_id]
          end

          response = HTTParty.post(
            'https://api.intercom.io/contacts', 
            :body => { 
              :user_id => @visitor_id,
              :email => @opt_in.email
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
