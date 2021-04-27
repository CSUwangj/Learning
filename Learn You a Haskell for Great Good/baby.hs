-- n^2 quicksort
quicksort :: (Ord a) => [a] -> [a]
quicksort [] = []
quicksort (x : xs) = 
  let lessPart = quicksort [a | a <- xs , a < x]
      largerPart = quicksort [a | a <- xs , a >= x]
  in lessPart ++ [x] ++ largerPart