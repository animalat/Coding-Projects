--
-- ***************************************************
-- Day-of-Week-Finder.rkt
-- Finds the day of the week, given the date in "yyyy/mm/dd"
-- ***************************************************
--


-- Citation:
-- This algorithm, called "Zeller's congruence" was created by Christian Zeller.
-- This is his paper archived:
-- https://projecteuclid.org/journals/acta-mathematica/volume-9/issue-none/Kalender-Formeln/10.1007/BF02406733.full
-- This code below that I created uses this algorithm.


findDayOfWeek :: Int -> String
findDayOfWeek zeller = case zeller of
    0 -> "Saturday"
    1 -> "Sunday"
    2 -> "Monday"
    3 -> "Tuesday"
    4 -> "Wednesday"
    5 -> "Thursday"
    6 -> "Friday"

zellerCongruence :: Int -> Int -> Int -> Int
zellerCongruence y m d = mod (d + div (13 * (m' + 1)) 5 + k + div k 4 + div j 4 + (-2 * j)) 7 where
    y' = if m < 3 then y - 1 else y
    m' = if m < 3 then m + 12 else m
    k = mod y' 100
    j = div y' 100

splitList :: String -> [String]
splitList date = case dropWhile (== '/') date of
    "" -> []
    date' -> w : splitList date''
            where (w, date'') = break (== '/') date'

main :: IO()
main = do
    putStrLn "Enter the date in the format yyyy/mm/dd: "
    date <- getLine
    let [y, m, d] = map read (splitList date) :: [Int]
    let dayOfWeek = findDayOfWeek (zellerCongruence y m d) :: String
    putStrLn ("The day of the week is " ++ dayOfWeek)