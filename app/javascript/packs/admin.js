// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

require("@rails/ujs").start()
// require("turbolinks").start()
require("@rails/activestorage").start()
require("channels")

require("trix")
require("@rails/actiontext")

// Vendor begin
import "KeenTheme/vendors/global";
import "KeenTheme/styles";
import "KeenTheme/scripts";

// Devise pages begin
import "KeenTheme/assets/sass/pages/login/login-v2";
import "KeenTheme/assets/js/pages/custom/user/login";
// Devise pages end
// Vendor end

// Require images begin
require.context('../images/admin', true);
require.context('../images/admin/flags', true);
// Require images end

// Stimulus controllers begin
import "controllers/admin"
// Stimulus controllers end

// Admin libraries begin
import Cookies from 'js-cookie'
// Admin libraries end

import "../stylesheets/admin";
