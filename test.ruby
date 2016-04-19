#!/bin/bash
source ./spec.sh

it_should_have_ruby_executable_in_path() {
  ruby --version
  assert $? 0
}

it_should_have_rubygems_installed() {
  gem env
  assert $? 0
}

run_tests
