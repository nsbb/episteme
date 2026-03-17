---
id: PM-004
date: 2026-03-17
project: T527 ai-sdk
severity: medium
time_wasted: ~30분
root_cause: 문서를 모델 하위폴더 4단계 깊이에 작성 → GitHub에서 유저가 존재 인지 불가
promoted_to:
  - 03_premise/docs_discoverability.md
---

# 문서를 하위폴더에 묻어서 유저가 찾을 수 없었던 문제

## 상황

`acuity_612_vs_621.md` (Acuity 양자화 버전 비교 문서)를 `ai-sdk/models/w2v_v.1.0.0_onnx/wav2vec2_base_960h_5s/` 안에 작성.
`RESULTS.md`도 동일 위치.

## 문제

GitHub에서 레포 루트(`ai-sdk/`)에 들어온 유저가 이 문서의 존재를 알 방법이 없음:
- GitHub은 `README.md`만 자동 렌더링. 다른 이름의 .md 파일은 파일 목록에 이름만 표시.
- 4단계 하위폴더(`models/w2v.../wav2vec2.../acuity_612_vs_621.md`)까지 들어가야 파일 이름이라도 보임.
- 중간 폴더(`models/`, `w2v_v.1.0.0_onnx/`)에 README.md가 없어서 어떤 하위폴더에 뭐가 있는지 안내도 없었음.

## 해결

1. SDK 레벨 문서(`acuity_612_vs_621.md`)를 `ai-sdk/docs/`로 이동
2. 빠진 README.md 4개 생성:
   - `models/README.md` — 전체 모델 목록 + 상태 + 링크
   - `models/w2v_v.1.0.0_onnx/README.md` — 결과 요약 + 하위폴더 설명
   - `models/w2v_v.1.0.0_onnx/wav2vec2_ko_base_3s/README.md`
   - `models/w2v_v.1.0.0_onnx/wav2vec2_ko_xls_r_300m_3s/README.md`

## 교훈

문서의 존재가 GitHub UI에서 자연스럽게 노출되어야 한다. 아무리 좋은 문서도 유저가 찾을 수 없으면 없는 것과 같다.
구조상 하위폴더에 있는 건 맞지만, 상위 README.md에서 링크로 안내해야 유저가 인지할 수 있다.
