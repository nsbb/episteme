---
id: PR-004
level: premise
domain: NPU 양자화 디버깅
applied_in: [T527-Wav2Vec2-Korean]
created_date: 2026-03-23
---

# NPU 시뮬레이션 결과를 디바이스 결과로 추정하지 마라

양자화 툴킷(Acuity 등)의 시뮬레이션 출력과 실제 NPU 디바이스 출력은 일치하지 않을 수 있다.
시뮬레이션 지표 개선이 디바이스 정확도 개선을 보장하지 않는다.

**실측 근거 (T527, wav2vec2-base-korean, kl_fqb16):**

| 비교 | argmax 일치율 |
|------|-------------|
| Sim uint8 vs FP32 | 67.1% |
| Device vs Sim uint8 | **31.5%** |

시뮬레이션 NB_agree를 58% → 70.8%로 개선했으나, 디바이스 CER은 100% → 174%로 오히려 악화.

**적용:** 양자화 품질 판단은 반드시 디바이스(vpm_run)에서 직접 수행할 것. 시뮬레이션은 동작 여부 확인용으로만 사용.
