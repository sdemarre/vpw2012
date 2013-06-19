(in-package :vpw2012)

(defun count-dashes-and-dots (morse-code)
  (list (count #\- morse-code)
	(count #\. morse-code)))

(defun morse-encode-and-count (number-dashes-and-dots)
  (destructuring-bind (number-dashes number-dots) number-dashes-and-dots
    (list (+ number-dashes number-dots) (+ (* 3 number-dashes) number-dots))))

(defun solve-morse-problem (line-producer)
  (destructuring-bind (morse-input repeated-morse-count)
      (split-sequence:split-sequence #\Space (funcall line-producer))
    (let ((number-dashes-and-dots (count-dashes-and-dots morse-input)))
      (dotimes (i (parse-integer repeated-morse-count))
	(setf number-dashes-and-dots (morse-encode-and-count number-dashes-and-dots)))
      (reduce #'+ number-dashes-and-dots))))

(defun solve-morse-problems ()
  (with-problem-entries ("morse" line-producer)
    (format t "~a~%" (solve-morse-problem line-producer))))
