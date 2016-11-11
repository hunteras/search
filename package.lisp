;;;; package.lisp

(defpackage #:search
  (:use #:cl :debug)
  (:export :depth-first-search
           :prepend
           :breadth-first-search))

