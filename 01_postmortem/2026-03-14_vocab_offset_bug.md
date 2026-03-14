---
id: PM-001
date: 2026-03-14
project: T527 KoCitrinet (awaiasr_2)
severity: critical
time_wasted: ~2 days
root_cause: vocab_ko.txt index 0에 <unk> 누락 → 전체 토큰 1칸 오프셋
promoted_to:
  - 04_doctrine/data_before_code.md
  - 04_doctrine/generated_file_validation.md
  - 05_axiom/debugging_order.md
  - 05_axiom/verify_generated_files.md
---

# vocab_ko.txt 1-token 오프셋 버그

## 증상
- awaiasr_2 앱 CER ~114%, 정확 일치 0/330
- 동일 모델을 쓰는 bundle_app은 CER 44.44%, 44/330
- 예: NPU 토큰 82 → bundle_app '네' / awaiasr_2 '그래서'

## 원인
vocab_ko.txt가 2047줄 (정상: 2048줄). 첫 줄에 `<unk>` (index 0)이 빠져 있어 모든 토큰이 1칸씩 밀림.

## 디버깅 과정에서 낭비된 시간
1. 모델 파일 MD5 비교 → 동일
2. 라이브러리 MD5 비교 → 동일
3. mel 전처리 Python 시뮬레이션 → byte-identical
4. NPU 호출 방식 코드 분석 → 동일
5. 배열 레이아웃 분석 → 동일
6. **마지막에야** vocab 파일 비교 → 1줄 차이 발견

데이터 파일을 먼저 확인했으면 10분 안에 해결 가능했음.

## 수정
tokenizer.model protobuf 파싱 → vocab_ko.txt 2048줄 재생성

## 교훈
→ AX-001: 동일 시스템에서 결과가 다르면 데이터를 코드보다 먼저 의심하라
→ AX-002: 파생 파일은 생성 직후 원본과 대조 검증하라
