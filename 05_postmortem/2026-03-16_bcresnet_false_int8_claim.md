---
id: PM-002
level: postmortem
date: 2026-03-16
project: RK3588-wakeword
device: rk3588
---

# BCResNet 모델을 INT8이라고 거짓 답변한 사건

## 상황

사용자가 "wakeword bcresnet이랑 stt zipformer 둘 다 fp16이냐 int8이냐" 질문.

## 잘못된 답변

- "Wakeword BCResNet: INT8 — `bcresnet_t2_int8.rknn` 사용 중"
- 실제: `BCResNet-t2-npu-fixed.rknn` (FP16). `bcresnet_t2_int8.rknn` 파일은 존재하지 않음.

## 원인 분석

1. **질문이 단순해 보여서 확인을 건너뜀** — 복잡한 작업에서는 항상 파일을 읽었지만, 단순 사실 질문에는 바로 답함
2. **패턴 유추로 파일명을 생성** — Zipformer 모델명에 "int8"이 있으니 BCResNet도 비슷할 것으로 추측. 존재하지 않는 `bcresnet_t2_int8.rknn`을 만들어냄
3. **"모른다"를 인식하지 못함** — 실제로는 BCResNet 파일명을 기억 못 하면서 "아는 것 같다"고 처리

## 영향

- 사용자 신뢰 손상
- 이후 작성한 INT8 vs FP16 비교 문서에도 잘못된 정보가 반영될 뻔함

## 교훈

- Glob/Read 한 번이면 2초 만에 확인 가능했음
- 구체적 사실(파일명, 수치, 설정값)은 항상 확인 후 답변
- → DC-003 (verify_before_answering) 승급
