Audissey.fm
================

This is the code that powers the audissey.fm website. The place where artists and promoters can find each other and create amazing events. Feel free to add any features you want via a pull request. If you notice something stupid, well, feel free to fix it!

Ruby on Rails
-------------

This application requires:

- Ruby 2.3.0
- Rails 4.2.5

Learn more about [Installing Rails](http://railsapps.github.io/installing-rails.html).

Getting Started
---------------

Follow these steps to install and run the website locally:

1. Install Ruby
2. Install bundler: `gem install bundler`
3. Clone this repository
4. Run `bundle install` inside the repository directory
5. Configure the file `config/local_env.yml` to match your environment
6. Initialize the Database: `rake db:migrate`
7. Run the application: `rails s`
8. Go to `localhost:3000` in your browser
9. Have fun.

Required / Supported Environment Variables: `SECRET_KEY_BASE`, `SENDGRID_USERNAME`, `SENDGRID_PASSWORD`, `FACEBOOK_APP_ID`, `FACEBOOK_APP_SECRET`, `WEBPAY_PUBLIC_KEY`, `WEBPAY_SECRET_KEY`, `STRIPE_PUBLIC_KEY`, `STRIPE_SECRET_KEY`, `AWS_ACCESS_KEY`, `AWS_SECRET_KEY`, `DRAGONFLY_SECRET`, `DOMAIN_NAME`


Issues
-------------

If you've got issues, use the issue tracker.

Contributing
------------

We don't impose any strict rules on how to structure and open pull requests. For localization contributions, check out our localeapp project: https://www.localeapp.com/projects/9031

Roadmap
-------

Very rough:

* Alpha: Artists, Venues & Organizer Booking Service
* Beta: Event publication, Schedule Management
* 1.0: Tour planning, Automated payouts
* 2.0: Ticket sales & Music Downloads

More detailed roadmap to be available soon.

License
-------

    DO WHAT THE FUCK YOU WANT TO UNIVERSAL LICENSE

    Copyright (C) 2016 Stefan Buhrmester <buhrmi@gmail.com>

    Everyone is permitted to copy and distribute verbatim or modified
    copies of the code accompanying this license document, and changing
    it is allowed in any way that pleases you.

    DO WHAT THE FUCK YOU WANT TO UNIVERSAL LICENSE
    TERMS AND CONDITIONS FOR COPYING, DISTRIBUTION AND MODIFICATION

     1. You just DO WHAT THE FUCK YOU WANT TO.
