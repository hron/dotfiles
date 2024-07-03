gsettings set ca.desrt.dconf-editor.Demo boolean true
gsettings set ca.desrt.dconf-editor.Demo boolean-nullable @mb nothing
gsettings set ca.desrt.dconf-editor.Demo byte byte 0x42
gsettings set ca.desrt.dconf-editor.Demo bytestring [byte 0x48, 0x65, 0x6c, 0x6c, 0x6c]
gsettings set ca.desrt.dconf-editor.Demo bytestring-array [[byte 0x48, 0x65, 0x6c, 0x6c, 0x6c], [0x57, 0x6f, 0x72, 0x6c, 0x64], [0x21]]
gsettings set ca.desrt.dconf-editor.Demo dbus-handle handle 0
gsettings set ca.desrt.dconf-editor.Demo dbus-object-path objectpath '/ca/desrt/dconf_editor'
gsettings set ca.desrt.dconf-editor.Demo dbus-object-path-array [objectpath '/ca/desrt/dconf_editor/menus/appmenu', '/ca/desrt/dconf_editor/window/1']
gsettings set ca.desrt.dconf-editor.Demo dbus-signature signature 'ii'
gsettings set ca.desrt.dconf-editor.Demo dict-entry {'color', 'red'}
gsettings set ca.desrt.dconf-editor.Demo dictionary {'title': <'Example'>, 'character': <uint32 56>, 'bold': <true>}
gsettings set ca.desrt.dconf-editor.Demo double 3.1415926535897931
gsettings set ca.desrt.dconf-editor.Demo enumeration 'White'
gsettings set ca.desrt.dconf-editor.Demo flags ['Blue', 'White', 'Red']
gsettings set ca.desrt.dconf-editor.Demo integer-16-signed int16 -32768
gsettings set ca.desrt.dconf-editor.Demo integer-16-unsigned uint16 65535
gsettings set ca.desrt.dconf-editor.Demo integer-32-signed -2147483648
gsettings set ca.desrt.dconf-editor.Demo integer-32-unsigned uint32 4294967295
gsettings set ca.desrt.dconf-editor.Demo integer-64-signed int64 -9223372036854775808
gsettings set ca.desrt.dconf-editor.Demo integer-64-unsigned uint64 18446744073709551615
gsettings set ca.desrt.dconf-editor.Demo number-with-range 3
gsettings set ca.desrt.dconf-editor.Demo pair-of-integers (800, 600)
gsettings set ca.desrt.dconf-editor.Demo string 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.'
gsettings set ca.desrt.dconf-editor.Demo string-array ['orange', 'banana', 'pear']
gsettings set ca.desrt.dconf-editor.Demo string-nullable @ms nothing
gsettings set ca.desrt.dconf-editor.Demo variant <@mmb just nothing>
gsettings set ca.desrt.dconf-editor.Demo weird-range 5
gsettings set ca.desrt.dconf-editor.Demo weird-triv ()
gsettings set ca.desrt.dconf-editor.Demo.Conflict1 a-non-conflicting-key true
gsettings set ca.desrt.dconf-editor.Demo.Conflict1 default-value-conflict 1
gsettings set ca.desrt.dconf-editor.Demo.Conflict1 range-conflict uint32 0
gsettings set ca.desrt.dconf-editor.Demo.Conflict1 type-conflict 'test'
gsettings set ca.desrt.dconf-editor.Demo.Conflict1 warning-similar true
gsettings set ca.desrt.dconf-editor.Demo.Conflict2 another-non-conflicting-key true
gsettings set ca.desrt.dconf-editor.Demo.Conflict2 default-value-conflict 2
gsettings set ca.desrt.dconf-editor.Demo.Conflict2 range-conflict uint32 0
gsettings set ca.desrt.dconf-editor.Demo.Conflict2 type-conflict @ms 'test'
gsettings set ca.desrt.dconf-editor.Demo.Conflict2 warning-similar true
gsettings set ca.desrt.dconf-editor.Settings behaviour 'always-confirm-implicit'
gsettings set ca.desrt.dconf-editor.Settings mouse-back-button 8
gsettings set ca.desrt.dconf-editor.Settings mouse-forward-button 9
gsettings set ca.desrt.dconf-editor.Settings mouse-use-extra-buttons true
gsettings set ca.desrt.dconf-editor.Settings refresh-settings-schema-source true
gsettings set ca.desrt.dconf-editor.Settings relocatable-schemas-enabled-mappings ['User', 'Built-in', 'Internal', 'Startup']
gsettings set ca.desrt.dconf-editor.Settings relocatable-schemas-user-paths {'ca.desrt.dconf-editor.Demo.Relocatable': '/ca/desrt/dconf-editor/Demo/relocatable/'}
gsettings set ca.desrt.dconf-editor.Settings restore-view true
gsettings set ca.desrt.dconf-editor.Settings saved-pathbar-path '/org/gnome/shell/extensions/dash-to-dock/app-hotkey-2'
gsettings set ca.desrt.dconf-editor.Settings saved-view '/org/gnome/shell/extensions/dash-to-dock/'
gsettings set ca.desrt.dconf-editor.Settings show-warning false
gsettings set ca.desrt.dconf-editor.Settings small-keys-list-rows false
gsettings set ca.desrt.dconf-editor.Settings sort-case-sensitive false
gsettings set ca.desrt.dconf-editor.Settings use-shortpaths false
gsettings set com.canonical.Unity.Lenses always-search ['applications.scope', 'music.scope', 'videos.scope', 'files.scope']
gsettings set com.canonical.Unity.Lenses disabled-scopes @as []
gsettings set com.canonical.Unity.Lenses hidden-scopes @as []
gsettings set com.canonical.Unity.Lenses home-lens-default-view ['applications.scope', 'files.scope']
gsettings set com.canonical.Unity.Lenses home-lens-priority ['files.scope', 'music.scope']
gsettings set com.canonical.Unity.Lenses locked-scopes @as []
gsettings set com.canonical.unity.desktop.background draw-background true
gsettings set com.canonical.unity.desktop.interface automatic-mnemonics true
gsettings set com.canonical.unity.desktop.interface buttons-have-icons false
gsettings set com.canonical.unity.desktop.interface menus-have-icons false
gsettings set com.canonical.unity.desktop.interface show-input-method-menu true
gsettings set com.canonical.unity.desktop.interface show-unicode-menu true
gsettings set com.canonical.unity.desktop.screensaver show-notifications false
gsettings set com.ubuntu.SoftwareProperties ubuntu-pro-banner-visible true
gsettings set com.ubuntu.login-screen background-color ''
gsettings set com.ubuntu.login-screen background-picture-uri ''
gsettings set com.ubuntu.login-screen background-repeat 'default'
gsettings set com.ubuntu.login-screen background-size 'default'
gsettings set com.ubuntu.login-screen enable-authd-authentication true
gsettings set com.ubuntu.notifications.hub blacklist @a(ss) []
gsettings set com.ubuntu.notifications.settings.applications applications @as []
gsettings set com.ubuntu.notifications.settings.applications vibrate-silent-mode true
gsettings set com.ubuntu.phone default-sim-for-calls 'ask'
gsettings set com.ubuntu.phone default-sim-for-messages 'ask'
gsettings set com.ubuntu.phone mms-group-chat-enabled false
gsettings set com.ubuntu.phone sim-names @a{ss} {}
gsettings set com.ubuntu.sound allow-amplified-volume false
gsettings set com.ubuntu.touch.network flight-mode false
gsettings set com.ubuntu.touch.network gps true
gsettings set com.ubuntu.touch.sound incoming-call-sound '/usr/share/sounds/ubuntu/ringtones/Ubuntu.ogg'
gsettings set com.ubuntu.touch.sound incoming-message-sound '/usr/share/sounds/ubuntu/notifications/Xylo.ogg'
gsettings set com.ubuntu.touch.sound silent-mode false
gsettings set com.ubuntu.touch.system activity-timeout uint32 60
gsettings set com.ubuntu.touch.system auto-brightness false
gsettings set com.ubuntu.touch.system brightness 80
gsettings set com.ubuntu.touch.system brightness-needs-hardware-default true
gsettings set com.ubuntu.touch.system dim-timeout uint32 45
gsettings set com.ubuntu.touch.system fingerprint-names @a{ss} {}
gsettings set com.ubuntu.touch.system orientation-lock 'none'
gsettings set com.ubuntu.touch.system rotation-lock false
gsettings set com.ubuntu.update-manager autoclose-install-window true
gsettings set com.ubuntu.update-manager check-dist-upgrades true
gsettings set com.ubuntu.update-manager check-new-release-ignore ''
gsettings set com.ubuntu.update-manager first-run false
gsettings set com.ubuntu.update-manager launch-count 2
gsettings set com.ubuntu.update-manager launch-time int64 1719992517
gsettings set com.ubuntu.update-manager show-details true
gsettings set com.ubuntu.update-manager show-versions false
gsettings set com.ubuntu.update-manager summary-before-name true
gsettings set com.ubuntu.update-manager window-height 575
gsettings set com.ubuntu.update-manager window-width 672
gsettings set com.ubuntu.update-notifier end-system-uids 500
gsettings set com.ubuntu.update-notifier hide-reboot-notification false
gsettings set com.ubuntu.update-notifier no-show-notifications false
gsettings set com.ubuntu.update-notifier notify-ubuntu-advantage-available true
gsettings set com.ubuntu.update-notifier regular-auto-launch-interval 7
gsettings set com.ubuntu.update-notifier release-check-time uint32 1719343342
gsettings set com.ubuntu.update-notifier show-apport-crashes true
gsettings set com.ubuntu.update-notifier show-livepatch-status-icon true
gsettings set com.ubuntu.user-interface scale-factor @a{si} {}
gsettings set com.ubuntu.user-interface.desktop cursor-size 24
gsettings set com.ubuntu.user-interface.desktop scaling-factor uint32 0
gsettings set com.ubuntu.user-interface.desktop text-scaling-factor 1.0
gsettings set org.freedesktop.ColorHelper display-gamma 2.3999999999999999
gsettings set org.freedesktop.ColorHelper display-whitepoint 6500
gsettings set org.freedesktop.ColorHelper sample-delay 400
gsettings set org.freedesktop.Tracker3.Extract max-bytes 1048576
gsettings set org.freedesktop.Tracker3.Extract text-allowlist ['*.txt', '*.md', '*.mdwn']
gsettings set org.freedesktop.Tracker3.Extract wait-for-miner-fs false
gsettings set org.freedesktop.Tracker3.FTS enable-stemmer false
gsettings set org.freedesktop.Tracker3.FTS enable-unaccent true
gsettings set org.freedesktop.Tracker3.FTS ignore-numbers true
gsettings set org.freedesktop.Tracker3.Miner.Files crawling-interval -1
gsettings set org.freedesktop.Tracker3.Miner.Files enable-monitors true
gsettings set org.freedesktop.Tracker3.Miner.Files ignored-directories ['po', 'CVS', 'core-dumps', 'lost+found']
gsettings set org.freedesktop.Tracker3.Miner.Files ignored-directories-with-content ['.trackerignore', '.git', '.hg', '.nomedia']
gsettings set org.freedesktop.Tracker3.Miner.Files ignored-files ['*~', '*.o', '*.la', '*.lo', '*.loT', '*.in', '*.m4', '*.rej', '*.gmo', '*.orig', '*.pc', '*.omf', '*.aux', '*.tmp', '*.vmdk', '*.vm*', '*.nvram', '*.part', '*.rcore', '*.lzo', 'autom4te', 'conftest', 'confstat', 'Makefile', 'SCCS', 'ltmain.sh', 'libtool', 'config.status', 'confdefs.h', 'configure', '#*#', '~$*.doc?', '~$*.dot?', '~$*.xls?', '~$*.xlt?', '~$*.xlam', '~$*.ppt?', '~$*.pot?', '~$*.ppam', '~$*.ppsm', '~$*.ppsx', '~$*.vsd?', '~$*.vss?', '~$*.vst?', '*.directory']
gsettings set org.freedesktop.Tracker3.Miner.Files index-on-battery true
gsettings set org.freedesktop.Tracker3.Miner.Files index-on-battery-first-time true
gsettings set org.freedesktop.Tracker3.Miner.Files index-optical-discs false
gsettings set org.freedesktop.Tracker3.Miner.Files index-recursive-directories ['&DESKTOP', '&DOCUMENTS', '&MUSIC', '&PICTURES', '&VIDEOS']
gsettings set org.freedesktop.Tracker3.Miner.Files index-removable-devices false
gsettings set org.freedesktop.Tracker3.Miner.Files index-single-directories ['$HOME', '&DOWNLOAD']
gsettings set org.freedesktop.Tracker3.Miner.Files initial-sleep 15
gsettings set org.freedesktop.Tracker3.Miner.Files low-disk-space-limit -1
gsettings set org.freedesktop.Tracker3.Miner.Files removable-days-threshold 3
gsettings set org.freedesktop.Tracker3.Miner.Files throttle 0
gsettings set org.freedesktop.ibus.general dconf-preserve-name-prefixes ['/desktop/ibus/engine/pinyin', '/desktop/ibus/engine/bopomofo', '/desktop/ibus/engine/hangul']
gsettings set org.freedesktop.ibus.general embed-preedit-text true
gsettings set org.freedesktop.ibus.general enable-by-default false
gsettings set org.freedesktop.ibus.general engines-order @as []
gsettings set org.freedesktop.ibus.general preload-engines @as []
gsettings set org.freedesktop.ibus.general switcher-delay-time 400
gsettings set org.freedesktop.ibus.general use-global-engine true
gsettings set org.freedesktop.ibus.general use-system-keyboard-layout false
gsettings set org.freedesktop.ibus.general use-xmodmap true
gsettings set org.freedesktop.ibus.general version ''
gsettings set org.freedesktop.ibus.general xkb-latin-layouts ['af', 'af(fa-olpc)', 'af(ps-olpc)', 'af(ps)', 'af(uz)', 'af(uz-olpc)', 'am', 'am(eastern)', 'am(eastern-alt)', 'am(phonetic)', 'am(phonetic-alt)', 'am(western)', 'ara', 'ara(azerty)', 'ara(azerty_digits)', 'ara(buckwalter)', 'ara(digits)', 'ara(qwerty)', 'ara(qwerty_digits)', 'az(cyrillic)', 'bd', 'bd(probhat)', 'bg', 'bg(bas_phonetic)', 'bg(phonetic)', 'brai', 'brai(left_hand)', 'brai(right_hand)', 'bt', 'by', 'by(phonetic)', 'by(legacy)', 'ca(ike)', 'cn(tib)', 'cn(tib_asciinum)', 'cn(ug)', 'cz', 'cz(ucw)', 'de(ru)', 'dev', 'et', 'fr(geo)', 'ge', 'ge(os)', 'gr', 'gr(extended)', 'gr(nodeadkeys)', 'gr(polytonic)', 'gr(simple)', 'gur', 'il', 'il(biblical)', 'il(lyx)', 'il(phonetic)', 'id(melayu-phonetic)', 'id(melayu-phoneticx)', 'id(pegon-phonetic)', 'in', 'in(ben)', 'in(ben_baishakhi)', 'in(ben_bornona)', 'in(ben_gitanjali)', 'in(ben_inscript)', 'in(ben_probhat)', 'in(bolnagri)', 'in(deva)', 'in(guj)', 'in(guj-kagapa)', 'in(guru)', 'in(hin-kagapa)', 'in(hin-wx)', 'in(jhelum)', 'in(kan)', 'in(kan-kagapa)', 'in(mal)', 'in(mal_enhanced)', 'in(mal_lalitha)', 'in(mar-kagapa)', 'in(ori)', 'in(san-kagapa)', 'in(tam)', 'in(tamilnet)', 'in(tamilnet_TAB)', 'in(tamilnet_TSCII)', 'in(tamilnet_tamilnumbers)', 'in(tam_tamilnumbers)', 'in(tel)', 'in(tel-kagapa)', 'in(urd-phonetic)', 'in(urd-phonetic3)', 'in(urd-winkeys)', 'iq', 'ir', 'ir(azb)', 'ir(pes_keypad)', 'jp(kana)', 'jp(mac)', 'kg', 'kg(phonetic)', 'kh', 'kz', 'kz(kazrus)', 'kz(ruskaz)', 'la', 'la(stea)', 'lk', 'lk(tam_TAB)', 'lk(tam_unicode)', 'lv(modern-cyr)', 'ma', 'ma(tifinagh)', 'ma(tifinagh-alt)', 'ma(tifinagh-alt-phonetic)', 'ma(tifinagh-extended)', 'ma(tifinagh-extended-phonetic)', 'ma(tifinagh-phonetic)', 'me(cyrillic)', 'me(cyrillicalternatequotes)', 'me(cyrillicyz)', 'mk', 'mk(nodeadkeys)', 'mm', 'mn', 'mv', 'np', 'ph(capewell-dvorak-bay)', 'ph(capewell-qwerf2k6-bay)', 'ph(colemak-bay)', 'ph(dvorak-bay)', 'ph(qwerty-bay)', 'pk', 'pk(ara)', 'pk(snd)', 'pk(urd-crulp)', 'pk(urd-nla)', 'pl(ru_phonetic_dvorak)', 'rs', 'rs(alternatequotes)', 'rs(rue)', 'rs(yz)', 'ru', 'ru(bak)', 'ru(chm)', 'ru(cv)', 'ru(dos)', 'ru(kom)', 'ru(legacy)', 'ru(mac)', 'ru(os_legacy)', 'ru(os_winkeys)', 'ru(phonetic)', 'ru(phonetic_winkeys)', 'ru(sah)', 'ru(srp)', 'ru(tt)', 'ru(typewriter)', 'ru(typewriter-legacy)', 'ru(udm)', 'ru(xal)', 'se(rus)', 'se(swl)', 'sy', 'sy(syc)', 'sy(syc_phonetic)', 'th', 'th(pat)', 'th(tis)', 'tj', 'tj(legacy)', 'tz', 'ua', 'ua(homophonic)', 'ua(legacy)', 'ua(phonetic)', 'ua(typewriter)', 'ua(winkeys)', 'us(chr)', 'us(rus)', 'uz']
gsettings set org.freedesktop.ibus.general.hotkey disable-unconditional @as []
gsettings set org.freedesktop.ibus.general.hotkey enable-unconditional @as []
gsettings set org.freedesktop.ibus.general.hotkey next-engine ['Alt+Shift_L']
gsettings set org.freedesktop.ibus.general.hotkey next-engine-in-menu ['Alt+Shift_L']
gsettings set org.freedesktop.ibus.general.hotkey prev-engine @as []
gsettings set org.freedesktop.ibus.general.hotkey previous-engine @as []
gsettings set org.freedesktop.ibus.general.hotkey trigger ['Control+space', 'Zenkaku_Hankaku', 'Alt+Kanji', 'Alt+grave', 'Hangul', 'Alt+Release+Alt_R']
gsettings set org.freedesktop.ibus.general.hotkey triggers ['<Super>space']
gsettings set org.freedesktop.ibus.panel auto-hide-timeout 10000
gsettings set org.freedesktop.ibus.panel custom-font 'Sans 10'
gsettings set org.freedesktop.ibus.panel custom-icon 'Adwaita'
gsettings set org.freedesktop.ibus.panel custom-theme 'Adwaita'
gsettings set org.freedesktop.ibus.panel follow-input-cursor-when-always-shown false
gsettings set org.freedesktop.ibus.panel lookup-table-orientation 1
gsettings set org.freedesktop.ibus.panel property-icon-delay-time 500
gsettings set org.freedesktop.ibus.panel show 0
gsettings set org.freedesktop.ibus.panel show-icon-on-systray true
gsettings set org.freedesktop.ibus.panel show-im-name false
gsettings set org.freedesktop.ibus.panel use-custom-font false
gsettings set org.freedesktop.ibus.panel use-custom-icon false
gsettings set org.freedesktop.ibus.panel use-custom-theme false
gsettings set org.freedesktop.ibus.panel use-glyph-from-engine-lang true
gsettings set org.freedesktop.ibus.panel x -1
gsettings set org.freedesktop.ibus.panel xkb-icon-rgba '#51a2da'
gsettings set org.freedesktop.ibus.panel y -1
gsettings set org.freedesktop.ibus.panel.emoji favorite-annotations @as []
gsettings set org.freedesktop.ibus.panel.emoji favorites @as []
gsettings set org.freedesktop.ibus.panel.emoji font 'Monospace 16'
gsettings set org.freedesktop.ibus.panel.emoji has-partial-match false
gsettings set org.freedesktop.ibus.panel.emoji hotkey ['<Super>period', '<Super>semicolon']
gsettings set org.freedesktop.ibus.panel.emoji lang 'en'
gsettings set org.freedesktop.ibus.panel.emoji load-emoji-at-startup true
gsettings set org.freedesktop.ibus.panel.emoji load-unicode-at-startup false
gsettings set org.freedesktop.ibus.panel.emoji partial-match-condition 0
gsettings set org.freedesktop.ibus.panel.emoji partial-match-length 3
gsettings set org.freedesktop.ibus.panel.emoji unicode-hotkey ['<Control><Shift>u']
gsettings set org.gnome.Characters max-recent-characters uint32 100
gsettings set org.gnome.Characters recent-characters @as []
gsettings set org.gnome.Disks image-dir-uri ''
gsettings set org.gnome.Disks.benchmark do-write true
gsettings set org.gnome.Disks.benchmark num-access-samples 1000
gsettings set org.gnome.Disks.benchmark num-samples 100
gsettings set org.gnome.Disks.benchmark sample-size-mib 10
gsettings set org.gnome.Evince allow-links-change-zoom true
gsettings set org.gnome.Evince auto-reload true
gsettings set org.gnome.Evince document-directory @ms nothing
gsettings set org.gnome.Evince override-restrictions true
gsettings set org.gnome.Evince page-cache-size uint32 50
gsettings set org.gnome.Evince pictures-directory @ms nothing
gsettings set org.gnome.Evince show-caret-navigation-message true
gsettings set org.gnome.Evince.Default continuous true
gsettings set org.gnome.Evince.Default dual-page false
gsettings set org.gnome.Evince.Default dual-page-odd-left false
gsettings set org.gnome.Evince.Default enable-spellchecking true
gsettings set org.gnome.Evince.Default fullscreen false
gsettings set org.gnome.Evince.Default inverted-colors false
gsettings set org.gnome.Evince.Default show-sidebar true
gsettings set org.gnome.Evince.Default sidebar-page 'thumbnails'
gsettings set org.gnome.Evince.Default sidebar-size 132
gsettings set org.gnome.Evince.Default window-ratio (1.5147058823529411, 1.3232323232323233)
gsettings set org.gnome.Evince.Default zoom 1.0
gsettings set org.gnome.Evolution.DefaultSources default-address-book 'system'
gsettings set org.gnome.Evolution.DefaultSources default-calendar 'system'
gsettings set org.gnome.Evolution.DefaultSources default-mail-account 'system'
gsettings set org.gnome.Evolution.DefaultSources default-mail-identity ''
gsettings set org.gnome.Evolution.DefaultSources default-memo-list 'system'
gsettings set org.gnome.Evolution.DefaultSources default-task-list 'system'
gsettings set org.gnome.Extensions window-height 500
gsettings set org.gnome.Extensions window-maximized false
gsettings set org.gnome.Extensions window-width 800
gsettings set org.gnome.GWeather4 default-location ('', 'KNYC', @m(dd) nothing)
gsettings set org.gnome.GWeather4 distance-unit 'default'
gsettings set org.gnome.GWeather4 pressure-unit 'default'
gsettings set org.gnome.GWeather4 speed-unit 'default'
gsettings set org.gnome.GWeather4 temperature-unit 'default'
gsettings set org.gnome.Logs ignore-warning false
gsettings set org.gnome.SessionManager auto-save-session false
gsettings set org.gnome.SessionManager auto-save-session-one-shot false
gsettings set org.gnome.SessionManager logout-prompt true
gsettings set org.gnome.SessionManager show-fallback-warning true
gsettings set org.gnome.Settings last-panel 'keyboard'
gsettings set org.gnome.Settings show-development-warning true
gsettings set org.gnome.Settings window-state (913, 745, false)
gsettings set org.gnome.Terminal.Legacy.Settings always-check-default-terminal true
gsettings set org.gnome.Terminal.Legacy.Settings confirm-close true
gsettings set org.gnome.Terminal.Legacy.Settings context-info ['numbers']
gsettings set org.gnome.Terminal.Legacy.Settings default-show-menubar true
gsettings set org.gnome.Terminal.Legacy.Settings headerbar @mb nothing
gsettings set org.gnome.Terminal.Legacy.Settings menu-accelerator-enabled true
gsettings set org.gnome.Terminal.Legacy.Settings mnemonics-enabled false
gsettings set org.gnome.Terminal.Legacy.Settings new-tab-position 'last'
gsettings set org.gnome.Terminal.Legacy.Settings new-terminal-mode 'window'
gsettings set org.gnome.Terminal.Legacy.Settings schema-version uint32 3
gsettings set org.gnome.Terminal.Legacy.Settings shell-integration-enabled true
gsettings set org.gnome.Terminal.Legacy.Settings shortcuts-enabled true
gsettings set org.gnome.Terminal.Legacy.Settings tab-position 'top'
gsettings set org.gnome.Terminal.Legacy.Settings theme-variant 'system'
gsettings set org.gnome.Terminal.Legacy.Settings unified-menu false
gsettings set org.gnome.Terminal.ProfilesList default 'b1dcc9dd-5262-4d8d-a863-c897e6d979b9'
gsettings set org.gnome.Terminal.ProfilesList list ['b1dcc9dd-5262-4d8d-a863-c897e6d979b9']
gsettings set org.gnome.TextEditor auto-indent true
gsettings set org.gnome.TextEditor auto-save-delay uint32 3
gsettings set org.gnome.TextEditor custom-font 'Monospace 11'
gsettings set org.gnome.TextEditor discover-settings true
gsettings set org.gnome.TextEditor draw-spaces @as []
gsettings set org.gnome.TextEditor enable-snippets false
gsettings set org.gnome.TextEditor highlight-current-line false
gsettings set org.gnome.TextEditor highlight-matching-brackets true
gsettings set org.gnome.TextEditor indent-style 'tab'
gsettings set org.gnome.TextEditor indent-width -1
gsettings set org.gnome.TextEditor keybindings 'default'
gsettings set org.gnome.TextEditor last-save-directory ''
gsettings set org.gnome.TextEditor line-height 1.2
gsettings set org.gnome.TextEditor recolor-window true
gsettings set org.gnome.TextEditor restore-session true
gsettings set org.gnome.TextEditor right-margin-position uint32 80
gsettings set org.gnome.TextEditor show-grid false
gsettings set org.gnome.TextEditor show-line-numbers false
gsettings set org.gnome.TextEditor show-map false
gsettings set org.gnome.TextEditor show-right-margin false
gsettings set org.gnome.TextEditor spellcheck true
gsettings set org.gnome.TextEditor style-scheme 'Adwaita'
gsettings set org.gnome.TextEditor style-variant 'follow'
gsettings set org.gnome.TextEditor tab-width uint32 8
gsettings set org.gnome.TextEditor use-system-font true
gsettings set org.gnome.TextEditor wrap-text true
gsettings set org.gnome.baobab.preferences excluded-uris @as []
gsettings set org.gnome.baobab.ui active-chart 'rings'
gsettings set org.gnome.baobab.ui is-maximized false
gsettings set org.gnome.baobab.ui window-size (960, 600)
gsettings set org.gnome.calculator accuracy 9
gsettings set org.gnome.calculator angle-units 'degrees'
gsettings set org.gnome.calculator base 10
gsettings set org.gnome.calculator button-mode 'basic'
gsettings set org.gnome.calculator number-format 'automatic'
gsettings set org.gnome.calculator precision 2000
gsettings set org.gnome.calculator refresh-interval 604800
gsettings set org.gnome.calculator show-thousands false
gsettings set org.gnome.calculator show-zeroes false
gsettings set org.gnome.calculator source-currency ''
gsettings set org.gnome.calculator source-units 'degree'
gsettings set org.gnome.calculator target-currency ''
gsettings set org.gnome.calculator target-units 'radian'
gsettings set org.gnome.calculator window-maximized false
gsettings set org.gnome.calculator window-position (-1, -1)
gsettings set org.gnome.calculator window-size (-1, -1)
gsettings set org.gnome.calculator word-size 64
gsettings set org.gnome.clocks alarms @aa{sv} []
gsettings set org.gnome.clocks geolocation true
gsettings set org.gnome.clocks timers @aa{sv} []
gsettings set org.gnome.clocks world-clocks @aa{sv} []
gsettings set org.gnome.clocks.state.window maximized false
gsettings set org.gnome.clocks.state.window panel-id 'world'
gsettings set org.gnome.clocks.state.window size (870, 690)
gsettings set org.gnome.crypto.cache gpg-cache-method 'session'
gsettings set org.gnome.crypto.cache gpg-cache-ttl 300
gsettings set org.gnome.crypto.pgp ascii-armor true
gsettings set org.gnome.crypto.pgp default-key ''
gsettings set org.gnome.crypto.pgp encrypt-to-self true
gsettings set org.gnome.crypto.pgp keyservers ['hkp://keyserver.ubuntu.com:11371', 'ldap://keyserver.pgp.com']
gsettings set org.gnome.crypto.pgp last-signer ''
gsettings set org.gnome.crypto.pgp sort-recipients-by 'name'
gsettings set org.gnome.desktop.a11y always-show-text-caret false
gsettings set org.gnome.desktop.a11y always-show-universal-access-status false
gsettings set org.gnome.desktop.a11y.applications screen-keyboard-enabled false
gsettings set org.gnome.desktop.a11y.applications screen-magnifier-enabled false
gsettings set org.gnome.desktop.a11y.applications screen-reader-enabled false
gsettings set org.gnome.desktop.a11y.interface high-contrast false
gsettings set org.gnome.desktop.a11y.interface show-status-shapes false
gsettings set org.gnome.desktop.a11y.keyboard bouncekeys-beep-reject false
gsettings set org.gnome.desktop.a11y.keyboard bouncekeys-delay 300
gsettings set org.gnome.desktop.a11y.keyboard bouncekeys-enable false
gsettings set org.gnome.desktop.a11y.keyboard disable-timeout 200
gsettings set org.gnome.desktop.a11y.keyboard enable false
gsettings set org.gnome.desktop.a11y.keyboard feature-state-change-beep false
gsettings set org.gnome.desktop.a11y.keyboard mousekeys-accel-time 300
gsettings set org.gnome.desktop.a11y.keyboard mousekeys-enable false
gsettings set org.gnome.desktop.a11y.keyboard mousekeys-init-delay 300
gsettings set org.gnome.desktop.a11y.keyboard mousekeys-max-speed 10
gsettings set org.gnome.desktop.a11y.keyboard slowkeys-beep-accept false
gsettings set org.gnome.desktop.a11y.keyboard slowkeys-beep-press false
gsettings set org.gnome.desktop.a11y.keyboard slowkeys-beep-reject false
gsettings set org.gnome.desktop.a11y.keyboard slowkeys-delay 300
gsettings set org.gnome.desktop.a11y.keyboard slowkeys-enable false
gsettings set org.gnome.desktop.a11y.keyboard stickykeys-enable false
gsettings set org.gnome.desktop.a11y.keyboard stickykeys-modifier-beep false
gsettings set org.gnome.desktop.a11y.keyboard stickykeys-two-key-off false
gsettings set org.gnome.desktop.a11y.keyboard timeout-enable false
gsettings set org.gnome.desktop.a11y.keyboard togglekeys-enable false
gsettings set org.gnome.desktop.a11y.magnifier brightness-blue 0.0
gsettings set org.gnome.desktop.a11y.magnifier brightness-green 0.0
gsettings set org.gnome.desktop.a11y.magnifier brightness-red 0.0
gsettings set org.gnome.desktop.a11y.magnifier caret-tracking 'centered'
gsettings set org.gnome.desktop.a11y.magnifier color-saturation 1.0
gsettings set org.gnome.desktop.a11y.magnifier contrast-blue 0.0
gsettings set org.gnome.desktop.a11y.magnifier contrast-green 0.0
gsettings set org.gnome.desktop.a11y.magnifier contrast-red 0.0
gsettings set org.gnome.desktop.a11y.magnifier cross-hairs-clip false
gsettings set org.gnome.desktop.a11y.magnifier cross-hairs-color '#ff0000'
gsettings set org.gnome.desktop.a11y.magnifier cross-hairs-length 4096
gsettings set org.gnome.desktop.a11y.magnifier cross-hairs-opacity 0.66000000000000003
gsettings set org.gnome.desktop.a11y.magnifier cross-hairs-thickness 8
gsettings set org.gnome.desktop.a11y.magnifier focus-tracking 'proportional'
gsettings set org.gnome.desktop.a11y.magnifier invert-lightness false
gsettings set org.gnome.desktop.a11y.magnifier lens-mode false
gsettings set org.gnome.desktop.a11y.magnifier mag-factor 2.0
gsettings set org.gnome.desktop.a11y.magnifier mouse-tracking 'proportional'
gsettings set org.gnome.desktop.a11y.magnifier screen-position 'full-screen'
gsettings set org.gnome.desktop.a11y.magnifier scroll-at-edges false
gsettings set org.gnome.desktop.a11y.magnifier show-cross-hairs false
gsettings set org.gnome.desktop.a11y.mouse click-type-window-visible true
gsettings set org.gnome.desktop.a11y.mouse dwell-click-enabled false
gsettings set org.gnome.desktop.a11y.mouse dwell-gesture-double 'up'
gsettings set org.gnome.desktop.a11y.mouse dwell-gesture-secondary 'right'
gsettings set org.gnome.desktop.a11y.mouse dwell-gesture-single 'left'
gsettings set org.gnome.desktop.a11y.mouse dwell-mode 'window'
gsettings set org.gnome.desktop.a11y.mouse dwell-threshold 10
gsettings set org.gnome.desktop.a11y.mouse dwell-time 1.2
gsettings set org.gnome.desktop.a11y.mouse secondary-click-enabled false
gsettings set org.gnome.desktop.a11y.mouse secondary-click-time 1.2
gsettings set org.gnome.desktop.app-folders folder-children ['Utilities', 'YaST', 'Pardus']
gsettings set org.gnome.desktop.background color-shading-type 'solid'
gsettings set org.gnome.desktop.background picture-opacity 100
gsettings set org.gnome.desktop.background picture-options 'zoom'
gsettings set org.gnome.desktop.background picture-uri 'file:///home/algus/Pictures/BingWallpaper/20240624-FloresIsland_ROW5747422444_UHD.jpg'
gsettings set org.gnome.desktop.background picture-uri-dark 'file:///home/algus/Pictures/BingWallpaper/20240624-FloresIsland_ROW5747422444_UHD.jpg'
gsettings set org.gnome.desktop.background primary-color '#000000'
gsettings set org.gnome.desktop.background secondary-color '#000000'
gsettings set org.gnome.desktop.background show-desktop-icons true
gsettings set org.gnome.desktop.calendar show-weekdate false
gsettings set org.gnome.desktop.datetime automatic-timezone false
gsettings set org.gnome.desktop.default-applications.office.calendar exec 'evolution -c calendar'
gsettings set org.gnome.desktop.default-applications.office.calendar needs-term false
gsettings set org.gnome.desktop.default-applications.office.tasks exec 'evolution -c tasks'
gsettings set org.gnome.desktop.default-applications.office.tasks needs-term false
gsettings set org.gnome.desktop.default-applications.terminal exec 'x-terminal-emulator'
gsettings set org.gnome.desktop.default-applications.terminal exec-arg '-e'
gsettings set org.gnome.desktop.input-sources current uint32 0
gsettings set org.gnome.desktop.input-sources mru-sources [('xkb', 'ru'), ('xkb', 'us'), ('xkb', 'by')]
gsettings set org.gnome.desktop.input-sources per-window true
gsettings set org.gnome.desktop.input-sources show-all-sources false
gsettings set org.gnome.desktop.input-sources sources [('xkb', 'us'), ('xkb', 'ru'), ('xkb', 'by')]
gsettings set org.gnome.desktop.input-sources xkb-model 'pc105+inet'
gsettings set org.gnome.desktop.input-sources xkb-options @as []
gsettings set org.gnome.desktop.interface avatar-directories @as []
gsettings set org.gnome.desktop.interface can-change-accels false
gsettings set org.gnome.desktop.interface clock-format '24h'
gsettings set org.gnome.desktop.interface clock-show-date true
gsettings set org.gnome.desktop.interface clock-show-seconds false
gsettings set org.gnome.desktop.interface clock-show-weekday false
gsettings set org.gnome.desktop.interface color-scheme 'default'
gsettings set org.gnome.desktop.interface cursor-blink true
gsettings set org.gnome.desktop.interface cursor-blink-time 1200
gsettings set org.gnome.desktop.interface cursor-blink-timeout 10
gsettings set org.gnome.desktop.interface cursor-size 24
gsettings set org.gnome.desktop.interface cursor-theme 'Yaru'
gsettings set org.gnome.desktop.interface document-font-name 'Sans 11'
gsettings set org.gnome.desktop.interface enable-animations true
gsettings set org.gnome.desktop.interface enable-hot-corners false
gsettings set org.gnome.desktop.interface font-hinting 'slight'
gsettings set org.gnome.desktop.interface font-name 'Ubuntu Sans 11'
gsettings set org.gnome.desktop.interface font-rgba-order 'rgb'
gsettings set org.gnome.desktop.interface gtk-color-palette 'black:white:gray50:red:purple:blue:light blue:green:yellow:orange:lavender:brown:goldenrod4:dodger blue:pink:light green:gray10:gray30:gray75:gray90'
gsettings set org.gnome.desktop.interface gtk-color-scheme ''
gsettings set org.gnome.desktop.interface gtk-enable-primary-paste true
gsettings set org.gnome.desktop.interface gtk-im-module ''
gsettings set org.gnome.desktop.interface gtk-im-preedit-style 'callback'
gsettings set org.gnome.desktop.interface gtk-im-status-style 'callback'
gsettings set org.gnome.desktop.interface gtk-key-theme 'Default'
gsettings set org.gnome.desktop.interface gtk-theme 'Yaru-blue'
gsettings set org.gnome.desktop.interface gtk-timeout-initial 200
gsettings set org.gnome.desktop.interface gtk-timeout-repeat 20
gsettings set org.gnome.desktop.interface icon-theme 'Yaru-blue'
gsettings set org.gnome.desktop.interface locate-pointer false
gsettings set org.gnome.desktop.interface menubar-accel 'F10'
gsettings set org.gnome.desktop.interface menubar-detachable false
gsettings set org.gnome.desktop.interface menus-have-tearoff false
gsettings set org.gnome.desktop.interface monospace-font-name 'Ubuntu Sans Mono 13'
gsettings set org.gnome.desktop.interface overlay-scrolling true
gsettings set org.gnome.desktop.interface scaling-factor uint32 0
gsettings set org.gnome.desktop.interface show-battery-percentage false
gsettings set org.gnome.desktop.interface text-scaling-factor 1.0
gsettings set org.gnome.desktop.interface toolbar-detachable false
gsettings set org.gnome.desktop.interface toolbar-style 'both-horiz'
gsettings set org.gnome.desktop.interface toolkit-accessibility false
gsettings set org.gnome.desktop.lockdown disable-application-handlers false
gsettings set org.gnome.desktop.lockdown disable-command-line false
gsettings set org.gnome.desktop.lockdown disable-lock-screen false
gsettings set org.gnome.desktop.lockdown disable-log-out false
gsettings set org.gnome.desktop.lockdown disable-print-setup false
gsettings set org.gnome.desktop.lockdown disable-printing false
gsettings set org.gnome.desktop.lockdown disable-save-to-disk false
gsettings set org.gnome.desktop.lockdown disable-show-password false
gsettings set org.gnome.desktop.lockdown disable-user-switching false
gsettings set org.gnome.desktop.lockdown mount-removable-storage-devices-as-read-only false
gsettings set org.gnome.desktop.lockdown user-administration-disabled false
gsettings set org.gnome.desktop.media-handling automount true
gsettings set org.gnome.desktop.media-handling automount-open true
gsettings set org.gnome.desktop.media-handling autorun-never true
gsettings set org.gnome.desktop.media-handling autorun-x-content-ignore @as []
gsettings set org.gnome.desktop.media-handling autorun-x-content-open-folder @as []
gsettings set org.gnome.desktop.media-handling autorun-x-content-start-app ['x-content/unix-software', 'x-content/ostree-repository']
gsettings set org.gnome.desktop.notifications application-children ['firefox-firefox', 'org-gnome-software', 'google-chrome', 'brave-browser', 'org-telegram-desktop', 'brave-cinhimbnkkaeohfgghhklpknlkffjgod-default', 'brave-dkchcgoomeofdpnkacmnmihkohcfmlch-default', 'brave-iiilmjpnmlnkgkmeihhnbdgihleogmnh-default', 'org-gnome-settings', 'brave-cifhbcnohmdccbgoicgdjpfamggdegmo-default', 'code-url-handler', 'org-telegram-desktop-1c524053184d93ed746764b234bea203', 'org-gnome-shell-extensions-gsconnect', 'brave-faolnafnngnfdaknnbpnkhgohbobgegn-default', 'com-slack-slack', 'com-gexperts-tilix', 'dev-warp-warp', 'org-gnome-characters', 'org-gnome-nautilus', 'ca-desrt-dconf-editor']
gsettings set org.gnome.desktop.notifications show-banners true
gsettings set org.gnome.desktop.notifications show-in-lock-screen true
gsettings set org.gnome.desktop.peripherals.keyboard delay uint32 500
gsettings set org.gnome.desktop.peripherals.keyboard numlock-state false
gsettings set org.gnome.desktop.peripherals.keyboard remember-numlock-state true
gsettings set org.gnome.desktop.peripherals.keyboard repeat true
gsettings set org.gnome.desktop.peripherals.keyboard repeat-interval uint32 30
gsettings set org.gnome.desktop.peripherals.mouse accel-profile 'flat'
gsettings set org.gnome.desktop.peripherals.mouse double-click 400
gsettings set org.gnome.desktop.peripherals.mouse drag-threshold 8
gsettings set org.gnome.desktop.peripherals.mouse left-handed false
gsettings set org.gnome.desktop.peripherals.mouse middle-click-emulation false
gsettings set org.gnome.desktop.peripherals.mouse natural-scroll false
gsettings set org.gnome.desktop.peripherals.mouse speed -0.022900763358778664
gsettings set org.gnome.desktop.peripherals.pointingstick accel-profile 'default'
gsettings set org.gnome.desktop.peripherals.pointingstick scroll-method 'default'
gsettings set org.gnome.desktop.peripherals.pointingstick speed 0.0
gsettings set org.gnome.desktop.peripherals.touchpad accel-profile 'default'
gsettings set org.gnome.desktop.peripherals.touchpad click-method 'default'
gsettings set org.gnome.desktop.peripherals.touchpad disable-while-typing true
gsettings set org.gnome.desktop.peripherals.touchpad edge-scrolling-enabled false
gsettings set org.gnome.desktop.peripherals.touchpad middle-click-emulation false
gsettings set org.gnome.desktop.peripherals.touchpad natural-scroll true
gsettings set org.gnome.desktop.peripherals.touchpad send-events 'enabled'
gsettings set org.gnome.desktop.peripherals.touchpad speed 0.0
gsettings set org.gnome.desktop.peripherals.touchpad tap-and-drag true
gsettings set org.gnome.desktop.peripherals.touchpad tap-and-drag-lock false
gsettings set org.gnome.desktop.peripherals.touchpad tap-button-map 'default'
gsettings set org.gnome.desktop.peripherals.touchpad tap-to-click true
gsettings set org.gnome.desktop.peripherals.touchpad two-finger-scrolling-enabled true
gsettings set org.gnome.desktop.peripherals.trackball accel-profile 'default'
gsettings set org.gnome.desktop.peripherals.trackball middle-click-emulation false
gsettings set org.gnome.desktop.peripherals.trackball scroll-wheel-emulation-button 0
gsettings set org.gnome.desktop.peripherals.trackball scroll-wheel-emulation-button-lock false
gsettings set org.gnome.desktop.privacy disable-camera false
gsettings set org.gnome.desktop.privacy disable-microphone false
gsettings set org.gnome.desktop.privacy disable-sound-output false
gsettings set org.gnome.desktop.privacy hide-identity false
gsettings set org.gnome.desktop.privacy old-files-age uint32 30
gsettings set org.gnome.desktop.privacy privacy-screen false
gsettings set org.gnome.desktop.privacy recent-files-max-age -1
gsettings set org.gnome.desktop.privacy remember-app-usage true
gsettings set org.gnome.desktop.privacy remember-recent-files true
gsettings set org.gnome.desktop.privacy remove-old-temp-files false
gsettings set org.gnome.desktop.privacy remove-old-trash-files false
gsettings set org.gnome.desktop.privacy report-technical-problems false
gsettings set org.gnome.desktop.privacy send-software-usage-stats false
gsettings set org.gnome.desktop.privacy show-full-name-in-top-bar true
gsettings set org.gnome.desktop.privacy usb-protection true
gsettings set org.gnome.desktop.privacy usb-protection-level 'lockscreen'
gsettings set org.gnome.desktop.remote-desktop.rdp enable false
gsettings set org.gnome.desktop.remote-desktop.rdp negotiate-port true
gsettings set org.gnome.desktop.remote-desktop.rdp port uint16 3389
gsettings set org.gnome.desktop.remote-desktop.rdp screen-share-mode 'mirror-primary'
gsettings set org.gnome.desktop.remote-desktop.rdp tls-cert ''
gsettings set org.gnome.desktop.remote-desktop.rdp tls-key ''
gsettings set org.gnome.desktop.remote-desktop.rdp view-only true
gsettings set org.gnome.desktop.remote-desktop.vnc auth-method 'prompt'
gsettings set org.gnome.desktop.remote-desktop.vnc enable false
gsettings set org.gnome.desktop.remote-desktop.vnc negotiate-port false
gsettings set org.gnome.desktop.remote-desktop.vnc port uint16 5900
gsettings set org.gnome.desktop.remote-desktop.vnc screen-share-mode 'mirror-primary'
gsettings set org.gnome.desktop.remote-desktop.vnc view-only true
gsettings set org.gnome.desktop.screensaver color-shading-type 'solid'
gsettings set org.gnome.desktop.screensaver embedded-keyboard-command ''
gsettings set org.gnome.desktop.screensaver embedded-keyboard-enabled false
gsettings set org.gnome.desktop.screensaver idle-activation-enabled true
gsettings set org.gnome.desktop.screensaver lock-delay uint32 3600
gsettings set org.gnome.desktop.screensaver lock-enabled true
gsettings set org.gnome.desktop.screensaver logout-command ''
gsettings set org.gnome.desktop.screensaver logout-delay uint32 7200
gsettings set org.gnome.desktop.screensaver logout-enabled false
gsettings set org.gnome.desktop.screensaver picture-opacity 100
gsettings set org.gnome.desktop.screensaver picture-options 'zoom'
gsettings set org.gnome.desktop.screensaver picture-uri 'file:///usr/share/backgrounds/Fuji_san_by_amaral.png'
gsettings set org.gnome.desktop.screensaver primary-color '#000000'
gsettings set org.gnome.desktop.screensaver secondary-color '#000000'
gsettings set org.gnome.desktop.screensaver show-full-name-in-top-bar true
gsettings set org.gnome.desktop.screensaver status-message-enabled true
gsettings set org.gnome.desktop.screensaver ubuntu-lock-on-suspend true
gsettings set org.gnome.desktop.screensaver user-switch-enabled true
gsettings set org.gnome.desktop.search-providers disable-external false
gsettings set org.gnome.desktop.search-providers disabled ['org.gnome.Terminal.desktop']
gsettings set org.gnome.desktop.search-providers enabled @as []
gsettings set org.gnome.desktop.search-providers sort-order ['org.gnome.Contacts.desktop', 'org.gnome.Documents.desktop', 'org.gnome.Nautilus.desktop']
gsettings set org.gnome.desktop.session idle-delay uint32 0
gsettings set org.gnome.desktop.session session-name 'ubuntu'
gsettings set org.gnome.desktop.sound allow-volume-above-100-percent false
gsettings set org.gnome.desktop.sound event-sounds true
gsettings set org.gnome.desktop.sound input-feedback-sounds true
gsettings set org.gnome.desktop.sound theme-name 'Yaru'
gsettings set org.gnome.desktop.thumbnail-cache maximum-age 180
gsettings set org.gnome.desktop.thumbnail-cache maximum-size 512
gsettings set org.gnome.desktop.thumbnailers disable @as []
gsettings set org.gnome.desktop.thumbnailers disable-all false
gsettings set org.gnome.desktop.wm.keybindings activate-window-menu ['<Alt>space']
gsettings set org.gnome.desktop.wm.keybindings always-on-top @as []
gsettings set org.gnome.desktop.wm.keybindings begin-move ['<Alt>F7']
gsettings set org.gnome.desktop.wm.keybindings begin-resize ['<Alt>F8']
gsettings set org.gnome.desktop.wm.keybindings close ['<Super>n']
gsettings set org.gnome.desktop.wm.keybindings cycle-group ['<Alt>F6']
gsettings set org.gnome.desktop.wm.keybindings cycle-group-backward ['<Shift><Alt>F6']
gsettings set org.gnome.desktop.wm.keybindings cycle-panels ['<Control><Alt>Escape']
gsettings set org.gnome.desktop.wm.keybindings cycle-panels-backward ['<Shift><Control><Alt>Escape']
gsettings set org.gnome.desktop.wm.keybindings cycle-windows ['<Alt>Escape']
gsettings set org.gnome.desktop.wm.keybindings cycle-windows-backward ['<Shift><Alt>Escape']
gsettings set org.gnome.desktop.wm.keybindings lower @as []
gsettings set org.gnome.desktop.wm.keybindings maximize @as []
gsettings set org.gnome.desktop.wm.keybindings maximize-horizontally @as []
gsettings set org.gnome.desktop.wm.keybindings maximize-vertically @as []
gsettings set org.gnome.desktop.wm.keybindings minimize ['<Super>comma']
gsettings set org.gnome.desktop.wm.keybindings move-to-center @as []
gsettings set org.gnome.desktop.wm.keybindings move-to-corner-ne @as []
gsettings set org.gnome.desktop.wm.keybindings move-to-corner-nw @as []
gsettings set org.gnome.desktop.wm.keybindings move-to-corner-se @as []
gsettings set org.gnome.desktop.wm.keybindings move-to-corner-sw @as []
gsettings set org.gnome.desktop.wm.keybindings move-to-monitor-down ['<Super><Shift>Down']
gsettings set org.gnome.desktop.wm.keybindings move-to-monitor-left ['<Super><Shift>Left']
gsettings set org.gnome.desktop.wm.keybindings move-to-monitor-right ['<Super><Shift>Right']
gsettings set org.gnome.desktop.wm.keybindings move-to-monitor-up ['<Super><Shift>Up']
gsettings set org.gnome.desktop.wm.keybindings move-to-side-e @as []
gsettings set org.gnome.desktop.wm.keybindings move-to-side-n @as []
gsettings set org.gnome.desktop.wm.keybindings move-to-side-s @as []
gsettings set org.gnome.desktop.wm.keybindings move-to-side-w @as []
gsettings set org.gnome.desktop.wm.keybindings move-to-workspace-1 @as []
gsettings set org.gnome.desktop.wm.keybindings move-to-workspace-10 @as []
gsettings set org.gnome.desktop.wm.keybindings move-to-workspace-11 @as []
gsettings set org.gnome.desktop.wm.keybindings move-to-workspace-12 @as []
gsettings set org.gnome.desktop.wm.keybindings move-to-workspace-2 @as []
gsettings set org.gnome.desktop.wm.keybindings move-to-workspace-3 @as []
gsettings set org.gnome.desktop.wm.keybindings move-to-workspace-4 @as []
gsettings set org.gnome.desktop.wm.keybindings move-to-workspace-5 @as []
gsettings set org.gnome.desktop.wm.keybindings move-to-workspace-6 @as []
gsettings set org.gnome.desktop.wm.keybindings move-to-workspace-7 @as []
gsettings set org.gnome.desktop.wm.keybindings move-to-workspace-8 @as []
gsettings set org.gnome.desktop.wm.keybindings move-to-workspace-9 @as []
gsettings set org.gnome.desktop.wm.keybindings move-to-workspace-down ['<Control><Shift><Alt>Down']
gsettings set org.gnome.desktop.wm.keybindings move-to-workspace-last ['<Super><Shift>End']
gsettings set org.gnome.desktop.wm.keybindings move-to-workspace-left ['<Super><Shift>Page_Up', '<Super><Shift><Alt>Left', '<Control><Shift><Alt>Left']
gsettings set org.gnome.desktop.wm.keybindings move-to-workspace-right ['<Super><Shift>Page_Down', '<Super><Shift><Alt>Right', '<Control><Shift><Alt>Right']
gsettings set org.gnome.desktop.wm.keybindings move-to-workspace-up ['<Control><Shift><Alt>Up']
gsettings set org.gnome.desktop.wm.keybindings panel-main-menu ['<Alt>F1']
gsettings set org.gnome.desktop.wm.keybindings panel-run-dialog ['<Alt>F2']
gsettings set org.gnome.desktop.wm.keybindings raise @as []
gsettings set org.gnome.desktop.wm.keybindings raise-or-lower @as []
gsettings set org.gnome.desktop.wm.keybindings set-spew-mark @as []
gsettings set org.gnome.desktop.wm.keybindings show-desktop ['<Primary><Super>d', '<Primary><Alt>d']
gsettings set org.gnome.desktop.wm.keybindings switch-applications ['<Super>Tab']
gsettings set org.gnome.desktop.wm.keybindings switch-applications-backward ['<Shift><Super>Tab']
gsettings set org.gnome.desktop.wm.keybindings switch-group ['<Super>Above_Tab', '<Alt>Above_Tab']
gsettings set org.gnome.desktop.wm.keybindings switch-group-backward ['<Shift><Super>Above_Tab', '<Shift><Alt>Above_Tab']
gsettings set org.gnome.desktop.wm.keybindings switch-input-source ['<Super>space', 'XF86Keyboard']
gsettings set org.gnome.desktop.wm.keybindings switch-input-source-backward ['<Shift><Super>space', '<Shift>XF86Keyboard']
gsettings set org.gnome.desktop.wm.keybindings switch-panels ['<Control><Alt>Tab']
gsettings set org.gnome.desktop.wm.keybindings switch-panels-backward ['<Shift><Control><Alt>Tab']
gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-1 @as []
gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-10 @as []
gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-11 @as []
gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-12 @as []
gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-2 @as []
gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-3 @as []
gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-4 @as []
gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-5 @as []
gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-6 @as []
gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-7 @as []
gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-8 @as []
gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-9 @as []
gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-down ['<Control><Alt>Down']
gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-last ['<Super>End']
gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-left ['<Super>Page_Up', '<Super><Alt>Left', '<Control><Alt>Left']
gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-right ['<Super>Page_Down', '<Super><Alt>Right', '<Control><Alt>Right']
gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-up ['<Control><Alt>Up']
gsettings set org.gnome.desktop.wm.keybindings switch-windows ['<Alt>Tab']
gsettings set org.gnome.desktop.wm.keybindings switch-windows-backward ['<Shift><Alt>Tab']
gsettings set org.gnome.desktop.wm.keybindings toggle-above @as []
gsettings set org.gnome.desktop.wm.keybindings toggle-fullscreen @as []
gsettings set org.gnome.desktop.wm.keybindings toggle-maximized @as []
gsettings set org.gnome.desktop.wm.keybindings toggle-on-all-workspaces @as []
gsettings set org.gnome.desktop.wm.keybindings unmaximize @as []
gsettings set org.gnome.desktop.wm.preferences action-double-click-titlebar 'toggle-maximize'
gsettings set org.gnome.desktop.wm.preferences action-middle-click-titlebar 'lower'
gsettings set org.gnome.desktop.wm.preferences audible-bell true
gsettings set org.gnome.desktop.wm.preferences auto-raise false
gsettings set org.gnome.desktop.wm.preferences auto-raise-delay 500
gsettings set org.gnome.desktop.wm.preferences button-layout ':minimize,maximize,close'
gsettings set org.gnome.desktop.wm.preferences disable-workarounds false
gsettings set org.gnome.desktop.wm.preferences focus-mode 'click'
gsettings set org.gnome.desktop.wm.preferences focus-new-windows 'smart'
gsettings set org.gnome.desktop.wm.preferences mouse-button-modifier '<Super>'
gsettings set org.gnome.desktop.wm.preferences num-workspaces 4
gsettings set org.gnome.desktop.wm.preferences raise-on-click true
gsettings set org.gnome.desktop.wm.preferences resize-with-right-button false
gsettings set org.gnome.desktop.wm.preferences theme 'Adwaita'
gsettings set org.gnome.desktop.wm.preferences titlebar-font 'Ubuntu Sans Bold 11'
gsettings set org.gnome.desktop.wm.preferences titlebar-uses-system-font false
gsettings set org.gnome.desktop.wm.preferences visual-bell false
gsettings set org.gnome.desktop.wm.preferences visual-bell-type 'fullscreen-flash'
gsettings set org.gnome.desktop.wm.preferences workspace-names @as []
gsettings set org.gnome.eog.fullscreen loop true
gsettings set org.gnome.eog.fullscreen seconds 5
gsettings set org.gnome.eog.fullscreen upscale true
gsettings set org.gnome.eog.plugins active-plugins ['fullscreen']
gsettings set org.gnome.eog.ui disable-close-confirmation false
gsettings set org.gnome.eog.ui disable-trash-confirmation false
gsettings set org.gnome.eog.ui filechooser-xdg-fallback true
gsettings set org.gnome.eog.ui image-gallery false
gsettings set org.gnome.eog.ui image-gallery-position 'bottom'
gsettings set org.gnome.eog.ui image-gallery-resizable false
gsettings set org.gnome.eog.ui scroll-buttons true
gsettings set org.gnome.eog.ui sidebar false
gsettings set org.gnome.eog.ui statusbar false
gsettings set org.gnome.eog.view autorotate true
gsettings set org.gnome.eog.view background-color '#000000'
gsettings set org.gnome.eog.view extrapolate true
gsettings set org.gnome.eog.view interpolate true
gsettings set org.gnome.eog.view scroll-wheel-zoom true
gsettings set org.gnome.eog.view trans-color '#000000'
gsettings set org.gnome.eog.view transparency 'checked'
gsettings set org.gnome.eog.view use-background-color true
gsettings set org.gnome.eog.view zoom-multiplier 0.050000000000000003
gsettings set org.gnome.evolution-data-server autoconfig-directory ''
gsettings set org.gnome.evolution-data-server autoconfig-variables ['']
gsettings set org.gnome.evolution-data-server camel-cipher-load-photos true
gsettings set org.gnome.evolution-data-server camel-gpg-binary ''
gsettings set org.gnome.evolution-data-server camel-message-info-user-headers @as []
gsettings set org.gnome.evolution-data-server camel-smtp-helo-argument ''
gsettings set org.gnome.evolution-data-server limit-operations-in-power-saver-mode false
gsettings set org.gnome.evolution-data-server migrated true
gsettings set org.gnome.evolution-data-server network-monitor-gio-name ''
gsettings set org.gnome.evolution-data-server oauth2-google-client-id ''
gsettings set org.gnome.evolution-data-server oauth2-google-client-secret ''
gsettings set org.gnome.evolution-data-server oauth2-outlook-client-id ''
gsettings set org.gnome.evolution-data-server oauth2-outlook-client-secret ''
gsettings set org.gnome.evolution-data-server oauth2-services-hint ['']
gsettings set org.gnome.evolution-data-server oauth2-yahoo-client-id ''
gsettings set org.gnome.evolution-data-server oauth2-yahoo-client-secret ''
gsettings set org.gnome.evolution-data-server.addressbook self-contact-uid ''
gsettings set org.gnome.evolution-data-server.calendar contacts-reminder-enabled false
gsettings set org.gnome.evolution-data-server.calendar contacts-reminder-interval 15
gsettings set org.gnome.evolution-data-server.calendar contacts-reminder-units 'minutes'
gsettings set org.gnome.evolution-data-server.calendar defall-reminder-enabled false
gsettings set org.gnome.evolution-data-server.calendar defall-reminder-interval 15
gsettings set org.gnome.evolution-data-server.calendar defall-reminder-units 'minutes'
gsettings set org.gnome.evolution-data-server.calendar delete-meeting-on-decline true
gsettings set org.gnome.evolution-data-server.calendar notify-completed-tasks true
gsettings set org.gnome.evolution-data-server.calendar notify-custom-snooze-minutes @ai []
gsettings set org.gnome.evolution-data-server.calendar notify-enable-audio true
gsettings set org.gnome.evolution-data-server.calendar notify-enable-display true
gsettings set org.gnome.evolution-data-server.calendar notify-last-snooze-minutes 5
gsettings set org.gnome.evolution-data-server.calendar notify-past-events false
gsettings set org.gnome.evolution-data-server.calendar notify-programs @as []
gsettings set org.gnome.evolution-data-server.calendar notify-window-height -1
gsettings set org.gnome.evolution-data-server.calendar notify-window-on-top true
gsettings set org.gnome.evolution-data-server.calendar notify-window-paned-position -1
gsettings set org.gnome.evolution-data-server.calendar notify-window-width -1
gsettings set org.gnome.evolution-data-server.calendar notify-window-x -1
gsettings set org.gnome.evolution-data-server.calendar notify-window-y -1
gsettings set org.gnome.evolution-data-server.calendar notify-with-tray false
gsettings set org.gnome.evolution-data-server.calendar reminders-past ['']
gsettings set org.gnome.evolution-data-server.calendar reminders-past-days 7
gsettings set org.gnome.evolution-data-server.calendar reminders-snoozed ['']
gsettings set org.gnome.evolution.eds-shell start-offline false
gsettings set org.gnome.evolution.shell.network-config authentication-password ''
gsettings set org.gnome.evolution.shell.network-config authentication-user ''
gsettings set org.gnome.evolution.shell.network-config autoconfig-url ''
gsettings set org.gnome.evolution.shell.network-config http-host ''
gsettings set org.gnome.evolution.shell.network-config http-port 0
gsettings set org.gnome.evolution.shell.network-config ignore-hosts @as []
gsettings set org.gnome.evolution.shell.network-config proxy-type 0
gsettings set org.gnome.evolution.shell.network-config secure-host ''
gsettings set org.gnome.evolution.shell.network-config secure-port 0
gsettings set org.gnome.evolution.shell.network-config socks-host ''
gsettings set org.gnome.evolution.shell.network-config socks-port 0
gsettings set org.gnome.evolution.shell.network-config use-authentication false
gsettings set org.gnome.evolution.shell.network-config use-http-proxy false
gsettings set org.gnome.gnome-system-monitor cpu-colors [(uint32 0, '#e01b24'), (1, '#ff7800'), (2, '#f6d32d'), (3, '#33d17a'), (4, '#26a269'), (5, '#62a0ea'), (6, '#1c71d8'), (7, '#613583'), (8, '#9141ac'), (9, '#c061cb'), (10, '#ffbe6f'), (11, '#f9f06b'), (12, '#8ff0a4'), (13, '#2ec27e'), (14, '#1a5fb4'), (15, '#c061cb'), (16, '#f332e7a97999'), (17, '#c42e7999f332'), (18, '#7999f332a0b3'), (19, '#f3327d377999')]
gsettings set org.gnome.gnome-system-monitor cpu-smooth-graph true
gsettings set org.gnome.gnome-system-monitor cpu-stacked-area-chart false
gsettings set org.gnome.gnome-system-monitor current-tab 'processes'
gsettings set org.gnome.gnome-system-monitor disk-read-color '#3584e4'
gsettings set org.gnome.gnome-system-monitor disk-write-color '#e66100'
gsettings set org.gnome.gnome-system-monitor disks-interval 5000
gsettings set org.gnome.gnome-system-monitor graph-data-points 60
gsettings set org.gnome.gnome-system-monitor graph-update-interval 100
gsettings set org.gnome.gnome-system-monitor kill-dialog true
gsettings set org.gnome.gnome-system-monitor logarithmic-scale false
gsettings set org.gnome.gnome-system-monitor maximized false
gsettings set org.gnome.gnome-system-monitor mem-color '#e01b24'
gsettings set org.gnome.gnome-system-monitor net-in-color '#3584e4'
gsettings set org.gnome.gnome-system-monitor net-out-color '#e66100'
gsettings set org.gnome.gnome-system-monitor network-in-bits false
gsettings set org.gnome.gnome-system-monitor network-total-in-bits false
gsettings set org.gnome.gnome-system-monitor process-memory-in-iec false
gsettings set org.gnome.gnome-system-monitor resources-memory-in-iec false
gsettings set org.gnome.gnome-system-monitor show-all-fs false
gsettings set org.gnome.gnome-system-monitor show-dependencies false
gsettings set org.gnome.gnome-system-monitor show-whose-processes 'user'
gsettings set org.gnome.gnome-system-monitor smooth-refresh true
gsettings set org.gnome.gnome-system-monitor solaris-mode true
gsettings set org.gnome.gnome-system-monitor swap-color '#33d17a'
gsettings set org.gnome.gnome-system-monitor update-interval 3000
gsettings set org.gnome.gnome-system-monitor window-height 500
gsettings set org.gnome.gnome-system-monitor window-width 700
gsettings set org.gnome.gnome-system-monitor.disktreenew col-0-visible true
gsettings set org.gnome.gnome-system-monitor.disktreenew col-0-width 100
gsettings set org.gnome.gnome-system-monitor.disktreenew col-1-visible true
gsettings set org.gnome.gnome-system-monitor.disktreenew col-1-width 100
gsettings set org.gnome.gnome-system-monitor.disktreenew col-2-visible true
gsettings set org.gnome.gnome-system-monitor.disktreenew col-2-width 50
gsettings set org.gnome.gnome-system-monitor.disktreenew col-3-visible true
gsettings set org.gnome.gnome-system-monitor.disktreenew col-3-width 80
gsettings set org.gnome.gnome-system-monitor.disktreenew col-4-visible false
gsettings set org.gnome.gnome-system-monitor.disktreenew col-4-width 80
gsettings set org.gnome.gnome-system-monitor.disktreenew col-5-visible true
gsettings set org.gnome.gnome-system-monitor.disktreenew col-5-width 80
gsettings set org.gnome.gnome-system-monitor.disktreenew col-6-visible true
gsettings set org.gnome.gnome-system-monitor.disktreenew col-6-width 0
gsettings set org.gnome.gnome-system-monitor.disktreenew columns-order [6]
gsettings set org.gnome.gnome-system-monitor.disktreenew sort-col 1
gsettings set org.gnome.gnome-system-monitor.disktreenew sort-order 0
gsettings set org.gnome.gnome-system-monitor.memmapstree sort-col 0
gsettings set org.gnome.gnome-system-monitor.memmapstree sort-order 0
gsettings set org.gnome.gnome-system-monitor.openfilestree sort-col 0
gsettings set org.gnome.gnome-system-monitor.openfilestree sort-order 0
gsettings set org.gnome.gnome-system-monitor.proctree col-0-visible true
gsettings set org.gnome.gnome-system-monitor.proctree col-0-width 225
gsettings set org.gnome.gnome-system-monitor.proctree col-1-visible true
gsettings set org.gnome.gnome-system-monitor.proctree col-1-width 98
gsettings set org.gnome.gnome-system-monitor.proctree col-10-visible false
gsettings set org.gnome.gnome-system-monitor.proctree col-10-width 70
gsettings set org.gnome.gnome-system-monitor.proctree col-11-visible false
gsettings set org.gnome.gnome-system-monitor.proctree col-11-width 48
gsettings set org.gnome.gnome-system-monitor.proctree col-12-visible true
gsettings set org.gnome.gnome-system-monitor.proctree col-12-width 60
gsettings set org.gnome.gnome-system-monitor.proctree col-13-visible false
gsettings set org.gnome.gnome-system-monitor.proctree col-13-width 80
gsettings set org.gnome.gnome-system-monitor.proctree col-14-visible false
gsettings set org.gnome.gnome-system-monitor.proctree col-14-width 120
gsettings set org.gnome.gnome-system-monitor.proctree col-15-visible true
gsettings set org.gnome.gnome-system-monitor.proctree col-15-width 80
gsettings set org.gnome.gnome-system-monitor.proctree col-16-visible false
gsettings set org.gnome.gnome-system-monitor.proctree col-16-width 48
gsettings set org.gnome.gnome-system-monitor.proctree col-17-visible false
gsettings set org.gnome.gnome-system-monitor.proctree col-17-width 48
gsettings set org.gnome.gnome-system-monitor.proctree col-18-visible false
gsettings set org.gnome.gnome-system-monitor.proctree col-18-width 70
gsettings set org.gnome.gnome-system-monitor.proctree col-19-visible false
gsettings set org.gnome.gnome-system-monitor.proctree col-19-width 41
gsettings set org.gnome.gnome-system-monitor.proctree col-2-visible false
gsettings set org.gnome.gnome-system-monitor.proctree col-2-width 37
gsettings set org.gnome.gnome-system-monitor.proctree col-20-visible false
gsettings set org.gnome.gnome-system-monitor.proctree col-20-width 59
gsettings set org.gnome.gnome-system-monitor.proctree col-21-visible false
gsettings set org.gnome.gnome-system-monitor.proctree col-21-width 59
gsettings set org.gnome.gnome-system-monitor.proctree col-22-visible true
gsettings set org.gnome.gnome-system-monitor.proctree col-22-width 100
gsettings set org.gnome.gnome-system-monitor.proctree col-23-visible true
gsettings set org.gnome.gnome-system-monitor.proctree col-23-width 100
gsettings set org.gnome.gnome-system-monitor.proctree col-24-visible true
gsettings set org.gnome.gnome-system-monitor.proctree col-24-width 100
gsettings set org.gnome.gnome-system-monitor.proctree col-25-visible true
gsettings set org.gnome.gnome-system-monitor.proctree col-25-width 100
gsettings set org.gnome.gnome-system-monitor.proctree col-26-visible true
gsettings set org.gnome.gnome-system-monitor.proctree col-26-width 100
gsettings set org.gnome.gnome-system-monitor.proctree col-3-visible false
gsettings set org.gnome.gnome-system-monitor.proctree col-3-width 90
gsettings set org.gnome.gnome-system-monitor.proctree col-4-visible false
gsettings set org.gnome.gnome-system-monitor.proctree col-4-width 90
gsettings set org.gnome.gnome-system-monitor.proctree col-5-visible false
gsettings set org.gnome.gnome-system-monitor.proctree col-5-width 90
gsettings set org.gnome.gnome-system-monitor.proctree col-6-visible false
gsettings set org.gnome.gnome-system-monitor.proctree col-6-width 90
gsettings set org.gnome.gnome-system-monitor.proctree col-7-visible false
gsettings set org.gnome.gnome-system-monitor.proctree col-7-width 90
gsettings set org.gnome.gnome-system-monitor.proctree col-8-visible true
gsettings set org.gnome.gnome-system-monitor.proctree col-8-width 71
gsettings set org.gnome.gnome-system-monitor.proctree col-9-visible false
gsettings set org.gnome.gnome-system-monitor.proctree col-9-width 80
gsettings set org.gnome.gnome-system-monitor.proctree columns-order [0]
gsettings set org.gnome.gnome-system-monitor.proctree sort-col 0
gsettings set org.gnome.gnome-system-monitor.proctree sort-order 0
gsettings set org.gnome.libgnomekbd.desktop default-group -1
gsettings set org.gnome.libgnomekbd.desktop group-per-window false
gsettings set org.gnome.libgnomekbd.desktop handle-indicators false
gsettings set org.gnome.libgnomekbd.desktop layout-names-as-group-names true
gsettings set org.gnome.libgnomekbd.desktop load-extra-items false
gsettings set org.gnome.libgnomekbd.indicator background-color ''
gsettings set org.gnome.libgnomekbd.indicator font-family ''
gsettings set org.gnome.libgnomekbd.indicator font-size 10
gsettings set org.gnome.libgnomekbd.indicator foreground-color ''
gsettings set org.gnome.libgnomekbd.indicator secondary 0
gsettings set org.gnome.libgnomekbd.indicator show-flags false
gsettings set org.gnome.libgnomekbd.keyboard layouts @as []
gsettings set org.gnome.libgnomekbd.keyboard model ''
gsettings set org.gnome.libgnomekbd.keyboard options @as []
gsettings set org.gnome.libgnomekbd.preview height -1
gsettings set org.gnome.libgnomekbd.preview width -1
gsettings set org.gnome.libgnomekbd.preview x -1
gsettings set org.gnome.libgnomekbd.preview y -1
gsettings set org.gnome.login-screen allowed-failures 3
gsettings set org.gnome.login-screen banner-message-enable false
gsettings set org.gnome.login-screen banner-message-text ''
gsettings set org.gnome.login-screen disable-restart-buttons false
gsettings set org.gnome.login-screen disable-user-list false
gsettings set org.gnome.login-screen enable-fingerprint-authentication true
gsettings set org.gnome.login-screen enable-password-authentication true
gsettings set org.gnome.login-screen enable-smartcard-authentication true
gsettings set org.gnome.login-screen fallback-logo ''
gsettings set org.gnome.login-screen logo '/usr/share/plymouth/ubuntu-logo.png'
gsettings set org.gnome.mousetweaks click-type-window-geometry ''
gsettings set org.gnome.mutter attach-modal-dialogs true
gsettings set org.gnome.mutter auto-maximize true
gsettings set org.gnome.mutter center-new-windows true
gsettings set org.gnome.mutter check-alive-timeout uint32 5000
gsettings set org.gnome.mutter draggable-border-width 10
gsettings set org.gnome.mutter dynamic-workspaces true
gsettings set org.gnome.mutter edge-tiling false
gsettings set org.gnome.mutter experimental-features @as []
gsettings set org.gnome.mutter focus-change-on-pointer-rest true
gsettings set org.gnome.mutter locate-pointer-key 'Control_L'
gsettings set org.gnome.mutter overlay-key ''
gsettings set org.gnome.mutter workspaces-only-on-primary false
gsettings set org.gnome.mutter.keybindings cancel-input-capture ['<Super><Shift>Escape']
gsettings set org.gnome.mutter.keybindings rotate-monitor ['XF86RotateWindows']
gsettings set org.gnome.mutter.keybindings switch-monitor ['<Super>p', 'XF86Display']
gsettings set org.gnome.mutter.keybindings toggle-tiled-left ['<Super>Left']
gsettings set org.gnome.mutter.keybindings toggle-tiled-right ['<Super>Right']
gsettings set org.gnome.mutter.wayland xwayland-allow-byte-swapped-clients false
gsettings set org.gnome.mutter.wayland xwayland-allow-grabs false
gsettings set org.gnome.mutter.wayland xwayland-disable-extension @as []
gsettings set org.gnome.mutter.wayland xwayland-grab-access-rules @as []
gsettings set org.gnome.mutter.wayland.keybindings restore-shortcuts @as []
gsettings set org.gnome.mutter.wayland.keybindings switch-to-session-1 ['<Primary><Alt>F1']
gsettings set org.gnome.mutter.wayland.keybindings switch-to-session-10 ['<Primary><Alt>F10']
gsettings set org.gnome.mutter.wayland.keybindings switch-to-session-11 ['<Primary><Alt>F11']
gsettings set org.gnome.mutter.wayland.keybindings switch-to-session-12 ['<Primary><Alt>F12']
gsettings set org.gnome.mutter.wayland.keybindings switch-to-session-2 ['<Primary><Alt>F2']
gsettings set org.gnome.mutter.wayland.keybindings switch-to-session-3 ['<Primary><Alt>F3']
gsettings set org.gnome.mutter.wayland.keybindings switch-to-session-4 ['<Primary><Alt>F4']
gsettings set org.gnome.mutter.wayland.keybindings switch-to-session-5 ['<Primary><Alt>F5']
gsettings set org.gnome.mutter.wayland.keybindings switch-to-session-6 ['<Primary><Alt>F6']
gsettings set org.gnome.mutter.wayland.keybindings switch-to-session-7 ['<Primary><Alt>F7']
gsettings set org.gnome.mutter.wayland.keybindings switch-to-session-8 ['<Primary><Alt>F8']
gsettings set org.gnome.mutter.wayland.keybindings switch-to-session-9 ['<Primary><Alt>F9']
gsettings set org.gnome.nautilus.compression default-compression-format 'zip'
gsettings set org.gnome.nautilus.icon-view captions ['none', 'none', 'none']
gsettings set org.gnome.nautilus.icon-view default-zoom-level 'small'
gsettings set org.gnome.nautilus.list-view default-column-order ['name', 'size', 'type', 'owner', 'group', 'permissions', 'mime_type', 'where', 'date_modified', 'date_modified_with_time', 'date_accessed', 'date_created', 'recency', 'starred']
gsettings set org.gnome.nautilus.list-view default-visible-columns ['name', 'size', 'date_modified']
gsettings set org.gnome.nautilus.list-view default-zoom-level 'medium'
gsettings set org.gnome.nautilus.list-view use-tree-view false
gsettings set org.gnome.nautilus.preferences always-use-location-entry false
gsettings set org.gnome.nautilus.preferences date-time-format 'simple'
gsettings set org.gnome.nautilus.preferences default-folder-viewer 'list-view'
gsettings set org.gnome.nautilus.preferences default-sort-in-reverse-order false
gsettings set org.gnome.nautilus.preferences default-sort-order 'name'
gsettings set org.gnome.nautilus.preferences fts-enabled true
gsettings set org.gnome.nautilus.preferences install-mime-activation true
gsettings set org.gnome.nautilus.preferences migrated-gtk-settings true
gsettings set org.gnome.nautilus.preferences mouse-back-button uint32 8
gsettings set org.gnome.nautilus.preferences mouse-forward-button uint32 9
gsettings set org.gnome.nautilus.preferences mouse-use-extra-buttons true
gsettings set org.gnome.nautilus.preferences open-folder-on-dnd-hover false
gsettings set org.gnome.nautilus.preferences recursive-search 'local-only'
gsettings set org.gnome.nautilus.preferences search-filter-time-type 'last_modified'
gsettings set org.gnome.nautilus.preferences show-create-link false
gsettings set org.gnome.nautilus.preferences show-delete-permanently false
gsettings set org.gnome.nautilus.preferences show-directory-item-counts 'local-only'
gsettings set org.gnome.nautilus.preferences show-hidden-files false
gsettings set org.gnome.nautilus.preferences show-image-thumbnails 'local-only'
gsettings set org.gnome.nautilus.preferences thumbnail-limit uint64 50
gsettings set org.gnome.nautilus.window-state initial-size (875, 601)
gsettings set org.gnome.nautilus.window-state maximized false
gsettings set org.gnome.nm-applet disable-connected-notifications false
gsettings set org.gnome.nm-applet disable-disconnected-notifications false
gsettings set org.gnome.nm-applet disable-vpn-notifications false
gsettings set org.gnome.nm-applet disable-wifi-create false
gsettings set org.gnome.nm-applet show-applet true
gsettings set org.gnome.nm-applet stamp 0
gsettings set org.gnome.nm-applet suppress-broadband-unlock-prompt false
gsettings set org.gnome.nm-applet suppress-wireless-networks-available false
gsettings set org.gnome.online-accounts whitelisted-providers ['all']
gsettings set org.gnome.power-manager info-history-graph-points true
gsettings set org.gnome.power-manager info-history-graph-smooth true
gsettings set org.gnome.power-manager info-history-time 21600
gsettings set org.gnome.power-manager info-history-type 'power'
gsettings set org.gnome.power-manager info-last-device ''
gsettings set org.gnome.power-manager info-page-number 0
gsettings set org.gnome.power-manager info-stats-graph-points true
gsettings set org.gnome.power-manager info-stats-graph-smooth true
gsettings set org.gnome.power-manager info-stats-type 'power'
gsettings set org.gnome.seahorse last-search-servers @as []
gsettings set org.gnome.seahorse last-search-text ''
gsettings set org.gnome.seahorse server-auto-publish false
gsettings set org.gnome.seahorse server-auto-retrieve false
gsettings set org.gnome.seahorse server-publish-to ''
gsettings set org.gnome.seahorse.manager item-filter 'personal'
gsettings set org.gnome.seahorse.manager keyrings-selected ['gnupg://']
gsettings set org.gnome.seahorse.manager show-expiry false
gsettings set org.gnome.seahorse.manager show-trust false
gsettings set org.gnome.seahorse.manager show-type false
gsettings set org.gnome.seahorse.manager show-validity false
gsettings set org.gnome.seahorse.manager sidebar-visible true
gsettings set org.gnome.seahorse.manager sidebar-width 148
gsettings set org.gnome.seahorse.manager sort-by 'name'
gsettings set org.gnome.settings-daemon.peripherals.keyboard bell-custom-file ''
gsettings set org.gnome.settings-daemon.peripherals.keyboard bell-duration 100
gsettings set org.gnome.settings-daemon.peripherals.keyboard bell-mode 'on'
gsettings set org.gnome.settings-daemon.peripherals.keyboard bell-pitch 400
gsettings set org.gnome.settings-daemon.peripherals.keyboard click true
gsettings set org.gnome.settings-daemon.peripherals.keyboard click-volume 0
gsettings set org.gnome.settings-daemon.peripherals.smartcard removal-action 'none'
gsettings set org.gnome.settings-daemon.peripherals.touchscreen orientation-lock false
gsettings set org.gnome.settings-daemon.plugins whitelisted-plugins ['all']
gsettings set org.gnome.settings-daemon.plugins.color night-light-enabled false
gsettings set org.gnome.settings-daemon.plugins.color night-light-last-coordinates (91.0, 181.0)
gsettings set org.gnome.settings-daemon.plugins.color night-light-schedule-automatic true
gsettings set org.gnome.settings-daemon.plugins.color night-light-schedule-from 20.0
gsettings set org.gnome.settings-daemon.plugins.color night-light-schedule-to 6.0
gsettings set org.gnome.settings-daemon.plugins.color night-light-temperature uint32 2700
gsettings set org.gnome.settings-daemon.plugins.color recalibrate-display-threshold uint32 0
gsettings set org.gnome.settings-daemon.plugins.color recalibrate-printer-threshold uint32 0
gsettings set org.gnome.settings-daemon.plugins.housekeeping free-percent-notify 0.050000000000000003
gsettings set org.gnome.settings-daemon.plugins.housekeeping free-percent-notify-again 0.01
gsettings set org.gnome.settings-daemon.plugins.housekeeping free-size-gb-no-notify 1
gsettings set org.gnome.settings-daemon.plugins.housekeeping ignore-paths @as []
gsettings set org.gnome.settings-daemon.plugins.housekeeping min-notify-period 10
gsettings set org.gnome.settings-daemon.plugins.media-keys battery-status ['']
gsettings set org.gnome.settings-daemon.plugins.media-keys battery-status-static ['XF86Battery']
gsettings set org.gnome.settings-daemon.plugins.media-keys calculator ['']
gsettings set org.gnome.settings-daemon.plugins.media-keys calculator-static ['XF86Calculator']
gsettings set org.gnome.settings-daemon.plugins.media-keys control-center ['']
gsettings set org.gnome.settings-daemon.plugins.media-keys control-center-static ['XF86Tools']
gsettings set org.gnome.settings-daemon.plugins.media-keys custom-keybindings @as []
gsettings set org.gnome.settings-daemon.plugins.media-keys decrease-text-size ['']
gsettings set org.gnome.settings-daemon.plugins.media-keys eject ['']
gsettings set org.gnome.settings-daemon.plugins.media-keys eject-static ['XF86Eject']
gsettings set org.gnome.settings-daemon.plugins.media-keys email ['']
gsettings set org.gnome.settings-daemon.plugins.media-keys email-static ['XF86Mail']
gsettings set org.gnome.settings-daemon.plugins.media-keys help ['', '<Super>F1']
gsettings set org.gnome.settings-daemon.plugins.media-keys hibernate ['']
gsettings set org.gnome.settings-daemon.plugins.media-keys hibernate-static ['XF86Suspend', 'XF86Hibernate']
gsettings set org.gnome.settings-daemon.plugins.media-keys home ['']
gsettings set org.gnome.settings-daemon.plugins.media-keys home-static ['XF86Explorer']
gsettings set org.gnome.settings-daemon.plugins.media-keys increase-text-size ['']
gsettings set org.gnome.settings-daemon.plugins.media-keys keyboard-brightness-down ['']
gsettings set org.gnome.settings-daemon.plugins.media-keys keyboard-brightness-down-static ['XF86KbdBrightnessDown']
gsettings set org.gnome.settings-daemon.plugins.media-keys keyboard-brightness-toggle ['']
gsettings set org.gnome.settings-daemon.plugins.media-keys keyboard-brightness-toggle-static ['XF86KbdLightOnOff']
gsettings set org.gnome.settings-daemon.plugins.media-keys keyboard-brightness-up ['']
gsettings set org.gnome.settings-daemon.plugins.media-keys keyboard-brightness-up-static ['XF86KbdBrightnessUp']
gsettings set org.gnome.settings-daemon.plugins.media-keys logout ['<Control><Alt>Delete']
gsettings set org.gnome.settings-daemon.plugins.media-keys magnifier ['<Alt><Super>8']
gsettings set org.gnome.settings-daemon.plugins.media-keys magnifier-zoom-in ['<Alt><Super>equal']
gsettings set org.gnome.settings-daemon.plugins.media-keys magnifier-zoom-out ['<Alt><Super>minus']
gsettings set org.gnome.settings-daemon.plugins.media-keys media ['']
gsettings set org.gnome.settings-daemon.plugins.media-keys media-static ['XF86AudioMedia']
gsettings set org.gnome.settings-daemon.plugins.media-keys mic-mute ['']
gsettings set org.gnome.settings-daemon.plugins.media-keys mic-mute-static ['XF86AudioMicMute']
gsettings set org.gnome.settings-daemon.plugins.media-keys next ['']
gsettings set org.gnome.settings-daemon.plugins.media-keys next-static ['XF86AudioNext', '<Ctrl>XF86AudioNext']
gsettings set org.gnome.settings-daemon.plugins.media-keys on-screen-keyboard ['']
gsettings set org.gnome.settings-daemon.plugins.media-keys pause ['']
gsettings set org.gnome.settings-daemon.plugins.media-keys pause-static ['XF86AudioPause']
gsettings set org.gnome.settings-daemon.plugins.media-keys play ['']
gsettings set org.gnome.settings-daemon.plugins.media-keys play-static ['XF86AudioPlay', '<Ctrl>XF86AudioPlay']
gsettings set org.gnome.settings-daemon.plugins.media-keys playback-forward ['']
gsettings set org.gnome.settings-daemon.plugins.media-keys playback-forward-static ['XF86AudioForward']
gsettings set org.gnome.settings-daemon.plugins.media-keys playback-random ['']
gsettings set org.gnome.settings-daemon.plugins.media-keys playback-random-static ['XF86AudioRandomPlay']
gsettings set org.gnome.settings-daemon.plugins.media-keys playback-repeat ['']
gsettings set org.gnome.settings-daemon.plugins.media-keys playback-repeat-static ['XF86AudioRepeat']
gsettings set org.gnome.settings-daemon.plugins.media-keys playback-rewind ['']
gsettings set org.gnome.settings-daemon.plugins.media-keys playback-rewind-static ['XF86AudioRewind']
gsettings set org.gnome.settings-daemon.plugins.media-keys power ['']
gsettings set org.gnome.settings-daemon.plugins.media-keys power-static ['XF86PowerOff']
gsettings set org.gnome.settings-daemon.plugins.media-keys previous ['']
gsettings set org.gnome.settings-daemon.plugins.media-keys previous-static ['XF86AudioPrev', '<Ctrl>XF86AudioPrev']
gsettings set org.gnome.settings-daemon.plugins.media-keys rfkill ['']
gsettings set org.gnome.settings-daemon.plugins.media-keys rfkill-bluetooth ['']
gsettings set org.gnome.settings-daemon.plugins.media-keys rfkill-bluetooth-static ['XF86Bluetooth']
gsettings set org.gnome.settings-daemon.plugins.media-keys rfkill-static ['XF86WLAN', 'XF86UWB', 'XF86RFKill']
gsettings set org.gnome.settings-daemon.plugins.media-keys rotate-video-lock ['']
gsettings set org.gnome.settings-daemon.plugins.media-keys rotate-video-lock-static ['<Super>o', 'XF86RotationLockToggle']
gsettings set org.gnome.settings-daemon.plugins.media-keys screen-brightness-cycle ['']
gsettings set org.gnome.settings-daemon.plugins.media-keys screen-brightness-cycle-static ['XF86MonBrightnessCycle']
gsettings set org.gnome.settings-daemon.plugins.media-keys screen-brightness-down ['']
gsettings set org.gnome.settings-daemon.plugins.media-keys screen-brightness-down-static ['XF86MonBrightnessDown']
gsettings set org.gnome.settings-daemon.plugins.media-keys screen-brightness-up ['']
gsettings set org.gnome.settings-daemon.plugins.media-keys screen-brightness-up-static ['XF86MonBrightnessUp']
gsettings set org.gnome.settings-daemon.plugins.media-keys screenreader ['<Alt><Super>s']
gsettings set org.gnome.settings-daemon.plugins.media-keys screensaver ['<Super>l']
gsettings set org.gnome.settings-daemon.plugins.media-keys screensaver-static ['XF86ScreenSaver']
gsettings set org.gnome.settings-daemon.plugins.media-keys search ['']
gsettings set org.gnome.settings-daemon.plugins.media-keys search-static ['XF86Search']
gsettings set org.gnome.settings-daemon.plugins.media-keys stop ['']
gsettings set org.gnome.settings-daemon.plugins.media-keys stop-static ['XF86AudioStop']
gsettings set org.gnome.settings-daemon.plugins.media-keys suspend ['']
gsettings set org.gnome.settings-daemon.plugins.media-keys suspend-static ['XF86Sleep']
gsettings set org.gnome.settings-daemon.plugins.media-keys terminal ['<Primary><Alt>t']
gsettings set org.gnome.settings-daemon.plugins.media-keys toggle-contrast ['']
gsettings set org.gnome.settings-daemon.plugins.media-keys touchpad-off ['']
gsettings set org.gnome.settings-daemon.plugins.media-keys touchpad-off-static ['XF86TouchpadOff']
gsettings set org.gnome.settings-daemon.plugins.media-keys touchpad-on ['']
gsettings set org.gnome.settings-daemon.plugins.media-keys touchpad-on-static ['XF86TouchpadOn']
gsettings set org.gnome.settings-daemon.plugins.media-keys touchpad-toggle ['']
gsettings set org.gnome.settings-daemon.plugins.media-keys touchpad-toggle-static ['XF86TouchpadToggle', '<Ctrl><Super>XF86TouchpadToggle']
gsettings set org.gnome.settings-daemon.plugins.media-keys volume-down ['']
gsettings set org.gnome.settings-daemon.plugins.media-keys volume-down-precise ['']
gsettings set org.gnome.settings-daemon.plugins.media-keys volume-down-precise-static ['<Shift>XF86AudioLowerVolume', '<Ctrl><Shift>XF86AudioLowerVolume']
gsettings set org.gnome.settings-daemon.plugins.media-keys volume-down-quiet ['']
gsettings set org.gnome.settings-daemon.plugins.media-keys volume-down-quiet-static ['<Alt>XF86AudioLowerVolume', '<Alt><Ctrl>XF86AudioLowerVolume']
gsettings set org.gnome.settings-daemon.plugins.media-keys volume-down-static ['XF86AudioLowerVolume', '<Ctrl>XF86AudioLowerVolume']
gsettings set org.gnome.settings-daemon.plugins.media-keys volume-mute ['']
gsettings set org.gnome.settings-daemon.plugins.media-keys volume-mute-quiet ['']
gsettings set org.gnome.settings-daemon.plugins.media-keys volume-mute-quiet-static ['<Alt>XF86AudioMute']
gsettings set org.gnome.settings-daemon.plugins.media-keys volume-mute-static ['XF86AudioMute']
gsettings set org.gnome.settings-daemon.plugins.media-keys volume-step 6
gsettings set org.gnome.settings-daemon.plugins.media-keys volume-up ['']
gsettings set org.gnome.settings-daemon.plugins.media-keys volume-up-precise ['']
gsettings set org.gnome.settings-daemon.plugins.media-keys volume-up-precise-static ['<Shift>XF86AudioRaiseVolume', '<Ctrl><Shift>XF86AudioRaiseVolume']
gsettings set org.gnome.settings-daemon.plugins.media-keys volume-up-quiet ['']
gsettings set org.gnome.settings-daemon.plugins.media-keys volume-up-quiet-static ['<Alt>XF86AudioRaiseVolume', '<Alt><Ctrl>XF86AudioRaiseVolume']
gsettings set org.gnome.settings-daemon.plugins.media-keys volume-up-static ['XF86AudioRaiseVolume', '<Ctrl>XF86AudioRaiseVolume']
gsettings set org.gnome.settings-daemon.plugins.media-keys www ['']
gsettings set org.gnome.settings-daemon.plugins.media-keys www-static ['XF86WWW']
gsettings set org.gnome.settings-daemon.plugins.power ambient-enabled true
gsettings set org.gnome.settings-daemon.plugins.power idle-brightness 30
gsettings set org.gnome.settings-daemon.plugins.power idle-dim true
gsettings set org.gnome.settings-daemon.plugins.power lid-close-ac-action 'suspend'
gsettings set org.gnome.settings-daemon.plugins.power lid-close-battery-action 'suspend'
gsettings set org.gnome.settings-daemon.plugins.power lid-close-suspend-with-external-monitor false
gsettings set org.gnome.settings-daemon.plugins.power power-saver-profile-on-low-battery true
gsettings set org.gnome.settings-daemon.plugins.power sleep-inactive-ac-timeout 3600
gsettings set org.gnome.settings-daemon.plugins.power sleep-inactive-ac-type 'nothing'
gsettings set org.gnome.settings-daemon.plugins.power sleep-inactive-battery-timeout 900
gsettings set org.gnome.settings-daemon.plugins.power sleep-inactive-battery-type 'suspend'
gsettings set org.gnome.settings-daemon.plugins.wwan unlock-sim false
gsettings set org.gnome.settings-daemon.plugins.xsettings disabled-gtk-modules @as []
gsettings set org.gnome.settings-daemon.plugins.xsettings enabled-gtk-modules @as []
gsettings set org.gnome.settings-daemon.plugins.xsettings overrides @a{sv} {}
gsettings set org.gnome.shell allow-extension-installation true
gsettings set org.gnome.shell always-show-log-out true
gsettings set org.gnome.shell app-picker-layout [{'org.gnome.Geary.desktop': <{'position': <0>}>, 'org.gnome.Contacts.desktop': <{'position': <1>}>, 'org.gnome.Weather.desktop': <{'position': <2>}>, 'org.gnome.clocks.desktop': <{'position': <3>}>, 'org.gnome.Maps.desktop': <{'position': <4>}>, 'org.gnome.Books.desktop': <{'position': <5>}>, 'org.gnome.Photos.desktop': <{'position': <6>}>, 'org.gnome.Totem.desktop': <{'position': <7>}>, 'org.gnome.Calculator.desktop': <{'position': <8>}>, 'org.gnome.gedit.desktop': <{'position': <9>}>, 'simple-scan.desktop': <{'position': <10>}>, 'org.gnome.Settings.desktop': <{'position': <11>}>, 'org.gnome.SystemMonitor.desktop': <{'position': <12>}>, 'org.gnome.Boxes.desktop': <{'position': <13>}>, 'org.gnome.Terminal.desktop': <{'position': <14>}>, 'Utilities': <{'position': <15>}>, 'org.gnome.Characters.desktop': <{'position': <16>}>, 'yelp.desktop': <{'position': <17>}>, 'org.gnome.Screenshot.desktop': <{'position': <18>}>, 'org.gnome.Cheese.desktop': <{'position': <19>}>, 'org.gnome.font-viewer.desktop': <{'position': <20>}>}]
gsettings set org.gnome.shell command-history ['r', 'lg']
gsettings set org.gnome.shell development-tools true
gsettings set org.gnome.shell disable-extension-version-validation false
gsettings set org.gnome.shell disable-user-extensions false
gsettings set org.gnome.shell disabled-extensions @as []
gsettings set org.gnome.shell enabled-extensions ['ding@rastersoft.com', 'ubuntu-dock@ubuntu.com', 'tophat@fflewddur.github.io', 'monitor@astraext.github.io', 'clipboard-history@alexsaveau.dev', 'gsconnect@andyholmes.github.io', 'weekstartmodifier@saccuzm.gmail.com', 'picture-of-the-day@swsnr.de', 'unblank@sun.wxg@gmail.com', 'unlockDialogBackground@sun.wxg@gmail.com', 'BingWallpaper@ineffable-gmail.com', 'hide-cursor@elcste.com', 'dim-background-windows@stephane-13.github.com', 'tiling-assistant@ubuntu.com']
gsettings set org.gnome.shell favorite-apps ['brave-browser.desktop', 'dev.warp.Warp.desktop', 'dev.zed.Zed-Dev.desktop', 'brave-iiilmjpnmlnkgkmeihhnbdgihleogmnh-Default.desktop', 'org.telegram.desktop.desktop', 'org.keepassxc.KeePassXC.desktop', 'com.slack.Slack.desktop', 'com.discordapp.Discord.desktop']
gsettings set org.gnome.shell last-selected-power-profile 'performance'
gsettings set org.gnome.shell looking-glass-history @as []
gsettings set org.gnome.shell remember-mount-password false
gsettings set org.gnome.shell welcome-dialog-last-shown-version '46.0'
gsettings set org.gnome.shell.app-switcher current-workspace-only true
gsettings set org.gnome.shell.extensions.appindicator custom-icons @a(sss) []
gsettings set org.gnome.shell.extensions.appindicator icon-brightness 0.0
gsettings set org.gnome.shell.extensions.appindicator icon-contrast 0.0
gsettings set org.gnome.shell.extensions.appindicator icon-opacity 240
gsettings set org.gnome.shell.extensions.appindicator icon-saturation 0.0
gsettings set org.gnome.shell.extensions.appindicator icon-size 0
gsettings set org.gnome.shell.extensions.appindicator icon-spacing 12
gsettings set org.gnome.shell.extensions.appindicator legacy-tray-enabled true
gsettings set org.gnome.shell.extensions.appindicator tray-order 1
gsettings set org.gnome.shell.extensions.appindicator tray-pos 'right'
gsettings set org.gnome.shell.extensions.dash-to-dock activate-single-window true
gsettings set org.gnome.shell.extensions.dash-to-dock always-center-icons false
gsettings set org.gnome.shell.extensions.dash-to-dock animate-show-apps true
gsettings set org.gnome.shell.extensions.dash-to-dock animation-time 0.20000000000000001
gsettings set org.gnome.shell.extensions.dash-to-dock app-ctrl-hotkey-1 ['<Ctrl><Super>1', '<Ctrl><Super>x']
gsettings set org.gnome.shell.extensions.dash-to-dock app-ctrl-hotkey-10 ['<Ctrl><Super>0']
gsettings set org.gnome.shell.extensions.dash-to-dock app-ctrl-hotkey-2 ['<Ctrl><Super>2', '<Ctrl><Super>c']
gsettings set org.gnome.shell.extensions.dash-to-dock app-ctrl-hotkey-3 ['<Ctrl><Super>3', '<Ctrl><Super>v']
gsettings set org.gnome.shell.extensions.dash-to-dock app-ctrl-hotkey-4 ['<Ctrl><Super>4', '<Ctrl><Super>s']
gsettings set org.gnome.shell.extensions.dash-to-dock app-ctrl-hotkey-5 ['<Ctrl><Super>5', '<Ctrl><Super>d']
gsettings set org.gnome.shell.extensions.dash-to-dock app-ctrl-hotkey-6 ['<Ctrl><Super>6', '<Ctrl><Super>f']
gsettings set org.gnome.shell.extensions.dash-to-dock app-ctrl-hotkey-7 ['<Ctrl><Super>7', '<Ctrl><Super>w']
gsettings set org.gnome.shell.extensions.dash-to-dock app-ctrl-hotkey-8 ['<Ctrl><Super>8', '<Ctrl><Super>e']
gsettings set org.gnome.shell.extensions.dash-to-dock app-ctrl-hotkey-9 ['<Ctrl><Super>9', '<Ctrl><Super>r']
gsettings set org.gnome.shell.extensions.dash-to-dock app-hotkey-1 ['<Super>1', '<Super>x']
gsettings set org.gnome.shell.extensions.dash-to-dock app-hotkey-10 ['<Super>0']
gsettings set org.gnome.shell.extensions.dash-to-dock app-hotkey-2 ['<Super>2', '<Super>c']
gsettings set org.gnome.shell.extensions.dash-to-dock app-hotkey-3 ['<Super>3', '<Super>v']
gsettings set org.gnome.shell.extensions.dash-to-dock app-hotkey-4 ['<Super>4', '<Super>s']
gsettings set org.gnome.shell.extensions.dash-to-dock app-hotkey-5 ['<Super>5', '<Super>d']
gsettings set org.gnome.shell.extensions.dash-to-dock app-hotkey-6 ['<Super>6', '<Super>f']
gsettings set org.gnome.shell.extensions.dash-to-dock app-hotkey-7 ['<Super>7', '<Super>w']
gsettings set org.gnome.shell.extensions.dash-to-dock app-hotkey-8 ['<Super>8', '<Super>e']
gsettings set org.gnome.shell.extensions.dash-to-dock app-hotkey-9 ['<Super>9', '<Super>r']
gsettings set org.gnome.shell.extensions.dash-to-dock app-shift-hotkey-1 ['<Shift><Super>1', '<Shift><Super>x']
gsettings set org.gnome.shell.extensions.dash-to-dock app-shift-hotkey-10 ['<Shift><Super>0']
gsettings set org.gnome.shell.extensions.dash-to-dock app-shift-hotkey-2 ['<Shift><Super>2', '<Shift><Super>c']
gsettings set org.gnome.shell.extensions.dash-to-dock app-shift-hotkey-3 ['<Shift><Super>3', '<Shift><Super>v']
gsettings set org.gnome.shell.extensions.dash-to-dock app-shift-hotkey-4 ['<Shift><Super>4', '<Shift><Super>s']
gsettings set org.gnome.shell.extensions.dash-to-dock app-shift-hotkey-5 ['<Shift><Super>5', '<Shift><Super>d']
gsettings set org.gnome.shell.extensions.dash-to-dock app-shift-hotkey-6 ['<Shift><Super>6', '<Shift><Super>f']
gsettings set org.gnome.shell.extensions.dash-to-dock app-shift-hotkey-7 ['<Shift><Super>7', '<Shift><Super>w']
gsettings set org.gnome.shell.extensions.dash-to-dock app-shift-hotkey-8 ['<Shift><Super>8', '<Shift><Super>e']
gsettings set org.gnome.shell.extensions.dash-to-dock app-shift-hotkey-9 ['<Shift><Super>9', '<Shift><Super>r']
gsettings set org.gnome.shell.extensions.dash-to-dock application-counter-overrides-notifications true
gsettings set org.gnome.shell.extensions.dash-to-dock apply-custom-theme false
gsettings set org.gnome.shell.extensions.dash-to-dock apply-glossy-effect true
gsettings set org.gnome.shell.extensions.dash-to-dock autohide true
gsettings set org.gnome.shell.extensions.dash-to-dock autohide-in-fullscreen false
gsettings set org.gnome.shell.extensions.dash-to-dock background-color '#ffffff'
gsettings set org.gnome.shell.extensions.dash-to-dock background-opacity 0.80000000000000004
gsettings set org.gnome.shell.extensions.dash-to-dock bolt-support true
gsettings set org.gnome.shell.extensions.dash-to-dock click-action 'focus-or-appspread'
gsettings set org.gnome.shell.extensions.dash-to-dock custom-background-color false
gsettings set org.gnome.shell.extensions.dash-to-dock custom-theme-customize-running-dots false
gsettings set org.gnome.shell.extensions.dash-to-dock custom-theme-running-dots-border-color '#ffffff'
gsettings set org.gnome.shell.extensions.dash-to-dock custom-theme-running-dots-border-width 0
gsettings set org.gnome.shell.extensions.dash-to-dock custom-theme-running-dots-color '#ffffff'
gsettings set org.gnome.shell.extensions.dash-to-dock custom-theme-shrink true
gsettings set org.gnome.shell.extensions.dash-to-dock customize-alphas false
gsettings set org.gnome.shell.extensions.dash-to-dock dance-urgent-applications true
gsettings set org.gnome.shell.extensions.dash-to-dock dash-max-icon-size 48
gsettings set org.gnome.shell.extensions.dash-to-dock default-windows-preview-to-open false
gsettings set org.gnome.shell.extensions.dash-to-dock disable-overview-on-startup true
gsettings set org.gnome.shell.extensions.dash-to-dock dock-fixed true
gsettings set org.gnome.shell.extensions.dash-to-dock extend-height true
gsettings set org.gnome.shell.extensions.dash-to-dock force-straight-corner false
gsettings set org.gnome.shell.extensions.dash-to-dock height-fraction 0.90000000000000002
gsettings set org.gnome.shell.extensions.dash-to-dock hide-delay 0.20000000000000001
gsettings set org.gnome.shell.extensions.dash-to-dock hide-tooltip false
gsettings set org.gnome.shell.extensions.dash-to-dock hot-keys true
gsettings set org.gnome.shell.extensions.dash-to-dock hotkeys-overlay false
gsettings set org.gnome.shell.extensions.dash-to-dock hotkeys-show-dock false
gsettings set org.gnome.shell.extensions.dash-to-dock icon-size-fixed true
gsettings set org.gnome.shell.extensions.dash-to-dock intellihide true
gsettings set org.gnome.shell.extensions.dash-to-dock intellihide-mode 'ALL_WINDOWS'
gsettings set org.gnome.shell.extensions.dash-to-dock isolate-locations true
gsettings set org.gnome.shell.extensions.dash-to-dock isolate-monitors false
gsettings set org.gnome.shell.extensions.dash-to-dock isolate-workspaces true
gsettings set org.gnome.shell.extensions.dash-to-dock manualhide false
gsettings set org.gnome.shell.extensions.dash-to-dock max-alpha 0.80000000000000004
gsettings set org.gnome.shell.extensions.dash-to-dock middle-click-action 'launch'
gsettings set org.gnome.shell.extensions.dash-to-dock min-alpha 0.20000000000000001
gsettings set org.gnome.shell.extensions.dash-to-dock minimize-shift true
gsettings set org.gnome.shell.extensions.dash-to-dock multi-monitor false
gsettings set org.gnome.shell.extensions.dash-to-dock preferred-monitor -2
gsettings set org.gnome.shell.extensions.dash-to-dock preferred-monitor-by-connector 'primary'
gsettings set org.gnome.shell.extensions.dash-to-dock pressure-threshold 100.0
gsettings set org.gnome.shell.extensions.dash-to-dock preview-size-scale 0.0
gsettings set org.gnome.shell.extensions.dash-to-dock require-pressure-to-show true
gsettings set org.gnome.shell.extensions.dash-to-dock running-indicator-dominant-color false
gsettings set org.gnome.shell.extensions.dash-to-dock running-indicator-style 'DOTS'
gsettings set org.gnome.shell.extensions.dash-to-dock scroll-switch-workspace true
gsettings set org.gnome.shell.extensions.dash-to-dock scroll-to-focused-application true
gsettings set org.gnome.shell.extensions.dash-to-dock shift-click-action 'launch'
gsettings set org.gnome.shell.extensions.dash-to-dock shift-middle-click-action 'minimize'
gsettings set org.gnome.shell.extensions.dash-to-dock shortcut ['<Super>q']
gsettings set org.gnome.shell.extensions.dash-to-dock shortcut-text '<Super>q'
gsettings set org.gnome.shell.extensions.dash-to-dock shortcut-timeout 2.0
gsettings set org.gnome.shell.extensions.dash-to-dock show-apps-always-in-the-edge true
gsettings set org.gnome.shell.extensions.dash-to-dock show-apps-at-top false
gsettings set org.gnome.shell.extensions.dash-to-dock show-delay 0.25
gsettings set org.gnome.shell.extensions.dash-to-dock show-dock-urgent-notify true
gsettings set org.gnome.shell.extensions.dash-to-dock show-favorites true
gsettings set org.gnome.shell.extensions.dash-to-dock show-icons-emblems true
gsettings set org.gnome.shell.extensions.dash-to-dock show-icons-notifications-counter true
gsettings set org.gnome.shell.extensions.dash-to-dock show-mounts true
gsettings set org.gnome.shell.extensions.dash-to-dock show-mounts-network true
gsettings set org.gnome.shell.extensions.dash-to-dock show-mounts-only-mounted false
gsettings set org.gnome.shell.extensions.dash-to-dock show-running true
gsettings set org.gnome.shell.extensions.dash-to-dock show-show-apps-button true
gsettings set org.gnome.shell.extensions.dash-to-dock show-trash true
gsettings set org.gnome.shell.extensions.dash-to-dock show-windows-preview true
gsettings set org.gnome.shell.extensions.dash-to-dock transparency-mode 'DEFAULT'
gsettings set org.gnome.shell.extensions.dash-to-dock unity-backlit-items false
gsettings set org.gnome.shell.extensions.dash-to-dock workspace-agnostic-urgent-windows true
gsettings set org.gnome.shell.extensions.ding add-volumes-opposite true
gsettings set org.gnome.shell.extensions.ding arrangeorder 'DESCENDINGNAME'
gsettings set org.gnome.shell.extensions.ding check-x11wayland true
gsettings set org.gnome.shell.extensions.ding dark-text-in-labels false
gsettings set org.gnome.shell.extensions.ding icon-size 'standard'
gsettings set org.gnome.shell.extensions.ding keep-arranged false
gsettings set org.gnome.shell.extensions.ding keep-stacked false
gsettings set org.gnome.shell.extensions.ding show-drop-place true
gsettings set org.gnome.shell.extensions.ding show-home false
gsettings set org.gnome.shell.extensions.ding show-link-emblem true
gsettings set org.gnome.shell.extensions.ding show-network-volumes false
gsettings set org.gnome.shell.extensions.ding show-trash false
gsettings set org.gnome.shell.extensions.ding show-volumes false
gsettings set org.gnome.shell.extensions.ding sort-special-folders false
gsettings set org.gnome.shell.extensions.ding unstackedtypes @as []
gsettings set org.gnome.shell.extensions.ding use-nemo false
gsettings set org.gnome.shell.extensions.tiling-assistant activate-layout0 @as []
gsettings set org.gnome.shell.extensions.tiling-assistant activate-layout1 @as []
gsettings set org.gnome.shell.extensions.tiling-assistant activate-layout10 @as []
gsettings set org.gnome.shell.extensions.tiling-assistant activate-layout11 @as []
gsettings set org.gnome.shell.extensions.tiling-assistant activate-layout12 @as []
gsettings set org.gnome.shell.extensions.tiling-assistant activate-layout13 @as []
gsettings set org.gnome.shell.extensions.tiling-assistant activate-layout14 @as []
gsettings set org.gnome.shell.extensions.tiling-assistant activate-layout15 @as []
gsettings set org.gnome.shell.extensions.tiling-assistant activate-layout16 @as []
gsettings set org.gnome.shell.extensions.tiling-assistant activate-layout17 @as []
gsettings set org.gnome.shell.extensions.tiling-assistant activate-layout18 @as []
gsettings set org.gnome.shell.extensions.tiling-assistant activate-layout19 @as []
gsettings set org.gnome.shell.extensions.tiling-assistant activate-layout2 @as []
gsettings set org.gnome.shell.extensions.tiling-assistant activate-layout3 @as []
gsettings set org.gnome.shell.extensions.tiling-assistant activate-layout4 @as []
gsettings set org.gnome.shell.extensions.tiling-assistant activate-layout5 @as []
gsettings set org.gnome.shell.extensions.tiling-assistant activate-layout6 @as []
gsettings set org.gnome.shell.extensions.tiling-assistant activate-layout7 @as []
gsettings set org.gnome.shell.extensions.tiling-assistant activate-layout8 @as []
gsettings set org.gnome.shell.extensions.tiling-assistant activate-layout9 @as []
gsettings set org.gnome.shell.extensions.tiling-assistant active-window-hint 1
gsettings set org.gnome.shell.extensions.tiling-assistant active-window-hint-border-size 5
gsettings set org.gnome.shell.extensions.tiling-assistant active-window-hint-color 'rgb(211,70,21)'
gsettings set org.gnome.shell.extensions.tiling-assistant active-window-hint-inner-border-size 0
gsettings set org.gnome.shell.extensions.tiling-assistant adapt-edge-tiling-to-favorite-layout false
gsettings set org.gnome.shell.extensions.tiling-assistant auto-tile @as []
gsettings set org.gnome.shell.extensions.tiling-assistant center-window ['<Super>y']
gsettings set org.gnome.shell.extensions.tiling-assistant debugging-free-rects @as []
gsettings set org.gnome.shell.extensions.tiling-assistant debugging-show-tiled-rects @as []
gsettings set org.gnome.shell.extensions.tiling-assistant default-move-mode 0
gsettings set org.gnome.shell.extensions.tiling-assistant disable-tile-groups false
gsettings set org.gnome.shell.extensions.tiling-assistant dynamic-keybinding-behavior 0
gsettings set org.gnome.shell.extensions.tiling-assistant enable-advanced-experimental-features false
gsettings set org.gnome.shell.extensions.tiling-assistant enable-hold-maximize-inverse-landscape false
gsettings set org.gnome.shell.extensions.tiling-assistant enable-hold-maximize-inverse-portrait false
gsettings set org.gnome.shell.extensions.tiling-assistant enable-raise-tile-group false
gsettings set org.gnome.shell.extensions.tiling-assistant enable-tile-animations true
gsettings set org.gnome.shell.extensions.tiling-assistant enable-tiling-popup false
gsettings set org.gnome.shell.extensions.tiling-assistant enable-untile-animations true
gsettings set org.gnome.shell.extensions.tiling-assistant favorite-layout -1
gsettings set org.gnome.shell.extensions.tiling-assistant favorite-layouts @as []
gsettings set org.gnome.shell.extensions.tiling-assistant horizontal-preview-area 15
gsettings set org.gnome.shell.extensions.tiling-assistant ignore-ta-mod 0
gsettings set org.gnome.shell.extensions.tiling-assistant import-layout-examples false
gsettings set org.gnome.shell.extensions.tiling-assistant last-version-installed 46
gsettings set org.gnome.shell.extensions.tiling-assistant low-performance-move-mode false
gsettings set org.gnome.shell.extensions.tiling-assistant maximize-with-gap false
gsettings set org.gnome.shell.extensions.tiling-assistant monitor-switch-grace-period true
gsettings set org.gnome.shell.extensions.tiling-assistant move-adaptive-tiling-mod 1
gsettings set org.gnome.shell.extensions.tiling-assistant move-favorite-layout-mod 2
gsettings set org.gnome.shell.extensions.tiling-assistant overridden-settings {'org.gnome.mutter.edge-tiling': <@mb nothing>}
gsettings set org.gnome.shell.extensions.tiling-assistant restore-window ['<Super>period']
gsettings set org.gnome.shell.extensions.tiling-assistant restore-window-size-on 0
gsettings set org.gnome.shell.extensions.tiling-assistant screen-bottom-gap 0
gsettings set org.gnome.shell.extensions.tiling-assistant screen-left-gap 0
gsettings set org.gnome.shell.extensions.tiling-assistant screen-right-gap 0
gsettings set org.gnome.shell.extensions.tiling-assistant screen-top-gap 0
gsettings set org.gnome.shell.extensions.tiling-assistant search-popup-layout @as []
gsettings set org.gnome.shell.extensions.tiling-assistant show-layout-panel-indicator false
gsettings set org.gnome.shell.extensions.tiling-assistant single-screen-gap 2
gsettings set org.gnome.shell.extensions.tiling-assistant tile-bottom-half @as []
gsettings set org.gnome.shell.extensions.tiling-assistant tile-bottom-half-ignore-ta @as []
gsettings set org.gnome.shell.extensions.tiling-assistant tile-bottomleft-quarter ['<Shift><Super>j']
gsettings set org.gnome.shell.extensions.tiling-assistant tile-bottomleft-quarter-ignore-ta @as []
gsettings set org.gnome.shell.extensions.tiling-assistant tile-bottomright-quarter ['<Shift><Super>k']
gsettings set org.gnome.shell.extensions.tiling-assistant tile-bottomright-quarter-ignore-ta @as []
gsettings set org.gnome.shell.extensions.tiling-assistant tile-edit-mode ['<Alt><Super>i']
gsettings set org.gnome.shell.extensions.tiling-assistant tile-left-half ['<Super>u']
gsettings set org.gnome.shell.extensions.tiling-assistant tile-left-half-ignore-ta @as []
gsettings set org.gnome.shell.extensions.tiling-assistant tile-maximize ['<Super>m']
gsettings set org.gnome.shell.extensions.tiling-assistant tile-maximize-horizontally @as []
gsettings set org.gnome.shell.extensions.tiling-assistant tile-maximize-vertically @as []
gsettings set org.gnome.shell.extensions.tiling-assistant tile-right-half ['<Super>i']
gsettings set org.gnome.shell.extensions.tiling-assistant tile-right-half-ignore-ta @as []
gsettings set org.gnome.shell.extensions.tiling-assistant tile-top-half @as []
gsettings set org.gnome.shell.extensions.tiling-assistant tile-top-half-ignore-ta @as []
gsettings set org.gnome.shell.extensions.tiling-assistant tile-topleft-quarter ['<Shift><Super>u']
gsettings set org.gnome.shell.extensions.tiling-assistant tile-topleft-quarter-ignore-ta @as []
gsettings set org.gnome.shell.extensions.tiling-assistant tile-topright-quarter ['<Shift><Super>i']
gsettings set org.gnome.shell.extensions.tiling-assistant tile-topright-quarter-ignore-ta @as []
gsettings set org.gnome.shell.extensions.tiling-assistant tilegroups-in-app-switcher false
gsettings set org.gnome.shell.extensions.tiling-assistant tiling-popup-all-workspace false
gsettings set org.gnome.shell.extensions.tiling-assistant toggle-always-on-top @as []
gsettings set org.gnome.shell.extensions.tiling-assistant toggle-maximize-tophalf-timer 600
gsettings set org.gnome.shell.extensions.tiling-assistant toggle-tiling-popup @as []
gsettings set org.gnome.shell.extensions.tiling-assistant vertical-preview-area 15
gsettings set org.gnome.shell.extensions.tiling-assistant window-gap 2
gsettings set org.gnome.shell.keybindings focus-active-notification @as []
gsettings set org.gnome.shell.keybindings open-new-window-application-1 ['<Super><Control>1']
gsettings set org.gnome.shell.keybindings open-new-window-application-2 ['<Super><Control>2']
gsettings set org.gnome.shell.keybindings open-new-window-application-3 ['<Super><Control>3']
gsettings set org.gnome.shell.keybindings open-new-window-application-4 ['<Super><Control>4']
gsettings set org.gnome.shell.keybindings open-new-window-application-5 ['<Super><Control>5']
gsettings set org.gnome.shell.keybindings open-new-window-application-6 ['<Super><Control>6']
gsettings set org.gnome.shell.keybindings open-new-window-application-7 ['<Super><Control>7']
gsettings set org.gnome.shell.keybindings open-new-window-application-8 ['<Super><Control>8']
gsettings set org.gnome.shell.keybindings open-new-window-application-9 ['<Super><Control>9']
gsettings set org.gnome.shell.keybindings screenshot ['<Shift>Print']
gsettings set org.gnome.shell.keybindings screenshot-window ['<Alt>Print']
gsettings set org.gnome.shell.keybindings shift-overview-down ['<Super><Alt>Down']
gsettings set org.gnome.shell.keybindings shift-overview-up ['<Super><Alt>Up']
gsettings set org.gnome.shell.keybindings show-screen-recording-ui ['<Ctrl><Shift><Alt>R']
gsettings set org.gnome.shell.keybindings show-screenshot-ui ['Print']
gsettings set org.gnome.shell.keybindings switch-to-application-1 ['<Super>1']
gsettings set org.gnome.shell.keybindings switch-to-application-2 ['<Super>2']
gsettings set org.gnome.shell.keybindings switch-to-application-3 ['<Super>3']
gsettings set org.gnome.shell.keybindings switch-to-application-4 ['<Super>4']
gsettings set org.gnome.shell.keybindings switch-to-application-5 ['<Super>5']
gsettings set org.gnome.shell.keybindings switch-to-application-6 ['<Super>6']
gsettings set org.gnome.shell.keybindings switch-to-application-7 ['<Super>7']
gsettings set org.gnome.shell.keybindings switch-to-application-8 ['<Super>8']
gsettings set org.gnome.shell.keybindings switch-to-application-9 ['<Super>9']
gsettings set org.gnome.shell.keybindings toggle-application-view ['<Super>a']
gsettings set org.gnome.shell.keybindings toggle-message-tray ['<Super>h']
gsettings set org.gnome.shell.keybindings toggle-overview ['<Super>Return']
gsettings set org.gnome.shell.keybindings toggle-quick-settings ['<Super>s']
gsettings set org.gnome.shell.ubuntu color-scheme 'default'
gsettings set org.gnome.shell.weather automatic-location false
gsettings set org.gnome.shell.weather locations @av []
gsettings set org.gnome.shell.window-switcher app-icon-mode 'app-icon-only'
gsettings set org.gnome.shell.window-switcher current-workspace-only true
gsettings set org.gnome.shell.world-clocks locations @av []
gsettings set org.gnome.software allow-updates true
gsettings set org.gnome.software check-timestamp int64 1719992431
gsettings set org.gnome.software compatible-projects ['GNOME', 'KDE', 'XFCE']
gsettings set org.gnome.software download-updates true
gsettings set org.gnome.software download-updates-notify true
gsettings set org.gnome.software enable-repos-dialog true
gsettings set org.gnome.software external-appstream-system-wide false
gsettings set org.gnome.software external-appstream-urls @as []
gsettings set org.gnome.software filter-default-branch true
gsettings set org.gnome.software first-run false
gsettings set org.gnome.software flatpak-purge-timestamp int64 1719995336
gsettings set org.gnome.software free-repos ['ubuntu-*-main', 'ubuntu-*-universe']
gsettings set org.gnome.software free-repos-url 'https://www.ubuntu.com/about/about-ubuntu/licensing'
gsettings set org.gnome.software install-bundles-system-wide true
gsettings set org.gnome.software install-timestamp int64 0
gsettings set org.gnome.software installed-page-show-size true
gsettings set org.gnome.software nonfree-software-uri 'https://en.wikipedia.org/wiki/Proprietary_software'
gsettings set org.gnome.software official-repos ['ubuntu-*']
gsettings set org.gnome.software packagekit-historical-updates-timestamp uint64 0
gsettings set org.gnome.software packaging-format-preference ['']
gsettings set org.gnome.software prompt-for-nonfree true
gsettings set org.gnome.software refresh-when-metered false
gsettings set org.gnome.software required-repos @as []
gsettings set org.gnome.software review-karma-required 0
gsettings set org.gnome.software review-server 'https://odrs.gnome.org/1.0/reviews/api'
gsettings set org.gnome.software screenshot-cache-age-maximum uint32 2592000
gsettings set org.gnome.software security-timestamp int64 0
gsettings set org.gnome.software show-nonfree-ui true
gsettings set org.gnome.software show-only-free-apps false
gsettings set org.gnome.software show-only-verified-apps false
gsettings set org.gnome.software show-ratings false
gsettings set org.gnome.software show-upgrade-prerelease false
gsettings set org.gnome.software update-notification-timestamp int64 0
gsettings set org.gnome.software upgrade-notification-timestamp int64 0
gsettings set org.gnome.system.dns_sd extra-domains ''
gsettings set org.gnome.system.locale region ''
gsettings set org.gnome.system.location enabled false
gsettings set org.gnome.system.proxy autoconfig-url ''
gsettings set org.gnome.system.proxy ignore-hosts ['localhost', '127.0.0.0/8', '::1']
gsettings set org.gnome.system.proxy mode 'none'
gsettings set org.gnome.system.proxy use-same-proxy true
gsettings set org.gnome.system.proxy.ftp host ''
gsettings set org.gnome.system.proxy.ftp port 0
gsettings set org.gnome.system.proxy.http authentication-password ''
gsettings set org.gnome.system.proxy.http authentication-user ''
gsettings set org.gnome.system.proxy.http enabled false
gsettings set org.gnome.system.proxy.http host ''
gsettings set org.gnome.system.proxy.http port 8080
gsettings set org.gnome.system.proxy.http use-authentication false
gsettings set org.gnome.system.proxy.https host ''
gsettings set org.gnome.system.proxy.https port 0
gsettings set org.gnome.system.proxy.socks host ''
gsettings set org.gnome.system.proxy.socks port 0
gsettings set org.gnome.system.smb workgroup ''
gsettings set org.gnome.yelp font-adjustment 0
gsettings set org.gnome.yelp show-cursor false
gsettings set org.gtk.Settings.ColorChooser custom-colors @a(dddd) []
gsettings set org.gtk.Settings.ColorChooser selected-color (false, 1.0, 1.0, 1.0, 1.0)
gsettings set org.gtk.Settings.Debug enable-inspector-keybinding false
gsettings set org.gtk.Settings.Debug inspector-warning true
gsettings set org.gtk.Settings.EmojiChooser recent-emoji @a((auss)u) []
gsettings set org.gtk.Settings.FileChooser clock-format '24h'
gsettings set org.gtk.Settings.FileChooser date-format 'regular'
gsettings set org.gtk.Settings.FileChooser expand-folders false
gsettings set org.gtk.Settings.FileChooser last-folder-uri ''
gsettings set org.gtk.Settings.FileChooser location-mode 'path-bar'
gsettings set org.gtk.Settings.FileChooser show-hidden false
gsettings set org.gtk.Settings.FileChooser show-size-column true
gsettings set org.gtk.Settings.FileChooser show-type-column true
gsettings set org.gtk.Settings.FileChooser sidebar-width 160
gsettings set org.gtk.Settings.FileChooser sort-column 'name'
gsettings set org.gtk.Settings.FileChooser sort-directories-first true
gsettings set org.gtk.Settings.FileChooser window-position (26, 23)
gsettings set org.gtk.Settings.FileChooser window-size (1203, 902)
gsettings set org.gtk.gtk4.Settings.ColorChooser custom-colors [(0.75, 0.25, 0.25, 1.0)]
gsettings set org.gtk.gtk4.Settings.ColorChooser selected-color (true, 1.0, 0.63921570777893066, 0.28235295414924622, 1.0)
gsettings set org.gtk.gtk4.Settings.Debug enable-inspector-keybinding true
gsettings set org.gtk.gtk4.Settings.Debug inspector-warning true
gsettings set org.gtk.gtk4.Settings.EmojiChooser recently-used-emoji @a((aussasasu)u) []
gsettings set org.gtk.gtk4.Settings.FileChooser clock-format '24h'
gsettings set org.gtk.gtk4.Settings.FileChooser date-format 'regular'
gsettings set org.gtk.gtk4.Settings.FileChooser expand-folders false
gsettings set org.gtk.gtk4.Settings.FileChooser location-mode 'path-bar'
gsettings set org.gtk.gtk4.Settings.FileChooser show-hidden false
gsettings set org.gtk.gtk4.Settings.FileChooser show-size-column true
gsettings set org.gtk.gtk4.Settings.FileChooser show-type-column true
gsettings set org.gtk.gtk4.Settings.FileChooser sidebar-width 140
gsettings set org.gtk.gtk4.Settings.FileChooser sort-column 'name'
gsettings set org.gtk.gtk4.Settings.FileChooser sort-directories-first true
gsettings set org.gtk.gtk4.Settings.FileChooser sort-order 'ascending'
gsettings set org.gtk.gtk4.Settings.FileChooser startup-mode 'recent'
gsettings set org.gtk.gtk4.Settings.FileChooser view-type 'list'
gsettings set org.gtk.gtk4.Settings.FileChooser window-position (-1, -1)
gsettings set org.gtk.gtk4.Settings.FileChooser window-size (821, 644)
