#!/bin/bash -e
reportdir=$1
uid=$2

go get -u github.com/jstemmer/go-junit-report

for f in ${reportdir:=testreports}/*.log
do
  test_name=$(basename "${f}" | sed 's/\.log$//g' | tr '/:_' '-')
  cat "${f}" | go-junit-report -package-name "${test_name}" > junit-report-${test_name}.xml
done

if [ -n "${uid}" ]
then
  chown -R ${uid} *.xml
fi
