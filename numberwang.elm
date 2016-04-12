module Numberwang where

-- Step 1: define our numberwang type

type Numberwang = Just Int | Numberwang Int

toNumberwang : Int -> Numberwang
toNumberwang i =
  case i of
    4 -> Numberwang i
    9 -> Numberwang i
    -- if it's Tuesday or a leap year, and it's raining, and
    -- the number of letters in your name is a factorial of
    -- your guess, etc etc etc... ->  Numberang i
    _ -> Just i

-- > toNumberwang 2
-- Just 2 : Numberwang

-- > toNumberwang 4
-- Numberwang 4 : Numberwang


-- Step 2: a function that knows nothing about numberwangs

inc : Int -> Int
inc i =
  i + 1

-- > inc 2
-- 3 : Int

-- > inc (toNumberwang 2)
-- Error: Function `inc` is expecting: Int, But received: Numberwang


-- Step 3: jamming a numberwang into our non-numberwang function

magicSauce : Numberwang -> (Int -> Numberwang) -> Numberwang
magicSauce n f =
  case n of
    Just i -> f i
    Numberwang i -> f i

incNumberwang : Numberwang -> Numberwang
incNumberwang n =
  magicSauce n (\i -> toNumberwang (inc i))

-- > incNumberwang (toNumberwang 2)
-- Just 3 : Numberwang

-- > incNumberwang (toNumberwang 4)
-- Just 5 : Numberwang

bruteForceNumberwang : Numberwang -> String
bruteForceNumberwang n =
  case n of
    Numberwang i -> (toString i) ++ " -- That's number wang!"
    _ -> bruteForceNumberwang (incNumberwang n)

-- > bruteForceNumberwang (toNumberwang 0)
-- "4 -- That's number wang!" : String

