(in-package :vpw2012)

(defun file-lines (filename)
  (iter (for line in-file filename using #'read-line)
	(collect line)))

(defparameter *problem-directory* #P"/home/serge/src/lisp/my-systems/vpw2012/data/")

(defun example-input-lines (problemname)
  (file-lines (merge-pathnames *problem-directory* (format nil "~a-voorbeeld.input.txt" problemname))))
(defun example-output-lines (problemname)
  (file-lines (merge-pathnames *problem-directory* (format nil "~a-voorbeeld.output.txt" problemname))))
(defun contest-input-lines (problemname)
  (file-lines (merge-pathnames *problem-directory* (format nil "~a-wedstrijd.input.txt" problemname))))
(defun contest-output-lines (problemname)
  (file-lines (merge-pathnames *problem-directory* (format nil "~a-wedstrijd.output.txt" problemname))))

(defun make-line-producer (lines)
  (let ((lines lines))
    #'(lambda () (prog1
		     (first lines)
		   (setf lines (rest lines))))))

(defun contest-names ()
  (list "dominos" "hercules" "morse" "veelhoeken" "woordsnippers"))

(defmacro with-contest-entries ((contest-name line-producer) &body body)
  (let ((contest-lines (gensym))
	(number-problems (gensym)))
    `(let* ((,contest-lines (contest-input-lines ,contest-name))
	    (,line-producer (make-line-producer ,contest-lines))
	    (,number-problems (parse-integer (funcall ,line-producer))))
       (iter (for problem from 1 to ,number-problems)
	     ,@body))))
