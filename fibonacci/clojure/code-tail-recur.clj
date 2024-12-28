(ns code
  (:gen-class))

(defn -main [& args]
  (let [fibonacci (fn fib ^long [^long n]
                    (letfn [(fib-helper [^long n ^long a ^long b]
                              (if (zero? n)
                                a
                                (recur (dec n) b (+ a b))))]
                      (fib-helper n 0 1)))
        ^long u (parse-long (first args))
        ^long r (loop [i 1
                       sum 0]
                  (if (< i u)
                    (recur (inc i) (long (+ sum (long (fibonacci i)))))
                    sum))]
    (println r)))
