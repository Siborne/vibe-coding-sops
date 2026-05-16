# README 编写规则

README 是其他开发者的首次接触点。好的 README 按漏斗式组织，立即回答四个问题。

## 漏斗式组织

像漏斗一样从宽到窄：顶部用一句话描述，让人在几秒内判断它是否解决自己的问题，然后逐步增加细节。按顺序回答四个问题：

1. **它做什么？** —— 一句话 + 可选视觉示意（截图、动图、图）
2. **我为何要在乎？** —— 核心价值主张，它解决什么痛点
3. **如何使用？** —— 先展示用法，让人看到能得到什么
4. **如何安装？** —— 最后才讲安装步骤，人们决定投入后才需要

> 先展示用法再讲安装——人们想先看到能得到什么，再决定是否投入安装步骤。

## 示例：好的 README 结构

```markdown
# lazydocker

Terminal UI for Docker, built with Go and gocui.

<p align="center">
  <img src="demo.gif" width="600">
</p>

## 为什么用 lazydocker

在终端里管理 Docker 通常是 `docker` + `docker-compose` + 手动敲容器名。
lazydocker 用一套键盘快捷键让你在单个 TUI 面板里操作所有容器、日志、
镜像和 compose 服务。

## 快速上手

- 按 `e` 进入容器 shell
- 按 `l` 查看容器日志（实时滚动）
- 按 `r` 重启容器
- ... 完整键位表见下方

## 安装

### macOS
brew install jesseduffield/lazydocker/lazydocker

### Linux
下载 [latest release] 二进制，放到 $PATH 下。
```

## 反例

```markdown
# MyProject

## 安装
先装这堆依赖... [20 行安装说明]

## 配置
设这些环境变量... [更多配置说明]

## API
[一大段 API 文档]

## 贡献
[贡献指南]
```

这个反例的问题：读者读完 50 行都不知道这东西到底干什么、自己需不需要它。
