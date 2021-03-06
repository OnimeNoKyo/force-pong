module States exposing (..)

import Types exposing (..)
import AnimationFrame
import Window exposing (..)
import Keyboard exposing (..)
import Config exposing (..)
import Material


defaultWorld : ( World, Cmd Msg )
defaultWorld =
    ( initialWorld, Cmd.none )

initialWorld : World
initialWorld = 
      { spheres =
            []
      , players =
            [ { number = One
              , position = { x = (playerSideLinePosistion Left playerWidth), y = graphicHeight / 2 }
              , side = Left
              , score = 0
              , size = 80
              , velocity = { x = 0, y = 0 }
              , upAction = NotPressed
              , downAction = NotPressed
              , mass = { size = 10 }
              , selectedWeapon = Normal
              , ammo = 10
              , weapons = [ { weaponType = Normal, force = { x = 1, y = 0 } } ]
              , weaponLastFired = 0
              , gamesWon = 0
              , name = "Player One"
              }
            , { number = Two
              , position = { x = (playerSideLinePosistion Right playerWidth), y = graphicHeight / 2 }
              , side = Right
              , score = 0
              , size = 80
              , velocity = { x = 0, y = 0 }
              , upAction = NotPressed
              , downAction = NotPressed
              , mass = { size = 10 }
              , selectedWeapon = Normal
              , ammo = 10
              , weapons = [ { weaponType = Normal, force = { x = 1, y = 0 } } ]
              , weaponLastFired = 0
              , gamesWon = 0
              , name = "Player Two"
              }
            ]
      , state = Play
      , graphicSettings =
            { graphicWidth = graphicWidth
            , graphicHeight = graphicHeight
            }
      , leftSideLine =
            { side = Left
            , x1 = sideLinePosistion Left
            , x2 = sideLinePosistion Left
            , y1 = innerContainerY1
            , y2 = innerContainerY2
            }
      , rightSideLine =
            { side = Right
            , x1 = sideLinePosistion Right
            , x2 = sideLinePosistion Right
            , y1 = innerContainerY1
            , y2 = innerContainerY2
            }
      , physicsSettings =
            { gravitationalConstant = 10
            , boundaryDampner = 0.95
            , maxSphereVelocity = 10
            , maxSphereSize = 200
            , gravityAttractionType = Attract
            , maxGravitationalConstant = 60
            , minGravitationalConstant = 0
            }
      , gameSettings =
            { scoreForGame = 500
            , scoreForSet = 5
            , maxShotSize = 45
            , minShotSize = 20
            , shotTimeFactor = 0.01
            , sphereLimit = 40
            , gamesToWin = 5
            }
      , winStates =
            { gameWinState = NoWin
            , setWinState = NoWin
            }
      , innerContainer =
            { x1 = innerContainerX1
            , x2 = innerContainerX2
            , y1 = innerContainerY1
            , y2 = innerContainerY2
            }
      , outerContainer =
            { x1 = outerContainerX1
            , x2 = outerContainerX2
            , y1 = outerContainerY1
            , y2 = outerContainerY2
            }
      , mdl = Material.model
      }


subscriptions : World -> Sub Msg
subscriptions world =
    Sub.batch
        [ AnimationFrame.diffs Tick
        , Keyboard.downs KeyDown
        , Keyboard.ups KeyUp
        , Window.resizes WindowSize
        ]
