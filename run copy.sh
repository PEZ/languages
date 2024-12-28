function run {
  if [ -f ${2} ]; then
    echo ""
    echo "Benchmarking $1"
    hyperfine -i --shell=none --runs 3 --warmup 2 "${3} ${4}" | cut -c1-100
  else
    echo "No executable or script found for $1. Skipping."
  fi
}

# We run the benchmark with input.txt as arguments
# unless the script is run with arguments, then those will be used instead
U=${*:-$(cat input.txt)}

# run "Language" "Executable" "Command" "Arguments"
#run "Ada" "./ada/code" "./ada/code" "${U}"
#run "AWK" "./awk/code.awk" "awk -f ./awk/code.awk" "${U}"
#run "Babashka" "bb/code.clj" "bb bb/code.clj" "${U}"
run "Bun (Compiled)" "./js/bun" "./js/bun" "${U}"
run "Bun (jitless)" "./js/code.js" "bun ./js/code.js" "BUN_JSC_useJIT=0" "${U}"
run "Bun" "./js/code.js" "bun ./js/code.js" "${U}"
run "C" "./c/code" "./c/code" "${U}"
run "C#" "./csharp/code" "./csharp/code" "${U}"
#run "C# AOT" "./csharp/code-aot/code" "./csharp/code-aot/code" "${U}"
run "Chez Scheme" "./chez/code.so" "chez --program ./chez/code.so" "${U}"
run "Clojure" "./clojure/classes/code.class" "java -cp clojure/classes:$(clojure -Spath) code" "${U}"
run "Clojure Native" "./clojure-native-image/code" "./clojure-native-image/code" "${U}"
run "COBOL" "./cobol/main" "./cobol/main" "${U}"
run "Common Lisp" "./common-lisp/code" "sbcl --script common-lisp/code.lisp" "${U}"
run "CPP" "./cpp/code" "./cpp/code" "${U}"
run "Crystal" "./crystal/code" "./crystal/code" "${U}"
#run "D" "./d/code" "./d/code" "${U}"
run "Dart" "./dart/code" "./dart/code" "${U}"
run "Deno (jitless)" "./js/code.js" "deno --v8-flags=--jitless ./js/code.js" "${U}"
run "Deno" "./js/code.js" "deno run ./js/code.js" "${U}"
run "Elixir" "./elixir/bench.exs" "elixir ./elixir/bench.exs" "${U}"
run "Emojicode" "./emojicode/code" "./emojicode/code" "${U}"
run "F#" "./fsharp/code" "./fsharp/code" "${U}"
#run "F# AOT" "./fsharp/code-aot/code" "./fsharp/code-aot/code" "${U}"
run "Fortran" "./fortran/code" "./fortran/code" "${U}"
run "Free Pascal" "./fpc/code" "./fpc/code" "${U}"
run "Go" "./go/code" "./go/code" "${U}"
run "Haskell" "./haskell/code" "./haskell/code" "${U}"
#run "Haxe JVM" "haxe/code.jar" "java -jar haxe/code.jar" "${U}" # was getting errors running `haxelib install hxjava` 
run "Inko" "./inko/code" "./inko/code" "${U}"
run "Java" "./jvm/code.class" "java jvm.code" "${U}"
#run "Java Native" "./jvm.code" "./jvm.code" "${U}"
run "Julia" "./julia/code.jl" "julia ./julia/code.jl" "${U}"
run "Kotlin JVM" "kotlin/code.jar" "java -jar kotlin/code.jar" "${U}"
run "Kotlin Native" "./kotlin/code.kexe" "./kotlin/code.kexe" "${U}"
run "Lua" "./lua/code.lua" "lua ./lua/code.lua" "${U}"
run "LuaJIT" "./lua/code" "luajit ./lua/code" "${U}"
#run "MAWK" "./awk/code.awk" "mawk -f ./awk/code.awk" "${U}"
run "Nim" "./nim/code" "./nim/code" "${U}"
run "Node (jitless)" "./js/code.js" "node --jitles ./js/code.js" "${U}"
run "Node" "./js/code.js" "node ./js/code.js" "${U}"
run "Objective-C" "./objc/code" "./objc/code" "${U}"
#run "Octave" "./octave/code.m" "octave ./octave/code.m 40" "${U}"
run "Odin" "./odin/code" "./odin/code" "${U}"
run "PHP JIT" "./php/code.php" "php -dopcache.enable_cli=1 -dopcache.jit=on -dopcache.jit_buffer_size=64M ./php/code.php" "${U}"
run "PHP" "./php/code.php" "php ./php/code.php" "${U}"
run "PyPy" "./py/code.py" "pypy ./py/code.py" "${U}"
run "Python" "./py/code.py" "python3.13 ./py/code.py" "${U}"
#run "R" "./r/code.R" "Rscript ./r/code.R" "${U}"
run "Ruby YJIT" "./ruby/code.rb" "miniruby --yjit ./ruby/code.rb" "${U}"
run "Ruby" "./ruby/code.rb" "ruby ./ruby/code.rb" "${U}"
run "Rust" "./rust/target/release/code" "./rust/target/release/code" "${U}"
run "Scala" "./scala/code" "./scala/code" "${U}"
run "Scala-Native" "./scala/code-native" "./scala/code-native" "${U}"
run "Swift" "./swift/code" "./swift/code" "${U}"
run "V" "./v/code" "./v/code" "${U}"
run "Zig" "./zig/code" "./zig/code" "${U}"
