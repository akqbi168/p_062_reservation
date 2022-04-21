// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

import Rails from "@rails/ujs"
import Turbolinks from "turbolinks"
import * as ActiveStorage from "@rails/activestorage"
import "channels"

Rails.start()
require("jquery")
Turbolinks.start()
ActiveStorage.start()
require("@nathanvda/cocoon")

import '@fortawesome/fontawesome-free/js/all';


// 画像のプレビュー表示
$(function() {
  function readURL(input) {
    if (input.files && input.files[0]) {
    var reader = new FileReader();
    reader.onload = function (e) {
  $('#img_prev').attr('src', e.target.result);
    }
    reader.readAsDataURL(input.files[0]);
    }
  }
  $("#prop_img").change(function(){
    readURL(this);
  });
});
