DBNotesEng
==========

DBNotesEng = DBNotes app as a Rails Engine

Link to DBNotes app - https://github.com/theAcadian/DBNotes

Demo link of DBNotes app - http://screencast.com/t/UXaEGpEBduO

WHAT THIS ENGINE CREATES
------------------------
1. Creates a page with URL = /DBNotes
2. Creates 2 tables - NOTES & COMMENTS 
These 2 tables are used to store the documentation in the form notes & comments for each column

STEPS to include it
----------------------

1. include gem in gemfile
gem 'db_notes_eng'

2. Run migrations - to create NOTES & COMMENTS tables 

Below command adds the migrations present in the gem to your application:
	rake db_notes_eng_engine:install:migrations

Then run -
	rake db:migrate

