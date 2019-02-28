main = do
  contents <- readFile "./input.txt"
  (putStrLn . show . toA . minRoute . toBlocks . map read . lines) contents

data Road = A | B deriving (Show)

data BlockDuration =
  BlockDuration { roadA  :: Int
                , roadB  :: Int
                , change :: Int
                }

data Route =
  Route { selectedRoad :: [Road]
        , duration     :: Int
        } deriving (Show)

data MinRoute =
  MinRoute { toA :: Route
           , toB :: Route
           }

toBlocks :: [Int] -> [BlockDuration]
toBlocks [] = []
toBlocks (a:b:c:s) =
  BlockDuration { roadA = a, roadB = b, change = c } : toBlocks s


minRoute :: [BlockDuration] -> MinRoute
minRoute blocks =
  foldl folding zeroAcc blocks
  where
    zeroRoute = Route { selectedRoad = []
                      , duration = 0
                      }
    zeroAcc = MinRoute { toA = zeroRoute
                       , toB = zeroRoute
                       }
    folding :: MinRoute -> BlockDuration -> MinRoute
    folding
      MinRoute { toA = Route { selectedRoad = aRoads, duration = aTime }
               , toB = Route { selectedRoad = bRoads, duration = bTime } }
      BlockDuration { roadA = a, roadB = b, change = c } =
      MinRoute { toA = newToA, toB = newToB }
      where
        timeA2A = aTime + a
        timeB2B = bTime + b
        timeA2B = timeA2A + c
        timeB2A = timeB2B + c
        newToA =
          if timeA2A <= timeB2A
            then Route { selectedRoad = aRoads ++ [A], duration = timeA2A }
            else Route { selectedRoad = bRoads ++ [B], duration = timeB2A }
        newToB =
          if timeB2B <= timeA2B
            then Route { selectedRoad = bRoads ++ [B], duration = timeB2B }
            else Route { selectedRoad = aRoads ++ [A], duration = timeA2B }
