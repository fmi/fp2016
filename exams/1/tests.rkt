#lang racket

(require rackunit)
(require rackunit/text-ui)


;--------------SOLUTIONS HERE--------------

;--------------SOLUTIONS HERE--------------

(define ns (variable-reference->namespace (#%variable-reference)))

(define-syntax (defined? stx)
  (syntax-case stx ()
    [(_ id)
     (with-syntax ([v (identifier-binding #'id)])
       #''v)]))

(define sum-numbers-tests
  (if (defined? sum-numbers)
      ((lambda (sum-numbers) (test-suite
                              "Tests for (sum-numbers a b)"
                              (check-equal? 45 (sum-numbers 1 9))
                              (check-equal? 200 (sum-numbers 199 203))
                              (check-equal? 663 (sum-numbers 219 225))
                              (check-equal? 6321 (sum-numbers 1000 2000))
                              (check-equal? 1 (sum-numbers 1 1))
                              (check-equal? 0 (sum-numbers 12 19)))) (eval #'sum-numbers ns))
      (test-suite "Empty suite")))


(define num-bigger-elements-tests
  (if (defined? num-bigger-elements)
      ((lambda (num-bigger-elements) (test-suite
                                      "Tests for (num-bigger-elements lst)"
                                      (check-equal? '((5 1) (6 0) (3 3) (4 2)) (num-bigger-elements '(5 6 3 4)))
                                      (check-equal? '((1 0) (1 0) (1 0)) (num-bigger-elements '(1 1 1)))
                                      (check-equal? '((1 6) (2 5) (3 4) (4 3) (5 2) (6 1) (7 0)) (num-bigger-elements '(1 2 3 4 5 6 7)))
                                      )) (eval #'num-bigger-elements ns))
      (test-suite "Empty suite")))

(define switchsum-tests
  (if (defined? switchsum)
      ((lambda (switchsum) (test-suite
                            "Tests for (switchsum f g n)"
                            (check-equal? 3 ((switchsum (lambda (x) (+ x 1)) 
                                                        (lambda (x) (* x 2)) 1) 2))
                            (check-equal? 9 ((switchsum (lambda (x) (+ x 1)) 
                                                        (lambda (x) (* x 2)) 2) 2))
                            (check-equal? 16 ((switchsum (lambda (x) (+ x 1)) 
                                                         (lambda (x) (* x 2)) 3) 2))
                            (check-equal? 30 ((switchsum (lambda (x) (+ x 1)) 
                                                         (lambda (x) (* x 2)) 4) 2))
                            (check equal? 580 ((switchsum add1 (compose add1 add1) 10) 50))
                            )) (eval #'switchsum ns))
      (test-suite "Empty suite")))

(define matrix-stuff-tests
  (if (and (defined? ~~) (defined? <<~))
      ((lambda (~~ <<~)
         (define A (list (list 1 2) 
                         (list 3 4)))
         
         (define F (list (list + +)
                         (list + +)))
         
         (define F1 (list (list (lambda (x y) (* x y 2)) (lambda (x y) (* x y 3)))
                          (list (lambda (x y) (* x y 4)) (lambda (x y) (* x y 5)))))
         
         (test-suite
          "Tests for matrix funxtions"
          (check-equal? '((2 3) (4 5)) (<<~ (~~ A F) 1))
          (check-equal?  '((11 12) (13 14)) (<<~ (~~ A F) 10))
          (check-equal? '((2 6) (12 20)) (<<~ (~~ A F1) 1))
          )) (eval #'~~ ns) (eval #'<<~ ns))
      (test-suite "Empty suite")))

(define game-of-life-tests
  (if (defined? game-of-life)
      ((lambda (game-of-life)
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
         
         (test-suite
          "Tests for (game-of-life board)"
          (check-equal? '((0 0 0 0) (0 1 1 0) (0 1 1 0) (0 0 0 0)) (game-of-life block))
          (check-equal? '((0 0 0) (1 1 1) (0 0 0)) (game-of-life blinker))
          (check-equal? '((0 0 0) (0 0 0) (0 0 0)) (game-of-life single-cell))
          (check-equal? '((0 0 0) (0 1 0) (0 0 0)) (game-of-life last-man-standing))
          )) (eval #'game-of-life ns))
      (test-suite "Empty suite")))

(displayln "Running tests for #1")
(run-tests
 sum-numbers-tests)

(displayln "Running tests for #2")
(run-tests
 num-bigger-elements-tests)

(displayln "Running tests for #3")
(run-tests
 switchsum-tests)

(displayln "Running tests for #4")
(run-tests
 matrix-stuff-tests)

(displayln "Running tests for #5")
(run-tests
 game-of-life-tests)