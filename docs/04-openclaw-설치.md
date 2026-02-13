# 04. OpenClaw 설치

서버 환경이 준비되었으니, OpenClaw를 설치합니다.

## 설치 방법 선택

| 방법 | 난이도 | 권장 대상 |
|------|--------|----------|
| **원라이너 (권장)** | 쉬움 | 처음 사용하는 분 |
| npm 글로벌 설치 | 쉬움 | Node.js에 익숙한 분 |
| 소스 빌드 | 중간 | 커스터마이징이 필요한 분 |
| Docker | 중간 | Docker에 익숙한 분 |

## 방법 1: 원라이너 설치 (권장)

```bash
curl -fsSL https://openclaw.ai/install.sh | bash
```

이 스크립트가 자동으로:
- Node.js가 없으면 설치
- OpenClaw를 글로벌로 설치
- 필요한 의존성 설치

설치 완료 후 확인:
```bash
openclaw --version
```

## 방법 2: npm 글로벌 설치

이미 Node.js 22를 설치한 경우:

```bash
npm install -g openclaw@latest
```

설치 확인:
```bash
openclaw --version
```

## Step 1: 온보딩 마법사 실행

설치가 완료되면 온보딩 마법사를 실행합니다:

```bash
openclaw onboard --install-daemon
```

마법사가 단계별로 안내합니다:

### 1. AI 모델 설정

마법사에서 AI 제공자를 선택합니다:

- **Anthropic (권장)**: Claude Pro/Max 구독 사용
- **OpenAI**: ChatGPT/Codex 구독 사용

#### Anthropic 설정 시

두 가지 인증 방법 중 선택:

**방법 A: OAuth 로그인 (권장)**
- 마법사가 브라우저 URL을 표시합니다
- 해당 URL을 PC 브라우저에서 열어 Anthropic 계정으로 로그인
- 인증 완료 후 마법사가 자동으로 계속됩니다

> **EC2 팁**: 서버에는 브라우저가 없으므로, 표시된 URL을 복사해서 로컬 PC 브라우저에서 열어야 합니다.

**방법 B: API 키 사용**
- Anthropic 콘솔(https://console.anthropic.com/)에서 API 키 생성
- 마법사에 API 키를 입력

### 2. Gateway 설정

마법사가 Gateway 데몬 설정을 안내합니다:

- **포트**: 18789 (기본값)
- **바인딩**: loopback (기본값, 보안상 권장)
- **데몬 설치**: `--install-daemon` 플래그로 자동 설치

### 3. 채널 설정 (선택)

마법사에서 메신저 채널을 바로 설정할 수 있습니다. 나중에 해도 됩니다.

## Step 2: Gateway 상태 확인

온보딩이 완료되면 Gateway가 자동으로 시작됩니다:

```bash
# Gateway 상태 확인
openclaw gateway status
```

출력 예시:
```
Gateway is running on port 18789
```

만약 실행 중이 아니라면:
```bash
# 수동으로 Gateway 시작
openclaw gateway --port 18789 --verbose
```

## Step 3: Control UI 접속 확인

Gateway가 실행 중이면, 로컬에서 Control UI에 접속할 수 있습니다:

```bash
# 대시보드 URL 확인
openclaw dashboard --no-open
```

URL과 토큰이 출력됩니다. 이 정보는 이후 외부 접속 설정에서 사용합니다.

## Step 4: 첫 번째 대화 테스트

CLI에서 바로 AI와 대화할 수 있습니다:

```bash
# 간단한 메시지 보내기
openclaw agent --message "안녕하세요! OpenClaw가 잘 작동하나요?"
```

응답이 오면 설치 성공입니다!

## Step 5: 시스템 헬스 체크

```bash
openclaw doctor
```

이 명령은 다음을 확인합니다:
- Gateway 연결 상태
- AI 모델 인증 상태
- 채널 설정 상태
- 보안 설정 상태

문제가 있으면 구체적인 해결 방법을 안내해줍니다.

## 설치 완료!

축하합니다! OpenClaw가 EC2에서 실행되고 있습니다.

현재 상태:
- [x] Gateway 데몬이 실행 중
- [x] AI 모델이 연결됨
- [x] CLI에서 대화 가능
- [ ] 외부에서 접속 (다음 장에서 설정)
- [ ] 메신저 연결 (06장에서 설정)

---

다음 장: [05. 외부 접속 설정](./05-외부-접속-설정.md)
