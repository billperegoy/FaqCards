module.exports = function(grunt) {

  grunt.initConfig({
    elm: {
      compile: {
        files: {
          "elm.js": ["frontend/*.elm"]
        }
      }
    },

    sass: {
      files: {
        'css/styles.css' : 'scss/styles.scss'
      }
    },

    watch: {
      elm: {
        files: ["frontend/*.elm"],
        tasks: ["elm"]
      }
    },
    clean: ["elm-stuff/build-artifacts"]
  });




  grunt.loadNpmTasks('grunt-contrib-watch');
  grunt.loadNpmTasks('grunt-contrib-clean');
  grunt.loadNpmTasks('grunt-elm');
  grunt.loadNpmTasks('grunt-contrib-sass');

  grunt.registerTask('default', ['elm']);

};
