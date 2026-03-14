# Episteme — The Epistemic Pyramid

실제 시행착오에서 추출한 개발 지식을 계층적으로 축적·승급·동기화하는 시스템.
여러 디바이스, 여러 Claude 세션에서 동시 운영되며, 일할수록 진화한다.

---

## 1. 지식 피라미드 (The Epistemic Pyramid)

아래로 갈수록 구체적 사건, 위로 올라갈수록 보편적 진리.

```
         ∴           Episteme
        ╱──╲
       ╱ 01 ╲         Axiom (공리)         — 자명한 진리, 불변
      ╱──────╲
     ╱   02   ╲       Doctrine (교리)      — 확립된 표준, 의무
    ╱──────────╲
   ╱     03     ╲     Premise (전제)       — 도메인별 가정, 반증 가능
  ╱──────────────╲
 ╱       04       ╲   Praxis (실천)        — 재사용 도구, 체크리스트
╱──────────────────╲
╲        05        ╱  Postmortem (사후분석) — 사건 기록, 날것의 데이터
 ╲────────────────╱
```

### 계층별 기호 (논리학/수학 유니코드)

| 계층 | 기호 | 유니코드 | 출처 | 의미 |
|------|------|----------|------|------|
| 01 Axiom | ⊤ | U+22A4 | 논리학 Verum | "항상 참" — 공리는 증명 없이 참 |
| 02 Doctrine | □ | U+25A1 | 양상논리 필연 | "반드시 참" — 의무 적용 표준 |
| 03 Premise | ∵ | U+2235 | 수학 증명 | "왜냐하면" — 전제를 진술할 때 사용 |
| 04 Praxis | λ | U+03BB | 람다 대수 | 함수/계산 — 실행 가능한 도구 |
| 05 Postmortem | † | U+2020 | 학술 표기 | Dagger — 라틴어 "죽음 이후" |
| Episteme | ∴ | U+2234 | 수학 증명 | "고로" — 지식의 최종 결론 |

**기타 관련 기호:**

| 기호 | 유니코드 | 용도 |
|------|----------|------|
| ⊢ | U+22A2 | Turnstile — `⊢P` = "P는 공리/정리" |
| ∀ | U+2200 | 전칭 한정사 — "모든 ~에 대해" (Axiom의 보편성) |
| Γ | U+0393 | 감마 — 형식논리에서 공리/전제 집합 표기 |
| ⊨ | U+22A8 | Double turnstile — "의미론적으로 타당" (Doctrine 검증) |
| ◇ | U+25C7 | 양상논리 가능 — "참일 수 있다" (Premise의 반증 가능성) |
| → | U+2192 | 함축/사상 — 입력→출력 (Praxis의 변환) |
| ∃ | U+2203 | 존재 한정사 — "~인 경우가 존재한다" (Postmortem의 구체적 사건) |
| ⊥ | U+22A5 | Falsum — 모순/실패 (Postmortem의 장애 기록) |

### 01 — Axiom (공리)

- **어원**: 그리스어 *ἀξίωμα* (axiōma) = "가치 있다고 여겨지는 것". 증명 없이 참으로 받아들이는 출발점.
- **인식론적 위치**: 자명한 진리. 기술 스택이 바뀌어도 불변. 한 문장으로 압축된 본질.
- **성격**: 모든 프로젝트, 모든 환경, 모든 기술에 예외 없이 적용. 도구와 무관.
- **수명**: 사실상 영구. 무효화되려면 근본적 패러다임 전환이 필요.
- **예시**: "데이터를 코드보다 먼저 의심하라."

### 02 — Doctrine (교리)

- **어원**: 라틴어 *doctrina* = "가르침, 교육". 조직이 공유하는 확립된 지침.
- **인식론적 위치**: 검증된 표준 절차(SOP). 여러 프로젝트에서 반복 증명되어 강제력을 갖는 규범.
- **성격**: 모든 신규 프로젝트에 의무 적용. 위반 시 근거가 필요하다.
- **수명**: 강력한 반증이 있어야 변경. 안정적.
- **예시**: "디버깅 시 데이터 파일을 코드보다 먼저 확인한다."

### 03 — Premise (전제)

- **어원**: 라틴어 *praemissa* = "앞서 보낸 것". 논증의 출발점으로 삼는 가정.
- **인식론적 위치**: 도메인별 작업 가정. "이것은 참이라고 전제하고 시작한다."
- **성격**: 특정 도메인(온디바이스 AI, JNI, NPU 등)에서 유효한 설계 원칙. Doctrine보다 유연하고 반증 가능.
- **수명**: 반증되면 폐기하거나 수정. 가설의 성격.
- **예시**: "NPU 드라이버의 메모리 관리는 thread-safe하지 않다고 전제한다."

### 04 — Praxis (실천)

- **어원**: 그리스어 *πρᾶξις* = "행동, 실천". 아리스토텔레스가 theoria(관조)와 구분한 실천적 지혜.
- **인식론적 위치**: 관찰에서 추출한 행동 도구. "무엇이 일어났나" → "어떻게 막을 수 있나"로의 전환.
- **성격**: 재사용 가능한 스크립트, 체크리스트, 트러블슈팅 매뉴얼. 실행 가능한 형태.
- **수명**: 더 나은 도구가 나오면 교체. 진화한다.
- **예시**: `verify_derived_file.sh` — 파생 파일 생성 직후 자동 검증 스크립트

### 05 — Postmortem (사후분석)

- **어원**: 라틴어 *post mortem* = "죽음 이후"
- **인식론적 위치**: 경험적 관찰 데이터(Empirical observation). 모든 지식의 원천이자 날것.
- **성격**: 구체적, 시간에 묶임, 프로젝트 한정. 하나의 사건에 대한 기록.
- **수명**: 영구 보존. 삭제하지 않는다 — 과거의 맥락이 미래의 판단에 필요하다.
- **예시**: "2026-03-14: vocab_ko.txt에 `<unk>` 누락 → 2일 디버깅"

---

## 2. 승급 (Promotion)

### 승급 흐름

```
Postmortem ──→ Praxis ──→ Premise ──→ Doctrine ──→ Axiom
  (사건)       (도구화)    (일반화)     (표준화)     (철학화)
```

### 승급 조건

| 전환 | 이름 | 조건 | 행동 |
|------|------|------|------|
| 05→04 | **도구화** | 동일 유형 사건 2회+, 또는 재발 방지 도구 제작 가능 | 스크립트·체크리스트로 추출 |
| 04→03 | **일반화** | 2개+ 서로 다른 프로젝트/도메인에서 사용됨 | 구체 도구 → 추상 설계 원칙 추출 |
| 03→02 | **표준화** | 3개+ 프로젝트에서 반례 없이 유효 | 의무 적용 표준으로 격상 |
| 02→01 | **철학화** | 기술 스택이 바뀌어도 본질 불변, 1문장 압축 가능 | 기술 구체사항 제거, 보편 원리만 남김 |

### 승급 실행 방법

1. 승급 대상 파일의 내용을 상위 계층 폴더에 새 파일로 작성
2. 원본 파일의 frontmatter에 `promoted_to` 추가
3. 새 파일의 frontmatter에 `promoted_from`, `origin_postmortem`, `applied_in` 기록
4. Axiom 또는 Doctrine이 변경되면 `./build_claude_md.sh` 실행
5. `./sync.sh`로 동기화

### 파일 frontmatter 형식

```markdown
---
id: AX-001
level: axiom
promoted_from: 02_doctrine/data_before_code.md
promoted_date: 2026-03-14
origin_postmortem: 05_postmortem/2026-03-14_vocab_offset_bug.md
applied_in: [T527-KoCitrinet]
---

# 한 줄 제목

설명 본문.
```

### 커밋 컨벤션

```
[⊤ AXIOM] "파생 파일은 생성 직후 검증하라"
[□ DOCTRINE] 파생 파일 검증 의무화
[∵ PREMISE] NPU 메모리 관리 thread-unsafe 전제
[λ PRAXIS] verify_derived_file.sh 추출
[† POSTMORTEM] vocab_ko.txt offset 버그
[PROMOTION] † → λ: PM-001에서 verify 스크립트 추출
[PROMOTION] □ → ⊤: "파생 파일은 생성 직후 검증하라"
[DEMOTION] ⊤ → □: 반례 발견 — {설명}
[∴ episteme] deviceA: auto-sync 2026-03-14_15:30
[∴ episteme] deviceA: rebuild CLAUDE.md
```

### 강등(Demotion) 및 폐기

- 반례가 발견되면 강등 가능 (axiom → doctrine 등)
- 완전히 무효화되면 `_archived/` 폴더로 이동 (삭제하지 않음)

---

## 3. 동기화 (Synchronization)

### 전제 상황

- 여러 디바이스에서 서로 다른 Claude 세션이 **동시** 실행
- 각 세션이 독립적으로 학습 → git repo에 **누락 없이** 반영
- 일할수록 진화하는 시스템

### 방식: Sidecar + Auto-sync

```
Device A                         GitHub                        Device B
~/episteme/ ──push──→  nsbb/episteme  ←──pull── ~/episteme/
     ↑                                                ↑
~/.claude/CLAUDE.md                      ~/.claude/CLAUDE.md
   (symlink)                                (symlink)
     ↑                                                ↑
 Claude 세션 A                                   Claude 세션 B
(프로젝트 X 작업중)                            (프로젝트 Y 작업중)
```

**Submodule이 아닌 독립 clone을 선택하는 이유:**
- Submodule은 부모 프로젝트의 특정 commit에 고정 → 최신 지식 즉시 반영 불가
- 독립 clone은 어느 프로젝트에서든 항상 최신 episteme를 pull 가능
- Claude Code는 bash로 `~/episteme/`에 직접 접근 가능 (sidecar)

### 동기화 타이밍

| 시점 | 동작 | 이유 |
|------|------|------|
| 세션 시작 | `~/episteme/sync.sh` | 다른 디바이스의 학습 내용 수신 |
| 지식 기록 후 | `~/episteme/sync.sh` | 즉시 공유 |
| 승급 실행 후 | `build_claude_md.sh && sync.sh` | CLAUDE.md 갱신 반영 |

### 동시 쓰기 충돌 방지

**핵심 설계: Additive (새 파일 추가) 위주 운영**

- Postmortem, Praxis = **항상 새 파일 생성** → 충돌 불가
- 파일명에 타임스탬프 + 디바이스명 포함: `2026-03-14_deviceA_vocab_bug.md`
- CLAUDE.md = `build_claude_md.sh`로 재생성 가능 → 충돌 시 재생성으로 해결
- Promotion = 기존 파일 수정 → **단일 세션에서만 실행** (동시 승급 금지)

### sync.sh

`~/episteme/sync.sh` — 충돌 안전 동기화 스크립트. 상세 내용은 파일 참조.

동작 순서:
1. `git fetch` — 원격 변경사항 가져오기
2. 로컬 변경사항 커밋 (있으면)
3. `git pull --rebase` — 원격 통합 (새 파일 위주이므로 충돌 거의 없음)
4. 충돌 시 CLAUDE.md 재생성으로 자동 해결
5. `git push` — 공유 (실패 시 1회 재시도)

---

## 4. Claude Code 연동

### 자동 로드 (Axiom + Doctrine)

```
~/.claude/CLAUDE.md → symlink → ~/episteme/CLAUDE.md
```

- `build_claude_md.sh`가 `01_axiom/` + `02_doctrine/` 내용을 합쳐서 CLAUDE.md 생성
- 모든 프로젝트, 모든 세션에서 자동 적용
- Claude는 항상 최상위 2계층의 원칙을 알고 시작함

### 수동 참조 (Premise + Praxis + Postmortem)

각 프로젝트의 CLAUDE.md에 추가:

```markdown
## 지식 DB (Episteme)
작업 시작 전 `~/episteme/`의 관련 문서를 확인하라.
- `03_premise/`: 이 도메인의 설계 전제
- `04_praxis/`: 디버깅 도구/체크리스트
- `05_postmortem/`: 유사 사건 기록
지식을 기록한 후 `~/episteme/sync.sh` 실행.
```

### 작업 흐름

```
1. 세션 시작
   └→ Claude가 ~/.claude/CLAUDE.md 자동 로드 (axiom + doctrine)

2. 작업 중 — 어려운 버그 해결
   └→ ~/episteme/05_postmortem/에 기록
   └→ ~/episteme/sync.sh 실행

3. 재발 방지 도구 제작 가능?
   └→ ~/episteme/04_praxis/에 스크립트/체크리스트 작성
   └→ ~/episteme/sync.sh 실행

4. 다른 디바이스의 Claude 세션
   └→ sync.sh로 pull → 새 postmortem/praxis 즉시 활용 가능
```

---

## 5. 셋업

### 새 기기 (1회)

```bash
git clone git@github.com:nsbb/episteme.git ~/episteme
ln -sf ~/episteme/CLAUDE.md ~/.claude/CLAUDE.md
chmod +x ~/episteme/sync.sh ~/episteme/build_claude_md.sh
```

### 기존 기기 — 최신 동기화

```bash
~/episteme/sync.sh
```

---

## 6. 폴더 구조

```
~/episteme/
├── CLAUDE.md              ← 자동 생성 (build_claude_md.sh). 직접 수정 금지.
├── README.md              ← 이 문서
├── build_claude_md.sh     ← 01_axiom + 02_doctrine → CLAUDE.md 빌드
├── sync.sh                ← 충돌 안전 git 동기화
├── 01_axiom/              ← Level 1: 공리 (최상위, 불변)
├── 02_doctrine/           ← Level 2: 교리 (확립된 표준)
├── 03_premise/            ← Level 3: 전제 (도메인별 가정)
├── 04_praxis/             ← Level 4: 실천 (도구/체크리스트)
├── 05_postmortem/         ← Level 5: 사후분석 (날것의 사건 기록)
└── _archived/             ← 폐기/강등된 지식 보관
```
