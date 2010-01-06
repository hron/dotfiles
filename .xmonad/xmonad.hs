import XMonad
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks
import XMonad.Util.Run(spawnPipe)
import XMonad.Util.EZConfig(additionalKeys)
import System.IO

myManageHook = composeAll
    [ className =? "Gimp"      --> doFloat
    , className =? "Vncviewer" --> doFloat
    ]

main = do
    xmonad $ defaultConfig
       { manageHook = manageDocks <+>
                      myManageHook <+>
                      manageHook defaultConfig
       , layoutHook = avoidStruts  $  layoutHook defaultConfig
       , modMask = mod4Mask -- Rebind Mod to the Windows key
       } `additionalKeys`
       [ ((mod4Mask .|. shiftMask, xK_z), spawn "xscreensaver-command -lock")
       , ((mod4Mask, xK_t), spawn "uxterm -e 'byobu -R'")
       , ((mod4Mask, xK_x), spawn "uxterm -e 'ncmpcpp'")
       , ((mod4Mask .|. shiftMask, xK_t), spawn "uxterm")
       , ((mod4Mask, xK_b), spawn "/home/gusev/bin/conkeror")
       , ((mod4Mask, xK_e), spawn "emacsclient -nc")
       ]

-- Local variables:
-- compile-command: "xmonad --recompile && xmonad --restart"
-- End: