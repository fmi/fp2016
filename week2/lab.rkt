#lang racket

(define (sum-digits n)
  (define (iter n result)
    (if (zero? n)
        result
        (iter (quotient n 10) (+ result (remainder n 10)))))
  (iter n 0))

; sum for all ints in [a, b]
(define (sum-range a b)
  (define (iter i result)
    (if (> i b)
        result
        (iter (+ i 1) (+ i result))))
  (iter a 0))

(define (sum-divisors n)
  (define (iter i result)
    (cond
      [(> i n) result]
      [(zero? (remainder n i)) (iter (+ i 1) (+ i result))]
      [else (iter (+ i 1) result)]))
  (iter 1 0))

(define (prime? n)
  (= (n + 1) (sum-divisors n)))

(define (prime-iter? n)
  (define (iter i)
    (cond
      [(> (* i i) n) #t]
      [(zero? (remainder n i)) #f]
      [else (iter (+ i 1))]))
  (if (<= n 1)
      #f
      (iter 2))) 
      
(define (int-reverse n)
  (define (iter n result)
    (if (zero? n)
        result
        (iter (quotient n 10) (+ (* result 10) (remainder n 10)))))
    (iter n 0))