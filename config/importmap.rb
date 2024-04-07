# Pin npm packages by running ./bin/importmap

pin "application", preload: true
pin "bootstrap", to: "bootstrap.min.js", preload: true
pin "popper", to: "popper.js", preload: true

module Importmap
  def self.assets
    {
      "application" => {
        "application" => "app/assets/stylesheets/application.css",
        "application_js" => "app/assets/javascripts/application.js"
      }
    }
  end
end