;;---------------------------------------------------------
;; Symbolic Expression (S-Expression)
;;---------------------------------------------------------


;;---------------------------------------------------------
;; 运算符和表达式

;;; 算数表达式
(+ 1 2)
(- 1 2)
(* 1 2)
(/ 1 2)
(% 1 2)

;;; 关系表达式
(< 1 2)
(<= 1 2)
(> 1 2)
(>= 1 2)
(= 1 2)
(/= 1 2)

;;; 逻辑表达式
(and t nil)
(or t nil)
(not t)

;;; 变量类型测试
(integerp 1)
(floatp 1.)
(numberp 1.)
(stringp "1")
;;---------------------------------------------------------


;;---------------------------------------------------------
;; elisp 内建类型

;;; 数字
(let ((foo 1.2))
  (truncate foo))

(let ((foo 1.2))
  (floor foo))

(let ((foo 1.2))
  (ceiling foo))

(let ((foo 1.2))
  (round foo))

(let ((foo -1))
  (abs foo))

(sin 1)
(cos 1)
(tan 1)
(asin 1)
(acos 1)
(atan 1)

(sqrt 1)

(exp 1)
(expt 2 2)
(log (exp 1))
(log10 10)
(logb 2)

(random t)
;;---------------------------------------------------------


;;---------------------------------------------------------
;; car cdr & cons

(car '(pine fir oak maple))
(cdr '(pine fir oak maple))

(cons 'maple nil)
(cons 'oak (cons 'mape nil))
(cons 'fir (cons 'oak (cons 'mape nil)))
(cons 'pine (cons 'fir (cons 'oak (cons 'mape nil))))

;;; Example
(defun push_front (l e)
  (cons e l))

(defun pop_front(l)
  (car l))


(defvar sample_list '(pine fir oak maple))

(setq foo ())
(let* ((l sample_list))
  (while l
	(setq foo (push_front foo (car l)))
	(setq l (cdr l))))
foo
;;---------------------------------------------------------
