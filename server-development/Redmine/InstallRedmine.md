# Redmine 3.2.0 µÄ°²×°

## Step 1. Create an empty database and accompanying user

Redmine database user will be named redmine hereafter but it can be changed to anything else.

    CREATE DATABASE redmine CHARACTER SET utf8;
	CREATE USER 'redmine'@'localhost' IDENTIFIED BY 'my_password';
	GRANT ALL PRIVILEGES ON redmine.* TO 'redmine'@'localhost';

For versions of MySQL prior to 5.0.2 - skip the 'create user' step and instead:

    GRANT ALL PRIVILEGES ON redmine.* TO 'redmine'@'localhost' IDENTIFIED BY 'my_password';

## Step 2.  Database connection configuration

Copy config/database.yml.example to config/database.yml and edit this file in order to configure your database settings for "production" environment.

Example for a MySQL database using ruby 1.8 or jruby:

    production:
	  adapter: mysql
	  database: redmine
	  host: localhost
	  username: redmine
	  password: my_password

Example for a MySQL database using ruby 1.9 (adapter must be set to mysql2):

    production:
	  adapter: mysql2
	  database: redmine
	  host: localhost
	  username: redmine
	  password: my_password

If your server is not running on the standard port (3306), use this configuration instead:

    production:
	  adapter: mysql
	  database: redmine
	  host: localhost
	  port: 3307
	  username: redmine
	  password: my_password

## Step 3. Dependencies installation

Redmine uses Bundler to manage gems dependencies.

You need to install Bundler first:

    gem install bundler

Then you can install all the gems required by Redmine using the following command:

    bundle install --without development test

### Optional dependencies

**RMagick (allows the use of ImageMagick to manipulate images for PDF and PNG export)**

If ImageMagick is not installed on your system, you should skip the installation of the rmagick gem using:

    bundle install --without development test rmagick

## Step 4. Session store secret generation

This step generates a random key used by Rails to encode cookies storing session data thus preventing their tampering.

Generating a new secret token invalidates all existing sessions after restart.

  * with Redmine 1.4.x:

        bundle exec rake generate_session_store

  * with Redmine 2.x:

        bundle exec rake generate_secret_token

## Step 5. Database schema objects creation

Create the database structure, by running the following command under the application root directory:

    RAILS_ENV=production bundle exec rake db:migrate

Redmine will prompt you for the data set language that should be loaded;
you can also define the REDMINE_LANG environment variable before running the command to a value which will be automatically and silently picked up by the task.

## Step 6. Test the installation

Test the installation by running WEBrick web server:

  1. with Redmine 1.4.x:

        bundle exec ruby script/server webrick -e production

  2. with Redmine 2.x:

        bundle exec ruby script/rails server webrick -e production

  3. with Redmine 3.x:

        bundle exec rails server webrick -e production

## Backups

Redmine backups should include:

  1. data (stored in your redmine database)

  2. attachments (stored in the files directory of your Redmine install)

Here is a simple shell script that can be used for daily backups (assuming you're using a mysql database):

    # Database
	/usr/bin/mysqldump -u <username> -p<password> <redmine_database> | gzip > /path/to/backup/db/redmine_`date +%y_%m_%d`.gz

	# Attachments
	rsync -a /path/to/redmine/files /path/to/backup/files
