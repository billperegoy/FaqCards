module.exports = function(grunt) {

  grunt.initConfig({
    pkg: grunt.file.readJSON('package.json'),

    sass: {
      css: {
        files: {
          'css/styles.css' : 'sass/styles.scss'
        }
      }
    },


    elm: {
      compile: {
        files: {
          "frontend/elm.js": ["frontend/*.elm"]
        }
      }
    },

    watch: {
      css: {
        files: ["sass/**/*.scss"],
        tasks: ["sass"]
      },

      elm: {
        files: ["frontend/*.elm"],
        tasks: ["elm"]
      }
    }
  });




  grunt.loadNpmTasks('grunt-contrib-watch');
  grunt.loadNpmTasks('grunt-contrib-sass');
  grunt.loadNpmTasks('grunt-contrib-clean');
  grunt.loadNpmTasks('grunt-elm');

  grunt.registerTask('default', ['watch', 'elm']);

};
