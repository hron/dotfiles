console.log("Autotile has been loaded");

const rightTiled = [
  /^dev.zed.Zed-.*$/,
  /brave-fjpjbebpkgbjfpebjkjkgijdmhpeflpn-Default/, // VueTorrent
  /^Alacritty$/,
];

function shouldBeOnRight(window) {
  return rightTiled.some((regexp) => regexp.test(window.resourceClass));
}

const skipped = [
  /brave-cinhimbnkkaeohfgghhklpknlkffjgod-Default/, // Youtube Music
  /^btop$/,
];

function shouldBeSkipped(window) {
  return skipped.some((regexp) => regexp.test(window.resourceClass));
}

function tileToRight() {
  workspace.slotWindowQuickTileRight();
  workspace.slotWindowQuickTileTop();
  workspace.slotWindowQuickTileTop();
  workspace.slotWindowQuickTileBottom();
}

function tileToLeft() {
  workspace.slotWindowQuickTileLeft();
  workspace.slotWindowQuickTileTop();
  workspace.slotWindowQuickTileTop();
  workspace.slotWindowQuickTileBottom();
}

function isTileable(window) {
  return (
    window.normalWindow &&
    window.managed &&
    !window.specialWindow &&
    !window.dialog &&
    !window.splash &&
    !window.utility &&
    !window.popupWindow &&
    !window.transient
  );
}

workspace.windowAdded.connect(function (window) {
  console.log("window.resourceClass: " + window.resourceClass);
  if (!isTileable(window)) {
    // console.log("Skipping because it's not tileable");
    return;
  }

  if (shouldBeSkipped(window)) {
    // do nothing
  } else if (shouldBeOnRight(window)) {
    tileToRight();
  } else {
    tileToLeft();
  }
});
