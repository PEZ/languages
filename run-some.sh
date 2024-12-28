# We run the benchmark with input.txt as arguments
# unless the script is run with arguments, then those will be used instead
# With arguments the check will be skipped, unless the only argument is "check"
# The special argument "check" makes the input always input.txt, and skips the benchmark

num_script_args="${#}"
script_args="${*}"
if [ "${script_args}" = "check" ]; then
  input=$(cat input.txt)
else
  input=${script_args:-$(cat input.txt)}
fi

function check {
  if [ ${num_script_args} -eq 0 ] || [ "${script_args}" = "check" ]; then
    echo "Checking $1"
    output=$(${2} ${3})
    if ! ./check.sh "$output"; then
      echo "Check failed for $1."
      return 1
    fi
  fi
}

function run {
  echo ""
  if [ -f ${2} ]; then
    check "${1}" "${3}" "${4}"
    if [ ${?} -eq 0 ] && [ "${script_args}" != "check" ]; then
      cmd=$(echo "${3} ${4}" | awk '{ if (length($0) > 80) print substr($0, 1, 60) " ..."; else print $0 }')
      echo "Benchmarking $1"
      hyperfine -i --shell=none --output=pipe --runs 3 --warmup 2 -n "${cmd}" "${3} ${4}"
    fi
  else
    echo "No executable or script found for $1. Skipping."
  fi
}

# run "Language" "Executable" "Command" "Arguments"
run "C" "./c/code" "./c/code" "${input}"
run "Clojure" "./clojure/classes/code.class" "java -cp clojure/classes:$(clojure -Spath) code" "${input}"
run "Clojure Native" "./clojure-native-image/code"  "./clojure-native-image/code" "${input}"
run "CPP" "./cpp/code" "./cpp/code" "${input}"
run "Dart" "./dart/code" "./dart/code" "${input}"
run "Fortran" "./fortran/code" "./fortran/code" "${input}"
run "Java" "./jvm/code.class" "java jvm.code" "${input}"
run "Java GraalVM" "./jvm.code" "./jvm.code" "${input}"
run "Node" "./js/code.js" "node ./js/code.js" "${input}"
#_run "Bad input to Clojure Native" "./clojure-native-image/code"  "./clojure-native-image/code" "10 ${input}"
#run "Python" "./py/code.py" "python3.13 ./py/code.py" "${input}"
#run "Babashka" "bb/code.clj" "bb bb/code.clj" "${input}"