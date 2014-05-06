seven
=====

Seven is a vagrant bash provisioning scripts that allows you to configure and include only packages that you need. Still very early..command line tool and version select options coming soon.

###Installation

````bash
 curl -o Vagrantfile https://raw.githubusercontent.com/davidxhill/seven/master/Vagrantfile
````
Run command in project's root directory, config Vagrantfile and run vagrant up.


####Currently includes:
* LAMP Stack
  * PHP 5.5.11
  * Apache2 (more options to come)
  * MySql
* Composer
  * Set up Global installs (phpunit)
* Node
  * Set up Global installs (jamjs, testem, grunt-cli)
* RVM
  * Set up Global installs (sass)
* PhpMyAdmin
* Vim(spf13)

######Install directions to come.
######refactoring/improved docs to come...

####Features to come(plus lots more):
*laravel
 * env var
  *composer packages
    *clockwork
    *and other dev packages
*grunt config/templates
*Nginx
*More Databases options


###Thanks to:
[terion-name](https://github.com/terion-name) for the concept([Lagrant](https://github.com/terion-name/Lagrant)).

