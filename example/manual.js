
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
	bottom: 0,
	left: 0,
	backgroundColor: '#eee'
});

textareaview.add(textarea);
textareaview.add(submit);

window.add(textareaview);

var last = 0;

window.addEventListener('keyboardchange', function (event) {

	var next = event.height ? (window.rect.height - event.y) : 0;
	var delta = Math.abs(next - last);
	var transform = Ti.UI.create2DMatrix().translate(0, -next);

	if (delta > 40) {
		textareaview.animate({
			curve: 7, // Undocumented (by Apple) iOS7 animation curve
			duration: 300,
			transform: transform
		});
	}
	else if (delta > 0) {
		textareaview.transform = transform;
	}

	last = next;
});

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
