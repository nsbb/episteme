---
id: PR-003
level: premise
domain: RKNN NPU 디버깅
promoted_from: 05_postmortem/2026-03-17_rknn_squeeze_bug.md
promoted_date: 2026-03-17
origin_postmortem: 05_postmortem/2026-03-17_rknn_squeeze_bug.md
applied_in: [RK3588-KoCitrinet]
---

# RKNN 검증 시 random input을 과신하지 마라 — real data로 반드시 재검증

## 원칙

`np.random.randn()`으로 생성한 입력은 **데이터 레이아웃 버그를 감지할 수 없다.**
차원이 뒤섞여도 random 값의 통계적 분포는 유사하므로 cosine similarity가 높게 나온다.

## 실증

| 입력 | ONNX↔RKNN Cosine | 판정 |
|------|-------------------|------|
| `np.random.randn(1,80,1,300)` | 0.997 | "정상"처럼 보임 |
| 실제 mel spectrogram | 0.424 | 완전히 깨짐 |

## 규칙

1. RKNN 변환 후 **반드시 실제 데이터로 cosine/argmax 비교**
2. random input 테스트는 "기본 동작 확인"에만 사용
3. cosine > 0.99여도 **실제 데이터에서 다시 확인**
