set :application, "set your application name here"
set :domain,      "#{application}.com"
set :deploy_to,   "/var/www/#{domain}"

set :repository,  "#{domain}:/var/repos/#{application}.git"
set :scm,         :git
# Or: `accurev`, `bzr`, `cvs`, `darcs`, `subversion`, `mercurial`, `perforce`, `subversion` or `none`

role :web, domain   # Your HTTP server, Apache/etc
role :app, domain   # This may be the same as your `Web` server or a separate administration server

set  :keep_releases,  3

set :app_symlinks, ["/media", "/var", "/sitemaps", "/staging"]
set :app_shared_dirs, ["/app/etc", "/sitemaps", "/media", "/var", "/staging"]
set :app_shared_files, ["/app/etc/local.xml"]