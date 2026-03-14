# Episteme — 지식 피라미드

실제 시행착오에서 추출한 개발 지식을 계층적으로 관리하는 시스템.

## 구조

```
05_axiom/       ← 모든 프로젝트에 예외 없이 적용되는 공리
04_doctrine/    ← 확립된 표준 절차, SOP
03_premise/     ← 도메인별 설계 전제, 가정
02_praxis/      ← 재사용 가능한 스크립트, 체크리스트
01_postmortem/  ← 특정 사건의 날것 기록 (모든 지식의 원천)
```

## 승급 (Promotion)

```
postmortem → praxis → premise → doctrine → axiom
```

- 2개 이상 프로젝트에서 유효하면 한 단계 승급
- 커밋 메시지에 `[PROMOTION] 02_praxis → 03_premise` 형식으로 기록

## Claude Code 연동

```bash
# 최초 셋업 (기기마다 1회)
git clone git@github.com:nsbb/episteme.git ~/episteme
ln -sf ~/episteme/CLAUDE.md ~/.claude/CLAUDE.md

# axiom/doctrine 변경 후
cd ~/episteme && ./build_claude_md.sh
```

`CLAUDE.md`는 `build_claude_md.sh`가 `05_axiom/` + `04_doctrine/` 내용으로 자동 생성.
직접 수정하지 말 것.
