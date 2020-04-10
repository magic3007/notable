#!/usr/bin/env bash

sed -i -E "s/(\(|\")([^\.]*)\.assets/\1\.\/\2\.assets/" *.md
