#!/bin/bash
# episteme/build_claude_md.sh
# 05_axiom + 04_doctrine 내용을 합쳐서 CLAUDE.md 자동 생성
# 사용: ./build_claude_md.sh
# 결과: CLAUDE.md (→ ~/.claude/CLAUDE.md로 symlink)

set -e
cd "$(dirname "$0")"

OUT="CLAUDE.md"

cat > "$OUT" << 'HEADER'
# Episteme — Global Development Axioms & Doctrine

이 파일은 `build_claude_md.sh`로 자동 생성됩니다. 직접 수정하지 마세요.
수정하려면 `05_axiom/` 또는 `04_doctrine/` 파일을 편집 후 `./build_claude_md.sh` 실행.

---

## Axioms (공리 — 모든 프로젝트에 예외 없이 적용)

HEADER

# Axioms
for f in 05_axiom/*.md; do
  [ -f "$f" ] || continue
  # frontmatter 제거하고 본문만 추출
  sed -n '/^---$/,/^---$/!p' "$f" | sed '/^$/d' >> "$OUT"
  echo "" >> "$OUT"
done

cat >> "$OUT" << 'MID'
---

## Doctrine (교리 — 확립된 표준 절차)

MID

# Doctrine
for f in 04_doctrine/*.md; do
  [ -f "$f" ] || continue
  sed -n '/^---$/,/^---$/!p' "$f" | sed '/^$/d' >> "$OUT"
  echo "" >> "$OUT"
done

cat >> "$OUT" << 'FOOTER'
---

_하위 계층 (03_premise, 02_praxis, 01_postmortem)은 각 프로젝트의 CLAUDE.md에서 필요시 참조._
_승급: postmortem → praxis → premise → doctrine → axiom. 2개 이상 프로젝트에서 검증되면 승급 대상._
FOOTER

echo "Generated $OUT ($(wc -l < "$OUT") lines)"
