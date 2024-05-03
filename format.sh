#!/bin/bash
for f in $(find . -name "*.swift"); do
  formatted=$(swift-format $f)
  printf "$formatted" > $f
done
