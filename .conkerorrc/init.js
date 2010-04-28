// -*- espresso -*-

// require("new-tabs.js");
require("clicks-in-new-buffer.js");
require("block-content-focus-change.js");
require("page-modes/gmane.js")
require("page-modes/gmail.js")
require("page-modes/youtube.js")
require("page-modes/google-maps.js")
require("page-modes/google-video.js")
require("page-modes/google-calendar.js")
require("page-modes/google-reader.js")
require("page-modes/google-images.js")
require("extensions/adblockplus.js");

// require("page-modes/google-search-results.js");
// google_search_bind_number_shortcuts();

// Webjump oneliners
define_webjump("codesearch", "http://www.google.com/codesearch?q=%s");
define_webjump("cpan", "http://search.cpan.org/search?query=%s&mode=all");
define_webjump("twitter", "http://twitter.com/%s");
define_webjump("youtube", "http://www.youtube.com/results?search_query=%s&search=Search");

define_webjump("emacswiki", "http://www.google.com/cse?cx=004774160799092323420%3A6-ff2s0o6yi&q=%s&sa=Search");
define_webjump("github", "http://github.com/search?q=%s&type=Everything&repo=&langOverride=&start_value=1");

define_webjump("rubytoolbox", "http://www.ruby-toolbox.com/categories.html");

// Personalized Webjumps
add_delicious_webjumps("hron");
add_lastfm_webjumps("hron77");

// Download buffers are opened automatically whenever you start a
// download, and whenever you use the download-show command. Those
// buffers can be opened in a new window, or in a new buffer in the
// current window. The default is to open them in a new window. This
// is controlled by the variable,
// download_buffer_automatic_open_target, which can either be a single
// target, or an array of two targets. When it is an array, the second
// target given will be used by download-show when it is called with
// universal-argument. The default is [OPEN_NEW_WINDOW,
// OPEN_NEW_BUFFER_BACKGROUND]. A popular alternative is to reverse
// the order of the two targets:
download_buffer_automatic_open_target = [OPEN_NEW_WINDOW, OPEN_NEW_BUFFER_BACKGROUND ];
// cwd = '/home/gusev/Downloads';
delete_temporary_files_for_command = false;

// Boolean Default is false. Controls whether urls in the browse
// history will be included in the completion list when prompting the
// user for an url, for example, with the open-url command.
//
// Due to a Mozilla bug, this value is currently mutually exclusive
// with url_completion_use_bookmarks. Refer to
// http://bugs.conkeror.org/issue10 for details.
url_completion_use_history = true;

editor_shell_command = '/usr/bin/emacsclient -c $@';

// When true, the view-source command will send its document to your external
// editor. Default is false.
view_source_use_external_editor = true;

// http://conkeror.org/PasswordManagement
session_pref("signon.rememberSignons", true);
session_pref("signon.expireMasterPassword", false);
session_pref("signon.SignonFileName", "signons.txt");
Components.classes["@mozilla.org/login-manager;1"].getService(Components.interfaces.nsILoginManager);

// MIME
external_content_handlers.set("application/x-bittorrent", "transmission");

// mode-line
remove_hook("mode_line_hook", mode_line_adder(clock_widget));
add_hook("mode_line_hook", mode_line_adder(loading_count_widget), true);
add_hook("mode_line_hook", mode_line_adder(buffer_count_widget), true);

require('eye-guide.js');
define_key(content_buffer_normal_keymap, "space", "eye-guide-scroll-down");
define_key(content_buffer_normal_keymap, "back_space", "eye-guide-scroll-up");

// http://conkeror.org/Extensions
user_pref("extensions.checkCompatibility", false);
user_pref("extensions.checkUpdateSecurity", false);

// Mozilla has a whitelist of domains which are allowed to install extensions.
// By default, this whitelist allows only local URLs. Conkeror does not yet have
// a user interface for adding to this whitelist. Therefore, to install an
// extension, you must first save the xpi file locally, and then browse to the
// xpi file in Conkeror. (You can press s (save) to save the xpi from a page
// which links to it.)
session_pref("xpinstall.whitelist.required", false);

// MozRepl
user_pref('extensions.mozrepl.autoStart', true);

if ('@hyperstruct.net/mozlab/mozrepl;1' in Cc) {
  let mozrepl = Cc['@hyperstruct.net/mozlab/mozrepl;1']
    .getService(Ci.nsIMozRepl);
  if (! mozrepl.isActive())
    mozrepl.start(4242);
}

// http://conkeror.org/Tips#FirebugLite
define_variable("firebug_url",
    "http://getfirebug.com/releases/lite/1.2/firebug-lite-compressed.js");

function firebug (I) {
    var doc = I.buffer.document;
    var script = doc.createElement('script');
    script.setAttribute('type', 'text/javascript');
    script.setAttribute('src', firebug_url);
    script.setAttribute('onload', 'firebug.init();');
    doc.body.appendChild(script);
}
interactive("firebug", "open firebug lite", firebug);
