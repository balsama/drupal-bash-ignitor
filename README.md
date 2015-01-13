# Drupal Bash Ignitor

<p class="lead">Bash script to get ignite your Drupal project.</p>

## Overview
This script will install Drupal, enable several core modules, download and
enable several contrib modules, and clone and enable several custom modules,
features and themes. Basically, it automates the first four hours of work on
90% of the Drupal sites I build.

### What you'll need
* Drush
* An empty database or a database that you're OK with overwriting
* This script (`dbi.sh`), downloaded to the parent directory of where you
  ultimately want to install Drupal

### Core modules enabled:

* Contextual Links
* Field UI
* File
* Image
* List
* Number
* Options
* Path
* Shortcut
* Taxonomy
* Toolbar

### Contrib modules downloaded and enabled:

* Bean, Bean Admin UI
* Block Class
* Chaos Tools
* Devel
* Entity
* Entity Reference
* Features
* Field Group
* Icon, Icon Field, Icon Menu
* Insert
* jQuery Update
* Markdown
* Publication Date
* Strongarm
* Token
* Path Auto
* Webform
* Views, Views UI

### Custom modules downloaded and enabled:

* Bean - No Rev
* Bean - No Title

### Custom features downloaded and enabled:

* Image Styles (Provides default image styles for inline images used with the
  Insert module)
* Markdown Text Format (Provides a Text Format/Input Filter that parses the
  input through Markdown)

### Themes:
* Bootstrap (contrib)
* Bootstrap Ignitor (custom)
* Bootstrap Starter (custom)

### Variables set:
* Pathauto pattern for nodes = `[node:title]`
* Default theme = `bootstrap_starter`
* Admin theme: `seven`
* Use admin theme for editing content = `TRUE`
* User cancel method = Delete account and set content author to Anonymous
* Allow users to create accounts = FALSE

## What about Install Profiles or Distributions?

I decided not to go with creating a Distribution for several reasons. Most
notably:

* You need a full project on DO
* You aren't allowed to include modules or themes that aren't full projects

## Instructions

1. Install Drupal as you normally would except choose the "Minimal"
   installation profile (if you normally don't).
2. After Drupal is installed and you see the "Proceed to your new site" link,
   place the `dbi.sh` file (contained in this repository) in docroot of your
   Drupal installation. The `dbi.sh` file should be siblings with Drupal's
   `index.php` file. Or run the following command:
       //
3. From Drupal's docroot, run the following command:
       bash dbi.sh
4. Enjoy! The script takes about five minutes to run, but will vary based on
   machine and your internet connection speed.

