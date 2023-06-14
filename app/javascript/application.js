// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "controllers"
import "@popperjs/core"
import "bootstrap"
import AutosubmitController from ".app/javascript/controllers/autosubmit_controller.js"
Stimulus.register("autosubmit", AutosubmitController)

