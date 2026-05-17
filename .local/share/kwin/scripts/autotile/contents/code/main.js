console.log("Autotile has been loaded");

const rightTiled = [
  /^dev.zed.Zed-.*$/,
  /brave-fjpjbebpkgbjfpebjkjkgijdmhpeflpn-Default/, // VueTorrent
];

// Gmail
// "brave-fmgjjmmmlfnkbppncabfkddbjimcfncm-Default"

function shouldBeOnRight(window) {
  // return window.resourceClass === "dev.zed.Zed-Nightly";
  // console.log(
  //   "shouldBeOnRight -- window.resourceClass: " +
  //     window.resourceClass +
  //     "; result: " +
  //     rightTiled.some((regexp) => regexp.test(window.resourceClass)),
  // );
  return rightTiled.some((regexp) => regexp.test(window.resourceClass));
}

const skipped = [
  /brave-cinhimbnkkaeohfgghhklpknlkffjgod-Default/, // Youtube Music
  /^btop$/,
];

function shouldBeSkipped(window) {
  // console.log(
  //   "shouldBeSkipped -- window.resourceClass: " +
  //     window.resourceClass +
  //     "; result: " +
  //     skipped.some((regexp) => regexp.test(window.resourceClass)),
  // );
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
