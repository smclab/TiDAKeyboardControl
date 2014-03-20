# TiDAKeyboardControl Module

## Description

Do you want to create a perfect clone of the iMessage compose interface? ***Fear no more!*** You can now respond to keyboard events (show, hide and interactive changes) and customize how much space will be used as an offset during interactive panning.

Titanium SDK wrapper for the awesome [DAKeyboardControl][dakc] from [@danielamitay][da]! (iOS only)

## Accessing the TiDAKeyboardControl Module

What you have to do is just install the module, anything else!

Thanks to the native implementation using Objective-C categories to extend classes, TiDAKeyboardControl Module does not need the **require( )** method to access the module from JavaScript.


## Usage

###Properties
- ``keyboardTriggerOffset``: *number*, 
How much space must be took on top of the keyboard.

- ``keyboardPanning``: *number*, This activates the panning feature.
- ``lockedViews``: *[Object,...]*, Automatically add the specified Object as a locked view.


An extensive example can be found in `example/app.js`, the following one just acts as an overview.
To clear up every doubts please read [this](../example/README.md).


```js

var textarea = Ti.UI.createTextArea({
	right: 0,
	bottom: 0,
	left: 0,
	scrollable: false,
	suppressReturn: false,
	height: Ti.UI.SIZE,
});

var window = Ti.UI.createWindow({
	keyboardTriggerOffset: 0,
	keyboardPanning: true,
	lockedViews: [ textarea ]
});

window.addEventListener('close', function (event) {
	// Very important! Releases what needs to be released
	event.source.keyboardPanning = false;
});

window.add(textarea);

// The window is now the host for keyboard events
window.addEventListener('keyboardchange', function (event) {
	Ti.API.error("Notification of keyboard change: y=" + event.y + " height="+event.height);
});

// Multiline text-area
textarea.addEventListener('postlayout', function (event) {
	window.keyboardTriggerOffset = event.source.rect.height;
});

window.open();
```


## Author

Kudos to @danielamitay for the development of DAKeyboardControl.

Humbly made by the spry ladies and gents at SMC.


[dakc]: https://github.com/danielamitay/DAKeyboardControl
[da]: http://danielamitay.com


## License

This library, *TiDAKeyboardControl*, is free software ("Licensed Software"); you can
redistribute it and/or modify it under the terms of the [GNU Lesser General
Public License](http://www.gnu.org/licenses/lgpl-2.1.html) as published by the
Free Software Foundation; either version 2.1 of the License, or (at your
option) any later version.

This library is distributed in the hope that it will be useful, but WITHOUT ANY
WARRANTY; including but not limited to, the implied warranty of MERCHANTABILITY,
NONINFRINGEMENT, or FITNESS FOR A PARTICULAR PURPOSE. See the GNU Lesser General
Public License for more details.

You should have received a copy of the [GNU Lesser General Public
License](http://www.gnu.org/licenses/lgpl-2.1.html) along with this library; if
not, write to the Free Software Foundation, Inc., 51 Franklin Street, Fifth
Floor, Boston, MA 02110-1301 USA


