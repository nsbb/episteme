---
id: PR-002
level: premise
domain: RKNN NPU 포팅
promoted_from: 05_postmortem/2026-03-17_rknn_squeeze_bug.md
promoted_date: 2026-03-17
origin_postmortem: 05_postmortem/2026-03-17_rknn_squeeze_bug.md
applied_in: [RK3588-KoCitrinet]
---

# RKNN 모델에서 Squeeze/Unsqueeze/Reshape(차원 변환)을 사용하지 마라

## 원칙

RKNN은 내부적으로 NHWC 레이아웃을 사용한다. ONNX 모델의 Squeeze/Unsqueeze/Reshape이 차원을 변환할 때, **RKNN이 NHWC 기준으로 axis를 적용**하여 데이터가 완전히 뒤섞인다.

## 구체적으로 실패하는 패턴

```
Squeeze(axis=2) on [1, 80, 1, 300]  → cosine ≈ -0.01 (완전 랜덤)
Reshape([1, 80, 300]) on [1, 80, 1, 300] → 동일하게 실패
```

## 우회법

- 모델 I/O를 처음부터 원하는 차원으로 설계 (Squeeze 필요 없도록)
- 4D↔3D 변환이 필요한 모델은 **Squeeze를 제거하고 3D 입력으로 변경**
- RKNN은 3D 입력(1D Conv)을 정상 처리함 — 문제는 차원 변환 op 자체

## 주의: random input으로는 발견 불가

Random 데이터는 차원이 뒤섞여도 통계적 분포가 유사하여 cosine이 높게 나온다.
**반드시 실제 데이터로 검증해야 한다.**
