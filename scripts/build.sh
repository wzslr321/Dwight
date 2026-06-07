#!/usr/bin/env bash
# build.sh — compile a Dwight notes document and report quality.
# Usage: ./scripts/build.sh path/to/notes.tex
set -euo pipefail

TEX="${1:?usage: build.sh <file.tex>}"
DIR="$(cd "$(dirname "$TEX")" && pwd)"
BASE="$(basename "${TEX%.tex}")"
cd "$DIR"

echo "▶ Compiling $BASE.tex (pass 1/2) …"
pdflatex -interaction=nonstopmode -halt-on-error "$BASE.tex" >/dev/null 2>&1 || {
  echo "✖ Compilation failed. Errors:"; grep -E "^! |^l\.[0-9]" "$BASE.log" | head -20; exit 1; }

echo "▶ Compiling $BASE.tex (pass 2/2 — ToC & cross-references) …"
pdflatex -interaction=nonstopmode "$BASE.tex" >/dev/null 2>&1 || true

# ---- quality report ----
echo
echo "── Quality report ───────────────────────────────"
ERRORS=$(grep -cE "^! " "$BASE.log" || true)
UNDEF=$(grep -ic "undefined" "$BASE.log" || true)
OVERFULL=$(grep -c "Overfull \\\\hbox" "$BASE.log" || true)
PAGES=$(pdfinfo "$BASE.pdf" 2>/dev/null | awk '/Pages/{print $2}')
echo "  errors:            ${ERRORS:-0}"
echo "  undefined refs:    ${UNDEF:-0}"
echo "  overfull hboxes:   ${OVERFULL:-0}"
echo "  pages:             ${PAGES:-?}"
WORST=$(grep "Overfull \\\\hbox" "$BASE.log" | grep -oE "\([0-9]+\.[0-9]+pt" | tr -d '(' | sort -rn | head -1 || true)
[ -n "${WORST:-}" ] && echo "  worst overfull:    ${WORST} (fix if > 15pt)"

# ---- clean aux files (keep .tex and .pdf) ----
rm -f "$BASE".{aux,log,out,toc,lof,lot,synctex.gz} 2>/dev/null || true

echo "─────────────────────────────────────────────────"
echo "✔ Built $DIR/$BASE.pdf"
