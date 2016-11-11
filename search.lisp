;;;; search.lisp

(in-package #:search)

;;; "search" goes here. Hacks and glory await!

(defun tree-search (states goal-p successors combiner)
  "Find a state that satisfies goal-p. Start with states, and search according to successors and combiner."
  (dbg :search "~&;; Search: ~A" states)
  (cond ((null states) nil)
        ((funcall goal-p (first states)) (first states))
        (t (tree-search
            (funcall combiner
                     (funcall successors (first states))
                     (rest states))
            goal-p successors combiner))))

(defun depth-first-search (start goal-p successors)
  "Search new states first until goal is reached."
  (tree-search (list start) goal-p successors #'append))

(defun binary-tree (x) (list (* 2 x) (+ 1 (* 2 x))))

(defun is (value) #'(lambda (x) (eql x value)))

(defun prepend (x y)
  "Prepend y to start of x"
  (append y x))

(defun breadth-first-search (start goal-p successors)
  "Search old states first until goal is reached."
  (tree-search (list start) goal-p successors #'prepend))

(defun finite-binary-tree (n)
  "Return a successor function that generates a binary tree with n nodes."
  #'(lambda (x)
      (remove-if #'(lambda (child) (> child n))
                 (binary-tree x))))
