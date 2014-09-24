# Uboxt technical test
This is a submission to a technical test, the examiner will understand the criteria.

## General approach
I am currently freelancing for a startup that is going live this week and therefore time for this test has been very constrained.

In order to produce a reasonable result in a short time I have made the following compromises:
- Used Rails as a template to host the application, this is simply for a fast development startup.
- Tested only the happy path.  Normally my tests would be considerably more detailed and fully test edge cases and sad path.
- Written Javascript UI interactions in raw jQuery.  Normally all UI enhancment would be encapsulated in a framework like Backbone Marionette or Angular and be fully tested.
- Not tested the base static_page controller or router.
- Used Twitter Bootstrap as a base responsive CSS framework.  Normally I would not do this as it destroys ones ability to have design fidelity, however it is perfect for a project like this.
- I noticed that Github returns nil languages in the repositories call.  I simply have not had time to address this.

I would welcome the opportunity to fully discuss how this project would be executed in a real client setting.


## Development environment
### Vagrant
When given the choice I create Virtual Box based Vagrant development servers.  This project contains a Vagrant file which will create a fully provisioned VM for this project.

### Docker
I user docker to host any services that the project depends on, in this example project I have included a Postgres database container to demonstrate the practice, however the project does not in fact need a database.  The build of the database can be seen in folder ```docker/postgres```.

### Development Setup
You will need a recent version of Virtual Box and Vagrant installed.

Clone down the repo.

In the project root folder create a ```.env``` file that looks like
```
RAILS_ENV=development
GITHUB_USER=<your github user id>
GITHUB_PASSWORD=<your github password>

```
In general I keep all secrets in .env files and exclude them from the repo.  This is very convenient as the file can be passed directly into docker containers.

In the project root folder create a ```ssh``` folder and copy in a id_rsa public key that grants access to your private github repos.  This key is not included in the repo.

For this project it is not strictly required, however it would be needed to build the ruby docker container where you Gemfile points to private github repos.  I have done it here for demonstration and it is part of my standard Ruby development workflow.

Execute ```vagrant up```

Vagrant should create and provision the machine, start the Postgres docker container and build the development container.

Execute
```
varant ssh
cd /vagrant
script/docker_web /bin/bash
```

This will give you a command line in the ruby development container.

Execute
```
bundle exec rake db:create
bundle exec rails s
```

You will now have the development server running.


http://localhost:3000 on your local machine should show you the site.

A screenshot has been included ```Screen Shot.png``` showing the final result.

## Project Structure
This is a basic Rails 4 Ruby 2 app.

A small library ```lib/github/client.rb``` encapsulates the Github interrraction and the associated spec is ```spec/lib/github/client_spec.rb```

A single controller ```app/controllers/static_pages_controller.rb``` supports the home page.

A single controller ```app/controllers/api/github_users_controller.rb``` supports the api call to process the githib request.  This has an associated trivial spec ```spec/controllers/api/github_users_controller_spec.rb```

A small CoffeeScript file ```app/assets/javascripts/main.coffee``` deals with validating the username form field and submitting the ajax request.


All templates are in HAML.
