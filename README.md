# Music-Player
![image](https://github.com/user-attachments/assets/c91af422-71b1-4a28-b93a-4d4cfb145bdf)
<br><br>

# 기술스택
- **아키텍처**
  - [The Modular Architecture(TMA) 기반의 모듈화 아키텍처](https://docs.tuist.dev/ko/guides/develop/projects/tma-architecture#the-modular-architecture-tm)
  - [Swift Composable Architecture (TCA)](https://github.com/pointfreeco/swift-composable-architecture)

- **의존성 주입**
  - [Swinject](https://github.com/Swinject/Swinject)

<br><br>


# 실행 방법
tuist 4.44.3 에서 작업되었습니다.

```
$cd {프로젝트 경로}
$make generate
```
<br><br>


# 잔여 기능
- [ ] 플레이어 > 이전곡 재생
- [ ] 플레이어 > 다음곡 재생
- [ ] 플레이어 > 한곡 반복
- [ ] 플레이어 > 다음곡부터 셔플 재생


<br><br>


# Music Player App 모듈 구조
![test drawio](https://github.com/user-attachments/assets/8418c1e7-ee00-40fd-8a9f-b411ab3074a3)

## Core Layer
### MediaKit
- 시스템 미디어 라이브러리와의 상호작용 담당
- MPMusicPlayerController 래핑
- 주요 기능:
  - 미디어 라이브러리 접근 권한 관리
  - 음악 재생/일시정지/정지 제어
  - 현재 재생 중인 곡 정보 제공
  - 재생 상태 및 시간 관찰
  - 볼륨 제어 및 볼륨 관찰

## Domain Layer
### MusicDomain
- 음악 관련 비즈니스 로직 처리

### PlayerDomain
- 재생 관련 비즈니스 로직 처리

## Feature Layer
### AlbumsFeature
- 앨범 목록 화면 담당
- 주요 기능:
  - 앨범 그리드 표시
  - 앨범 선택 및 상세 화면 이동

### AlbumDetailFeature
- 앨범 상세 화면 담당
- 주요 기능:
  - 앨범 정보 표시
  - 수록곡 목록 표시
  - 재생 제어

### PlayerFeature
- 음악 재생 UI 담당
- 주요 컴포넌트:
  - MiniPlayerView: 하단 미니 플레이어
  - PlayerView: 전체 화면 플레이어
- 주요 기능:
  - 재생/일시정지 제어
  - 재생 진행률 표시
  - 앨범 아트워크 표시

## App Layer
### App
- 앱의 진입점
- 의존성 주입 설정


<br><br><br><br><br>



