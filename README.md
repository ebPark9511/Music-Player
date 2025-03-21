# Music-Player


[![Tuist Modular Architecture](https://img.shields.io/badge/Tuist%20Modular%20Architecture-%232197D6?style=for-the-badge&logo=tuist&logoColor=white)](https://docs.tuist.dev/ko/guides/develop/projects/tma-architecture#the-modular-architecture-tma)

[![Swift Composable Architecture](https://img.shields.io/badge/Swift%20Composable%20Architecture-%23F05138?style=for-the-badge&logo=swift&logoColor=white)](https://github.com/pointfreeco/swift-composable-architecture)

[![Tuist Modular Template](https://img.shields.io/badge/Tuist%20Modular%20Template-%232197D6?style=for-the-badge&logo=tuist&logoColor=white)](https://github.com/baekteun/Tuist_Modular_Template)
[![Swinject](https://img.shields.io/badge/Swinject-%23CC3D3D?style=for-the-badge&logo=swift&logoColor=white)](https://github.com/Swinject/Swinject)


![image](https://github.com/user-attachments/assets/c91af422-71b1-4a28-b93a-4d4cfb145bdf)


# 실행 방법
4.44.3 에서 작업되었습니다.

```
$cd {프로젝트 경로}
$make generate
```


# 잔여 기능
-[] 플레이어 > 이전곡 재생
-[] 플레이어 > 다음곡 재생
-[] 플레이어 > 한곡 반복
-[] 플레이어 > 다음곡부터 셔플 재생



# Music Player App 모듈 구조

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

