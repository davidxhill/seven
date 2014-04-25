#!/usr/bin/env bash

echo "------ Building Structure ------"

if [ ! -d "/vagrant/public" ]; then
    sudo mkdir /vagrant/public
fi

if [ ! -d "/vagrant/public/sass" ]; then
    sudo mkdir /vagrant/public/sass
fi

if [ ! -d "/vagrant/public/img" ]; then
    sudo mkdir /vagrant/public/img
fi

if [ ! -d "/vagrant/public/js" ]; then
    sudo mkdir /vagrant/public/js
fi

if [ ! -d "/vagrant/public/css" ]; then
    sudo mkdir /vagrant/public/css
    sudo touch /vagrant/public/css/global.css
fi

echo "------ Creating Package.json ------"

sudo cat > /vagrant/Package.json <<EOF
{
  "name": "SevenProject",
  "version": "0.1.0",
  "devDependencies": {
    "grunt": "~0.4.2",
    "grunt-contrib-concat": "~0.3.0",
    "grunt-contrib-uglify": "~0.2.7",
    "grunt-contrib-watch": "~0.5.3",
    "grunt-phpunit": "~0.3.2",
    "grunt-contrib-sass": "~0.6.0"
  }
}
EOF

echo "------ Installing NPM Packages ------"

cd /vagrant
npm install

echo "------ Creating Gruntfile.js ------"

sudo cat > /vagrant/Gruntfile.js <<EOF
module.exports = function(grunt) {

    // 1. All configuration goes here
    grunt.initConfig({
        pkg: grunt.file.readJSON('package.json'),

        concat: {
            dist: {
                src: [
                   'public/js/*.js',
                ],
                dest: 'public/js/build/main.js',
            },
        },

        uglify: {
            build: {
                src: 'public/js/build/main.js',
                dest: 'public/js/build/main.min.js'
            }
        },

        watch: {
            options: {
                livereload: true,
            },
            css: {
                files: ['public/css/*.scss'],
                tasks: ['sass'],
                options: {
                    spawn: false,
                }
            }
        },

        phpunit: {
            classes: {
                dir: 'app/tests/'
            },
            options: {
                bin: '/usr/local/bin/phpunit',
                colors: true
            }
        },

        sass: {
            dist: {
                options:{
                    style: 'compressed'
                },
                files: {
                    'public/css/global.css' : 'public/sass/*.scss'
                }
            }
        },

    });

    // 3. Where we tell Grunt we plan to use this plug-in.
    grunt.loadNpmTasks('grunt-contrib-sass');
    grunt.loadNpmTasks('grunt-contrib-concat');
    grunt.loadNpmTasks('grunt-contrib-uglify');
    grunt.loadNpmTasks('grunt-contrib-watch');
    grunt.loadNpmTasks('grunt-phpunit');

    // 4. Where we tell Grunt what to do when we type "grunt" into the terminal.
    grunt.registerTask('default', ['sass']);

};
EOF

