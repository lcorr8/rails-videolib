# Rails VideoLib

This is a ruby on Rails v4.2 lecture video library to keep your watched Avi lectures organized. Includes standard signup, signin, logout, and third party Github signup/singin.

###Uses ActiveRecord Model Associations between:

- User
- Section
- Video
- Rating

This App offers the following characteristics depending on user role:

##Roles:

###General Student:
- Can view public videos.
- Can add new videos.
- Can add new sections.
- Can request Flatiron student status

###Flatiron Student:
- Can do what a general student can do.
- Can view Flatiron videos.

###Admin:
- Can do what a Flatiron student can do.
- Can assign Flatiron status to users.
- Can delete users.

## Usage

To use this app, just clone, run `bundle install`, `rake db:migrate`, `rake db:seed`, then run `rails s`.

The seed file contains dummy data. For actual Flatiron videos, send me a message via the Learn chat. learn.co/lcorr8

## Contributing Bugfixes or Features

For submitting something back, be it a patch, some documentation, or new feature requires some level of community interactions.

Committing code is easy:

- Fork this repository.
- Create a local development branch for the bugfix; I recommend naming the branch such that you'll recognize its purpose.
- Commit a change, and push your local branch to your github fork
- Send me pull request for your changes to be included

I apologize in advance for the slow action on pull requests and issues.

## License
VideoLib is licensed under the MIT license. (http://opensource.org/licenses/MIT)