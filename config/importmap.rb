# Pin npm packages by running ./bin/importmap

pin "application", preload: true
pin "@hotwired/turbo-rails", to: "turbo.min.js", preload: true
pin "@hotwired/stimulus", to: "stimulus.min.js", preload: true
pin "@hotwired/stimulus-loading", to: "stimulus-loading.js", preload: true
pin_all_from "app/javascript/controllers", under: "controllers"
pin "bootstrap", to: "bootstrap.min.js", preload: true
pin "@popperjs/core", to: "popper.js", preload: true
pin "twilio-video", to: "https://ga.jspm.io/npm:twilio-video@2.27.0/es5/index.js"
pin "events", to: "https://ga.jspm.io/npm:events@3.3.0/events.js"
pin "ws", to: "https://ga.jspm.io/npm:ws@7.5.9/browser.js"
