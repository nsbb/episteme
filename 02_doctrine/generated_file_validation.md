---
id: DC-002
level: doctrine
promoted_to: 01_axiom/verify_generated_files.md
origin_postmortem: 05_postmortem/2026-03-14_vocab_offset_bug.md
applied_in: [T527-KoCitrinet]
---

# 파생 파일 생성 직후 검증 체크리스트

원본(tokenizer.model, config.json 등)에서 파생 파일(vocab.txt, lookup table 등)을 생성했으면 즉시:

1. 총 항목 수 = 원본 항목 수
2. index 0 내용 = 원본 index 0
3. 임의 2~3개 인덱스 교차 확인
4. 마지막 항목 확인

이 검증을 생성 스크립트에 내장하는 것이 이상적.
