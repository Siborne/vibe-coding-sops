# skills 与 rules 分类体系重构 + 标准格式

## What

对 `skills/` 与 `rules/` 做分层分类，并给每个文件加上统一的 frontmatter 元数据，同步更新所有引用与统计数据。

### skills/ — 三级分类（工程类/对话类/原子类）

```
skills/
├── engineering/              # 工程类：固定流程技能
│   ├── README.md
│   ├── git-collaboration/    #   github-pr-workflow（移动自 skills/github-pr-workflow）
│   ├── code-quality/         #   （规划中占位 README）
│   ├── testing/              #   （规划中占位 README）
│   └── delivery/             #   （规划中占位 README）
├── conversational/           # 对话类：多轮对话驱动
│   ├── README.md
│   ├── requirement/          #   prompt-composer
│   ├── interview/            #   resume-builder
│   └── brainstorm/           #   （规划中占位 README）
└── atomic/                   # 原子类：单一可组合技巧
    ├── README.md
    └── agent-prompt-engineering/
```

### rules/ — 四类目录（按约束对象）

```
rules/
├── code-quality/    # meaningful-comments、uncertainty-marking、code-style-declaration
├── workflow/        # commit-message、code-review、branch-pr-workflow
├── documentation/   # code-change-log、readme-structure
└── communication/   # status-honesty
```

### 标准格式

每个 rule / SKILL.md 头部加入 YAML frontmatter。

- **rule frontmatter**：`name` / `title` / `type` / `category` / `summary` / `translation` / `applies_to`
- **skill frontmatter**：`name` / `title` / `description` / `type` / `category` / `subcategory` / `triggers` / `tags`

### 同步范围

- `rationale/rules/`：改为 `<category>/<en|zh>/<name>.md`（18 个文件，en/zh 对称）
- `rationale/skills/`：改为 `<category>/<subcategory>/<name>/<en|zh>.md`（8 个文件），并**补齐此前缺失的 github-pr-workflow 的 en/zh rationale**
- `README.md` / `README.zh.md`：快速开始、规则索引（4 类分组）、Skills（3 类分组 + 补入 github-pr-workflow + 新路径）、仓库结构树
- `CLAUDE.md`：Repository Structure、Rules to Load（4 类）、Skills to Load（3 类 + 补入 github-pr-workflow）、Adding a New Rule/Skill 步骤
- `scripts/generate-stats.sh`：skills 统计改为 `-name 'SKILL.md'`（适配多级目录），rules 改递归 `-name '*.md'`
- `stats.json`：skills 从 3 → 4（含此前被遗漏的 github-pr-workflow），rationale 从 24 → 26（9×2 + 4×2）
- `.claude/rules/` 9 个规则副本、`.claude/skills/` 4 个技能副本同步为最新内容

## Why

用户请求按"工程的 / 讨论的 / 原子的"维度给 skills 分类并创建二级目录，两个大类（工程、对话）再细分一级；rules 也建二级目录；统一每个文件的标准格式；并全量同步周边引用。

现状中的问题也一并修复：skills 实际有 4 个但 README/CLAUDE/stats 只列 3 个（漏 github-pr-workflow），且大量链接指向旧扁平路径 `skills/*.md`（实际已是 `skills/<name>/SKILL.md`）。

## Before / After

**skills 目录：扁平** `skills/prompt-composer.md` → **分层** `skills/conversational/requirement/prompt-composer/SKILL.md`（含 frontmatter）。

**rules 目录：扁平** `rules/code-review.md` → **按类分目录** `rules/workflow/code-review.md`（含 frontmatter）。

**rationale：按语言** `rationale/rules/en/code-review.md` → **按类+语言** `rationale/rules/workflow/en/code-review.md`；skills rationale 从 `rationale/skills/{en,zh}/<name>.md` 改为 `rationale/skills/<category>/<subcategory>/<name>/{en,zh}.md`。

**stats.json**：`"skills": 3` → `"skills": 4`；`"rationale": 24` → `"rationale": 26`。

## 遗留说明

- `.reasonix/`、`garden-skills/`、`reference/` 为仓库中既有的未跟踪目录，非本次改动引入，未处理。
- `.claude/rules/code-change-log copy.md` 的删除为之前遗留的工作区变更，本次保持现状。
