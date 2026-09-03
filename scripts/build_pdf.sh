#!/usr/bin/env bash

set -euo pipefail

if [[ $# -ne 1 ]]; then
  echo "Usage: $0 path/to/main.tex" >&2
  exit 2
fi

main_input="$1"

if [[ ! -f "$main_input" ]]; then
  echo "LaTeX source not found: $main_input" >&2
  exit 2
fi

main_dir="$(cd "$(dirname "$main_input")" && pwd)"
main_file="$(basename "$main_input")"

if [[ "$main_file" != *.tex ]]; then
  echo "Expected a .tex main file: $main_file" >&2
  exit 2
fi

job_name="${main_file%.tex}"
cd "$main_dir"

pdflatex -interaction=nonstopmode -halt-on-error "$main_file"

if grep -q '\\bibdata' "$job_name.aux"; then
  bibtex "$job_name"
fi

pdflatex -interaction=nonstopmode -halt-on-error "$main_file"
pdflatex -interaction=nonstopmode -halt-on-error "$main_file"

if grep -Eq 'There were undefined references|Citation .* undefined|There were undefined citations' "$job_name.log"; then
  echo "Build finished with unresolved references or citations; inspect $job_name.log" >&2
  exit 1
fi

echo "Built $main_dir/$job_name.pdf"
