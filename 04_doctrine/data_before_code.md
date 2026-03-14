---
id: DC-001
promoted_to: 05_axiom/debugging_order.md
origin: 2026-03-14 T527 KoCitrinet vocab_ko.txt
---

# 디버깅 순서: 데이터 → 코드 → 전처리

"동일 모델/라이브러리인데 결과가 다르다" 상황에서:

1. **데이터 파일 먼저** — vocab, config, tokenizer, 가중치, 매핑 테이블
   - 줄 수가 기대값과 일치하는가
   - index 0 (첫 항목)이 올바른가
   - 2~3개 샘플 인덱스를 원본과 교차 확인
2. **코드** — 로직 차이, API 호출 순서
3. **전처리/연산** — 부동소수점, 레이아웃, 양자화 파라미터
