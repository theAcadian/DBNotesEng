class ModelInfoController < ApplicationController
  def DBNotes
  end
end
class ModelInfoController < ApplicationController

	#before_filter :get_models_info

	

	before_filter :user_logged_in, :only => [:add_note, :add_comment]

	def get_models_info
		# The below line requires "cache_classes" to be "on"
		# It seems it is "on" by default in Dev , but not in Prod
		# See the following SO question & answers - http://stackoverflow.com/questions/516579/is-there-a-way-to-get-a-collection-of-all-the-models-in-your-rails-app
		Rails.application.eager_load!
		#Dir.glob(Rails.root.join('app/models/*')).each do |x| 
		#	require x 
		#end
		@models = ActiveRecord::Base.descendants
		return @models
	end

	def DBNotes
		Rails.application.eager_load!
		@models = get_models_info
		session[:username] = nil
	end

	<<-DOC
	def show_notes_for_table
		@table_name = params[:table]
		@notes = Note.where(:table_name => @table_name)

		render "index"
	end
	DOC
	

	################################################################################################
	#  									Authentication using Jira REST Api
	################################################################################################	

	<<-DOC
    # THis function is not being used at present..
  	def user_exists? (username, password)
	  	# Below is the message returned when "Not already Authenticated in Jira"
	  	# {"errorMessages":["You are not authenticated. Authentication required to perform this operation."],"errors":{}}

	  	# Below is the message returned when "Already Authenticated in Jira"
	  	# {"self":"https://jira2.icentris.com/jira/rest/api/latest/user?username=jyothiprasad.ponduru","name":"jyothiprasad.ponduru","loginInfo":{"failedLoginCount":15,"loginCount":278,"lastFailedLoginTime":"2013-04-18T05:49:07.054-0600","previousLoginTime":"2013-04-18T22:19:09.290-0600"}}
	  	#!(jira(username, password).include? "not authenticated")
	  	!(IcentrisJira::get_user_info(username, password).include? "not authenticated")
  	end
	DOC

  	# This is called in before_filter for add_note() & add_comment()
  	def user_logged_in
  		if session[:username].blank? 
  			render :json => "not logged in".to_json
  		else 
  			true
  		end
  	end

  	<<-DOC
  	require 'net/http'

    def jira(username, password)
	  	#uri = URI.parse("https://jira2.icentris.com/jira/rest/auth/1/session/")
	  	uri = URI.parse("https://jira2.icentris.com/jira/rest/api/2/user?username=" + username)
	    http = Net::HTTP.new(uri.host, uri.port)
	    http.use_ssl = true
	    http.verify_mode = OpenSSL::SSL::VERIFY_NONE
	    request = Net::HTTP::Get.new(uri.request_uri)
	    request.basic_auth username, password 
		request["Content-Type"] = "application/json"
	    @jira_response = http.request(request)
	    return @jira_response.body
	end
	DOC

	require 'IcentrisJira'
  	def user_authenticate
  		username = params[:username]
  		password = params[:password]
  		#jira_response = jira(username, password)
  		#jira_response = IcentrisJira::get_user_info(username, password) # Used IcentrisJira gem (which has the same code as jira() method above)
  		jira_response = IcentrisJira::getJSON("https://jira2.icentris.com/jira/rest/api/2/user?username=" + username, username, password)
  		if jira_response.include? "username="
  			session[:username] = jira_response.split('"displayName":')[1].split(",")[0]
  			render :json => "Authentication Successful".to_json	# send back user's full name if authentication is successful
  		else 
  			session[:username] = nil
  			render :json => "Authentication Failed".to_json # send back "Authentication Failed" if authentication has failed
  		end 
  	end

	################################################################################################
	#  						Below actions are called by Ajax calls and return JSON
  	################################################################################################
  	def show_notes_for_column
		@table_name = params[:table]
		@column_name = params[:column]
		@notes = Note.where(:table_name => @table_name, :column_name => @column_name)

		#respond_to do |format|
			#format.any(:xml, :html, :json) { render :json => @notes.to_json(:include => :comments) }
		#end
		render :json => @notes.to_json(:include => :comments)
	end

  	def is_user_logged_in
  		logged_in_status = !session[:username].blank?
  		render :json => logged_in_status.to_json
  	end 


  	def get_author_name
  		render :json => session[:username].to_json
  	end

  	def add_note
		table_name = params[:table_name]
		column_name = params[:column_name]
		author = params[:author]
		note_text = params[:note_text]
		@n = Note.create :table_name => table_name, :column_name => column_name, :author => author, :note_text => note_text
		respond_to do |format|
			format.any(:xml, :html, :json) { render :json => @n.to_json }
		end
	end

	def add_comment
		#table_name = params[:table_name]
		#column_name = params[:column_name]
		author = params[:author]
		comment_text = params[:comment_text]
		note_id = params[:note_id]
		@c = Comment.create :author => author, :comment_text => comment_text, :note_id => note_id
		respond_to do |format|
			format.any(:xml, :html, :json) { render :json => @c.to_json}
		end
	end

  	
  	# This will be called on page-load via Ajax
  	def get_table_notes_count
  		# write code to that outputs some json 
  		# 		{"table1": 21, "table2": 2,.....}
  		render :json => Note.find_by_sql("select table_name, count(*) as note_count from Notes group by table_name").to_json
  	end

  	
  	# This will be called when user clicks on a particular table-name in the Accordion control
  	def get_column_notes_count_within_a_table (table_name)
  		# write code that outputs some json
  		#		{"col1": 10, "col2": 5, "col3": 3,......}
  		render :json => Note.find_by_sql("select table_name, column_name, count(*) as note_count from Notes where table_name = ? group by table_name, column_name", table_name).to_json
  	end


  	def get_column_notes_count()
  		render :json => Note.find_by_sql("select table_name, column_name, count(*) as note_count from Notes group by table_name, column_name").to_json
  	end


end
