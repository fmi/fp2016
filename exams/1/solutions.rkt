#lang racket

(define (decreasing? ns)
  (cond
    [(empty? ns) #f]
    [(empty? (rest ns)) #t]
    [else (and (>= (first ns) (second ns)) (decreasing? (rest ns)))]))

(define (number->list n)
  (define (iter n result)
    (if (zero? n)
        result
        (iter (quotient n 10) (cons (remainder n 10) result))))
  (iter n (list)))

(define (sum-numbers a b)
  (apply + (filter (lambda (n) (decreasing? (number->list n)))
                   (range a (+ b 1)))))


; ---------------------------------------------------------------------------


(define (count-bigger-than xs y)
  (length (filter (lambda (x) (> x y))
                  xs)))

(define (num-bigger-elements xs)
  (map (lambda (x) (list x (count-bigger-than xs x)))
       xs))

; ---------------------------------------------------------------------------

(define (switcher f g n x)
  (define (iter counter
                result
                previous-result
                f1
                f2)
    (if (>= counter n)
        result
        (iter (+ counter 1)
              (+ result (f1 previous-result))
              (f1 previous-result)
              f2
              f1)))
  (iter 1
        (f x)
        (f x)
        g
        f))

(define (switchsum f g n)
  (lambda (x)
    (switcher f g n x)))

; ---------------------------------------------------------------------------

(define (partial2 f a)
  (lambda (b) (f a b)))

(define (~~ A B)
  (map (lambda (args fs)
         (map partial2 fs args))
       A
       B))

(define (<<~ A x)
  (map (lambda (row)
         (map (lambda (f) (f x))
              row))
       A))

(define A (list (list 1 2) 
                (list 3 4)))
(define F (list (list + +)
                (list + +)))

; Game Of Life ---------------------------------------------------------------------------

(define block (list (list 0 0 0 0)
                    (list 0 1 1 0)
                    (list 0 1 1 0)
                    (list 0 0 0 0)))

(define blinker (list (list 0 1 0)
                      (list 0 1 0)
                      (list 0 1 0)))

(define single-cell (list (list 0 0 0)
                          (list 0 1 0)
                          (list 0 0 0)))

(define last-man-standing (list (list 1 0 0)
                                (list 0 1 0)
                                (list 0 0 1)))

(define (make-board-of-indexes w h)
  (map (lambda (row)
         (map (lambda (column) (list row column))
              (range 0 h)))
       (range 0 w)))

(define (repeat n elem)
  (map (lambda (_) elem)
       (range 0 n)))

(define (get-cell x y board)
  (list-ref (list-ref board x) y))

(define (alive? x y board)
  (= 1 (get-cell x y board)))

(define (in-board? x y board)
  (and
    (>= x 0)
    (< x (length board))
    (>= y 0)
    (< y (length (first board)))))

(define (alive-neighbours-count x y board)
  (let* ([steps (list '(0 1) '(1 1) '(1 0) '(0 -1) '(-1 -1) '(-1 0) '(-1 1) '(1 -1))]
         [neighbours-coordinates (map (lambda (step pos) (map + step pos)) steps (repeat 8 (list x y)))]
         [in-board (filter (lambda (pos) (in-board? (first pos) (second pos) board)) neighbours-coordinates)])
    (length (filter (lambda (pos) (alive? (first pos) (second pos) board)) in-board))))

(define (next-generation-for-cell x y board)
  (let ([cnt (alive-neighbours-count x y board)])
    (cond
      [(< cnt 2) 0]
      [(> cnt 3) 0]
      [(and (alive? x y board) (or (= cnt 2) (= cnt 3))) 1]
      [(and (not (alive? x y board)) (= cnt 3)) 1]
      [else 0])))


(define (game-of-life board)
  (let ([w (length board)]
        [h (length (first board))])
    (map (lambda (row)
           (map (lambda (pos)
                  (next-generation-for-cell (first pos) (second pos) board))
                row))
         (make-board-of-indexes w h))))
