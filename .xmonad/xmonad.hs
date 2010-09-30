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
import XMonad.Actions.TopicSpace
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

main :: IO ()
main = xmonad =<< myConfig

myConfig = do
  checkTopicConfig myTopics myTopicConfig
  xmproc <- spawnPipe "xmobar"  -- start xmobar
  return $ withUrgencyHookC dzenUrgencyHook urgencyConfig { suppressWhen = Focused }
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
       , workspaces        = myTopics
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
       , ("M-t",     spawn "uxterm -e 'screen -RR'")
       , ("M-/ S-t", spawn "uxterm -e 'byobu -RR'")
       , ("M-/ b",   spawn "google-chrome")
       , ("M-b",     spawn "google-chrome")
       , ("M-/ e",   spawn "emacsclient -nc")
       , ("M-e",     spawn "emacsclient -nc")
       , ("M-/ q",   safePromptSelection "stardict")
       , ("M-q",     safePromptSelection "stardict")
       , ("<XF86HomePage>",   spawn "google-chrome")
       , ("<XF86Tools>",   spawn "emacsclient -nc")
       -- WM actions
       , ("M-<Escape>", toggleWS)
       , ("M-<Backspace>", toggleWS)
       , ("M-S-]", kill)
       , ("M-g", promptedGoto)
       , ("M-/ g", promptedGoto)
       , ("M-S-g", promptedShift)
       , ("M-/ S-g", promptedShift)
       , ("M-s", sshPrompt customXPConfig)
       , ("M-/ s", sshPrompt customXPConfig)
       , ("M-r", shellPrompt customXPConfig)
       , ("M-/ r", shellPrompt customXPConfig)
       , ("M-/ S-r", spawn "emacsclient -e '(remember-other-frame)'")
       , ("M-u", focusUrgent)
       , ("M-o", windowMenu)
       , ("M-p", fullFloatFocused)
       , ("M-i", withFocused $ windows . W.sink)
       , ("M-m", sendMessage Mag.Toggle)
       -- MusicPlaerDaemon
       -- , ("<XF86AudioPlay>", spawn "mpc toggle")
       -- , ("<XF86AudioNext>", spawn "mpc next")
       -- , ("<XF86AudioMedia>", spawn "mpc next")
       -- , ("<XF86AudioPrev>", spawn "mpc prev")
       -- , ("<XF86AudioStop>", spawn "mpc stop")
       ]
       `additionalKeys`
       [((m .|. mod4Mask, key), screenWorkspace sc >>= flip whenJust (windows . f))
            | (key, sc) <- zip [xK_F1, xK_F2, xK_F3] [0..]
       , (f, m) <- [(W.view, 0), (W.shift, shiftMask)]]

myLayoutHook = minimize
               $ maximize
               $ boringAuto
               $ avoidStruts
               $ Mag.magnifierOff
               $ smartBorders
               $ onWorkspace "im#2" imLayout
               $ basicLayout
  where
    basicLayout = Full ||| tiled ||| mirrorTiled ||| onebig ||| simpleCross

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

myManageHook = composeOne
               [ className =? "Gimp"                            -?> doFloat
               , className =? "Vncviewer"                       -?> doFloat
               , className =? "gcolor2"                         -?> doFloat
               , className =? "totem"                           -?> doFloat
               , className =? "Firefox Preferences"             -?> doFloat
               , className =? "*VLC"                            -?> doFloat
               , className =? "Skype"                           -?> doFloat
               , className =? "gdebi-gtk"                       -?> doFloat
               , iconName  =? "Параметры Google Chrome"         -?> doFloat
               , className =? "Firefox"                         -?> insertPosition End Older
               , className =? "Pidgin"                          -?> doShift "im#2"
               , className =? "Empathy"                         -?> doShift "im#2"
               , title     =? "ERC"                             -?> doShift "im#2"
               , className =? "Stardict"                        -?> doCenterFloat
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
             ppCurrent = xmobarColor "white" "#9F664D" . wrap "[" "]"
           , ppUrgent = xmobarColor "white" "#FF0000" . wrap "*" "*"
           , ppLayout = xmobarColor "white" "black"
           , ppTitle = xmobarColor "white" ""
           , ppSep = "   "
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

-- The list of all topics/workspaces of your xmonad configuration.
-- The order is important, new topics must be inserted
-- at the end of the list if you want hot-restarting
-- to work.
myTopics :: [Topic]
myTopics =
    [ "dashboard#1" -- the first one
    , "im#2", "music#3", "torrents#4", "mail/news#5", "conf#6", "video#7"
    -- "dynamic"
    , "unigate"
    , "payment-page"
    , "hms"
    , "onheroku"
    , "unigate_deploy"
    , "ci"
    , "rails"
    , "unigate_statements"
    , "accord"
    ]

myTopicConfig :: TopicConfig
myTopicConfig = TopicConfig
                { topicDirs = M.fromList $
                              [ ("conf#6", "src/dotfiles")
                              , ("dashboard#1", "src/")
                              , ("music#3", "Music")
                              , ("torrents#4", "/mnt/terrabyte/archiv/")
                              , ("video#7", "Видео")
                              , ("unigate", "src/unigate-dev/unigate")
                              , ("payment-page", "src/unigate-dev/certo-payment-page")
                              , ("onheroku", "src/onheroku-dev/")
                              , ("rails", "src/rails/")
                              , ("accord", "src/accord-dev/")
                              ]
                , defaultTopicAction = const $ spawnShell >*> 3
                , defaultTopic = "dashboard#1"
                , topicActions = M.fromList $
                                 [ ("conf#6", spawn "emacsclient -nc ~/org/newgtd.org.gpg" >>
                                              spawn "emacsclient -nc ~/.xmonad/xmonad.hs")
                                 , ("torrents#4", gnomeOpen "http://rutracker.org" >> spawn "transmission")
                                 , ("im#2", spawn "pidgin")
                                 , ("music#3", spawn "rhythmbox")
                                 , ("mail/news#5", spawn "google-chrome --new-window http://gmail.com http://reader.google.com")
                                 , ("unigate", spawn "unigate")
                                 , ("payment-page", spawn "payment-page")
                                 , ("video#7", spawn "emacsclient -nc ~/Videos" >> spawn "smpalyer")
                                 , ("hms", spawn "google-chrome --new-window http://odesk.com http://hmsinc.unfuddle.com/" >> spawn "$SHELL -c 'cd $HOME/src/hms-dev/ && exec emacs'")
                                 , ("onheroku", spawn "$SHELL -c 'cd $HOME/src/onheroku-dev && exec emacs'")
                                 , ("rails", spawn "$SHELL -c 'cd $HOME/src/rails && exec emacs'")
                                 , ("unigate_deploy", spawn "$SHELL -c 'cd $HOME/src/unigate-dev/ && exec emacs'")
                                 , ("unigate_statements", spawn "$SHELL -c 'cd $HOME/src/unigate-dev/ss && exec emacs'")
                                 , ("ci", gnomeOpen "http://192.168.66.3:3333")
                                 , ("accord", gnomeOpen "http://accord.basecamphq.com" >> spawn "$SHELL -c 'cd $HOME/src/accord-dev/ && exec emacs'")
                                 ]
                }

spawnShell :: X ()
spawnShell = currentTopicDir myTopicConfig >>= spawnShellIn

spawnShellIn :: Dir -> X ()
spawnShellIn dir = spawn $ "urxvt '(cd ''" ++ dir ++ "'' && " ++ "$SHELL" ++ " )'"

goto :: Topic -> X ()
goto = switchTopic myTopicConfig

promptedGoto :: X ()
promptedGoto = workspacePrompt customXPConfig goto

promptedShift :: X ()
promptedShift = workspacePrompt customXPConfig $ windows . W.shift

gnomeOpen :: String -> X ()
gnomeOpen url = spawn $ "gnome-open '" ++ url ++ "'"

-- Local variables:
-- compile-command: "xmonad --recompile && xmonad --restart"
-- End:
