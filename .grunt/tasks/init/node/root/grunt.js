module.exports = function(grunt) {

  // Project configuration.
  grunt.initConfig({
    pkg: '<json:package.json>',

    watch: {
      coffee: {
        files: '<config:coffee.all.src>',
        tasks: 'coffee'
      }
    },

    coffee: {
      all: {
        src: ['lib/**/*.coffee', 'test/**/*.coffee'],
        dest: '<%= grunt.task.current.target %>'
      }
    },

    exec: {
      buster: {
        command: 'node_modules/buster/bin/buster-test --node',
        stdout: true
      }
    }
  });

  // External tasks
  grunt.loadNpmTasks('grunt-exec');
  grunt.loadNpmTasks('grunt-coffee');

  // Tasks
  grunt.registerTask('test', 'exec:buster');
};