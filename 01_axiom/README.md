# ⊤ Axiom (공리)

자명한 진리. 모든 프로젝트, 모든 환경에 예외 없이 적용. 불변.

---

## AX-001 — 동일 시스템에서 결과가 다르면, 데이터를 코드보다 먼저 의심하라

코드는 컴파일러가 검증하지만 데이터 파일은 아무도 검증하지 않는다.

> 출처: [vocab_ko.txt offset 버그](../05_postmortem/2026-03-14_vocab_offset_bug.md) → [DC-001](../02_doctrine/data_before_code.md)에서 승급

---

## AX-002 — 파생 파일은 생성 직후 원본과 대조 검증하라

총 항목 수, 첫 항목, 샘플 인덱스. 생성 직후 10초 검증이 이틀 디버깅을 방지한다.

> 출처: [vocab_ko.txt offset 버그](../05_postmortem/2026-03-14_vocab_offset_bug.md) → [DC-002](../02_doctrine/generated_file_validation.md)에서 승급

---

## AX-003 — 가장 단순한 가설부터 확인하라

파일 누락, 오타, 인덱스 오프셋을 먼저 확인한 뒤에 라이브러리 내부 동작, 하드웨어 차이, 부동소수점 정밀도를 의심하라.

> 출처: [vocab_ko.txt offset 버그](../05_postmortem/2026-03-14_vocab_offset_bug.md)

---

## AX-004 — 모르면 확인하라. 추측을 사실처럼 말하지 마라.

"알 것 같다"는 "안다"가 아니다. 확인에 2초 걸리고, 틀리면 신뢰를 잃는다.

> 출처: [BCResNet INT8 거짓 답변](../05_postmortem/2026-03-16_bcresnet_false_int8_claim.md) → [DC-003](../02_doctrine/verify_before_answering.md)에서 승급
