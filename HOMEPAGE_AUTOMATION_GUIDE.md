# Claude Code + Codex 자동 홈페이지 제작 가이드

## 📋 개요
영상에서 소개된 **Claude Code + Codex 멀티 에이전트** 방식을 활용하여 **완전 자동화된 홈페이지 제작 워크플로우** 구성.

**목표**: 프롬프트 하나로 기획 → 이미지 생성 → 코딩 → 배포까지 자동화

---

## 🎯 단계별 프롬프트 구성

### Phase 1️⃣: 사전 준비 (Codex 설정 확인)

```bash
# 터미널에서 직접 실행
codex exec "시스템 설정 파일에서 image_generation 플래그를 true로 수정하고, 환경을 새로고침해줘."
```

**확인:**
```bash
grep "image_generation" ~/.codex/config.toml
# 출력: image_generation = true
```

---

### Phase 2️⃣: 홈페이지 기획 및 구조 설계

#### 프롬프트 A (기획 담당)
```
주제: 봄철 여행지 소개 홈페이지

요청:
"다음 요구사항에 맞춰 웹사이트 전체 레이아웃을 기획해줘:
- 타겟: 25-35세 직장인 (휴가 계획자)
- 테마: 신선한 봄 분위기
- 색 팔레트: 연두색(#A8D8A8), 하늘색(#87CEEB), 흰색(#FFFFFF), 강조색(#FF9800)
- 구성:
  1. 헤더 (네비게이션)
  2. 메인 배너 (봄 여행지 이미지)
  3. 4개 섹션 (각각 여행지별 설명 + 이미지)
  4. 하단 (CTA 버튼, 예약 링크)

각 섹션에 들어갈 이미지의 컨셉을 명시해줘. 예:
- 섹션 1: 벚꽃 축제 장면
- 섹션 2: 녹색 산책로
- 섹션 3: 해변 일출
- 섹션 4: 전통 마을 풍경"
```

---

### Phase 3️⃣: 이미지 자동 생성

#### 프롬프트 B (이미지 생성 담당)
```
상황: Phase 2에서 기획한 4개 섹션 컨셉 기반

요청:
"Codex를 사용해 다음 4개의 이미지를 생성해줘. 모두 1280x720 해상도, 일관된 색감(연두, 하늘색, 흰색):

1. hero_banner.png
   - 콘셉트: 봄 풍경 (산, 벚꽃, 따뜻한 햇빛)
   - 색감: 연두색 + 분홍색 벚꽃

2. section_cherry.png
   - 콘셉트: 벚꽃 축제 장면 (많은 벚꽃 나무)
   - 색감: 분홍색(#FFB6C1) + 녹색

3. section_hiking.png
   - 콘셉트: 신선한 산책로 (초록색 풍경)
   - 색감: 연두색(#A8D8A8) + 하늘색

4. section_beach.png
   - 콘셉트: 해변 일출 장면 (따뜻한 태양)
   - 색감: 주황색(#FF9800) + 하늘색(#87CEEB)

각 이미지는:
- 캡션 포함: 섹션 제목
- 일관된 폰트 사이즈
- PNG 형식으로 /home/km/codex-website/images/ 에 저장"
```

---

### Phase 4️⃣: HTML/CSS/JavaScript 코드 작성

#### 프롬프트 C (개발 담당)
```
상황: 4개의 이미지가 생성되었음

요청:
"생성된 4개의 이미지를 활용해서 반응형 홈페이지를 코딩해줘:

파일: /home/kim/codex-website/index.html

요구사항:
1. HTML 구조:
   - <!DOCTYPE html> 부터 시작
   - 메타 태그 (반응형, 인코딩)
   - SEO 최적화 (meta description, keywords)

2. CSS 스타일:
   - 색감: 연두색(#A8D8A8), 하늘색(#87CEEB), 흰색(#FFFFFF), 강조색(#FF9800)
   - 폰트: Google Fonts 'Noto Sans KR' 또는 'Poppins'
   - 반응형: 모바일(320px), 태블릿(768px), 데스크톱(1024px)
   - 섹션별 여백: padding 40px
   - 이미지: max-width 100%, height auto

3. JavaScript:
   - 스크롤 애니메이션 (Intersection Observer API)
   - 네비게이션 스티키 헤더
   - 마우스 호버 효과 (이미지 확대)
   - 모바일 메뉴 토글

4. 이미지 경로:
   - ./images/hero_banner.png
   - ./images/section_cherry.png
   - ./images/section_hiking.png
   - ./images/section_beach.png

5. 텍스트 콘텐츠 (예시):
   - 헤더: '봄 여행지, 우리 함께 떠날까요?'
   - 섹션 1: '벚꽃 축제 - 만개의 벚꽃을 만나다'
   - 섹션 2: '산책로 - 신선한 초록색으로 가득'
   - 섹션 3: '해변 일출 - 따뜻한 아침을 맞이하다'
   - 섹션 4: '전통마을 - 시간이 멈춘 곳'

6. CTA (Call-to-Action):
   - '지금 예약하기' 버튼 (배경: 주황색)
   - 클릭 시 예약 페이지로 연결

저장: /home/kim/codex-website/index.html"
```

---

### Phase 5️⃣: 검토 및 반복 개선

#### 프롬프트 D (QA 담당)
```
상황: 홈페이지가 생성됨

요청:
"생성된 홈페이지를 다음 기준으로 검토해줘:

1. 색감 일관성:
   - 모든 섹션이 연두색/하늘색/흰색을 유지하는가?
   - 이미지와 배경의 조화가 이루어졌는가?

2. 반응형 디자인:
   - 모바일에서 텍스트가 읽을 수 있는가?
   - 이미지가 모바일에서 깨지지 않는가?

3. 사용성:
   - 네비게이션이 직관적인가?
   - CTA 버튼이 눈에 띄는가?

문제 발견 시: '섹션 3의 색감이 너무 어두워. 하늘색을 더 밝게 수정해줘'와 같이 구체적으로 지시해줘."
```

---

## 🤖 자동화 워크플로우 (멀티 에이전트 방식)

### 실행 구조
```
┌─────────────────────────────────────────────┐
│      Claude Code (메인 조율자)              │
├─────────────────────────────────────────────┤
│                                             │
│  ┌─────────────────────────────────────┐   │
│  │ Agent 1: 기획 담당 (Planner)        │   │
│  │ - 레이아웃 설계                      │   │
│  │ - 컬러 팔레트 정의                  │   │
│  └─────────────────────────────────────┘   │
│           ↓                                 │
│  ┌─────────────────────────────────────┐   │
│  │ Agent 2: 이미지 생성 담당 (Designer) │   │
│  │ - Codex 이미지 생성                  │   │
│  │ - 색감 일관성 유지                  │   │
│  └─────────────────────────────────────┘   │
│           ↓                                 │
│  ┌─────────────────────────────────────┐   │
│  │ Agent 3: 개발 담당 (Developer)     │   │
│  │ - HTML/CSS/JavaScript 작성          │   │
│  │ - 반응형 디자인 구현                │   │
│  └─────────────────────────────────────┘   │
│           ↓                                 │
│  ┌─────────────────────────────────────┐   │
│  │ Agent 4: QA 담당 (Reviewer)        │   │
│  │ - 검토 및 개선 피드백                │   │
│  │ - 최종 승인                         │   │
│  └─────────────────────────────────────┘   │
│           ↓                                 │
│      최종 홈페이지 완성 ✅                 │
└─────────────────────────────────────────────┘
```

---

## 💻 실제 구현 예제

### 스크립트: 자동 홈페이지 생성
```bash
#!/bin/bash

# codex_website_generator.sh
# 완전 자동화된 홈페이지 생성

PROJECT_DIR="/home/kim/codex-website"
mkdir -p "$PROJECT_DIR/images"

echo "🚀 홈페이지 자동 생성 시작..."

# Phase 1: 기획
echo "📋 Phase 1: 기획 및 구조 설계..."
codex exec "다음 요구사항에 맞춰 웹사이트 기획을 해줘... [위의 프롬프트 A 내용]"

# Phase 2: 이미지 생성
echo "🎨 Phase 2: 이미지 자동 생성..."
python3 << 'PYTHON_EOF'
# Codex를 통한 이미지 생성
import subprocess
import os

images = {
    "hero_banner.png": "봄 풍경 (산, 벚꽃, 따뜻한 햇빛)",
    "section_cherry.png": "벚꽃 축제 장면",
    "section_hiking.png": "신선한 산책로",
    "section_beach.png": "해변 일출 장면"
}

for img, concept in images.items():
    print(f"생성 중: {img} - {concept}")
    # Codex 호출로 이미지 생성
    subprocess.run([
        "codex", "exec",
        f"다음 컨셉의 1280x720 이미지를 생성해줘: {concept}"
    ])
PYTHON_EOF

# Phase 3: HTML/CSS 생성
echo "💻 Phase 3: HTML/CSS/JavaScript 작성..."
codex exec "생성된 4개의 이미지를 활용해서 반응형 홈페이지를 코딩해줘... [위의 프롬프트 C 내용]"

# Phase 4: 검토 및 배포
echo "✅ Phase 4: 검토 및 최종 배포..."
codex exec "생성된 홈페이지를 색감, 반응형, 사용성 기준으로 검토해줘... [위의 프롬프트 D 내용]"

echo "🎉 홈페이지 생성 완료!"
echo "📍 위치: $PROJECT_DIR/index.html"
```

---

## 🎨 생성 예상 결과물

### 색감 일관성 유지
```
연두색(#A8D8A8)  ← 배경, 섹션 구분선
하늘색(#87CEEB)  ← 헤더, 이미지 오버레이
흰색(#FFFFFF)    ← 텍스트, 카드 배경
주황색(#FF9800)  ← CTA 버튼 (강조)
```

### 반응형 브레이크포인트
```
모바일:    320px - 768px   (스택 레이아웃)
태블릿:    768px - 1024px  (2열 그리드)
데스크톱:  1024px+         (3열 그리드)
```

---

## 📊 단계별 체크리스트

| 단계 | 담당 에이전트 | 산출물 | 상태 |
|------|-------------|--------|------|
| Phase 1 | Planner | 레이아웃 기획서 | ⏳ |
| Phase 2 | Designer | 4개 이미지 | ⏳ |
| Phase 3 | Developer | index.html | ⏳ |
| Phase 4 | Reviewer | QA 보고서 | ⏳ |
| 최종 | - | 배포 완료 | ⏳ |

---

## 🔄 반복 개선 프롬프트

### 색감 수정
```
"섹션 3의 하늘색이 너무 밝아. #87CEEB에서 #4A90E2로 어둡게 수정하고, 
모든 섹션의 색감을 다시 확인해줘."
```

### 폰트 크기 조정
```
"모바일에서 제목(h1)의 크기가 너무 작아 보여. 
데스크톱: 48px → 모바일: 32px로 조정하고, 
이에 맞춰 다른 텍스트 크기도 조정해줘."
```

### 애니메이션 추가
```
"섹션이 스크롤로 나타날 때 페이드인 애니메이션이 생기도록 해줘. 
Intersection Observer API를 사용해서 구현해."
```

---

## ✨ 최종 결과물 구조

```
/home/kim/codex-website/
├── index.html                 # 메인 홈페이지
├── style.css                  # (HTML에 인라인 포함 가능)
├── script.js                  # (HTML에 인라인 포함 가능)
└── images/
    ├── hero_banner.png
    ├── section_cherry.png
    ├── section_hiking.png
    └── section_beach.png
```

---

## 🚀 배포 옵션

### 옵션 1: 로컬 테스트
```bash
cd /home/kim/codex-website
python3 -m http.server 8000
# http://localhost:8000 에서 접속
```

### 옵션 2: dclub 배포 (CLAUDE.md 참조)
```bash
dclub deploy spring-website 50410
# https://spring-website.dclub.kr 자동 배포
```

---

## 💡 팁 & 트러블슈팅

### Q: 이미지가 흐릿해 보여요
**A:** Codex 이미지 생성 시 해상도를 명시하세요: "1280x720 고해상도로"

### Q: 색감이 일관성 없어요
**A:** 각 이미지 생성 프롬프트에 **정확한 Hex 색코드**를 포함하세요:
```
"배경색 #A8D8A8(연두색), 강조색 #FF9800(주황색)을 사용해서..."
```

### Q: 모바일에서 텍스트가 깨져요
**A:** CSS에 viewport 메타 태그 확인:
```html
<meta name="viewport" content="width=device-width, initial-scale=1.0">
```

---

## 📚 참고 자료

- [CSS 색상 코드](https://www.color-hex.com/)
- [Google Fonts](https://fonts.google.com/?subset=korean)
- [Intersection Observer API](https://developer.mozilla.org/en-US/docs/Web/API/Intersection_Observer_API)
- [Responsive Design](https://web.dev/responsive-web-design-basics/)

---

*이 가이드는 영상의 Claude Code + Codex 멀티 에이전트 방식을 기반으로 작성되었습니다.*  
*2026-07-03*
