# Agent-Reach Integration Guide

Claude Code + Codex와 Agent-Reach를 함께 사용하는 완벽한 가이드

## 📋 목차
1. [Agent-Reach란?](#agent-reach란)
2. [설치 방법](#설치-방법)
3. [현재 활성화된 채널](#현재-활성화된-채널)
4. [실제 사용 예제](#실제-사용-예제)
5. [Claude Code와의 통합](#claude-code와의-통합)

---

## Agent-Reach란?

**GitHub:** https://github.com/Panniantong/Agent-Reach

AI 에이전트에게 **인터넷 전체에 접근할 수 있는 능력**을 제공하는 CLI 도구입니다.

### 주요 특징
- ✅ **15개+ 플랫폼** 지원 (X, YouTube, Reddit, GitHub, Bilibili, 소중서 등)
- ✅ **API 비용 0원** (무료)
- ✅ **Self-healing Router** - 통로 차단 시 자동 우회
- ✅ **6개 채널 즉시 사용** (설정 불필요)
- ✅ **Claude Code 완벽 통합**

---

## 설치 방법

### 1. pipx로 설치 (권장)

```bash
pipx install https://github.com/Panniantong/Agent-Reach/archive/main.zip
```

### 2. 초기화

```bash
agent-reach install --env=auto
```

### 3. 상태 확인

```bash
agent-reach doctor
```

---

## 현재 활성화된 채널

### ✅ 즉시 사용 가능 (0 설정)

| 채널 | 설명 | 사용법 |
|------|------|--------|
| **YouTube** | 영상 자막 추출 | `yt-dlp --write-auto-subs URL` |
| **V2EX** | 커뮤니티 검색 | `curl https://www.v2ex.com/api/topics/hot.json` |
| **RSS/Atom** | 구독원 읽기 | `curl RSS_URL` |
| **웹 검색 (Exa)** | 의미론적 검색 | `mcporter call 'exa.web_search_exa(...)'` |
| **웹페이지 (Jina)** | 페이지 텍스트 | `curl https://r.jina.ai/URL` |

### 🔌 선택 설치

```bash
# Twitter/X, Reddit, Instagram 등 설치
agent-reach install --channels=twitter,reddit,instagram

# 모든 채널 설치
agent-reach install --channels=all
```

---

## 실제 사용 예제

### 1. YouTube 자막 추출 및 분석

```bash
# 자막 다운로드
yt-dlp --write-auto-subs --sub-lang ko,en -o "output" https://youtu.be/VIDEO_ID

# Claude Code에서 분석
# "이 영상의 자막을 추출하고 핵심 3가지를 정리해줄래"
# → agent-reach 자동 실행
```

**예제 결과:**
```
영상: "Claude Code + Codex 완전 활용"
- 문제: AI가 인터넷 접근 불가
- 솔루션: agent-reach 설치
- 방법: pip install → agent-reach install
```

### 2. V2EX 커뮤니티 검색

```bash
# V2EX 핫 토픽 조회
curl -s "https://www.v2ex.com/api/topics/hot.json" | jq '.[0:3]'

# Claude Code에서 사용
# "V2EX에서 'AI automation' 관련 논의 찾아줄래"
```

### 3. 웹 의미론적 검색

```bash
# Exa로 검색
mcporter call 'exa.web_search_exa(query: "agent-reach tutorial", numResults: 5)'

# Claude Code에서 사용
# "최신 agent-reach 튜토리얼 찾아줄래"
```

### 4. GitHub 저장소 분석

```bash
# GitHub API + Jina Reader
curl "https://r.jina.ai/https://github.com/Panniantong/Agent-Reach"

# Claude Code에서 사용
# "이 GitHub 저장소가 뭐 하는 건지 설명해줄래"
```

---

## Claude Code와의 통합

### 방법 1: 스킬로 자동 사용

agent-reach는 Claude Code에 **스킬**로 자동 등록됩니다.

**위치:** `~/.agents/skills/agent-reach/SKILL.md`

```bash
# 확인
ls -la ~/.agents/skills/agent-reach/
```

### 방법 2: 프롬프트로 호출

```
Claude Code에게:
"YouTube 자막을 추출해줄래"
"V2EX에서 검색해줄래"
"이 웹페이지를 분석해줄래"
```

agent-reach 스킬이 자동으로 활성화됩니다.

### 방법 3: 터미널에서 직접

```bash
# 터미널에서 명령어 실행
yt-dlp --write-auto-subs URL
agent-reach doctor
```

---

## 실전 활용 시나리오

### 시나리오 1: 에러 해결

```
상황: "RuntimeError: out of memory" 발생
요청: "이 에러 메시지를 Reddit에서 검색해서 해결책을 찾아줄래"

결과: Reddit의 동일 문제 + 해결책 자동 수집
```

### 시나리오 2: 코드 리뷰

```
상황: GitHub 라이브러리 평가
요청: "이 저장소의 최근 Issue와 PR을 읽고 평가해줄래"

결과: GitHub 데이터 + Jina Reader → 종합 분석
```

### 시나리오 3: 콘텐츠 기획

```
상황: "Prompt Engineering" 트렌드 조사
요청: "X와 YouTube에서 이 주제에 대한 최신 논의를 모아줄래"

결과: 다중 플랫폼 트렌드 데이터 자동 수집
```

### 시나리오 4: 문서 번역

```
상황: 복잡한 영문 문서
요청: "이 웹페이지를 한국어로 번역해줄래"

결과: Jina Reader → 텍스트 추출 → Claude 번역
```

---

## 트러블슈팅

### Q: "X 검색이 안 돼요"
**A:** OpenCLI 설치 필요 (선택사항)
```bash
agent-reach install --channels=opencli
```

### Q: "GitHub 검색이 느려요"
**A:** gh CLI 설치 권장
```bash
brew install gh  # Mac
apt install gh   # Linux
```

### Q: "특정 사이트가 안 돼요"
**A:** Self-healing router가 자동 대체 경로 시도
```bash
agent-reach doctor  # 상태 확인
```

---

## 성능 비교

| 방식 | 비용 | 설정 | 속도 | 신뢰도 |
|------|------|------|------|--------|
| agent-reach | 0원 | 자동 | ⚡⚡ | 95%+ |
| 공식 API | 💰💰 | 복잡 | ⚡ | 99% |
| 웹 스크래핑 | 0원 | 수동 | ⚡⚡⚡ | 70% |

---

## 다음 단계

### 1. 모든 채널 활성화
```bash
agent-reach install --channels=all
```

### 2. 프로젝트에 통합
```bash
# Claude Code로 이미지 검색 + 분석 자동화
# "이 주제의 최신 이미지들을 웹에서 찾아줄래"
```

### 3. 자동화 워크플로우 구축
```bash
# Daily digest 만들기
# "매일 아침 AI 관련 트렌드를 정리해줄래"
```

---

## 참고 자료

- **공식 GitHub:** https://github.com/Panniantong/Agent-Reach
- **설치 가이드:** https://github.com/Panniantong/Agent-Reach/blob/main/docs/install.md
- **한국어 README:** https://github.com/Panniantong/Agent-Reach/blob/main/docs/README_ko.md

---

**Made with agent-reach + Claude Code**  
*2026-07-03*
