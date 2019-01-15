find . \( \
  -name .git -o \
  -name node_modules -o \
  -name dist -o \
  -name .nuxt -o \
  -path "./assets/js/research/*" -o \
  -path "./tests/fixtures/*" -o \
  -name package-lock.json \
\) -prune -o -type f -exec sh -c "LC_ALL=C sed '/^\s*$/d' {} | wc -l" \; | awk '{s+=$1} END {printf "%.0f Lines Of Code\n", s}'
