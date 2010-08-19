yak.functions.add({
    goForward: function() {
	history.go(1);
    }
});
yak.bindings.add({
    // I assume that most people who have gotten this far were raised on
    // Netscape's behavior of Backspace = PageUp.
    'F': {
        exclude: yak.textElements,
        onkeydown: yak.functions.goForward
    },
    'M-p': {
        exclude: yak.textElements,
	onkeydown: yak.functions.tabLeft
    },
    'M-n': {
        exclude: yak.textElements,
	onkeydown: yak.functions.tabRight
    }
});