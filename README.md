# Questionizer

* Sending emails to clients? But not receiving all answers?
* Tired of emails where people add points in line?

hi Questionizer.

## SETING UP THE APP

* Clone it
* `bundle install`

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
