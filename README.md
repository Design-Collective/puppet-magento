Getting started
---------------

    vagrant up
    vagrant reload

if you have networking problems:

    vagrant ssh
    sudo /etc/init.d/networking restart

Using your magento project
--------------------------

git-clone your magento to `data/magento`, import your mysql database run the query:

    update magento.core_config_data
    set value = 'http://vagrant-magento:8080/'
    where path in ('web/unsecure/base_url', 'web/secure/base_url')

and clear the magento cache (`var/cache/`)
