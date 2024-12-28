(ns code-dual-fibs
  (:gen-class))

(set! *unchecked-math* :warn-on-boxed)

;; need a defn'd LL to trick the compiler into using invokeStatic recursively
(defn fibB
  ^long [^long n]
  n)

(defn fibonacci
  ^long [^long n]
  (if (> n 1)
    (+ (fibB (- n 1)) (fibB (- n 2)))
    n))

(defn fibB
  ^long [^long n]
  (if (> n 1)
    (+ (fibonacci (- n 1)) (fibonacci (- n 2)))
    n))

(defn -main [& args]
  (let [u (long (parse-long (first args)))]
    (loop [sum 0
           i 0]
      (if (< i u)
        (recur (+ sum (fibonacci i)) (inc i))
        (println sum)))))

(comment
  (-main "40")
  (binding [*compiler-options* {:direct-linking true}] (compile 'code-dual-fibs))
  (time (-main "40"))
  (require '[criterium.core :refer [quick-bench]])
  (quick-bench (-main "40"))
  ;; Evaluation count : 6 in 6 samples of 1 calls.
  ;;            Execution time mean : 194.793923 ms
  ;;   Execution time std-deviation : 7.976032 ms
  ;;  Execution time lower quantile : 183.871374 ms ( 2.5%)
  ;;  Execution time upper quantile : 202.375171 ms (97.5%)
  ;;                  Overhead used : 1.408749 ns
  :rcf)

;; (comment
;;   (dotimes [i 100]
;;     (print i " ")
;;     (time (code/-main "40")))
;;   (require '[clj-async-profiler.core :as prof])
;;   (prof/profile (dotimes [i 8]
;;                   (print i " ")
;;                   (time (code/-main "40"))))
;;   (prof/serve-ui 9898)
;;   :rcf)