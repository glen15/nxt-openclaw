# OpenClaw EC2 교육 콘텐츠

EC2 환경에 [OpenClaw](https://openclaw.ai/)를 설치하고 사용하는 과정을 비개발자도 따라할 수 있도록 정리한 교육 콘텐츠입니다.

## 대상 독자

- AWS EC2를 처음 사용하는 분
- AI 비서를 직접 운영해보고 싶은 분
- 기술 배경이 없어도 따라할 수 있도록 작성

## 주의사항

> **시작하기 전에 반드시 읽어주세요.**

- **Gateway 토큰 관리**: Gateway 토큰은 비밀번호와 같습니다. 외부에 노출하지 마세요
- **AI 사용 비용**: thinking 모드(`/thinking high`)는 토큰 소비가 크므로, 필요한 경우에만 사용하세요
- **보안그룹**: 443 포트가 열려 있으면 외부 공격 표면이 됩니다. 기본 설정은 내 IP만 허용합니다
- **리소스 삭제**: `terraform destroy`를 실행하면 EC2, EBS 등 **모든 데이터가 영구 삭제**됩니다. 실행 전 백업하세요

## 문서 목차

| 장 | 제목 | 내용 |
|----|------|------|
| [01](docs/walkthrough/01-ec2-생성.md) | EC2 생성 | Terraform으로 EC2 프로비저닝 |
| [02](docs/walkthrough/02-openclaw-설치.md) | OpenClaw 설치 | 설치, 온보딩, Slack 연동, 대시보드 |
| [03](docs/walkthrough/03-대시보드-가이드.md) | 대시보드 가이드 | Control UI 8개 탭 상세 설명 |
| [04](docs/walkthrough/04-운영-레퍼런스.md) | 운영 레퍼런스 | 명령어, 팁, 트러블슈팅, 비용, FAQ |

## 필요 사항

- AWS 계정
- Anthropic Claude Pro/Max 구독 ($20~$100/월)
- 권장 EC2: t3.small (Ubuntu 22.04 LTS)

## 예상 비용

| 항목 | 월 비용 |
|------|---------|
| EC2 t3.small | ~$15 |
| Claude Pro 구독 | $20 |
| **합계** | **~$35** |

## 참고

- OpenClaw 공식 사이트: https://openclaw.ai/
- OpenClaw 문서: https://docs.openclaw.ai/
- OpenClaw GitHub: https://github.com/openclaw/openclaw
