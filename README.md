# StoryToVideo (PC Client + Server + Model Skeleton) / 故事到视频单仓骨架

A minimal, extensible monorepo skeleton for the StoryToVideo MVP (PC Qt client + server APIs + model stubs) based on the provided PRD. Target: run through story → storyboard → keyframe generation → preview/export in 19 days.  
一个基于 PRD 的极简可扩展单仓骨架，包含 PC 端 Qt 客户端、服务端 API 与模型桩，目标 19 天跑通“故事→分镜→关键帧→预览/导出”全链路。

## Repo layout / 目录
- `docs/` — PRD, architecture, milestones, API draft. / 产品文档、架构、里程碑、API 草案
- `client/` — Qt/QML PC client skeleton (Windows/macOS). / PC 端 Qt/QML 骨架
- `server/` — FastAPI mock for quick iterate + Django/DRF hints. / 快速联调的 FastAPI 桩 + Django/DRF 提示
- `model/` — local model service placeholders (Qwen/SD/TTS) via FastAPI. / 本地模型服务占位（Qwen/SD/TTS）
- `frp/` — sample FRP configs. / FRP 示例配置

## Quick start (client demo UI) / 客户端快速体验
- Prereqs: Qt 6.5+ with Qt Quick, CMake, C++17 compiler. / 依赖：Qt 6.5+、Qt Quick、CMake、C++17 编译器
- Build & run / 构建运行：
  ```bash
  cd client
  cmake -S . -B build -DCMAKE_PREFIX_PATH="$(qtpaths --qt-version >/dev/null 2>&1 && qtpaths --install-prefix)"
  cmake --build build
  ./build/storytovideo
  ```
  If `qtpaths` fails, set `-DCMAKE_PREFIX_PATH` manually to your Qt install. / 若 `qtpaths` 失败，请手动设置 Qt 路径。

## Quick start (API mock) / API 桩快速体验
- Prereqs: Python 3.10+. / 依赖：Python 3.10+
- Install & run / 安装运行：
  ```bash
  cd server/fastapi_stub
  python -m venv .venv
  source .venv/bin/activate
  pip install -r requirements.txt
  uvicorn main:app --reload --port 8000
  ```

## Notes / 说明
- Server of record: Django/DRF + queue + OSS/TOS; FastAPI stub is for rapid UI integration.  
  正式服务建议 Django/DRF + 队列 + OSS/TOS；FastAPI 桩仅用于快速联调。
- Model services are decoupled, exposed via HTTP; use FRP when remote.  
  模型服务解耦并用 HTTP 暴露，远程时通过 FRP 打通。
- See `docs/PRD.md` and `docs/ARCHITECTURE.md` for scope and flows.  
  详见 `docs/PRD.md` 和 `docs/ARCHITECTURE.md` 获取范围与流程。
