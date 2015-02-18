#!/bin/bash

cat << "EOF"

       /$$$$$$$                                          /$$
      | $$__  $$                                        | $$
      | $$  \ $$  /$$$$$$  /$$   /$$  /$$$$$$   /$$$$$$ | $$
      | $$  | $$ /$$__  $$| $$  | $$ /$$__  $$ |____  $$| $$
      | $$  | $$| $$  \__/| $$  | $$| $$  \ $$  /$$$$$$$| $$
      | $$  | $$| $$      | $$  | $$| $$  | $$ /$$__  $$| $$
      | $$$$$$$/| $$      |  $$$$$$/| $$$$$$$/|  $$$$$$$| $$
      |_______/ |__/       \______/ | $$____/  \_______/|__/
                                    | $$
                                    | $$
                                    |__/
 /$$$$$$  /$$$$$$  /$$   /$$ /$$$$$$ /$$$$$$$$ /$$$$$$  /$$$$$$$
|_  $$_/ /$$__  $$| $$$ | $$|_  $$_/|__  $$__//$$__  $$| $$__  $$
  | $$  | $$  \__/| $$$$| $$  | $$     | $$  | $$  \ $$| $$  \ $$
  | $$  | $$ /$$$$| $$ $$ $$  | $$     | $$  | $$  | $$| $$$$$$$/
  | $$  | $$|_  $$| $$  $$$$  | $$     | $$  | $$  | $$| $$__  $$
  | $$  | $$  \ $$| $$\  $$$  | $$     | $$  | $$  | $$| $$  \ $$
 /$$$$$$|  $$$$$$/| $$ \  $$ /$$$$$$   | $$  |  $$$$$$/| $$  | $$
|______/ \______/ |__/  \__/|______/   |__/   \______/ |__/  |__/


EOF

read -r -p "
Welcome to Drupal Ignitor.

You should run this script from the parent directory of where you want to install Drupal.

For example, if you want to install Drupal at:
'/var/www/vhosts/sitename/public_html/',

...you should run this script from:
'/var/www/vhosts/sitename/'.

Your current working directory is:
${PWD}

Is this correct? [Y/n]" response

case $response in
    [yY][eE][sS]|[yY])
        echo "continuing
        "
        ;;
    *)
        echo "Aborting"
        exit 1
        ;;
esac

echo -n "Enter the name of the directory in which Drupal should be installed. (WARNING: if the directory already exists, all contents will be overwritten.): "
read -e DIRECTORY

echo -n "Enter the database name: "
read -e DB_NAME

echo -n "Enter the database user name: "
read -e DB_UN

echo -n "Enter the database password: "
read -e DB_PASS

echo "
You entered the following:
"

echo Directory name: $DIRECTORY
echo Database name: $DB_NAME
echo Database user: $DB_UN
echo Database password: $DB_PASS

read -r -p "

Is this correct? [Y/n]" response

case $response in
    [yY][eE][sS]|[yY])
        echo "continuing
        "
        ;;
    *)
        echo "Aborting"
        exit 1
        ;;
esac

drush dl --drupal-project-rename=$DIRECTORY --yes

cp $DIRECTORY/sites/default/default.settings.php $DIRECTORY/sites/default/settings.php

cd $DIRECTORY

drush site-install minimal --db-url=mysql://$DB_UN:$DB_PASS@localhost/$DB_NAME --account-name=admin --account-pass=changeme --yes

printf "\n##\n# Do not inturrupt this process. Configuration usually takes about five minutes.\n##\n"

# Organize our module directory
mkdir sites/all/modules/contrib
mkdir sites/all/modules/custom
mkdir sites/all/modules/patched
mkdir sites/all/modules/features

printf "\n##\n# Step 1 of 13 (Organize module directory) Complete\n##\n"

# Download contrib modules
drush dl bean
drush dl devel
drush dl block_class
drush dl entity
drush dl entityreference
drush dl features
drush dl field_group
drush dl icon
drush dl jquery_update
drush dl link
drush dl markdown
drush dl publication_date
drush dl strongarm
drush dl token
drush dl pathauto
drush dl webform
drush dl ctools
drush dl views
drush dl insert

printf "\n##\n# Step 2 of 13 (Download contrib modules) Complete\n##\n"

# Download custom modules and delete their git directories
git clone https://github.com/balsama/beannorev.git sites/all/modules/custom/beannorev
git clone https://github.com/balsama/beannotitle.git sites/all/modules/custom/beannotitle
git clone https://github.com/balsama/image_styles.git sites/all/modules/features/image_styles
git clone https://github.com/balsama/markdown_text_format.git sites/all/modules/features/markdown_text_format
rm -rf sites/all/modules/custom/beannorev/.git
rm -rf sites/all/modules/custom/beannotitle/.git
rm -rf sites/all/modules/features/image_styles/.git
rm -rf sites/all/modules/features/markdown_text_format/.git

# Download contrib themes
drush dl bootstrap

printf "\n##\n# Step 3 of 13 (Cownload contrib themes) Complete\n##\n"

# Download custom themes and remove their git directories
git clone https://github.com/balsama/bootstrap_starter.git sites/all/themes/bootstrap_starter
git clone https://github.com/balsama/bootstrap_ignitor.git sites/all/themes/bootstrap_ignitor
rm -rf sites/all/themes/bootstrap_starter/.git
rm -rf sites/all/themes/bootstrap_ignitor/.git

printf "\n##\n# Step 4 of 13 (Download custom themes) Complete\n##\n"

# Enable the bootstrap themes
drush pm-enable bootstrap -y
drush pm-enable bootstrap_ignitor -y
drush pm-enable bootstrap_starter -y
drush pm-disable barktik -y

printf "\n##\n# Step 5 of 13 (Enable themes) Complete\n##\n"

# Set bootstrap_starter to default theme
drush vset theme_default bootstrap_starter

printf "\n##\n# Step 6 of 13 (Set default theme) Complete\n##\n"

# Use the admin theme when editing content and set it Seven
drush vset node_admin_theme 1
drush vset admin_theme seven

printf "\n##\n# Step 7 of 13 (Use admin theme to edit content) Complete\n##\n"

# Set the user cancel method to "Delete the account and make its content belong to the Anonymous user"
drush vset user_cancel_method user_cancel_reassign

printf "\n##\n# Step 8 of 13 (Set user cancel method) Complete\n##\n"

# Only allow administrators to create accounts
drush vset user_register 0

printf "\n##\n# Step 9 of 13 (Disallow non-admin account creation) Complete\n##\n"

# Enable core modules
drush en contextual -y
drush en field_ui -y
drush en file -y
drush en image -y
drush en list -y
drush en number -y
drush en options -y
drush en path -y
drush en shortcut -y
drush en taxonomy -y
drush en toolbar -y

printf "\n##\n# Step 10 of 13 (Enable core modules) Complete\n##\n"

# Enable contrib modules
drush en ctools -y
drush en bean, bean_admin_ui -y
drush en devel -y
drush en block_class -y
drush en entity -y
drush en entityreference -y
drush en features -y
drush en field_group -y
drush en icon, icon_field, icon_menu -y
drush en insert -y
drush en jquery_update -y
drush en link -y
drush en markdown -y
drush en publication_date -y
drush en strongarm -y
drush en token -y
drush en pathauto -y
drush en webform -y
drush en views, views_ui -y

printf "\n##\n# Step 11 of 13 (Enable contrib modules) Complete\n##\n"

# Enable custom modules
drush en beannorev -y
drush en beannotitle -y
drush en image_styles -y
drush en markdown_text_format -y

printf "\n##\n# Step 12 of 13 (Enable custom modules) Complete\n##\n"

# Update the image style and text format features
drush fua -y

printf "\n##\n# Step 13 of 13 (Update features) Complete\n##\n"

# Set the default pathauto pattern to something that's not stupid
drush vset pathauto_node_pattern [node:title]

printf "\n##\n# Finishing up\n##\n"

# Clear the cache for good measure
drush cc all

printf "\n##\n# Configuration complete!\n##\n"

printf "\n##\n# You can login to your new Drupal site with the username: 'admin' and the password: 'changeme'.\n##\n"

