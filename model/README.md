# Model Node (Local GPU) / 模型节点

Purpose: host generation capabilities decoupled from server; accessed via HTTP (FastAPI) and optionally exposed through FRP.  
目的：承载生成能力，与服务端解耦，通过 FastAPI/HTTP 暴露，必要时用 FRP 打通。

## Suggested components / 推荐组件
- LLM: Qwen2.5-0.5B via Ollama → story structure / storyboard JSON / narration draft.  
  文本生成分镜 JSON/旁白。
- T2I: Stable Diffusion Turbo (diffusers) → keyframes. / 关键帧生图
- I2V (optional): Stable-Video-Diffusion-Img2Vid → short clips. / 图生视频（可选）
- TTS: CosyVoice-mini → narration audio. / 旁白语音

## Minimal FastAPI skeleton (pseudo) / 最小示例
```python
from fastapi import FastAPI
app = FastAPI()

@app.post("/llm/storyboard")
async def storyboard(req: dict):
    return {"shots": [...]}

@app.post("/sd_generate")
async def sd_generate(req: dict):
    return {"url": "https://.../image.png"}
```

## Deployment / 部署
- Run on local GPU; package models separately from server. / 本地 GPU 运行，独立包模型。
- Expose ports via `frpc` to cloud `frps`. / 用 frpc 将端口暴露给公网 frps。
- Upload outputs to OSS/TOS and return URLs. / 产物上传 OSS/TOS 并返回 URL。
