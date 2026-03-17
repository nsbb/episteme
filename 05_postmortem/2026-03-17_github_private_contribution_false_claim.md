---
id: PM-006
date: 2026-03-17
project: claude_nsbb
severity: high
time_wasted: ~5min
root_cause: GitHub private contribution 가시성 정책을 확인 없이 추측으로 단정
promoted_to: []
---

# GitHub private repo contribution 가시성을 틀리게 답변한 사건

## 사건
유저가 "private repo로 바꾸면 잔디가 안 보이냐" 질문.
"Private contributions" 설정 켜면 타인에게도 보이는데, "타인에게 절대 안 보임"이라고 단정.
유저가 직접 "56 contributions in private repositories" 보인다고 반박해서 오류 발각.

## 실패 패턴
1. GitHub 정책을 기억에 의존해서 답변
2. WebSearch로 10초면 확인 가능했는데 스킵
3. "절대"라는 단어까지 써가며 확신을 표현 — 확인 안 한 주제에 대해

## 근본 원인
AX-004 "모르면 확인하라. 추측을 사실처럼 말하지 마라" 직접 위반.
CLAUDE.md에 매 세션 로드되는 원칙인데도 외부 서비스 정책 질문에 확인 절차를 밟지 않음.

## 교훈
- 외부 서비스 정책(GitHub, AWS, Docker 등)은 자주 바뀌므로 기억 의존 금지
- "확실히 안다"는 느낌은 근거가 아님
- 확신도와 무관하게 외부 사실은 WebSearch 먼저
