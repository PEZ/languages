(ns code
  (:gen-class))

(set! *warn-on-reflection* true)
(set! *unchecked-math* :warn-on-boxed)


(defn- fibonacci ^long [^long n]
  (loop [a 0
         b 1
         i 0]
    (if (< i n)
      (recur b (+ a b) (inc i))
      a)))

(defn -main [& args]
  (let [^long u (parse-long (first args))
        ^long runs (parse-long (second args))]
    (loop [run 0]
      (let [^long r (loop [i 1
                           sum 0]
                      (if (< i u)
                        (recur (inc i) (+ sum (fibonacci i)))
                        sum))]
        (if (< run runs)
          (recur (inc run))
          (println r))))))
