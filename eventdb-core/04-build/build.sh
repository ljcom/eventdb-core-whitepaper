#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "$0")/.." && pwd)"
WHITEPAPER_DIR="$ROOT_DIR/01-whitepaper"
OUT_DIR="$ROOT_DIR/04-build/out"
OUT_FILE="$OUT_DIR/eventdb-core-whitepaper.pdf"
TMP_MD="$OUT_DIR/.whitepaper_combined.md"

mkdir -p "$OUT_DIR"

if ! command -v pandoc >/dev/null 2>&1; then
  echo "ERROR: pandoc is required but not installed." >&2
  exit 1
fi

PDF_ENGINE="/Library/TeX/texbin/xelatex"

if [[ ! -x "$PDF_ENGINE" ]]; then
  cat >&2 <<'MSG'
ERROR: required XeLaTeX engine not found at:
  /Library/TeX/texbin/xelatex
Install MacTeX and ensure this path is available.
MSG
  exit 1
fi

# Ordered whitepaper sources (conceptual flow)
SOURCES=(
  "$WHITEPAPER_DIR/01-abstract.md"
  "$WHITEPAPER_DIR/02-introduction.md"
  "$WHITEPAPER_DIR/03-problem-statement.md"
  "$WHITEPAPER_DIR/04-non-goals.md"
  "$WHITEPAPER_DIR/04-related-work.md"
  "$WHITEPAPER_DIR/05-design-goals.md"
  "$WHITEPAPER_DIR/06-architecture-overview.md"
  "$WHITEPAPER_DIR/07-core-data-model.md"
  "$WHITEPAPER_DIR/08-event-envelope-and-hashing.md"
  "$WHITEPAPER_DIR/09-sealing-and-windows.md"
  "$WHITEPAPER_DIR/10-snapshot-and-retention.md"
  "$WHITEPAPER_DIR/11-anchoring-interface.md"
  "$WHITEPAPER_DIR/12-federation-model.md"
  "$WHITEPAPER_DIR/12-governance-boundary.md"
  "$WHITEPAPER_DIR/13-security-and-threat-model.md"
  "$WHITEPAPER_DIR/14-performance-and-ops.md"
  "$WHITEPAPER_DIR/15-roadmap.md"
  "$WHITEPAPER_DIR/16-conclusion.md"
  "$WHITEPAPER_DIR/appendix-integrity-model.md"
)

for f in "${SOURCES[@]}"; do
  if [[ ! -f "$f" ]]; then
    echo "ERROR: missing source file: $f" >&2
    exit 1
  fi
done

{
  echo "% EventDB Core: A Deterministic Integrity Layer for Enterprise Systems Without Mandatory Blockchain"
  echo "% Version 0.1"
  echo "% $(date +%F)"
  echo
  for f in "${SOURCES[@]}"; do
    cat "$f"
    echo
    echo "\\newpage"
    echo
  done
} > "$TMP_MD"

BIB_FILE="$WHITEPAPER_DIR/references.bib"
PANDOC_ARGS=(
  "$TMP_MD"
  --from gfm
  --toc
  --toc-depth=2
  --number-sections
  --pdf-engine="$PDF_ENGINE"
  -V geometry:margin=1in
  -V colorlinks=true
  -V linkcolor=blue
  -o "$OUT_FILE"
)

if [[ -f "$BIB_FILE" ]]; then
  PANDOC_ARGS+=(--citeproc --bibliography "$BIB_FILE")
fi

pandoc "${PANDOC_ARGS[@]}"

echo "PDF generated: $OUT_FILE"
