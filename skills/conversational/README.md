# Conversational Skills（对话类）

对话类技能以多轮人机对话为核心交互方式：先通过提问澄清信息，再基于收集到的信息产出结果。

## 子类体系

| 子类 | 定义 | 技能 |
|------|------|------|
| `requirement` | 需求澄清与任务拆解 | [prompt-composer](requirement/prompt-composer/SKILL.md) |
| `interview` | 访谈式信息收集 | [resume-builder](interview/resume-builder/SKILL.md) |
| `brainstorm` | 头脑风暴与方案讨论 | （规划中） |

## 收录标准

核心环节是"与用户对话"，先问清楚再产出；对话质量决定产出质量。一次只问一个问题，不连珠炮。
