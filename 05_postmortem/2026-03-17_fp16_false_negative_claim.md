---
id: PM-2026-03-17-fp16
date: 2026-03-17
project: T527-STT
severity: high
resolved: true
promoted_to: 02_doctrine/negative_claims_higher_bar.md
---

# fp16 지원을 "없다"고 단정한 오류

## 사건
Pegasus/Acuity 툴킷에서 fp16 export 옵션이 실제로 존재하는데, README 문서에 없다는 이유만으로 "fp16은 Acuity Toolkit의 양자화 옵션에 아예 없습니다"라고 단정.

## 실제 상황
- `pegasus_export_ovx_nbg.sh MODEL_NAME float` → fp16 NB 생성
- ai-sdk ReadMe.txt에 명시: "when using float to export, it will generate fp16 format source network"
- 이미 `wav2vec2_ko_base_3s_fp16.quantize` 파일이 존재
- Zipformer joiner가 실제 fp16으로 동작 중

## 실패 패턴
1. README만 grep → fp16 언급 없음
2. "문서에 없음 = 기능이 없음" 결론 (부재의 증거 오류)
3. 실제 스크립트/코드/바이너리를 확인하지 않음

## 근본 원인
기존 axiom "모르면 확인하라"는 긍정 주장(~이다)에 대한 검증을 다루지만, **부정 주장(~없다/~불가능)**에 대해서는 구체적 검증 절차가 없었음. 부정 주장은 "모든 가능한 곳을 확인해야" 반증 가능하므로 더 높은 검증 기준이 필요.

## 교훈
- "없다"는 "있다"보다 증명이 어렵다
- 문서는 불완전하다. 코드가 진실이다.
- "없다"고 말하려면: 문서 + 코드 + 스크립트 + help/usage + 기존 파일 전부 확인해야 함
