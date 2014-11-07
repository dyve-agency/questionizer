# Rails blank app
An already working application with the latest libraries, and our own conventions, that we love already in place

## List of awesome things this App does:

* i18n and locale detection already in place
* javascript, css and assets in general are never managed by gems, they are instead stored in the `/vendor` folder
* it has `Bootstrap 3.2`
* it has `Backbone 1.1.2` with `hamlcoffe` as a templating solution
* it uses our own `Backbone way`
* it has support for `js i18n`
* it uses `font-awesome` and it is already properly configured to work in production
* it uses our own layout structure
* it already has our `bootstrapData` solution in place
* it has our `developer toolbar` that smoothes development :)
* it uses `rspec` for unit and controller testing
* it uses `cucumber` for integration and behaviour testing with support for poltergeist
* it has an error messages helper
* IE9 conditional stylesheet + css splitter to avoid the > 4096 selectors issue for that browser
* seo_vars, look how they are used in `DevController`
* return_here_url helper
* basic cancacan config
* rescue CanCan::AccessDenied
* follow_return_to_or helper
* authenticate_user_and_return_to helper
* render_404 y ActiveRecord::RecordNotFound helper
* helper to display an object errors `errors_list`
* helper for flash messages

## TODO
* document the application
* list the libraries supported
* open new branch for `devise`
* add I18n support
* finish the TODO
* explain database, secrets examples
* document the application the awesome things this App does
* list the libraries supported
* document how to install poltergeist
* explain database, secrets examples
* bin/tests

# Devise
Add a proper mail sender to devise.rb, Ex:

    config.mailer_sender = "MyApp <noreply@myapp.com>"


## SETING UP THE APP
What you need to know about how to install and get this app running.

### EMAILS
We're using MailCatcher [http://mailcatcher.me/]

1. Install it: `gem install mailcatcher`
2. Launch it: `mailcatcher`
  1. Alternatively if you are in *vagrant* `mailcatcher --http-ip=0.0.0.0`
  2. Remember that you need the `1080` port opened in your *vagrant*
3. Browse it: `http://localhost:1080/`
4. Configure it:
```
config.action_mailer.delivery_method = :smtp
config.action_mailer.smtp_settings = { :address => "localhost", :port => 1025 }
```

_Remember that you need the `1080` port opened in your vagrant_

We are not adding this file to the Gemfile as it not recommended by the MailCatcher mantainer
"Please don't put mailcatcher into your Gemfile. It will conflict with your applications gems at some point."
