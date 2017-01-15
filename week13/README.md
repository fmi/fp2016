# Седмица 13 - Подготовка за контролно

## Longest Increasing Prefix

Напишете следната функция:

```haskell
longestIncreasingPrefix :: Ord a => [a] -> [a]
```

Функцията връща най-дълго нарастващия префикс на даден списък.

Пример:

```haskell
longestIncreasingPrefix [1, 2, 2] == [1, 2]
longestIncreasingPrefix [1, 2, 3] == [1, 2, 3]
longestIncreasingPrefix [1] == [1]
longestIncreasingPrefix [1, 2, 3, 4, 2] == [1, 2, 3, 4]
```

## Reorder Tuples

Напишете следната функция:

```haskell
reorderTuples :: Ord a => [(a, a)] -> [(a, a)]
```

Функцията взима списък от наредени двойки и връща нов списък, където:

* Ако за поредната наредена двойка `(a, b)` е изпълнено условието `a < b`, то тя се превръща в `(b, a)`
* Ако е изпълнено обратното условие: `a >= b`, то тя се запазва на място -> `(a, b)`

Пример:

```haskell
reorderTuples [(1, 2), (2, 2), (1, 10), (10, 1)] == [(2, 1), (2, 2), (10, 1), (10, 1)]
```

## Merge and Sort Digits

Напишете функцията `mergeAndSortDigits :: Int -> Int -> Int`, която взима две цели числа, `X` и `Y` и връща ново число `N`, такова че:

* То се състои от цифрите на `X` и `Y`, без повторения в цифрите (само уникални цифри)
* Цифрите на `N` трябва да са сортирани във възходящ или низходящ ред, спрямо следното условие:
* Ако `sumDigits X <= sumDigits Y`, то трябва да са във възходящ ред
* Otherwise - във низходящ ред.
* Ако в някое от числата `X` или `Y` се среща нула, тя се премахва и изобщо не участва в схемата!

Примери:

```haskell
> mergeAndSortDigits 11 111
1 -- Защото искаме резултатното число да няма повтарящи се цифри.
> mergeAndSortDigits 123 456
123456 -- сумата на 1+2+3 е <= от сумата на 4+5+6
> mergeAndSortDigits 456 123
654321 -- тук имаме обратния вариант
```

## Balance

Напишете функция `balance :: Int -> [Int] -> Int`, която взима число `N`, списък с числа `numbers` и връща **минималния брой** на премахванията на елементи от списъка, такъв че сумата на числата в списъка да стане `<= N` или пък списъкът не остане празен.

`N` няма да бъде отрицателно число.

Примери:

```haskell
balance 50 [45, 5, 100]
1 -- Трябва да махнем 100, за да получим сума 50
balance 3 [2, 10, 15]
2 -- Тук трябва да махнем 10 и 15
balance 1 [5, 10, 15, 36]
4 -- Тук трябва да махнем всички елементи от списъка
```

## Repeater

Напишете функция `repeater :: String -> (Int -> String -> String)`, която взима низ `str` и връща функция на два аргумента.

Когато извикате върнатата функция с число `count` и низ `glue`, се получава низ, който представлява `count`- кратно повтаряне на низа `str`, при което между всеки две съседни повторения на `str` стои низът `glue`.

Примери:

```haskell
> let haskellRepeat = repeater "I love Haskell"
> haskellRepeat 3 " "
"I love Haskell I love Haskell I love Haskell"
> repeater "Quack" 5 "!"
"Quack!Quack!Quack!Quack!Quack"
```

## Orders

Да се дефинира тип `Order`, който моделира поръчка на продукт. 

Типът да има `2` `value` констуктора - `Online Float Int Int` (цена на стоката, номер на поръчката и брой часове до доставка) и `Offline Float` (цена на стоката)

- да се дефинира функция `isOnline :: Order -> Bool`, която връща дали дадена поръчка е направена онлайн.
- да се дефинира функция `timeUntilReceiving :: Order -> Int`, която връща след колко часа поръчката ще бъде получена
- да се дефинира функция `totalPrice :: [Order] -> Float`, която връща общата цена на списък от поръчки
- да се дефинира функция `onlineOrders :: [Order] -> Int`, която връща броят на онлайн поръчки в даден списък.
- да се дефинира функция `isExpensive :: Order -> Bool`, която проверява дали цената на поръчаната стока надвишава 100.
- да се направи `Order` инстанция на `Show` и `Eq`.

## Trees - level sum & cone

Имаме следното представяне на двоично дърво:

```haskell
data Tree a = Empty | Node a (Tree a) (Tree a)
```

Казваме, че едно двоично дърво е конус, ако сумата на елементите на всяко ниво в дървото е по-голяма от сумата на елементите на предишното ниво.

a) Да се дефинира функция `levelSum :: Int -> Tree Int -> Int`, която намира сумата на елементите на ниво *level* в дървото *tree*.

b) Да се дефинира функция `cone :: Tree Int -> Bool`, която проверява дали дървото *tree* е конус.

Приемаме, че коренът на дървото е на ниво 1. Да се използва следната дефиниция на двоично дърво:

**Примери:**

```haskell
levelSum Empty 0 -> 0
levelSum (Node 1 (Node 2 Empty Empty) (Node 3 Empty Empty)) 0 -> 1
levelSum (Node 1 (Node 2 Empty Empty) (Node 3 Empty Empty)) 1 -> 5
levelSum (Node 1 (Node 2 Empty Empty) (Node 3 Empty Empty)) 2 -> 0

cone Empty -> True
cone (Node 1 (Node 2 Empty Empty) (Node 3 Empty Empty)) -> True
cone (Node 5 (Node 2 Empty Empty) (Node 3 Empty Empty)) -> False
cone (Node 1 (Node 2 Empty Empty) (Node 3 Empty (Node 4 Empty Empty))) -> False
```
