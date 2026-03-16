---
id: PM-002
date: 2026-03-16
project: ondevice-research
severity: minor
time_wasted: ~30min
root_cause: Co-Authored-By 트레일러가 GitHub contributor 목록에 반영됨
promoted_to: []
---

# Git Co-Authored-By → GitHub Contributor 노출

## 증상
- Claude Code가 커밋 메시지에 `Co-Authored-By: Claude Opus 4.6 <noreply@anthropic.com>` 자동 추가
- GitHub 레포 contributor 목록에 Claude가 표시됨

## 시도한 해결 방법

### 1. git filter-branch (실패)
```bash
git filter-branch --msg-filter 'sed "/^Co-Authored-By:/d"' --force -- --all
git push --force origin master
```
- 커밋 메시지에서 Co-Authored-By 줄은 제거됨
- 하지만 GitHub가 옛 커밋 객체를 캐싱하여 contributor 목록 갱신 안 됨
- backup ref 삭제 + reflog expire + gc prune 해도 GitHub 캐시는 최대 24시간 유지

### 2. 레포 삭제 후 재생성 (성공)
1. `git remote remove origin`
2. GitHub에서 레포 삭제 (Settings → Danger Zone)
3. GitHub에서 동일 이름 빈 레포 재생성
4. `git remote add origin git@github.com:nsbb/ondevice-research.git`
5. `git push -u origin master`

로컬에 모든 커밋/파일이 보존되어 있으므로 데이터 손실 없음.

## 예방
- Claude Code 커밋 시 Co-Authored-By 줄이 자동 추가되는 것을 인지
- contributor에 Claude를 남기고 싶지 않으면 커밋 메시지에서 해당 줄 제거 필요
