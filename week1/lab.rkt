#lang racket


(define (square x)
  (* x x))

(define (square-sum a b)
  (+ (square a) (square b)))

(define (triangle? a b c)
  (and
    (> (+ b c) a)
    (> (+ a b) c)
    (> (+ a c) b)))

(define (pyth? a b c)
  (= (square c) (square-sum a b)))

; Факториел, написан чрез if
(define (fact2 n)
  (if
    (zero? n)
    1
    (* n (fact2 (- n 1)))))

; Факториел, написан чрез cond
(define (fact n)
  (cond
    [(zero? n) 1]
    [else (* n (fact (- n 1)))]))

(define (cut-last-digit n)
  (remainder n 10))

(define (cut-number-from-last-digit n)
  (quotient n 10))

; Използваме по-хубави имена за функциите remainder и quotient
; Така разбираме какво се случва
(define (sum-digits n)
  (cond
    [(zero? n) 0]
    [else (+ (cut-last-digit n) (sum-digits (cut-number-from-last-digit n)))]))

; Същата идея като по-горе
; Дъното на рекурсията е 1, операцията е умножение
(define (product-digits n)
  (cond
    [(zero? n) 1]
    [else (* (cut-last-digit n) (product-digits (cut-number-from-last-digit n)))]))

; Лице на триъгълник
; Използваме Херонова формула
; Дефинираме си локална константа, която ще отговаря за полупериметъра
(define (area a b c)
  (define p (/ (+ a b c) 2))
  (sqrt (* p (- p a) (- p b) (- p c))))
