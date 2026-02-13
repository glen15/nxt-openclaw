# OpenClaw EC2 교육 콘텐츠

EC2 환경에 [OpenClaw](https://openclaw.ai/)를 설치하고 사용하는 과정을 비개발자도 따라할 수 있도록 정리한 교육 콘텐츠입니다.

## 대상 독자

- AWS EC2를 처음 사용하는 분
- AI 비서를 직접 운영해보고 싶은 분
- 기술 배경이 없어도 따라할 수 있도록 작성

## 문서 목차

| 장 | 제목 | 내용 |
|----|------|------|
| [01](docs/01-openclaw-소개.md) | OpenClaw 소개 | OpenClaw란? 왜 EC2에 설치하나? |
| [02](docs/02-ec2-인스턴스-생성.md) | EC2 인스턴스 생성 | AWS 콘솔에서 서버 만들기 |
| [03](docs/03-서버-환경-설정.md) | 서버 환경 설정 | Node.js, 스왑 등 사전 준비 |
| [04](docs/04-openclaw-설치.md) | OpenClaw 설치 | 설치, 온보딩, Gateway 시작 |
| [05](docs/05-외부-접속-설정.md) | 외부 접속 설정 | Tailscale, Nginx, SSH 터널 |
| [06](docs/06-채널-연결.md) | 채널 연결 | Telegram, Discord, WhatsApp |
| [07](docs/07-기본-사용법.md) | 기본 사용법 | 채팅, 명령어, 실습 예제 |
| [08](docs/08-운영-및-관리.md) | 운영 및 관리 | 백업, 모니터링, 업데이트 |
| [09](docs/09-트러블슈팅.md) | 트러블슈팅 | 자주 발생하는 문제 해결 |
| [10](docs/10-부록.md) | 부록 | 명령어 모음, 비용 계산, FAQ |

## 필요 사항

- AWS 계정
- Anthropic Claude Pro/Max 구독 ($20~$100/월)
- 권장 EC2: t3.medium (Ubuntu 22.04 LTS)

## 예상 비용

| 항목 | 월 비용 |
|------|---------|
| EC2 t3.medium | ~$30 |
| Claude Pro 구독 | $20 |
| **합계** | **~$50** |

## 참고

- OpenClaw 공식 사이트: https://openclaw.ai/
- OpenClaw 문서: https://docs.openclaw.ai/
- OpenClaw GitHub: https://github.com/openclaw/openclaw
