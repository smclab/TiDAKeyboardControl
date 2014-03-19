module.exports = function () {

var window = Ti.UI.createWindow({
	orientationModes: [
		Ti.UI.PORTRAIT,
		Ti.UI.LANDSCAPE_LEFT,
		Ti.UI.LANDSCAPE_RIGHT
	],
	backgroundColor: '#fff',

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
	top: 5,
	right: 80,
	bottom: 5,
	left: 5,
	scrollable: false,
	suppressReturn: false,
	height: Ti.UI.SIZE,
	backgroundColor: '#fff',
	borderRadius: 3,
	borderWidth: '1px',
	borderColor: '#BBB'
});

var submit = Ti.UI.createButton({
	title: 'Send',
	width: 70,
	right: 5
});

var textareaview = Ti.UI.createView({
	height: Ti.UI.SIZE,
	right: 0,
	bottom: 0, // This value will not be updated!
	left: 0,
	backgroundColor: '#eee'
});

textareaview.add(textarea);
textareaview.add(submit);

window.add(textareaview);

// Automatically add the textarea as a locked view
window.lockedViews = [ textareaview ];

// The textarea will change in size, because it’s multi-line.
// I need to update the correct offset for the panning.
textareaview.addEventListener('postlayout', function (event) {
	window.keyboardTriggerOffset = event.source.rect.height;
});

// Just an example programmatic dismissal.
submit.addEventListener('click', function () {
	textarea.value = '';
	textarea.blur();

	setTimeout(function () {
		window.close();
	}, 4000);
});

window.open();
};