# OpenClaw EC2 교육 콘텐츠 제작 계획

## 프로젝트 개요

EC2 환경에 OpenClaw를 설치해서 사용해보는 모든 과정을 문서화하여 교육 콘텐츠로 만들고 공유하는 프로젝트.

## Ralph Loop 상태

- **현재 Iteration**: 5/5 ✅ 완료
- **단계**: 전체 10장 문서 완성 + Notion 페이지 구성 완료

---

## OpenClaw 조사 결과 (Iteration 1에서 수집)

### OpenClaw란?

**OpenClaw**는 오픈소스 개인 AI 어시스턴트 플랫폼이다.
- **GitHub**: https://github.com/openclaw/openclaw (191k stars, MIT 라이선스)
- **공식 사이트**: https://openclaw.ai/
- **문서**: https://docs.openclaw.ai/
- **만든 사람**: @steipete

### 핵심 특징

1. **셀프 호스팅**: 내 컴퓨터/서버에서 직접 실행 (데이터가 내 것)
2. **멀티 채널**: WhatsApp, Telegram, Discord, Slack, Signal, iMessage 등 50+ 통합
3. **AI 모델 유연성**: Anthropic Claude(권장), OpenAI GPT 등 외부 API 사용
4. **항상 켜짐**: Gateway 데몬으로 24/7 실행
5. **브라우저 컨트롤**: 웹 브라우징, 폼 입력, 데이터 추출
6. **스킬/플러그인**: 커뮤니티 스킬 설치 또는 직접 제작 가능
7. **영구 메모리**: 사용자 맥락과 선호도를 기억

### 기술 스택 및 요구사항

| 항목 | 내용 |
|------|------|
| **런타임** | Node.js ≥ 22 |
| **언어** | TypeScript |
| **패키지 매니저** | npm, pnpm, bun 지원 |
| **AI 모델** | 외부 API 사용 (로컬 LLM 아님, GPU 불필요) |
| **권장 모델** | Anthropic Claude Opus 4.6 (Pro/Max 구독) |
| **OS** | macOS, Linux, Windows (WSL2) |
| **Docker** | 선택사항 (컨테이너 배포 가능) |

### 설치 방법 (3가지)

1. **원라이너 (권장)**: `curl -fsSL https://openclaw.ai/install.sh | bash`
2. **npm**: `npm i -g openclaw && openclaw onboard`
3. **소스**: `git clone` → `pnpm install` → `pnpm build`
4. **Docker**: `./docker-setup.sh`

### 아키텍처

```
WhatsApp / Telegram / Slack / Discord / Signal / iMessage / WebChat
               │
               ▼
┌───────────────────────────────┐
│            Gateway            │
│       (control plane)         │
│     ws://127.0.0.1:18789      │
└──────────────┬────────────────┘
               │
               ├─ Pi agent (RPC) ← AI 추론
               ├─ CLI (openclaw …)
               ├─ WebChat UI (브라우저 대시보드)
               ├─ macOS app
               └─ iOS / Android nodes
```

---

## EC2 사양 결정

### 결정 근거

- OpenClaw는 **로컬 LLM을 실행하지 않음** → GPU 불필요
- 외부 AI API (Anthropic/OpenAI)를 호출하는 **가벼운 Node.js 서버**
- 브라우저 컨트롤 기능 사용 시 Chromium 실행 → 메모리 여유 필요

### 권장 EC2 사양

| 항목 | 최소 사양 | 권장 사양 |
|------|----------|----------|
| **인스턴스 타입** | t3.small | t3.medium |
| **vCPU** | 2 | 2 |
| **RAM** | 2 GB | 4 GB |
| **스토리지** | 20 GB EBS (gp3) | 30 GB EBS (gp3) |
| **OS** | Amazon Linux 2023 | Ubuntu 22.04 LTS |
| **네트워크** | 보안그룹에 18789 포트 오픈 | + HTTPS(443) 포트 |

> **참고**: plan/context.md 원본에서 "Amazon Linux 2"로 되어 있었으나, OpenClaw 공식 문서가 Ubuntu 22.04+를 권장하므로 Ubuntu 22.04 LTS를 기본으로 채택. Amazon Linux 2023도 가능.

---

## 확인된 요구사항

| 항목 | 내용 |
|------|------|
| **OpenClaw** | https://openclaw.ai/ — 오픈소스 개인 AI 어시스턴트 |
| **대상 독자** | 비개발자 포함 (기술 배경 없는 사람도 따라할 수 있도록) |
| **콘텐츠 형식** | Markdown 문서 + Notion 페이지 |
| **EC2 환경** | Ubuntu 22.04 LTS (t3.medium 권장) |
| **공유 목적** | 교육 콘텐츠 |
| **필수 구독** | Anthropic Claude Pro/Max (API 키 또는 OAuth) |

---

## 교육 콘텐츠 목차 초안

> `docs/` 폴더에 Markdown 파일로 작성

### 01. OpenClaw 소개
- OpenClaw란 무엇인가?
- 왜 EC2에 설치하는가? (24/7 가동, 서버 활용)
- 필요한 것들 (AWS 계정, AI 구독)

### 02. AWS EC2 인스턴스 생성
- AWS 콘솔 접속
- EC2 인스턴스 생성 (Ubuntu 22.04, t3.medium)
- 키 페어 설정
- 보안 그룹 설정 (SSH 22, Gateway 18789, HTTPS 443)
- 인스턴스 시작 및 SSH 접속

### 03. 서버 환경 설정
- 시스템 업데이트
- Node.js 22 설치 (nvm 사용)
- 필수 패키지 설치 (git, curl 등)

### 04. OpenClaw 설치
- 원라이너 설치 또는 npm 설치
- `openclaw onboard` 실행 (온보딩 마법사)
- AI 모델 연결 (Anthropic API 키 설정)
- Gateway 데몬 설치 및 시작

### 05. 외부 접속 설정
- 방법 A: Tailscale (가장 쉬움)
- 방법 B: 리버스 프록시 (Nginx + Let's Encrypt)
- 방법 C: SSH 터널
- Control UI 접속 확인

### 06. 채널 연결 (메신저 통합)
- Telegram 봇 연결
- Discord 봇 연결
- WhatsApp 연결 (QR 코드)

### 07. 기본 사용법
- Control UI에서 채팅하기
- 메신저에서 대화하기
- 파일/URL 처리
- 스킬 설치 및 사용

### 08. 운영 및 관리
- 서비스 상태 확인
- 로그 확인
- 업데이트 방법
- 백업 전략
- 비용 최적화 팁

### 09. 트러블슈팅
- 자주 발생하는 문제와 해결법
- `openclaw doctor` 활용
- 로그 분석

### 10. 부록
- 유용한 명령어 모음
- 참고 링크
- 비용 계산기 (EC2 + AI API)

---

## Iteration 계획 (업데이트)

### Iteration 1: 정보 수집 및 요구사항 구체화 ✅
- [x] Firecrawl로 openclaw.ai 크롤링
- [x] GitHub 저장소 조사
- [x] EC2 사양 결정
- [x] 교육 콘텐츠 목차 초안 작성
- [x] 01~04장 초안 작성

### Iteration 2: 확장 콘텐츠 작성 (05~07장) ✅
- [x] 05장: 외부 접속 설정 (Tailscale, Nginx, SSH 터널)
- [x] 06장: 채널 연결 (Telegram, Discord, WhatsApp)
- [x] 07장: 기본 사용법

### Iteration 3: 운영/부록 (08~10장) ✅
- [x] 08장: 운영 및 관리
- [x] 09장: 트러블슈팅
- [x] 10장: 부록

### Iteration 4: README + 비개발자 검토 + context 업데이트 ✅
- [x] README.md 작성
- [x] 비개발자 시점 검토
- [x] context.md 최종 업데이트

### Iteration 5: 최종 검토 및 Notion 구성 ✅
- [x] 전체 문서 최종 리뷰
- [x] Notion 페이지 구성 (메인 페이지 + 10개 하위 페이지 생성 완료)
- [x] 공유 가능 상태 확인

**Notion 페이지 URL**: https://www.notion.so/3062156ceb5f81f98926fdd89745402f

---

## MCP 설정 수정 사항

`~/.claude/mcp.json`에서 Firecrawl 환경변수 불일치 수정 완료:
```
변경 전: "${FIRECRAWL_KEY}"     (존재하지 않는 변수)
변경 후: "${FIRECRAWL_API_KEY}" (.zshrc에 실제 설정된 변수)
```
