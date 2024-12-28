(ns crit-code
  (:require
   [criterium.core :refer [bench quick-bench]])
  (:import code jcode))

(comment
  (quick-bench
   (code/-main "40")
   :runtime)
  (def a40 (into-array ["40"]))
  (quick-bench
   (jcode/main a40))
  :rcf)

