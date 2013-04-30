DBNotesEng
==========

DBNotesEng = DBNotes app as a Rails Engine

The engine is a 'full' engine (i.e. not a 'mountable' one), so if you add this gem, the added files, routes etc will Not be namespaced. 

Link to DBNotes app - https://github.com/theAcadian/DBNotes

Demo link of DBNotes app - http://screencast.com/t/UXaEGpEBduO

WHAT THIS ENGINE CREATES
------------------------
1. Creates a route/page with URL = /DBNotes
2. Creates 2 models/tables - NOTES & COMMENTS 
These 2 tables are used to store the database documentation in the form notes & comments for each database-column
3. Creates a view - DBNotes.html.erb
4. Creates a controller - model_info_controller.rb

(All these files will Not be visible even after we add this engine/gem. However if we do a 'rake routes', we can see the routes that have been added by this gem; we probably can see the Models & Tables via 'rails console' and 'rails dbconsole')

STEPS to include it
----------------------

1. include gem in gemfile

gem 'db_notes_eng'

2. Run migrations - to create NOTES & COMMENTS tables 

Below command adds the migrations present in the gem to your application:

	rake db_notes_eng_engine:install:migrations

Then run -

	rake db:migrate

