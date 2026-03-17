# † Postmortem (사후분석)

구체적 사건 기록. 모든 지식의 원천. 영구 보존, 삭제하지 않는다.

---

## PM-001 (2026-03-14) — vocab_ko.txt 1-token 오프셋 버그

- **프로젝트:** T527 KoCitrinet
- **심각도:** critical | **낭비 시간:** ~2일
- **증상:** awaiasr_2 앱 CER ~114%, bundle_app은 44.44%
- **원인:** vocab_ko.txt가 2047줄 (정상 2048줄). index 0 `<unk>` 누락 → 전체 토큰 1칸 오프셋
- **교훈:** 데이터 파일을 먼저 확인했으면 10분 안에 해결
- **승급:** → AX-001, AX-002, AX-003, DC-001, DC-002

---

## PM-002 (2026-03-16) — BCResNet 모델을 INT8이라고 거짓 답변

- **프로젝트:** RK3588-wakeword
- **심각도:** medium
- **증상:** "bcresnet_t2_int8.rknn 사용 중"이라고 답변. 실제 파일: `BCResNet-t2-npu-fixed.rknn` (FP16)
- **원인:** 단순 질문이라 확인 건너뜀 + 패턴 유추로 존재하지 않는 파일명 생성
- **교훈:** Glob/Read 한 번이면 2초 확인 가능
- **승급:** → AX-004, DC-003

---

## PM-002b (2026-03-16) — Git Co-Authored-By → GitHub Contributor 노출

- **프로젝트:** ondevice-research
- **심각도:** minor | **낭비 시간:** ~30분
- **증상:** GitHub contributor 목록에 Claude 표시
- **원인:** Claude Code가 커밋 메시지에 `Co-Authored-By` 자동 추가
- **해결:** filter-branch로 제거 실패 (GitHub 캐시) → 레포 삭제 후 재생성으로 해결
- **승급:** → DC-004

---

## PM-003 (2026-03-17) — fp16 지원을 "없다"고 단정한 오류

- **프로젝트:** T527-STT
- **심각도:** high
- **증상:** "fp16은 Acuity Toolkit에 아예 없다"고 단정
- **실제:** `pegasus_export_ovx_nbg.sh MODEL float` → fp16 NB 생성 가능. 이미 fp16.quantize 파일 존재.
- **원인:** README만 확인, 실제 스크립트/코드 미확인. 부재의 증거 오류.
- **교훈:** "없다"는 "있다"보다 증명이 어렵다. 문서는 불완전하다. 코드가 진실.
- **승급:** → DC-005, DC-006

---

## PM-004 (2026-03-17) — 문서를 하위폴더에 묻어서 유저가 찾을 수 없음

- **프로젝트:** T527 ai-sdk
- **심각도:** medium | **낭비 시간:** ~30분
- **증상:** `acuity_612_vs_621.md`를 4단계 하위폴더에 작성. GitHub에서 유저가 존재 인지 불가.
- **원인:** 중간 폴더에 README.md 없음 + SDK 레벨 문서를 모델 폴더에 배치
- **교훈:** 문서는 존재하는 것만으로 부족, 발견 가능해야 한다. 모든 폴더에 README.md, 상위에서 하위 문서 링크 필수.
- **승급:** → PR-001
