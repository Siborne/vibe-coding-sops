# Code Review Security Pre-Check Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Add mandatory security pre-check (OWASP Top 10 self-checklist + banned patterns) to the existing code review rule before the seven review principles.

**Architecture:** Passive-document expansion — no code or tooling. This plan modifies 2 rule artifacts (rule + rationale) and 2 index files (CLAUDE.md + README.md), then records a change log per the repo's self-application rule.

**Tech Stack:** Markdown only

**Spec:** `docs/superpowers/specs/2026-05-17-code-review-security-precheck-design.md`

---

### Task 1: Add Security Pre-Check section to rules/code-review.md

**Files:**
- Modify: `rules/code-review.md:1-2` (intro paragraph)
- Modify: `rules/code-review.md:7-7` (before principle 1)
- Modify: `rules/code-review.md:39-40` (principle 5 end)

- [ ] **Step 1: Add sentence to intro paragraph**

Add one sentence at the end of the intro paragraph (after line 5, before the blank line at line 6).

Old intro paragraph (lines 1-5):
```
# 代码评审规则

代码评审不只是资深工程师的事——你的视角很有价值。新鲜的眼睛能抓到资深开发者忽视的东西，不熟悉代码的人提出的问题常能暴露那些应该被记录或简化的假设。

评审也是最快的学习方式之一：看到别人如何解题，学到模式和惯用法，培养对可读代码的直觉。此外，评审还能在代码入库前捕捉 bug、在团队内传播知识、通过协作提升代码质量。
```

Change line 5 to append:
```
评审也是最快的学习方式之一：看到别人如何解题，学到模式和惯用法，培养对可读代码的直觉。此外，评审还能在代码入库前捕捉 bug、在团队内传播知识、通过协作提升代码质量。**在 vibe coding 中，AI 在开始代码评审前必须先完成安全预检。**
```

Use Edit to make this change:
- `old_string`: `评审也是最快的学习方式之一：看到别人如何解题，学到模式和惯用法，培养对可读代码的直觉。此外，评审还能在代码入库前捕捉 bug、在团队内传播知识、通过协作提升代码质量。`
- `new_string`: `评审也是最快的学习方式之一：看到别人如何解题，学到模式和惯用法，培养对可读代码的直觉。此外，评审还能在代码入库前捕捉 bug、在团队内传播知识、通过协作提升代码质量。**在 vibe coding 中，AI 在开始代码评审前必须先完成安全预检。**`

- [ ] **Step 2: Insert Security Pre-Check section before the seven principles**

Insert the complete Security Pre-Check section between `## 评审原则` heading and `### 1. 评审代码，不评审人`.

Use Edit, targeting the `## 评审原则` heading through `### 1. 评审代码，不评审人`:

`old_string`:
```
## 评审原则

### 1. 评审代码，不评审人
```

`new_string`:
```
## 评审原则

### 安全预检

在进入七项评审原则前，AI 必须完成安全预检。预检覆盖 OWASP Top 10（2021），分两步：禁止模式扫描 + 逐项自查。

#### 禁止模式

以下 8 种代码模式 AI 绝对禁止生成。每次评审时先扫描是否存在这些模式，发现即视为阻断项。

| # | 模式 | 对应 OWASP | 禁止写法 | 正确做法 |
|---|------|-----------|---------|---------|
| 1 | SQL 字符串拼接 | A03 注入 | `f"SELECT * FROM users WHERE id = {uid}"`；`"SELECT " + uid` | 参数化查询（PreparedStatement / `?` placeholder） |
| 2 | 硬编码凭据 | A02 加密失败 | `password = "admin123"`；`API_KEY = "sk-..."` | 环境变量或密钥管理服务 |
| 3 | 不安全的 DOM 写入 | A03 注入 | `element.innerHTML = userInput`；`dangerouslySetInnerHTML` | `textContent` 或 DOMPurify 清洗 |
| 4 | 动态执行用户输入 | A03 注入 | `eval(userInput)`；`exec(code)`（Python） | 结构化解析器，避免动态执行 |
| 5 | Shell 命令拼接 | A03 注入 | `os.system(f"ping {host}")`；`subprocess.call("ls " + path)` | `subprocess.run([...], shell=False)`（Python）；避免字符串拼接参数 |
| 6 | 禁用 TLS 验证 | A02 加密失败 | `verify=False`（Python）；`rejectUnauthorized: false`（Node） | 默认保持 TLS 验证开启；生产代码中绝不关闭 |
| 7 | 缺失授权检查 | A01 访问控制 | 路由/Endpoint 未挂载认证中间件 | 每个受保护端点必须声明授权要求 |
| 8 | 明文 HTTP 传输敏感数据 | A02 加密失败 | API 端点使用 `http://` | 所有数据传输一律使用 HTTPS |

#### OWASP Top 10 自查清单

AI 必须逐项回答并输出自查结果。全部 8 项为 [blocking]（必须修复），A07 和 A09 为 [suggestion]（建议修复，因其涉及更广泛的系统级判断）。

| OWASP Top 10 (2021) | 自查问题 | 严重程度 |
|---|---|---|
| A01: 访问控制失效 | 每个新端点/路由是否声明了授权要求？ | [blocking] |
| A02: 加密失败 | 是否有硬编码密钥？敏感数据是否通过 HTTP 明文传输？ | [blocking] |
| A03: 注入 | 是否有字符串拼接构成的 SQL/OS 命令/LDAP 查询？ | [blocking] |
| A04: 不安全设计 | 是否有缺失的输入校验（null、范围、类型）？是否暴露了内部路径或错误栈？ | [blocking] |
| A05: 安全配置错误 | 是否有关闭 TLS 验证、默认密码、debug 模式开启的代码？ | [blocking] |
| A06: 已知漏洞组件 | 新增依赖是否运行了 `npm audit` / `pip audit`？ | [blocking] |
| A07: 认证与身份管理失效 | 新增的认证/找回密码流程是否存在逻辑绕过？ | [suggestion] |
| A08: 软件与数据完整性故障 | 反序列化是否信任外部输入？是否缺少签名校验？ | [blocking] |
| A09: 安全日志与监控不足 | 安全事件（登录失败、权限被拒）是否埋了日志？ | [suggestion] |
| A10: SSRF（服务端请求伪造） | 服务端是否根据用户提供的 URL 发起请求？是否有目标白名单？ | [blocking] |

#### 预检输出格式

完成自查后，AI 必须按以下格式输出结果：

```markdown
## 安全预检

### 禁止模式扫描
- 扫描结果：未发现 / 发现禁止模式
- （如发现）具体位置及修复：

### OWASP Top 10 自查
| 项目 | 状态 | 说明 |
|------|------|------|
| A01 访问控制 | ✅ / ❌ / ⚠️ N/A | ... |
| A02 加密失败 | ... | ... |
| ... | ... | ... |

### 预检结论
- [ ] 全部通过 → 继续七原则评审
- [ ] 有阻断项 → 已修复，修复内容见上方
```

**阻断项必须先修复，再进入七原则评审。** 建议项可在评审过程中讨论。

---

### 1. 评审代码，不评审人
```

- [ ] **Step 3: Update principle 5 to reference security findings**

Add a note at the end of principle 5, after line 39 (`- [nit] —— 无关紧要，随便提一嘴`):

`old_string`:
```
- `[nit]` —— 无关紧要，随便提一嘴

### 6. 肯定做得好的地方
```

`new_string`:
```
- `[nit]` —— 无关紧要，随便提一嘴

安全预检中发现的全部问题均自动标记为 `[blocking]`，除非自查清单中已标注为 `[suggestion]`（A07、A09）。

### 6. 肯定做得好的地方
```

---

### Task 2: Add rationale for security pre-check placement

**Files:**
- Modify: `rationale/code-review.md:25-25` (before "在 vibe coding 场景下更关键")

- [ ] **Step 1: Insert rationale section before "在 vibe coding 场景下更关键"**

`old_string`:
```
## 在 vibe coding 场景下更关键
```

`new_string`:
```
## 为什么安全预检放在七原则之前

安全漏洞和代码风格缺陷性质不同。风格缺陷在评审中可以讨论协商，但注入漏洞、硬编码密钥、权限缺失在合并前必须解决，没有妥协空间。

把安全预检放在七原则之前有两个作用：

1. **不可跳过** — 前置的检查关卡在人因上更显眼，不会被淹没在后续的评审讨论中。AI 必须先输出自检结果，然后才能进入下一阶段。
2. **输出可见** — 自检清单的格式化输出提供了可审计的证据。未来复查时，可以直接看到每次 AI 代码修改经过了哪些安全门槛。

A07（认证失效）和 A09（日志不足）标注为 [suggestion] 而非 [blocking]，是因为这两项涉及更广泛的系统级设计判断，不是纯代码模式可以判定。即便如此，AI 仍然需要逐项回答，不能跳过。

## 在 vibe coding 场景下更关键
```

---

### Task 3: Update CLAUDE.md Rules to Load table

**Files:**
- Modify: `CLAUDE.md:28-28` (Code Review row)

- [ ] **Step 1: Update Code Review row**

`old_string`:
```
| Code Review | `rules/code-review.md` | Review code not people; actionable suggestions; ask don't command; explain why; label blocking vs suggestion; praise good work; know when to stop |
```

`new_string`:
```
| Code Review | `rules/code-review.md` | Security pre-check (OWASP Top 10 + banned patterns) before 7 review principles; review code not people; actionable suggestions; ask don't command; explain why; label blocking vs suggestion; praise good work; know when to stop |
```

---

### Task 4: Update README.md rule index

**Files:**
- Modify: `README.md:45-45` (row #5)

- [ ] **Step 1: Update rule #5 description in README**

`old_string`:
```
| 5 | [代码评审规则](rules/code-review.md) | 评审七原则：对事不对人、可操作建议、提问、解释为什么、区分阻断、肯定优点、适可而止 |
```

`new_string`:
```
| 5 | [代码评审规则](rules/code-review.md) | 评审七原则 + 安全预检：OWASP Top 10 自查清单 + 禁止模式扫描 |
```

---

### Task 5: Create change log

**Files:**
- Create: `docs/变更记录/代码评审规则增加安全预检_2026-05-17.md`

- [ ] **Step 1: Write change log**

Create `docs/变更记录/代码评审规则增加安全预检_2026-05-17.md`:

```markdown
# 代码评审规则增加安全预检

**日期:** 2026-05-17

## 变更了什么

| 文件 | 变更类型 | 说明 |
|------|---------|------|
| `rules/code-review.md` | 修改 | 新增「安全预检」章节（禁止模式表 + OWASP Top 10 自查清单 + 输出格式），置于七原则之前；原则 5 末尾增加安全项自动阻断说明 |
| `rationale/code-review.md` | 修改 | 新增「为什么安全预检放在七原则之前」段落 |
| `CLAUDE.md` | 修改 | 更新 Code Review 规则描述 |
| `README.md` | 修改 | 更新规则 #5 说明 |

## 为什么变更

用户请求：在代码评审规则中增加安全意识要求，覆盖完整 OWASP Top 10。

设计决策：
- 安全预检作为前置关卡，而非第八条原则（性质不同：原则是"怎么评"，安全检查是"评什么"）
- 双保险机制：禁止模式（代码生成层面拦截）+ 自查清单（完成前逐项确认）
- 8/10 项为 [blocking]，A07/A09 为 [suggestion]（需要系统级判断，不能纯代码判定）

## 变更前后对比

### rules/code-review.md

**前：** 简介 → 七项评审原则

**后：** 简介（含安全预检提示） → 安全预检章节（禁止模式 + OWASP 自查清单 + 输出格式） → 七项评审原则（原则 5 补充安全阻断说明）

### rationale/code-review.md

**前：** 四个评审价值 → vibe coding 场景论证

**后：** 四个评审价值 → 安全预检前置理由 → vibe coding 场景论证

### CLAUDE.md / README.md

描述性更新，将安全预检纳入规则概要。
```

---

### Task 6: Commit all changes

- [ ] **Step 1: Stage all changed files**

```bash
git add rules/code-review.md rationale/code-review.md CLAUDE.md README.md "docs/变更记录/代码评审规则增加安全预检_2026-05-17.md"
```

- [ ] **Step 2: Commit**

```bash
git commit -m "$(cat <<'EOF'
Add security pre-check to code review rule

User requested OWASP Top 10 coverage as a mandatory pre-review checkpoint
with banned-pattern table and self-assessment checklist, placed before the
seven review principles (not as an 8th principle — different category).
EOF
)"
```
