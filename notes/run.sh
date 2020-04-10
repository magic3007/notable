#!/usr/bin/env bash

sed -i -E "s/(\(|\")([^\.]*)\.assets/\1\.\/\2\.assets/" *.md

sed -i -E "s/\!\[([^]]*)\]\(([^\)]*)\)/ <img\ src=\"\2\"\ alt=\"\1\"\ \/> /" *.md

