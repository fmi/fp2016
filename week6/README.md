# Examp preparation

* [`let`, `let*` in Racket](https://docs.racket-lang.org/reference/let.html)
* [First exam from 2015](https://docs.google.com/document/d/1-ZoGJVt_1oOHVuug8t1-317HbJnB2cvngMCq5Bory1c/edit)
* [First exam from 2014, group 1](https://github.com/fmi/fp2014/blob/master/exam/exam1/group1.md)
* [First exam from 2014, group 2](https://github.com/fmi/fp2014/blob/master/exam/exam1/group2.md)

Problems to solve:

```racket
; Проверява дали списъкът от числа е строго нарастваща редица.
; Използваме >=
(define (increasing? ns)
  (void))

; Проверява дали списъкът от числа е строго нарастваща редица.
; Използваме <=
(define (decreasing? ns)
  (void))

; Смятаме колко пъти y се съдръжа в xs
(define (count y xs)
  (void))

; Премахваме повтарящите се елементи от xs и връщаме списък от неповтарящи се елементи
; Използвайте (equal? x y) за сравненията
(define (dedup xs)
  (void))

; Сумира всички числа в числовата матрица mns
; Матрицата представлява списък от списъци:
; (define A (list (list 1 2 3)
;                 (list 4 5 6)
;                 (list 7 8 9)))
(define (sum-matrix mns)
  (void))

; Намира елемент с позиция (x, y) в дадената матрица
; Броим индексите от 0
; x е номерът на реда, y на колоната
(define (get-element x y matrix)
  (void))

; Връща n-тия ред на дадена матрица
; Броим от 0
(define (get-row n matrix)
  (void))

; Връща n-тата колона на дадена матрица
; Броим от 0
(define (get-column n matrix)
  (void))

; Връща списък, който представлява главният диагонал на дадена квадратна матрица
(define (main-diagonal matrix)
  (void))
```
