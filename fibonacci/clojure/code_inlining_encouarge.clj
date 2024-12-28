(ns code
  (:gen-class))

(set! *unchecked-math* :warn-on-boxed)

;; declare for recursion
(defn fibonacci
  ^long [^long n])

(defn fibonacci
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
  (binding [*compiler-options* {:direct-linking true}] (compile 'code))
  (dotimes [i 100]
    (print i " ")
    (time (code/-main "40")))
  (require '[clj-async-profiler.core :as prof])
  (prof/profile (dotimes [i 8]
                  (print i " ")
                  (time (code/-main "40"))))
  (prof/serve-ui 9898)
  :rcf)