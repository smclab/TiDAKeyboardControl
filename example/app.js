var automatic = require('automatic');
var manual = require('manual');

var win = Ti.UI.createWindow({
	layout:'vertical'
});

var automaticButton = Ti.UI.createButton({
	title: 'Automatic',
	width: 150,
	height: 50
});

var manualButton = Ti.UI.createButton({
	title: 'Manual',
	width: 150,
	height: 50
});

automaticButton.addEventListener('click', automatic);
manualButton.addEventListener('click', manual);

win.add(automaticButton);
win.add(manualButton);

win.open();
