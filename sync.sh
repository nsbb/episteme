#!/bin/bash
# ~/episteme/sync.sh — 지식 동기화 (충돌 안전)
#
# 사용: ~/episteme/sync.sh
# 동작: pull → commit → push (additive 파일 위주이므로 충돌 거의 없음)
#
# 동시 실행 안전:
#   - Postmortem/Praxis = 새 파일 추가 → 충돌 불가
#   - CLAUDE.md 충돌 → 재생성으로 자동 해결
#   - Promotion은 단일 세션에서만 실행할 것

set -e
cd "$(dirname "$0")"
DEVICE=$(hostname)

echo "[episteme] Syncing from ${DEVICE}..."

# 1. 원격 변경사항 가져오기
git fetch origin master 2>/dev/null || git fetch origin main 2>/dev/null || true

# 브랜치 이름 감지
BRANCH=$(git rev-parse --abbrev-ref HEAD)

# 2. 로컬 변경사항이 있으면 커밋
if ! git diff --quiet 2>/dev/null || ! git diff --cached --quiet 2>/dev/null || [ -n "$(git ls-files --others --exclude-standard 2>/dev/null)" ]; then
    git add -A
    git commit -m "[episteme] ${DEVICE}: auto-sync $(date +%Y-%m-%d_%H:%M)" 2>/dev/null || true
fi

# 3. rebase로 원격 통합
git pull --rebase origin "${BRANCH}" 2>/dev/null || {
    echo "[episteme] CONFLICT detected. Attempting auto-resolve..."

    # CLAUDE.md는 항상 재생성 가능 → theirs 수락 후 재빌드
    if git diff --name-only --diff-filter=U 2>/dev/null | grep -q "CLAUDE.md"; then
        git checkout --theirs CLAUDE.md 2>/dev/null || true
        git add CLAUDE.md 2>/dev/null || true
    fi

    # 나머지 충돌은 rebase 계속 시도
    git rebase --continue 2>/dev/null || {
        echo "[episteme] WARNING: Auto-resolve failed. Aborting rebase."
        git rebase --abort 2>/dev/null || true
        echo "[episteme] Manual conflict resolution needed."
        exit 1
    }
}

# 4. CLAUDE.md 재생성 (axiom/doctrine 변경이 있었을 수 있으므로)
if [ -x "./build_claude_md.sh" ]; then
    ./build_claude_md.sh >/dev/null 2>&1
    if ! git diff --quiet CLAUDE.md 2>/dev/null; then
        git add CLAUDE.md
        git commit -m "[episteme] ${DEVICE}: rebuild CLAUDE.md" 2>/dev/null || true
    fi
fi

# 5. push (실패 시 1회 재시도)
git push origin "${BRANCH}" 2>/dev/null || {
    echo "[episteme] Push failed, retrying after pull..."
    git pull --rebase origin "${BRANCH}" 2>/dev/null
    git push origin "${BRANCH}" 2>/dev/null || {
        echo "[episteme] Push failed after retry. Check network or conflicts."
        exit 1
    }
}

echo "[episteme] Synced OK — $(date +%Y-%m-%d_%H:%M:%S)"
