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

    watch: {
      css: {
        files: ["sass/**/*.scss"],
        tasks: ["sass"]
      }
    }
  });




  grunt.loadNpmTasks('grunt-contrib-watch');
  grunt.loadNpmTasks('grunt-contrib-sass');

  grunt.registerTask('default', ['watch']);

};
