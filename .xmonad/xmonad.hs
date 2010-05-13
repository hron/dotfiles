import XMonad
import XMonad.ManageHook
import XMonad.Config.Gnome
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.UrgencyHook
import XMonad.Hooks.RestoreMinimized
import XMonad.Hooks.ManageHelpers
import XMonad.Hooks.InsertPosition
import XMonad.Hooks.SetWMName
import XMonad.Actions.CycleWS
import XMonad.Actions.GridSelect
import XMonad.Actions.WindowMenu
import XMonad.Actions.WindowGo
import XMonad.Util.Run
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
import XMonad.Layout.OneBig
import XMonad.Layout.BoringWindows
import XMonad.Layout.IM
import XMonad.Layout.Grid
import XMonad.Layout.PerWorkspace
import XMonad.Layout.GridVariants
import qualified XMonad.Layout.Magnifier as Mag

import qualified XMonad.StackSet as W

import System.IO
import Data.Monoid
import Data.Ratio
import qualified Data.Map as M

import Control.Arrow (first)

main = do
  xmproc <- spawnPipe "xmobar"  -- start xmobar
  xmonad $ withUrgencyHookC dzenUrgencyHook urgencyConfig { suppressWhen = Focused }
         $ gnomeConfig
       { manageHook = manageDocks <+>
                      myManageHook <+>
                      manageHook gnomeConfig
       , startupHook       = setWMName "LG3D"
       , layoutHook        = myLayoutHook
       , logHook           = myLogHook xmproc
       , handleEventHook   = mappend myHandleEventHook (handleEventHook gnomeConfig)
       , terminal          = "uxterm"
       , focusFollowsMouse = False
       , workspaces        = myWorkspaces
       -- Rebind Mod to the Windows key
       , modMask           = mod4Mask
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
       , ("<XF86Launch1>", spawn "gnome-screensaver-command -l")
       , ("M-/ S-q", spawn "gnome-session-save --gui --shutdown-dialog")
       -- External applications
       , ("M-/ t",   spawn "uxterm -e 'screen -RR'")
       , ("M-/ S-t", spawn "uxterm -e 'byobu -RR'")
       -- , ("M-x",   spawn "uxterm -e 'ncmpcpp'")
       , ("M-/ m",   spawn "emacsclient -c -e '(emms-smart-browse)'")
       , ("M-/ b",   spawn "conkeror")
       , ("M-/ e",   spawn "emacsclient -nc")
       , ("M-/ q",   promptSelection "stardict ")
       , ("<XF86HomePage>",   spawn "conkeror")
       , ("<XF86Tools>",   spawn "emacsclient -nc")
       -- WM actions
       , ("M-<Escape>", toggleWS)
       , ("M-<Backspace>", toggleWS)
       , ("M-S-]", kill)
       , ("M-/ g", windowPromptGoto  customXPConfig)
       , ("M-/ S-g", goToSelected defaultGSConfig)
       , ("M-/ s", sshPrompt customXPConfig)
       , ("M-/ r", shellPrompt customXPConfig)
       , ("M-/ S-r", xmonadPrompt customXPConfig)
       , ("M-u", focusUrgent)
       , ("M-o", windowMenu)
       , ("M-p", fullFloatFocused)
       , ("M-i", withFocused $ windows . W.sink)
       , ("M-m", sendMessage Mag.Toggle)
       -- MusicPlaerDaemon
       , ("<XF86AudioPlay>", spawn "mpc toggle")
       , ("<XF86AudioNext>", spawn "mpc next")
       , ("<XF86AudioPrev>", spawn "mpc prev")
       , ("<XF86AudioStop>", spawn "mpc stop")
       ]
       `additionalKeys`
       [((m .|. mod4Mask, key), screenWorkspace sc >>= flip whenJust (windows . f))
            | (key, sc) <- zip [xK_F1, xK_F2, xK_F3] [0..]
       , (f, m) <- [(W.view, 0), (W.shift, shiftMask)]]
       `additionalKeys`
       [((m, k), windows $ f i)
            | (i, k) <- zip myWorkspaces numPadKeys
       , (f, m) <- [(W.greedyView, 0), (W.shift, shiftMask)]]

-- Non-numeric num pad keys, sorted by number
numPadKeys = [ xK_KP_End,  xK_KP_Down,  xK_KP_Page_Down -- 1, 2, 3
             , xK_KP_Left, xK_KP_Begin, xK_KP_Right     -- 4, 5, 6
             , xK_KP_Home, xK_KP_Up,    xK_KP_Page_Up   -- 7, 8, 9
             , xK_KP_Insert] -- 0

-- myLayoutHook = minimize $ maximize $ boringAuto $ avoidStruts $ Mag.magnifierOff $ smartBorders
--             (tiled ||| (Mirror tiled) ||| Full ||| onebig ||| simpleCross  ||| onWorkspace "7" (withIM (0.15) (Role "buddy_list") Grid) ||| layoutHook gnomeConfig)
--   where
--      -- default tiling algorithm partitions the screen into two panes
--      tiled   = Tall nmaster delta ratio
--
--      -- The default number of windows in the master pane
--      nmaster = 1
--
--      -- Default proportion of screen occupied by master pane
--      ratio   = 1/2
--
--      -- Percent of screen to increment by when resizing panes
--      delta   = 3/100
--
--      -- OneBig + settings
--      onebig = OneBig (3/4) (3/4)

myLayoutHook = minimize
               $ maximize
               $ boringAuto
               $ avoidStruts
               $ Mag.magnifierOff
               $ smartBorders
               $ onWorkspace "7.im" imLayout
               $ basicLayout
  where
    basicLayout = tiled ||| mirrorTiled ||| Full ||| onebig ||| simpleCross

    -- Tiled layout
    tiled = Tall nmaster delta ratio
    -- The default number of windows in the master pane
    nmaster = 1
    -- Default proportion of screen occupied by master pane
    ratio   = 1/2
    -- Percent of screen to increment by when resizing panes
    delta   = 3/100

    -- Mirror
    mirrorTiled = Mirror tiled

    -- OneBig + settings
    onebig = OneBig (3/4) (3/4)

    -- for IM
    -- goldenRatio  = 2/(1+sqrt(5)::Double);
    -- imLayout = withIM (0.15) pidginRoster (GridRatio (1/5))
    imLayout  = withIM (1%6) pidginRoster (SplitGrid XMonad.Layout.GridVariants.L 2 3 (2/3) (16/10) (5/100))
    empathyRoster = And (ClassName "Empathy") (Role "contact_list")
    pidginRoster  = And (ClassName "Pidgin") (Role "buddy_list")

myWorkspaces = [ "1", "2", "3", "4" , "5", "6", "7.im", "8", "9" ]

myManageHook = composeOne
               [ className =? "Gimp"                            -?> doFloat
               , className =? "Vncviewer"                       -?> doFloat
               , className =? "stardict"                        -?> doFloat
               , className =? "gcolor2"                         -?> doFloat
               , className =? "totem"                           -?> doFloat
               , className =? "Firefox Preferences"             -?> doFloat
               , className =? "*VLC"                            -?> doFloat
               , className =? "Skype"                           -?> doFloat
               , className =? "gdebi-gtk"                       -?> doFloat
               , iconName  =? "Параметры Google Chrome"         -?> doFloat
               , className =? "Firefox"                         -?> doHideIgnore
               , className =? "Pidgin"                          -?> doShift "7.im"
               , className =? "Empathy"                         -?> doShift "7.im"
               , isDialog                                       -?> doCenterFloat
               , isFullscreen                                   -?> doFullFloat
               ]
    where
      role     = stringProperty "WM_WINDOW_ROLE"
      iconName = stringProperty "WM_ICON_NAME"

myHandleEventHook = restoreMinimizedEventHook

-- http://www.haskell.org/pipermail/xmonad/2009-August/008365.html
fullFloatFocused = withFocused $ \f -> windows =<< appEndo `fmap` runQuery doFullFloat f

-- logHook
myLogHook :: Handle -> X ()
myLogHook h = dynamicLogWithPP $ customPP { ppOutput = hPutStrLn h }

customPP :: PP
customPP = defaultPP {
             ppHidden = xmobarColor "white" ""
           , ppCurrent = xmobarColor "#9F664D" "" . wrap "[" "]"
           , ppUrgent = xmobarColor "#FF0000" "" . wrap "*" "*"
           , ppLayout = xmobarColor "#6A6BD8" ""
           , ppTitle = xmobarColor "white" "" . shorten 80
           , ppSep = "<fc=#0033FF> | </fc>"
           }

customXPConfig :: XPConfig
customXPConfig = defaultXPConfig { font         = "misc-terminus-*-*-*-*-14-*-*-*-*-*-*-*"
                                 , bgColor      = "black"
                                 , fgColor      = "grey90"
                                 , bgHLight     = "black"
                                 , fgHLight     = "green"
                                 , position     = Top
                                 , promptKeymap = customXPKeymap}

-- Make sure we can use Alt.
metaMask :: KeyMask
metaMask = mod1Mask

customXPKeymap :: M.Map (KeyMask,KeySym) (XP ())
customXPKeymap = M.fromList $
  map (first $ (,) controlMask) -- control + <key>
  [ (xK_u, killBefore)
  , (xK_k, killAfter)
  , (xK_a, startOfLine)
  , (xK_e, endOfLine)
  , (xK_y, pasteString)
  , (xK_c, copyString)
  , (xK_Right, moveWord Next)
  , (xK_Left, moveWord Prev)
  , (xK_Delete, killWord Next)
  , (xK_BackSpace, killWord Prev)
  , (xK_w, killWord Prev)
  , (xK_q, quit)
  , (xK_p, moveHistory W.focusUp')
  , (xK_n, moveHistory W.focusDown')
  ] ++
  map (first $ (,) metaMask) -- meta + <key>
  [ (xK_b, moveWord Prev)
  , (xK_f, moveWord Next)
  , (xK_d, killWord Next)
  , (xK_BackSpace, killWord Prev)
  , (xK_m, startOfLine)
  , (xK_n, moveHistory W.focusUp')
  , (xK_p, moveHistory W.focusDown')
  ] ++
  map (first $ (,) 0)
  [ (xK_Return, setSuccess True >> setDone True)
  , (xK_KP_Enter, setSuccess True >> setDone True)
  , (xK_BackSpace, deleteString Prev)
  , (xK_Delete, deleteString Next)
  , (xK_Left, moveCursor Prev)
  , (xK_Right, moveCursor Next)
  , (xK_Home, startOfLine)
  , (xK_End, endOfLine)
  , (xK_Down, moveHistory W.focusUp')
  , (xK_Up, moveHistory W.focusDown')
  , (xK_Escape, quit)
  ]

-- Local variables:
-- compile-command: "xmonad --recompile && xmonad --restart"
-- End:
