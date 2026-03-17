# □ Doctrine (교리)

확립된 표준 절차. 모든 신규 프로젝트에 의무 적용. 위반 시 근거 필요.

---

## DC-001 — 디버깅 순서: 데이터 → 코드 → 전처리

"동일 모델/라이브러리인데 결과가 다르다" 상황에서:
1. **데이터 파일 먼저** — vocab, config, tokenizer, 가중치, 매핑 테이블
2. **코드** — 로직 차이, API 호출 순서
3. **전처리/연산** — 부동소수점, 레이아웃, 양자화 파라미터

> ⊤ 승급됨 → [AX-001](../01_axiom/debugging_order.md) | 출처: [PM-001](../05_postmortem/2026-03-14_vocab_offset_bug.md)

---

## DC-002 — 파생 파일 생성 직후 검증 체크리스트

1. 총 항목 수 = 원본 항목 수
2. index 0 내용 = 원본 index 0
3. 임의 2~3개 인덱스 교차 확인
4. 마지막 항목 확인

> ⊤ 승급됨 → [AX-002](../01_axiom/verify_generated_files.md) | 출처: [PM-001](../05_postmortem/2026-03-14_vocab_offset_bug.md)

---

## DC-003 — 구체적 사실은 확인 후 답변하라

파일명, 모델 이름, 설정값, 수치, 경로 등 구체적 사실은 반드시 파일을 읽거나 검색해서 확인한 후 답변할 것.
- 존재하지 않는 파일명을 그럴듯하게 지어내는 것은 최악의 실수
- 패턴 유추로 사실을 생성하지 말 것

> ⊤ 승급됨 → [AX-004](../01_axiom/verify_before_claiming.md) | 출처: [PM-002](../05_postmortem/2026-03-16_bcresnet_false_int8_claim.md)

---

## DC-004 — Git 커밋에 AI 흔적을 남기지 않는다

`Co-Authored-By: Claude ...` 줄을 커밋 메시지에 포함시키지 않는다. GitHub contributor 목록에 AI가 표시되며, 한번 들어가면 레포 삭제 후 재생성해야 함.

> 출처: [PM-002](../05_postmortem/2026-03-16_git_coauthor_contributor.md)

---

## DC-005 — 부정 주장(없다/불가능/미지원)은 긍정 주장보다 높은 검증 기준을 적용하라

"~없다/~안 된다" 주장 전에 반드시 전부 확인:
1. **문서** — README, 공식 가이드
2. **코드/스크립트** — 실제 구현, CLI 옵션
3. **기존 산출물** — 이미 생성된 파일, config, 로그
4. **help/usage** — 바이너리 `--help`

하나라도 확인 안 했으면 "없다"가 아닌 "확인이 필요하다"로 답할 것.

> 출처: [fp16 거짓 부정 주장](../05_postmortem/2026-03-17_fp16_false_negative_claim.md)

---

## DC-006 — 사용자가 오류를 지적하면: 사과 아닌 분석→해결→반영

1. **왜** — 근본 원인 분석
2. **어떻게** — 구체적 해결책 설계
3. **반영** — episteme/CLAUDE.md에 실제 반영

사과는 0줄, 분석+해결+반영이 전부.

> 출처: [fp16 거짓 부정 주장](../05_postmortem/2026-03-17_fp16_false_negative_claim.md)

---

## DC-007 — episteme 변경 시 반드시 즉시 커밋+푸시

episteme에 파일을 추가/수정/삭제한 뒤 반드시:
1. `build_claude_md.sh` 실행
2. git add + commit + push

로컬에만 두면 의미가 없다. 유저 요청을 기다리지 말고 즉시 푸시.

---

## DC-008 — git push 전에 반드시 원격과 동기화 확인

1. `git fetch origin`
2. `git log HEAD..origin/BRANCH --oneline` — 놓친 커밋 확인
3. 놓친 커밋이 있으면 `git pull --rebase` 후 push
4. 충돌 발생 시 유저에게 보고 후 진행
