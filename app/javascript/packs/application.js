// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

import Rails from "@rails/ujs"
import Turbolinks from "turbolinks"
import * as ActiveStorage from "@rails/activestorage"
import "channels"
import '../stylesheets/application'
import '@fortawesome/fontawesome-free/js/all';
import 'tw-elements';
import "./other_image_preview";
import "./top_image_preview";
import "./header";
import "./shuffle";

Rails.start()
Turbolinks.start()
ActiveStorage.start()
