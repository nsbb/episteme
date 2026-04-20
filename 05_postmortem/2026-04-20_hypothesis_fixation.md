---
id: PM-2026-04-20-hypothesis
date: 2026-04-20
project: T527-VadPipelineService
severity: critical
time_wasted: ~6시간
root_cause: 한 가설(NPU 깨짐)에 고착되어 사용자 피드백과 코드 주석을 무시
promoted_to: []
---

# 가설 고착 — NPU 탓만 하다 마이크 캡처 경로 문제 못 찾음

## 사건

VadPipelineService에서 wakeword 감지가 간헐적으로 실패. 데브킷에서는 되고 월패드에서만 안 됨. 팀장님 앱은 같은 월패드에서 정상 동작.

## 잘못된 진단 (반복)

"NPU가 깨졌다", "NPU 메모리 풀 부족", "NPU 드라이버 리셋 필요", "Conformer와 Wakeword 동시 로드가 문제" 등 NPU 관련 가설만 6시간 동안 반복.

사용자가 "NPU 아니다", "추측하지 마라", "확인해라"를 수차례 말했으나 무시하고 같은 가설을 계속 제시.

## 실제 원인

AudioRecord가 월패드 시스템 서비스에 의해 silenced 처리됨. 코드 주석(VadPipelineService.java:279)에 이미 적혀있었음:

```java
// NOTE: 새 월패드에서는 com.android.inputdevices 등 uid:1000 시스템 서비스가 UNPROCESSED로
// mic을 항상 점유해서 silenced:true됨. 구 월패드(00f75c)에서는 정상 동작.
```

AlsaCapture.java도 이 우회용으로 만들어져 있었으나 사용하지 않고 있었음.

팀장님 앱은 Oboe(네이티브 오디오) + DMIC 라우팅으로 AudioFlinger silencing을 우회.

## 왜 못 찾았나

1. **가설 고착**: "NPU가 문제다"라는 첫 추측을 버리지 못함
2. **사용자 피드백 무시**: "NPU 아니다"를 여러 번 들었으나 무시
3. **자기 코드 주석을 안 읽음**: 수십 번 파일을 열었지만 279번 줄 주석을 원인으로 연결 안 함
4. **비교 분석 안 함**: "팀장님 앱은 되는데 우리는 안 된다" → 전체 파이프라인(마이크→전처리→추론) 비교를 안 하고 NPU만 봄
5. **AudioLevel non-zero를 "마이크 정상"으로 단정**: silenced 상태에서도 미세 값이 나올 수 있음을 고려 안 함

## Codex가 한 번에 찾은 이유

선입견 없이 전체 코드베이스를 비교. 우리 앱(AudioRecord)과 팀장님 앱(Oboe)의 캡처 경로 차이를 즉시 발견.

## 교훈

1. **사용자가 "아니다"라고 하면 즉시 폐기**: 같은 가설을 2번 이상 제시하지 마라
2. **추측보다 비교**: "왜 다른 앱은 되는데 우리는 안 되는가" → 전체 파이프라인 비교
3. **자기 코드 주석을 읽어라**: 답이 주석에 있었다
4. **확인 안 된 것은 "모르겠다"**: 추측을 사실처럼 말하지 마라
