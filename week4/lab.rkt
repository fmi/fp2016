#lang racket

; Намира сумата на всички числа в numbers
; -> (sum (list))
; 0
; -> (sum (list 1 2 3))
; 6
(define (sum ns)
  (if (empty? ns)
      0
      (+ (first ns) (sum (rest ns)))))

; Проверява дали x се среща в items
; -> (member? 1 (list 1 2 3))
; #t
; -> (member? "asdf" (list "asd"))
; #f
; Разгледайте http://docs.racket-lang.org/reference/booleans.html
(define (member? y xs)
  ; Решението следва тази логика:
  ; Ако xs е празен, няма как y да се съдържа в него
  ; Или y е равен на първият елемент на xs или се намира в опашката
  ; Слепяме рекурсията с or
  ; За упражнение - разпишете израза, който се строи в рекурсията
  (if (empty? xs)
      #f
      (or (equal? y (first xs)) (member? y (rest xs)))))

; -> (length2 (range2 1 10))
; 9
; В Racket има такава функция, наречена length
(define (length2 items)
  (if (empty? items)
      0
      (+ 1 (length2 (rest items)))))

; Връща n-тия елемент от items при 0лево базиран индекс
; -> (list-ref2 (list 1 2 3) 0)
; 1
; В Racket има такава функция, наречена list-ref
(define (list-ref2 items n)
  ; Решението използва най-проста опашкова рекурсия
  ; Тук, ако някой поиска индекс, който го няма, оставяме функцията да гръмне с грешка при first
  (if (zero? n)
      (first items)
      (list-ref2 (rest items) (- n 1))))

; -> (range2 1 10)
; '(1 2 3 4 5 6 7 8 9)
; В Racket съществува такава функция, наречена range
(define (range2 a b)
  (if (>= a b)
      (list)
      (cons a (range2 (+ a 1) b))))

; Строи списък от числата между 0 и n, включително, като прилага f върху всяко число
; i-тия елемент на този списък е (f i)
; -> (build-list2 3 id)
; '(0 1 2)
; -> (build-list2 3 (lambda (x) (* x x)))
; '(0 1 4)
; В Racket има такава функция, наречена build-list

(define (build-list2 n f)
  ; Тук за решението използваме предстоящата за изучаване функция map
  ; Примерно използваме на build-list2 би било ако искаме да направим списък от 1вите 10 факториела:
  ; (build-list 10 fact)
  ; '(1 1 2 6 24 120 720 5040 40320 362880 3628800)
  (map f (range 0 (+ n 1))))

; Конкатенира два списъка в нов списък
; -> (append2 (list 1 2 3) (list 4 5 6))
; '(1 2 3 4 5 6)
; В Racket има такава фунцкия, наречена append
(define (append2 xs ys)
  ; Тук използваме най-"каноничното" решение
  ; Докато имаме елементи в xs, правим cons-рекурсия с тях
  ; Когато изчерпаме xs, продължаваме с тези елементи в ys
  ; Kогато изчерпаме ys, връщаме дъното на рекурсията - празен списък
  (cond
    [(empty? ys) (list)]
    [(empty? xs) (cons (first ys) (append2 xs (rest ys)))]
    [else (cons (first xs) (append2 (rest xs) ys))]))

; Обръща списъка наобратно
; -> (reverse2 (list 1 2 3))
; '(3 2 1)
; В Racket има такава функция, наречена reverse
(define (reverse2 xs)
  ; Използваме хитър трик да трупаме резултат в опашкова рекурсия
  ; Поради факта, че тя върви в нормална посока, все едно е цикъл
  ; А cons слага елемент отпред
  ; Накрая изкарваме обърнат резултат
  (define (iter xs ys)
    (if (empty? xs)
        ys
        (iter (rest xs) (cons (first xs) ys))))
  (iter xs (list)))

; Взима първите n елемента от даден списък
; Ако (> n (length items)), тогава връща items
; -> (take2 3 (list 1 2 3 4 5))
; '(1 2 3)
(define (take2 n xs)
  (cond
    [(empty? xs) (list)]
    [(zero? n) (list)]
    [else (cons (first xs) (take2 (- n 1) (rest xs)))]))

; Маха първите n елемента от даден списък
; Ако (> n (length items)) връща '()
; -> (drop2 3 (list 1 2 3 4 5))
; '(4 5)
(define (drop2 n xs)
  (cond
    [(empty? xs) (list)]
    [(zero? n) xs]
    [else (drop2 (- n 1) (rest xs))]))

; Функция от по-висок ред. Взима поредни елементи от items докато предиката p за тях дава истина
; -> (take-while zero? (list 0 0 0 1 2 3))
; '(0 0 0)
; -> (take-while even? (list 2 4 5 7 8 3 2))
; '(2 4)
; -> (take-while (lambda (x) (> x 3)) (list 1 1 1 1 1))
; '()
(define (take-while p items)
  (void))

; Функция от по-висок ред. Маха поредните елементи от items докато предикатa p дава лъжа за тях
; -> (drop-while zero? (list 0 0 0 1 2 3))
; '(1 2 3)
; -> (drop-while even? (list 2 4 5 7 8 3 2))
; '(5 7 8 3 2)
; -> (drop-while (lambda (x) (> x 3)) (list 1 1 1 1 1))
; '(1 1 1 1 1)
(define (drop-while p items)
  (void))

; Функцията взима число и връща списък от цифрите му
; -> (number->list 123)
; '(1 2 3)
(define (number->list n)
  (void))

; Функцията взима списък от цифри и връща числото
; -> (list->number (list 1 2 3))
; 123
(define (list->number ns)
  (void))