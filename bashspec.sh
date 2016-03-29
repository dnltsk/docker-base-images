function run_test() {
  local function=$1

  echo "=== RUN ${function}"
  local start=$(date "+%s")
  (
    exec > /tmp/${function}.testlog 2>&1
    set -x
    ${function}
  )
  result=$?

  if [ ${result} -eq 0 ]
  then
    printf -- "--- PASS: %s (%.2fs)\n" ${function} $(( $(date "+%s") - ${start} ))
  elif [ ${result} -eq 255 ]
  then
    printf -- "--- SKIP: %s (%.2fs)\n" ${function} $(( $(date "+%s") - ${start} ))
  else
    printf -- "--- FAIL: %s (%.2fs)\n" ${function} $(( $(date "+%s") - ${start} ))
    cat /tmp/${function}.testlog | sed 's/^/	/g'
    printf "\terror code: %d\n" ${result}
    echo "error occured in ${function}"
    compgen -A function | grep -o tear_down_testing_env && tear_down_testing_env
  fi
}

function SKIP_TEST() {
  exit 255
}

function assert~() {
  assert "$(echo $1 | grep -m1 -o "$2"|head -n1)" "$2"
}

function assert() {
  result=$1
  expected=$2
  description=$3

  if [ "${result}" != "${expected}" ]
  then
    if [ -n "${description}" ]
    then
      echo -e "\033[1;38;40mwhile testing ${description}\033[m"
    fi
    echo -e "\033[1;38;40merror: in test ${current_test} expected '${result}' to be '${expected}'\033[m"
    exit 1
  else
    echo "###################################### OK ##########################################"
  fi
}

function run_tests() {
  # call setup function if present
  function_list=$(compgen -A function | grep -o setup_testing_env)

  # add all functions starting with 'it_' to  the function list
  function_list="${function_list} $(compgen -A function | grep "^it_" | grep "${TESTS:-.}")"

  # call tear down function if present
  function_list="${function_list} $(compgen -A function | grep -o tear_down_testing_env)"

  for f in ${function_list}
  do
    current_test=$f
    run_test $f
  done
}
