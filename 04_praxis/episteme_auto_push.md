---
id: PX-004
level: praxis
demoted_from: 02_doctrine/episteme_auto_push.md
demoted_date: 2026-03-17
demoted_reason: origin_postmortem 없이 doctrine 생성 — 사건 기반 아닌 운영 규칙
applied_in: [all]
---

# episteme 변경 시 반드시 즉시 커밋+푸시

episteme에 파일을 추가/수정/삭제한 뒤에는 반드시:
1. `build_claude_md.sh` 실행
2. git add + commit + push

episteme의 존재 이유가 모든 세션/디바이스에서 공유하는 지식이므로, 로컬에만 두면 의미가 없다. 유저 요청을 기다리지 말고 즉시 푸시할 것.
