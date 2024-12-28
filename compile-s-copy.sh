clang -O3 c/code.c -o c/code
javac jvm/code.java
(cd clojure && mkdir -p classes && clojure -Sdeps '{:paths ["."]}' -M -e "(compile 'code)")
(cd clojure && mkdir -p classes && clojure -Sdeps '{:paths ["."]}' -M -e "(binding [*compiler-options* {:direct-linking true}] (compile 'code-dual-fibs))")