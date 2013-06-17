(in-package :vpw2012)

(defclass rbt-solver () ())

(defgeneric is-solution-p (rbt-solver))
(defgeneric handle-solution (rbt-solver))
(defgeneric possible-extensions (rbt-solver))
(defgeneric extend-solution (rbt-solver extension))
(defgeneric restore-solution (rbt-solver extension))

(defmethod solve-rbt ((solver rbt-solver))
  (if (is-solution-p solver)
      (handle-solution solver)
      (iter (for extension in (possible-extensions solver))
	    (extend-solution solver extension)
	    (solve-rbt solver)
	    (restore-solution solver extension))))
