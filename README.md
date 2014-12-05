# Drupal Bash Ignitor

Bash script to ignite your drupal project.

## Overview
This script will enable several core modules, download and enable several
contrib modules, and clone and enable several custom modules, features and
themes. Basically, it automates the first four hours of work on 90% of the
Drupal sites I build.

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

* [Bean, Bean Admin UI](https://www.drupal.org/project/bean)
* [Block Class](https://www.drupal.org/project/block_class)
* [Chaos Tools](https://www.drupal.org/project/ctools)
* [Devel](https://www.drupal.org/project/devel)
* [Entity API](https://www.drupal.org/project/entity)
* [Entity Reference](https://www.drupal.org/project/entityreference)
* [Features](https://www.drupal.org/project/features)
* [Field Group](https://www.drupal.org/project/field_group)
* [Icon, Icon Field, Icon Menu](https://www.drupal.org/project/icon)
* [Insert](https://www.drupal.org/project/insert)
* [jQuery Update](https://www.drupal.org/project/jquery_update)
* [Markdown](https://www.drupal.org/project/markdown)
* [Publication Date](https://www.drupal.org/project/publication_date)
* [Strongarm](https://www.drupal.org/project/strongarm)
* [Token](https://www.drupal.org/project/token)
* [Path Auto](https://www.drupal.org/project/pathauto)
* [Webform](https://www.drupal.org/project/webform)
* [Views, Views UI](https://www.drupal.org/project/views)

### Custom modules downloaded and enabled:

* [Bean - No Rev](https://github.com/balsama/beannorev)
* [Bean - No Title](https://github.com/balsama/beannotitle)

### Custom features downloaded and enabled:

* [Image Styles](https://github.com/balsama/image_styles) (Provides default image styles for inline images used with the
  Insert module)
* [Markdown Text Format](https://github.com/balsama/markdown_text_format) (Provides a Text Format/Input Filter that parses the
  input through Markdown)

### Themes:
* [Bootstrap (contrib)](https://www.drupal.org/project/bootstrap)
* [Bootstrap Ignitor](https://github.com/balsama/bootstrap_ignitor) (custom)
* [Bootstrap Starter](https://github.com/balsama/bootstrap_starter) (custom)

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

### Install

1. Install Drupal as you normally would except choose the "Minimal"
   installation profile (if you normally don't).
2. After Drupal is installed and you see the "Proceed to your new site" link,
   place the `dbi.sh` file (contained in this repository) in docroot of your
   Drupal installation. The `dbi.sh` file should be siblings with Drupal's
   `index.php` file. Or run the following command from Drupal's docroot:

        wget https://raw.githubusercontent.com/balsama/drupal-bash-ignitor/master/dbi.sh
3. From Drupal's docroot, run the following command:

        bash dbi.sh
4. Enjoy! The script takes about five minutes to run, but will vary based on
   machine and your internet connection speed.

### Caveats

As I mentioned, this script is useful for 90% of **my** Drupal projects. Things
to note:

* Drush must be installed on your system.
* This will not work for multisite installs, or will only affect the "Default"
  site.
