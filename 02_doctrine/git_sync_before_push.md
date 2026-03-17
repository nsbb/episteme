---
id: DC-008
level: doctrine
applied_in: [all]
---

# git push 전에 반드시 원격과 동기화 확인

여러 세션/디바이스/폴더에서 동일 레포에 접근할 수 있으므로, push 전에 반드시:

1. `git fetch origin` — 원격 최신 상태 가져오기
2. `git log HEAD..origin/BRANCH --oneline` — 내가 놓친 커밋 확인
3. 놓친 커밋이 있으면 `git pull --rebase` 후 push
4. 충돌 발생 시 유저에게 보고 후 진행

push 실패 시 `--force` 하지 말고 원인 먼저 파악할 것.
