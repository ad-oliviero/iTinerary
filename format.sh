#!/bin/bash
for f in $(find . -name "*.swift"); do
  formatted=$(swift-format $f)
  [ ! -z $formatted ] && printf "$formatted" > $f
done
