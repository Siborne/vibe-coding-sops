# add-readme-banner-image_2026-05-17

## 基本信息

- **时间**: 2026-05-17
- **修改文件**: README.md, README.zh.md

## 根因分析

- **问题现象**: README 缺少视觉标识，读者打开后无法第一时间感知项目定位
- **根因**: 项目有 `assets/readmeBannerImage.png` 但未在 README 中使用

## 修改详情

### 文件: README.md (L1-L4)

**BEFORE:**
```markdown
# vibe-coding-sops

<p align="center">
```

**AFTER:**
```markdown
# vibe-coding-sops

<p align="center">
  <img src="assets/readmeBannerImage.png" alt="vibe-coding-sops banner" width="800">
</p>

<p align="center">
```

> 在标题和 badges 之间插入横幅图片，增强视觉识别度

### 文件: README.zh.md (L1-L4)

同 README.md 的改动，中文版同步添加横幅。

## 解决方案

在 README（中英文）标题正下方、badges 上方添加 `assets/readmeBannerImage.png` 横幅图片，让读者第一时间感知项目。
