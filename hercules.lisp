(in-package :vpw2012)

(defun remove-a-leaf (tree)
  (if (null (first tree))
      (rest tree)
      (cons (remove-a-leaf (first tree)) (rest tree))))

(defun snip (tree)
  (cond ((null tree) nil)
	((null (first tree)) (rest tree))
	(t
	 (let ((snipped (remove-a-leaf (first tree))))
	   (cons snipped (cons (copy-tree snipped) (rest tree)))))))

(defun hercules (tree)
  (let ((count 0))
    (iter (until (null tree))
	  (setf tree (snip tree))
	  (incf count))
    count))

(defun read-hercules-branch (line-producer)
  (let* ((branch-line-elements (split-sequence:split-sequence #\Space (funcall line-producer)))
	 (branch-name (intern (car branch-line-elements)))
	 (sub-branches
	  (iter (for sub-branch-name in (cddr branch-line-elements))
		(collect (intern sub-branch-name)))))
    (cons branch-name sub-branches)))

(defun tree-replace (tree branch-name sub-branches)
  (if (atom tree)
      (if (eq tree branch-name)
	  sub-branches
	  tree)
      (iter (for branch in tree)
	    (collect (if (and (atom branch) (eq branch branch-name))
			 sub-branches
			 (unless (null branch)
			   (tree-replace branch branch-name sub-branches)))))))

(defun make-tree-from-hash (tree-hash)
  (let ((tree '|stam|))
    (iter (for (branch-name sub-branches) in-hashtable tree-hash)
	  (setf tree (tree-replace tree branch-name sub-branches)))
    (tree-replace tree '* nil)))
(defun make-hercules-tree-from-input (line-producer)
  (let ((tree-hash (make-hash-table :test 'eq)))
    (iter (for branch-level from 1 to (parse-integer (funcall line-producer) :junk-allowed t))
	  (let ((branch (read-hercules-branch line-producer)))
	    (setf (gethash (car branch) tree-hash) (rest branch))))
    (make-tree-from-hash tree-hash)))

(defun solve-hercules-problems ()
  (let* ((hercules-lines (contest-input-lines "hercules"))
	 (line-producer (make-line-producer hercules-lines))
	 (number-problems (parse-integer (funcall line-producer) :junk-allowed t)))
    (iter (for hercules-problem-index from 1 to number-problems)
	  (let ((tree (make-hercules-tree-from-input line-producer)))
	    (format t "~a~%" (hercules tree))))))
