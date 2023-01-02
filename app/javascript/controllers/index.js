// Import and register all your controllers from the importmap under controllers/*

import { application } from "controllers/application"

// Eager load all controllers defined in the import map under controllers/**/*_controller
import { eagerLoadControllersFrom } from "@hotwired/stimulus-loading"
eagerLoadControllersFrom("controllers", application)

// Lazy load controllers as they appear in the DOM (remember not to preload controllers in import map!)
// import { lazyLoadControllersFrom } from "@hotwired/stimulus-loading"
// lazyLoadControllersFrom("controllers", application)


// precompile the problem is solved by deleting all tmp folder, clearing public/assets and restarting text editor
// $('document').ready(function(){
//     var timer = setTimeout(showNotifications, 7000)
//     function showNotifications(){
//         $('.notice').hide();
//         $('.alert').hide();
//     };
// });

// starts working with unreloaded page (buttons click events) agter adding in gemfile and application.js jquery-turbolinks, turbolinks
// $(document).ready(function(){
//     $('.repost_button').on('click', function(){
//         var post_index = ($(this).attr('id').split('_').at(-1))
//         $.ajax({
//             url: '/reposts/create',
//             type: "POST",
//             dataType: "json",
//             data: {
//                  post_index: post_index,
//             },
//             complete: function(){
//                  console.log('Congrats');
//             }
          
//           });
//     });
// });


function clearInputOnButtonClick(css_selector){
    let postFileInput = document.querySelector(css_selector)
    postFileInput.value = '';
    let newPostFileInput = postFileInput.cloneNode( true )
    postFileInput.replaceWith( newPostFileInput );
    postFileInput = newPostFileInput;
}

$('#clear_file_button').on("click", function(){
    clearInputOnButtonClick("#posts_file_input")
});

$('#clear_file_profile_button').on("click", function(){
    clearInputOnButtonClick("#profile_file_input")
});

function holdScrollBarInTheBottom(){
    var scroll_bar_container = document.getElementById("messages");
    scroll_bar_container.scrollTop = scroll_bar_container.scrollHeight;
}

// for messenger part

$(document).ready(function(){
    $('#send_message_button').on("click", function(){
        setTimeout(function(){
            clearInputOnButtonClick("#chat_text")
        }, 700)
    });
})

$(document).ready(holdScrollBarInTheBottom());

$(document).ready(function(){
    $('#send_message_button').on("click", function(){
        setTimeout(function(){
            holdScrollBarInTheBottom()
        }, 700)
    });
})
// function waitForElm(selector) {
//     return new Promise(resolve => {
//         if (document.querySelector(selector)) {
//             return resolve(document.querySelector(selector));
//         }

//         const observer = new MutationObserver(mutations => {
//             if (document.querySelector(selector)) {
//                 resolve(document.querySelector(selector));
//                 observer.disconnect();
//             }
//         });

//         observer.observe(document.body, {
//             childList: true,
//             subtree: true
//         });
//     });
// }

// waitForElm('.some-class').then((elm) => {
//     console.log('Element is ready');
//     console.log(elm.textContent);
// });

// let observer = new MutationObserver((mutations) => {
//     mutations.forEach((mutation) => {
//       if (!mutation.addedNodes) return
  
//       for (let i = 0; i < mutation.addedNodes.length; i++) {
//         // do things to your newly added nodes here
//         $('#send_message_button').on("click", function(){
//             holdScrollBarInTheBottom()
//         });
//         let node = mutation.addedNodes[i]
//       }
//     })
//   })
  
//   observer.observe(document.body, {
//       childList: true
//     , subtree: true
//     , attributes: false
//     , characterData: false
//   })
  
//   // stop watching using:
//   observer.disconnect()