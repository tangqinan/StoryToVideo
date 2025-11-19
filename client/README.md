# PC Client (Qt/QML) / PC 客户端

Minimal Qt Quick skeleton reflecting PRD pages: Assets, Create, Storyboard, Shot Detail, Preview. Uses mock data; wire REST/WS and cache per architecture.  
最小 Qt Quick 骨架，覆盖 PRD 页（资产、新建、分镜、详情、预览），当前为占位与假数据，需按架构接入 REST/WS 与缓存。

## Build (desktop) / 构建
Prereqs: Qt 6.5+ with Quick & QuickControls2, CMake, C++17 toolchain.  
依赖：Qt 6.5+（Quick/Controls2）、CMake、C++17 工具链。

```bash
cmake -S . -B build -DCMAKE_PREFIX_PATH="<your Qt install>"
cmake --build build
./build/storytovideo
```

Notes / 说明：
- Replace mock models with network data (QNetworkAccessManager / QWebSocket). / 用网络数据替换假数据。
- Implement ViewModels for story/shot/task; persist via SQLite. / 用 ViewModel 管理状态并落盘 SQLite。
- Swap placeholders with FFmpeg/QtMultimedia playback & export. / 将占位播放器替换为 FFmpeg/QtMultimedia 播放与导出。
