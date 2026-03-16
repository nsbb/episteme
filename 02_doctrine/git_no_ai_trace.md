---
id: DC-004
level: doctrine
origin_postmortem: 05_postmortem/2026-03-16_git_coauthor_contributor.md
applied_in: [ondevice-research]
---

# Git 커밋에 AI 흔적을 남기지 않는다

## 원칙

Claude Code 등 AI 도구로 커밋할 때, Co-Authored-By 등 AI 귀속 정보가 커밋 메시지에 포함되지 않도록 한다.

## 이유

- `Co-Authored-By: Claude ...` → GitHub contributor 목록에 AI가 표시됨
- 한번 들어가면 `filter-branch`로도 GitHub 캐시 때문에 안 지워짐 → 레포 삭제 후 재생성해야 함

## 방법

커밋 메시지 끝에 자동 추가되는 아래 줄을 제거:
```
Co-Authored-By: Claude Opus 4.6 <noreply@anthropic.com>
```

## 사후 대응 (이미 들어간 경우)

1. `git filter-branch --msg-filter 'sed "/^Co-Authored-By:/d"' --force -- --all`
2. GitHub 캐시가 안 풀리면: 레포 삭제 → 동일 이름 빈 레포 재생성 → `git push`
3. 로컬에 모든 데이터가 보존되므로 손실 없음
