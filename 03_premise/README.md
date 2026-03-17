# ∵ Premise (전제)

도메인별 작업 가정. 반증 가능. 특정 도메인에서 유효한 설계 원칙.

---

## PR-001 — 문서는 존재하는 것만으로는 부족하다 — 발견 가능해야 한다

- **도메인:** GitHub 레포 문서 구조
- **규칙:** 모든 폴더에 README.md, 상위 README에서 하위 문서 링크, SDK/공통 문서는 상위 배치
- **출처:** PM-004 (하위폴더에 문서 묻힘)

---

## PR-002 — RKNN 모델에서 Squeeze/Unsqueeze/Reshape(차원 변환)을 사용하지 마라

- **도메인:** RKNN NPU 포팅
- **규칙:** RKNN 내부 NHWC 변환이 차원 변환 op과 충돌. 모델 I/O를 처음부터 원하는 차원으로 설계
- **출처:** PM-005 (CitriNet Squeeze 버그)

---

## PR-003 — RKNN 검증 시 random input을 과신하지 마라

- **도메인:** RKNN NPU 디버깅
- **규칙:** random 데이터는 레이아웃 버그를 감지 못함. 반드시 실제 데이터로 cosine/argmax 비교
- **출처:** PM-005 (random cosine 0.997 vs real cosine 0.424)
