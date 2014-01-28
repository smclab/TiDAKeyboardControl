TiDAKeyboardControl
==========

Do you want to create a perfect clone of the iMessage compose interface? ***Fear no more!*** You can now respond to keyboard events (show, hide and interactive changes) and customize how much space will be used as an offset during interactive panning.

Titanium SDK wrapper for the awesome [DAKeyboardControl][dakc] from [@danielamitay][da]! (iOS only)


Example
-------

An extensive example can be found in `example/app.js`, the following one just acts as an overview.


```js
var window = Ti.UI.createWindow({
	// How much space must be took on top of the keyboard
	keyboardTriggerOffset: 0,
	// This activates the panning feature
	keyboardPanning: true
});

window.addEventListener('close', function (event) {
	// Very important! Releases what needs to be released
	event.source.keyboardPanning = false;
});

var textarea = Ti.UI.createTextArea({
	right: 0,
	bottom: 0,
	left: 0,
	scrollable: false,
	suppressReturn: false,
	height: Ti.UI.SIZE,
});

window.add(textarea);

// The window is now the host for keyboard events
window.addEventListener('keyboardchange', function (event) {
	textarea.bottom = event.height ? (window.rect.height - event.y) : 0;
});

// Multiline text-area
textarea.addEventListener('postlayout', function (event) {
	window.keyboardTriggerOffset = event.source.rect.height;
});

window.open();
```


Credits
-------

Kudos to @danielamitay for the development of DAKeyboardControl.

Humbly made by the spry ladies and gents at SMC.


[dakc]: https://github.com/danielamitay/DAKeyboardControl
[da]: http://danielamitay.com


License
-------

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
