main =
  let left = myFoldl (\acm x -> acm + length x) 10 ["foo", "bar", "bazoooo"] in
  let right = myFoldr (\x acm -> acm + length x) 10 ["foo", "bar", "bazoooo"] in
  putStrLn $ "left: " ++ (show left) ++", right: " ++ (show right)

myFoldl :: (b -> a -> b) -> b -> [a] -> b
myFoldl f d []     = d
myFoldl f d (x:xs) = myFoldl f (f d x) xs

myFoldr :: (a -> b -> b) -> b -> [a] -> b
myFoldr f d []     = d
myFoldr f d (x:xs) = f x (myFoldr f d xs)
