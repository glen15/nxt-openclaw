# nxt-openclaw

EC2 환경에 OpenClaw를 설치하는 교육 콘텐츠 프로젝트.

## Conclave (다중 AI 협업)

다른 AI(Codex, Gemini)의 의견을 들을 때 Conclave를 사용합니다.

```bash
CONCLAVE="/Users/glen/Desktop/work/conclave/conclave.sh"

# 모든 AI에게 의견 수렴
$CONCLAVE --all ask "이 문서 구조에 대한 개선점?"

# 특정 AI에게 질문
$CONCLAVE -t codex ask "EC2 비용 최적화 방법?"
$CONCLAVE -t gemini ask "비개발자 관점에서 문서 가독성은?"

# 코드/문서 리뷰
$CONCLAVE --all review --uncommitted

# 작업 위임
$CONCLAVE -t codex delegate "트러블슈팅 섹션에 새 항목 추가"

# 병렬 위임 (worktree 경쟁)
$CONCLAVE --all delegate "문서 오류 수정"
$CONCLAVE worktree diff codex
$CONCLAVE worktree apply codex
$CONCLAVE worktree clean
```

### 등록된 멤버

| 멤버 | 모델 | 용도 |
|------|------|------|
| codex | gpt-5.3-codex | 코드/구조 분석 |
| gemini | gemini-2.5-flash | 빠른 의견, 문서 검토 |

### 주의사항

- `ask`/`review`는 읽기 전용 (파일 수정 없음)
- `delegate`만 파일 수정 가능 - 결과는 반드시 검증 후 커밋
- 기본 타임아웃 300초 (5분), `--timeout N`으로 조정 가능
- 결과 파일은 conclave 디렉토리의 `results/`에 저장됨
