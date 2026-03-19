---
id: PX-006
level: praxis
created: 2026-03-19
origin: rknn-pipeline README 다이어그램 정렬 반복 실패
applied_in: [rknn-pipeline]
---

# 한글 포함 ASCII 다이어그램 정렬 검증

## 문제

코드블록(```)에 한글이 포함되면 모노스페이스 폰트에서 정렬이 깨진다.
한글은 fullwidth(2칸), 영어는 halfwidth(1칸)인데 에디터마다 다르게 렌더링하기 때문.

Claude는 텍스트를 바이트로만 보기 때문에, 정렬이 맞는지 **눈으로 확인할 수 없다.**

## 해결: 2단계 검증

### 1단계 — display width 계산

`unicodedata.east_asian_width()`로 각 줄의 표시 폭을 계산하여 `|` 위치가 같은지 확인.

```python
import unicodedata

def display_width(s):
    """모노스페이스 폰트에서의 표시 폭 계산."""
    return sum(2 if unicodedata.east_asian_width(c) in ('W', 'F') else 1 for c in s)

# 박스 안쪽 각 줄의 | ~ | 사이 폭이 같은지 확인
lines = [
    '|  Wakeword Detection                       |',
    '|  "하이 원더" detect                       |',
    '|  threshold=0.55, EMA smoothing            |',
]
for line in lines:
    inner = line[line.index('|')+1:line.rindex('|')]
    print(f'width={display_width(inner):2d}  {line}')
```

출력: 모든 줄이 같은 width면 정렬 OK.

### 2단계 — 이미지 렌더링으로 시각 확인

Pillow로 모노스페이스 폰트를 사용해 이미지를 생성하면 Claude가 직접 눈으로 볼 수 있다.

```python
from PIL import Image, ImageDraw, ImageFont
import unicodedata

text = '''여기에 다이어그램 텍스트'''

mono_font = ImageFont.truetype('NotoSansMono-Regular.ttf', 20)  # 영문 모노스페이스
cjk_font = ImageFont.truetype('NotoSansCJK-Regular.ttc', 20)    # 한글 폰트

img = Image.new('RGB', (1000, 500), 'white')
draw = ImageDraw.Draw(img)

y = 10
for line in text.split('\n'):
    x = 10
    for ch in line:
        if ord(ch) > 0x2E80:  # CJK 문자
            draw.text((x, y), ch, fill='black', font=cjk_font)
            x += 20  # 2칸
        else:
            draw.text((x, y), ch, fill='black', font=mono_font)
            x += 10  # 1칸
    y += 24

img.save('/tmp/alignment_check.png')
# Read tool로 이미지 확인
```

핵심: 글자 단위로 그리되, CJK는 2칸(20px), ASCII는 1칸(10px)으로 배치.

## 팁

- GitHub 코드블록에서 한글 정렬 문제를 근본적으로 피하려면 **다이어그램은 영문으로 작성**
- 한글이 꼭 필요하면 `mermaid` 다이어그램 사용 (```mermaid)
- 한글 1글자 = 영문 2글자 폭. 한글 3자("하이 원더" 중 하,원,더) = 영문 6자 → 공백 3개 줄여야 함
