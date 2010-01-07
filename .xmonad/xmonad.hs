import XMonad
import XMonad.ManageHook
import XMonad.Config.Gnome
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.UrgencyHook
import XMonad.Hooks.RestoreMinimized
import XMonad.Hooks.ManageHelpers
import XMonad.Actions.CycleWS
import XMonad.Actions.GridSelect
import XMonad.Actions.WindowMenu
import XMonad.Util.Run(spawnPipe)
import XMonad.Util.EZConfig
import XMonad.Util.XSelection
import XMonad.Prompt
import XMonad.Prompt.Window
import XMonad.Prompt.Workspace
import XMonad.Prompt.Ssh
import XMonad.Prompt.Shell
import XMonad.Prompt.XMonad
import XMonad.Layout.Maximize
import XMonad.Layout.Minimize
import XMonad.Layout.Cross
import XMonad.Layout.NoBorders
import qualified XMonad.Layout.Magnifier as Mag
    
import qualified XMonad.StackSet as W

import System.IO
import Data.Monoid
    
main = do
  xmonad $ withUrgencyHookC dzenUrgencyHook urgencyConfig { suppressWhen = Focused }
         $ gnomeConfig
       { manageHook = manageDocks <+>
                      myManageHook <+>
                      manageHook gnomeConfig
       , layoutHook = myLayoutHook
       -- Rebind Mod to the Windows key
       , modMask = mod4Mask
       , handleEventHook = mappend myHandleEventHook (handleEventHook gnomeConfig)
       }
       `removeKeysP`
       [
         ("M-S-<Return>")
       , ("M-p")
       , ("M-S-p")
       -- mod-{w,e,r} %! Switch to physical/Xinerama screens 1, 2, or 3
       -- mod-shift-{w,e,r} %! Move client to screen 1, 2, or 3
       , ("M-w")
       , ("M-e")
       , ("M-r")
       , ("M-S-w")
       , ("M-S-e")
       , ("M-S-r")
       ]
       `additionalKeysP`
       [
       -- DE actions
         ("M-S-l", spawn "gnome-screensaver-command -l")
       , ("M-S-q", spawn "gnome-session-save --gui --logout-dialog")
       -- External applications
       , ("M-t",   spawn "uxterm -e 'byobu -R'")
       , ("M-x",   spawn "uxterm -e 'ncmpcpp'")
       , ("M-S-t", spawn "uxterm")
       , ("M-b",   spawn "/home/gusev/bin/conkeror")
       , ("M-e",   spawn "emacsclient -nc")
       , ("M-q",   spawn "stardict ")
       -- WM actions
       , ("M-<Escape>", toggleWS)
       , ("M-S-g", goToSelected defaultGSConfig)
       , ("M-g", windowPromptGoto  defaultXPConfig)
       , ("M-s", sshPrompt defaultXPConfig)
       , ("M-r", shellPrompt amberXPConfig)
       , ("M-u", focusUrgent)   -- FIXME: do not work
       , ("M-o", windowMenu)
       , ("M-S-r", xmonadPrompt amberXPConfig)
       , ("M-f", fullFloatFocused)
       , ("M-v", withFocused $ windows . W.sink)
       , ("M-m", sendMessage Mag.Toggle)
       ]
       `additionalKeys`
       -- mod-{w,e,r} %! Switch to physical/Xinerama screens 1, 2, or 3
       -- mod-shift-{w,e,r} %! Move client to screen 1, 2, or 3
       [((m .|. mod4Mask, key), screenWorkspace sc >>= flip whenJust (windows . f))
            | (key, sc) <- zip [xK_F1, xK_F2, xK_F3] [0..]
       , (f, m) <- [(W.view, 0), (W.shift, shiftMask)]]

myLayoutHook = minimize $ maximize $ avoidStruts $ Mag.magnifierOff $ smartBorders
               (tiled ||| (Mirror tiled) ||| Full ||| simpleCross ||| layoutHook gnomeConfig)
  where
     -- default tiling algorithm partitions the screen into two panes
     tiled   = Tall nmaster delta ratio

     -- The default number of windows in the master pane
     nmaster = 1

     -- Default proportion of screen occupied by master pane
     ratio   = 1/2

     -- Percent of screen to increment by when resizing panes
     delta   = 3/100


myManageHook = composeAll
    [ className =? "Gimp"                 --> doFloat
    , className =? "Vncviewer"            --> doFloat
    , className =? "stardict"             --> doFloat
    , className =? "gcolor2"              --> doFloat
    , className =? "totem"                --> doFloat
    , className =? "Firefox Preferences"  --> doFloat
    , className =? "*VLC"                 --> doFloat
    , className =? "Skype"                --> doFloat
    , role  =? "buddy_list"               --> doFloat
    , className =? "Pidgin"               --> doCenterFloat
    , isDialog                            --> doCenterFloat
    , isFullscreen                        --> doFullFloat
    ]
    where role = stringProperty "WM_WINDOW_ROLE"
               
myHandleEventHook = restoreMinimizedEventHook

-- http://www.haskell.org/pipermail/xmonad/2009-August/008365.html
fullFloatFocused = withFocused $ \f -> windows =<< appEndo `fmap` runQuery doFullFloat f

-- Local variables:
-- compile-command: "xmonad --recompile && xmonad --restart"
-- End: