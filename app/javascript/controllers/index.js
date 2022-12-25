// Import and register all your controllers from the importmap under controllers/*

import { application } from "controllers/application"

// Eager load all controllers defined in the import map under controllers/**/*_controller
import { eagerLoadControllersFrom } from "@hotwired/stimulus-loading"
eagerLoadControllersFrom("controllers", application)

// Lazy load controllers as they appear in the DOM (remember not to preload controllers in import map!)
// import { lazyLoadControllersFrom } from "@hotwired/stimulus-loading"
// lazyLoadControllersFrom("controllers", application)


// precompile the problem is solved by deleting all tmp folder, clearing public/assets and restarting text editor
$('document').ready(function(){
    var timer = setTimeout(showNotifications, 7000)
    function showNotifications(){
        $('.notice').hide();
        $('.alert').hide();
    };
});

// starts working with unreloaded page (buttons click events) agter adding in gemfile and application.js jquery-turbolinks, turbolinks
$(document).ready(function(){
    $('.repost_button').on('click', function(){
        var post_index = ($(this).attr('id').split('_').at(-1))
        //alert(post_index)
        $.ajax({
            url: '/reposts/create',
            type: "POST",
            dataType: "json",
            data: {
                 post_index: post_index,
            },
            complete: function(){
                 console.log('Congrats');
            }
          
          });
    });
});

$('#clear_file_button').on("click", function(){
    let postFileInput = document.querySelector("#posts_file_input")
    postFileInput.value = '';
    let newPostFileInput = postFileInput.cloneNode( true )
    postFileInput.replaceWith( newPostFileInput );
    postFileInput = newPostFileInput;
});