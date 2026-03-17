---
id: PM-005
level: postmortem
date: 2026-03-17
project: RK3588-KoCitrinet
device: rk3588
---

# RKNN Squeeze 버그 — 모델 출력이 전부 blank인 원인

## 상황

한국어 CitriNet CTC 모델을 RK3588 NPU에 FP16으로 포팅.
변환은 성공하지만 추론 결과가 **전부 blank 토큰(2048)**.

## 디버깅 과정

### 삽질 (잘못된 방향)

1. SE 블록의 마스크 체인이 문제라고 판단 → 530 노드 제거 → **효과 없음**
2. ReduceMean 버그(이미 알려진)라고 판단 → depthwise Conv로 교체 → **효과 없음**

### 핵심 단서: random input vs real input

| 입력 | ONNX↔RKNN Cosine |
|------|-------------------|
| `np.random.randn(...)` | **0.997** (정상처럼 보임) |
| 실제 mel spectrogram | **0.424** (완전히 깨짐) |

이 차이가 결정적이었다. op 버그는 입력에 무관하게 발생하므로, **데이터 레이아웃 문제**를 의심.

### Bisection으로 root cause 특정

```
전체 모델 (1005 nodes)  → cosine 0.42
Block 0 (18 nodes)      → cosine 0.73
Block 0 Conv 전 (5 nodes) → cosine -0.006 ← 여기서 이미 깨짐!
Squeeze만 (2 nodes)     → cosine -0.01  ← 범인!
```

**2번째 노드(Squeeze)에서 이미 출력이 완전히 뒤섞여 있었다.**

## Root Cause

> ### ⚠️ RKNN은 Squeeze(axis=2)를 NHWC 레이아웃의 axis에 적용한다
>
> ```
> 입력 NCHW: [1, 80, 1, 300]
> 기대 출력: [1, 80, 300]     (H=1 제거)
> RKNN 실제: 첫 값만 맞고 나머지 전부 뒤섞임
> ```
>
> RKNN 내부에서 NHWC [1, 1, 300, 80]으로 변환한 뒤
> axis=2를 적용하면 **W=300 차원이 제거**되어 완전히 다른 결과가 나온다.
>
> **Reshape으로 교체해도 동일하게 실패한다.**

## 해결

모델 I/O를 3D로 변경하여 Squeeze/Unsqueeze를 완전히 제거:
- 입력: `[1, 80, 1, 300]` → `[1, 80, 300]`
- 출력: `[1, 2049, 1, 38]` → `[1, 2049, 38]`
- RKNN은 3D 입력(1D Conv)을 정상 처리함 — 문제는 4D↔3D 변환 자체

결과: **cosine 0.999935**, 4개 테스트 ONNX와 100% 일치.

## 왜 random input에서는 정상처럼 보였나

Random 데이터는 어떤 축으로 읽어도 통계적으로 비슷한 분포를 가진다.
차원이 뒤섞여도 "비슷한 범위의 랜덤 값"이 나오므로 cosine이 높게 나온다.
**실제 구조화된 데이터(mel spectrogram)에서만 차이가 드러난다.**

## 교훈

1. **random input 테스트를 과신하지 말 것** — real data로 반드시 검증
2. **Bisection은 최고의 디버깅 도구** — 1005개 노드를 2개로 좁히는 데 3번의 실험
3. **RKNN의 NHWC 내부 변환은 Shape 변환 op과 충돌할 수 있다**

## 적용된 수정 (총 4개)

| Fix | 내용 | 제거 노드 |
|-----|------|-----------|
| 1 | LogSoftmax 제거 (빌드 크래시) | 1 |
| 2 | 마스크 SE → ReduceMean | 530 |
| 3 | ReduceMean → depthwise Conv | 23 (교체) |
| **4** | **Squeeze/Unsqueeze 제거 (root cause)** | **4** |

## 승급 후보

- → PR-002 (RKNN Squeeze/Unsqueeze 사용 금지)
- → PR-003 (RKNN 디버깅 시 random vs real input 비교 필수)
