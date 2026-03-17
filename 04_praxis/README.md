# λ Praxis (실천)

재사용 가능한 스크립트, 체크리스트, 트러블슈팅 매뉴얼. 실행 가능한 형태.

---

## PX-001 — Git 커밋에 AI 흔적을 남기지 않는다

- **출처:** PM-002 (Co-Authored-By → GitHub contributor 노출)
- **내용:** Co-Authored-By 제거 방법 + 사후 대응 절차
- **적용:** ondevice-research

## PX-002 — 부정 주장은 높은 검증 기준 적용

- **출처:** PM-fp16 (fp16 지원을 "없다"고 단정)
- **내용:** "없다" 주장 시 문서+코드+스크립트+help+기존파일 전부 확인
- **적용:** T527-STT

## PX-003 — 사과 아닌 분석→해결→반영

- **출처:** PM-fp16
- **내용:** 오류 지적 시 근본 원인 분석 → 해결책 → episteme 반영
- **적용:** T527-STT

## PX-004 — episteme 변경 시 즉시 커밋+푸시

- **내용:** episteme 변경 후 build_claude_md.sh + git push 즉시 실행
- **적용:** all

## PX-005 — git push 전에 원격 동기화 확인

- **내용:** push 전 fetch → 놓친 커밋 확인 → pull --rebase 후 push
- **적용:** all
