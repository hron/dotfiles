yak.functions.add({
    goForward: function() {
	history.go(1);
    }
});
yak.bindings.add({
    'l': {
        exclude: yak.textElements,
        onkeydown: yak.functions.goBack
    },
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