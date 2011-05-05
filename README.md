Safely manage document.write() with events and functions

document.write() is still widely used in Javascript, especially by advertisers. This causes several problems:

* can only write where the script is loaded from
* can't edit text before writing
* can't cancel writing
* can't trigger events on writing
* calls after the ready event will reset the page

To work around these issues, the docwrite plugin:

* provides beforedocwrite and afterdocwrite events around document.write()
* allows document.write() to be edited, redirected and even cancelled altogether
* automatically redirects late document.write() calls to an invisible <div>
* provides $(element).docwrite() that redirects document.write()s in a specified function

You can use the event-based interface like this:

```js
$(document).bind('beforedocwrite', function(event, data) {
    // redirect the write:
    data.target = $('#my_element');
    // Edit what will be written:
    if ( /pattern/.test( data.html ) ) {
        data.html = "you can change the text <i>however you like</i>";
    };
    // Cancel writing:
    if ( !confirm("Should we write this:\n" + data.html) )
        event.preventDefault();
});
$(document).bind('afterdocwrite', function(event, data) {
    alert(data.html + " was written to " + data.target);
});
```

You can use the functional interface like this:

```js
$(element).docwrite( function(arg1, arg2) {
    document.write("my <b>html</b> will be appended to $(element)");
}, "passed to function as arg1",
   "passed to function as arg2"
);
$(element).docwrite(
    "<div>Appended to element</div>\n" +
    "<script type='text/javascript'>" +
        "document.write('nested document.write()s are handled correctly');" +
    "</script>"
);
```

The functional interface doesn't trigger docwrite events:

```js
$(document).bind('afterdocwrite',
    function(event, data) { alert('event triggered'); }
);
$(window).load(function() {
    document.write("will trigger an event (and be appended to a hidden <div>)");
});
$(element).docwrite( "will not trigger an event" );
```

Initial release from Slando (http://www.slando.com) Development team. (http://plugins.jquery.com/content/docwrite-100)