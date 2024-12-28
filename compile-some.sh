function compile {
  if [ -d ${1} ]; then
    echo ""
    echo "Compiling $1"
    ${2} 2> /dev/null
    result=$?
    if [ $result -eq 1 ]; then
        echo "Failed to compile ${1} with command: ${2}"
    fi
  fi
}

compile 'zig' 'zig build-exe -O ReleaseFast -femit-bin=zig/code zig/code.zig'
compile 'rust' 'cargo build --manifest-path rust/Cargo.toml --release'
compile 'c' 'clang -O3 c/code.c -o c/code'
compile 'jvm' 'javac jvm/code.java'
#compile 'jvm' 'native-image -O3 jvm.code'
(cd clojure-native-image && clojure -M:native-image)
compile 'clojure' "(cd clojure && touch code.clj && mkdir -p classes && clojure -Sdeps '{:paths [\".\"]}' -M -e \"(compile 'code)\")"
#(cd clojure && mkdir -p classes && clojure -Sdeps '{:paths ["."]}' -M -e "(binding [*compiler-options* {:direct-linking true}] (compile 'code-dual-fibs))")q