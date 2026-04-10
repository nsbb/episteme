# Episteme — Global Development Axioms & Doctrine

이 파일은 `build_claude_md.sh`로 자동 생성됩니다. 직접 수정하지 마세요.
수정하려면 `01_axiom/` 또는 `02_doctrine/` 파일을 편집 후 `./build_claude_md.sh` 실행.

---

## Axioms (공리 — 모든 프로젝트에 예외 없이 적용)

# 동일 시스템에서 결과가 다르면, 데이터를 코드보다 먼저 의심하라
코드는 컴파일러가 검증하지만 데이터 파일은 아무도 검증하지 않는다.

# "알고 있다"는 "지키고 있다"가 아니다
규칙을 읽었다고 지키고 있는 것이 아니다.
매 실행 시점에 확인하지 않으면 습관이 규칙을 이긴다.

# 프레임워크가 없으면 설치하지 말고 환경을 먼저 찾아라
NeMo, PyTorch, TensorFlow, Acuity, ONNX Runtime 같은 **프레임워크 수준 라이브러리**가
로컬에 없다고 바로 `pip install` 하지 마라.
## 왜?
- 이미 Docker 이미지나 conda env에 올바른 버전이 설치되어 있을 확률이 높다.
- 로컬에 아무 버전이나 설치하면 **버전 불일치**로 이전에 성공했던 파이프라인이 깨진다.
- 실제 사례: 로컬 NeMo(1.20.0)로 ONNX export → Acuity import 실패. NeMo Docker(23.06)로 하면 성공.
- 실제 사례: torchvision을 로컬에 설치 → 의존성 꼬임.
## 규칙
1. **프레임워크가 없다면 먼저 확인:**
   - `docker images` → 관련 Docker 이미지
   - `docker ps -a` → 중지된 컨테이너
   - `conda env list` → conda 환경
   - 프로젝트 문서 (CLAUDE.md, README) → 지정된 환경
2. **환경이 있으면 그 안에서 실행.** 로컬에 설치하지 마라.
3. **환경이 정말 없으면** 사용자에게 먼저 확인. "Docker에 OOO 환경 있나요?" 물어라.
4. **작은 유틸리티 라이브러리**(jq, csvkit 등)는 로컬 설치 OK. 프레임워크만 해당.
## 프레임워크 vs 유틸리티 구분
**프레임워크 (로컬 설치 금지):**
NeMo, PyTorch, TensorFlow, torchvision, torchaudio, ONNX Runtime,
Acuity Toolkit, RKNN Toolkit, TensorRT, HuggingFace Transformers
**유틸리티 (로컬 설치 OK):**
onnx, onnxsim, numpy, scipy, librosa, jinja2, pyyaml, csvkit

# 가장 단순한 가설부터 확인하라
파일 누락, 오타, 인덱스 오프셋을 먼저 확인한 뒤에 라이브러리 내부 동작, 하드웨어 차이, 부동소수점 정밀도를 의심하라.

# 모르면 확인하라. 추측을 사실처럼 말하지 마라.
"알 것 같다"는 "안다"가 아니다. 확인에 2초 걸리고, 틀리면 신뢰를 잃는다.

# 파생 파일은 생성 직후 원본과 대조 검증하라
총 항목 수, 첫 항목, 샘플 인덱스. 생성 직후 10초 검증이 이틀 디버깅을 방지한다.

---

## Doctrine (교리 — 확립된 표준 절차)

# 세션 시작 시 episteme 전체(01~05)를 읽어라
CLAUDE.md에 자동 로드되는 01_axiom + 02_doctrine만 읽지 마라.
03_premise, 04_praxis, 05_postmortem도 반드시 확인하라.
자동 로드 안 된다고 안 보면 규칙을 넣은 의미가 없다.

---

_하위 계층 (03_premise, 04_praxis, 05_postmortem)은 각 프로젝트의 CLAUDE.md에서 필요시 참조._
_승급: postmortem → praxis → premise → doctrine → axiom. 2개 이상 프로젝트에서 검증되면 승급 대상._
