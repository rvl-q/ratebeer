import { Application } from "@hotwired/stimulus"

const application = Application.start()

// Configure Stimulus development experience
application.debug = false
window.Stimulus   = application

export { application }

import { beers } from "custom/utils";

beers();

import { breweries } from "custom/utils";

breweries();