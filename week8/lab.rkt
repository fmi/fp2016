#lang racket

; за тестване на функцийките
(define G '((a b c d) ; от а има ребра към b,c,d
            (b e f)   ; може да бъде и ориентиран
            (c a d)
            (d b c g)
            (e)       ; връх без наследници
            (f b e)
            (g a)))

; взимане на всички върхове в графа
(define (vertices g)
  (map car g))

; директните наследници на връх в графа
(define (successors v g)
  (let [(result (assoc v g))]
    (if result (cdr result) result)))

; тъй като member връща или подсписък, или #f,
; "cast"-ваме резултата до bool с (if x #t #f)
(define (has-edge? u v g)
  (let [(result (member v (successors u g)))]
    (if result #t #f)))

; добавяне на връх в графа - само ако такъв не съществува!
(define (add-vertex v g)
    (if (member v (vertices g))
        g
        (cons (list v) g)))

; за да добавим ребро, първо трябва да добавим двата му края като върхове
(define (add-edge u v g)
  (let [(newg (add-vertex u (add-vertex v g)))]
    (map (lambda (lst) (if (equal? (car lst) u)
                           (append lst (list v))
                           lst)) newg)))

; изграждане на граф по списък от ребра
(define (graph-from-edges lst)
  ;(if (null? lst)
  ;    '()
  ;    (add-edge (caar lst) (cdar lst)
  ;              (graph-from-edges (cdr lst)))))
  (foldr (lambda (e g) (add-edge (car e) (cdr e) g)) '() lst))

; проверка за съдържане на път в граф
(define (contains-path? path g)
  (cond [(or (null? path) (null? (cdr path))) #t]
        [(has-edge? (car path) (cadr path) g)
              (contains-path? (cdr path) g)]
        [else #f]))

; помощна функция за втория вариант на решение
; от списъка '(1 2 3 4) получаваме '((1 . 2) (2 . 3) (3 . 4))
(define (make-pairs path)
  (if (or (null? path) (null? (cdr path)))
      '()
      (cons (cons (car path) (cadr path))
            (make-pairs (cdr path)))))

;(define (make-pairs* path)
;  (zip path (tail path))) ; само ако имахме zip...

; пътя декомпозираме до списък от ребра и после проверяваме
; дали има някое ребро, което не е в графа
(define (contains-path?? path g)
  (let [(edges (make-pairs path))]
    (null? (filter (lambda (e) (not (has-edge? (car e) (cdr e) g)))
                   edges))))

; директни предшественици на връх в графа
(define (predecessors v g)
  (filter (lambda (u) (has-edge? u v g)) (vertices g)))

; удължаване на път с едно ребро (всички възможни такива "удължавания"
; - подход: намираме всички върхове, които са наследници на последния връх
; в пътя, и вече не са включени в него, и после за всеки от тях append-ваме
; текущия път, за да получим всички разширени пътища.
(define (extend-path path g)
  (if (null? path)
      (map list (vertices g))
      (map (lambda (v) (append path (list v)))
           (filter (lambda (u) (not (member u path))) (successors (last path) g)))))

; превръщане на графа в списък от ребра
(define (edge-list g)
  (define (get-edges lst)
    (map (lambda (v) (cons (car lst) v)) (cdr lst)))
  (apply append (map get-edges g)))

; обръщане на графа - най-лесно с превръщане на списък в ребра,
; след което обръщаме всички ребра и построяваме наново графа
(define (invert g)
  (define (flip p) (cons (cdr p) (car p)))
  (graph-from-edges (map flip (edge-list g))))

; обхождане в ширина. Идея:
; - обхождаме графа ниво по ниво
; - на всяка стъпка изчисляваме новото ниво
; - добавяме старото към резултата от обхождането (което е същото като списъка с маркираните върхове)
;   и преминаваме към следващото ниво.
; - приключваме когато това следващо ниво е празен списък.
; генерирането на следващото ниво за улеснение е в отделна функцийка
(define (bfs v g)
  (define (get-next-level current visited)
    (apply append
           (map (lambda (u)
                  (filter (lambda (v) (not (member v (append current visited))))
                          (successors u g))) current)))
  (define (helper current visited)
    (let [(next-level (get-next-level current visited))]
      (if (null? next-level)
          (append visited current)
          (helper next-level
                  (append visited current)))))
  (helper (list v) '()))
