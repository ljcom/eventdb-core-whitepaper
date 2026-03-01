#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "$0")/.." && pwd)"
WHITEPAPER_DIR="$ROOT_DIR/01-whitepaper"
DIAGRAM_DIR="$ROOT_DIR/02-diagrams"
OUT_DIR="$ROOT_DIR/04-build/out"
OUT_FILE="$OUT_DIR/eventdb-core-whitepaper.pdf"
TMP_MD="$OUT_DIR/.whitepaper_combined.md"
DIAGRAM_RENDER_DIR="$OUT_DIR/diagrams"
TITLE="EventDB Core: Bridging Mutable Enterprise Data and Verifiable History"

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

if ! command -v mmdc >/dev/null 2>&1; then
  cat >&2 <<'MSG'
ERROR: Mermaid CLI (mmdc) is required but not installed.
Install with one of:
  npm install -g @mermaid-js/mermaid-cli
or
  brew install mermaid-cli
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
  "$WHITEPAPER_DIR/17-blockchain-anchoring-extension-optional.md"
  "$WHITEPAPER_DIR/appendix-integrity-model.md"
  "$WHITEPAPER_DIR/18-future-development-directions.md"
)

DIAGRAM_SOURCES=(
  "$DIAGRAM_DIR/architecture.md"
  "$DIAGRAM_DIR/data-model.md"
  "$DIAGRAM_DIR/seal-window-flow.md"
  "$DIAGRAM_DIR/snapshot-flow.md"
  "$DIAGRAM_DIR/federation-boundary.md"
)

for f in "${SOURCES[@]}"; do
  if [[ ! -f "$f" ]]; then
    echo "ERROR: missing source file: $f" >&2
    exit 1
  fi
done

for f in "${DIAGRAM_SOURCES[@]}"; do
  if [[ ! -f "$f" ]]; then
    echo "ERROR: missing diagram source file: $f" >&2
    exit 1
  fi
done

mkdir -p "$DIAGRAM_RENDER_DIR"

render_mermaid_png() {
  local src_md="$1"
  local base
  local mmd_file
  local png_file

  base="$(basename "${src_md%.md}")"
  mmd_file="$DIAGRAM_RENDER_DIR/${base}.mmd"
  png_file="$DIAGRAM_RENDER_DIR/${base}.png"

  awk '
    BEGIN { in_block = 0 }
    /^```mermaid[[:space:]]*$/ { in_block = 1; next }
    /^```[[:space:]]*$/ {
      if (in_block) { in_block = 0; exit }
    }
    in_block { print }
  ' "$src_md" > "$mmd_file"

  if [[ ! -s "$mmd_file" ]]; then
    echo "ERROR: no mermaid block found in $src_md" >&2
    exit 1
  fi

  mmdc -q -i "$mmd_file" -o "$png_file"
}

for f in "${DIAGRAM_SOURCES[@]}"; do
  render_mermaid_png "$f"
done

{
  echo "% $TITLE"
  echo "% Version 0.1"
  echo "% $(date +%F)"
  echo
  echo "# $TITLE"
  echo
  for f in "${SOURCES[@]}"; do
    cat "$f"
    echo
  done
  echo "## Diagram Appendix"
  echo
  for f in "${DIAGRAM_SOURCES[@]}"; do
    base="$(basename "${f%.md}")"
    echo "### ${base//-/ }"
    echo
    echo "![${base}](diagrams/${base}.png)"
    echo
  done
} > "$TMP_MD"

BIB_FILE="$WHITEPAPER_DIR/references.bib"
PANDOC_ARGS=(
  "$TMP_MD"
  --from gfm
  --standalone
  --metadata "title=$TITLE"
  --toc
  --toc-depth=2
  --number-sections
  --resource-path="$OUT_DIR:$ROOT_DIR"
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
