# Code Review Rule: Security Pre-Check Design

## Date: 2026-05-17

## Goal

Extend the existing code review rule (`rules/code-review.md`) with a mandatory security pre-check before the seven review principles. This ensures AI-generated code is checked against OWASP Top 10 before review proceeds.

## Scope

- Modify `rules/code-review.md` — add Security Pre-Check section before the seven principles
- Modify `rationale/code-review.md` — add rationale for why security is a pre-check, not an embedded principle
- Update `CLAUDE.md` and `README.md` to reflect the expanded rule description

Not in scope:
- Creating a new standalone rule (ruled out in brainstorming)
- Runtime security testing or penetration testing automation

## Design

### rules/code-review.md structure

After the intro paragraph, insert a new section "Security Pre-Check" before the seven principles. The seven principles remain unchanged (except principle 5 "区分阻断" adds a note that all security findings are automatically [blocking]).

#### Intro paragraph change

Add one sentence at the end of the intro:
"In vibe coding, AI must complete a security pre-check before starting any code review."

#### Security Pre-Check section (new)

Three subsections:

**1. Banned Patterns**

A table of 8 patterns the AI must never generate, with detection method, forbidden code, and correct alternative:

| # | Pattern | OWASP | Forbidden | Correct |
|---|---------|-------|-----------|---------|
| 1 | SQL string concatenation | A03 Injection | `f"SELECT * FROM users WHERE id = {uid}"` / `"SELECT " + uid` | Parameterized queries |
| 2 | Hardcoded credentials | A02 Crypto Failures | `password = "admin123"` / `API_KEY = "sk-..."` | Environment variables or secrets manager |
| 3 | Unsafe DOM insertion | A03 Injection | `element.innerHTML = userInput` / `dangerouslySetInnerHTML` | `textContent` or sanitization (DOMPurify) |
| 4 | Dynamic code execution on user input | A03 Injection | `eval(userInput)` / `exec(code)` (Python) | Avoid entirely; use structured parsers |
| 5 | Shell command injection | A03 Injection | `os.system(f"ping {host}")` / `subprocess.call("ls " + path)` | `subprocess.run` with list args (shell=False) |
| 6 | Disabled TLS verification | A02 Crypto Failures | `verify=False` (Python) / `rejectUnauthorized: false` (Node) | Default to verify=true; never disable in production code |
| 7 | Missing authorization check | A01 Access Control | Decorator/route without auth middleware | Every protected endpoint must declare auth requirement |
| 8 | Plain HTTP for sensitive data | A02 Crypto Failures | `http://` in API endpoints | Always HTTPS for any data transmission |

**2. OWASP Top 10 Self-Check**

A checklist table with one row per OWASP item, a self-check question, and a severity label:

| OWASP (2021) | Check | Severity |
|---|---|---|
| A01: Broken Access Control | Does every new endpoint/route declare an authorization requirement? | [blocking] |
| A02: Cryptographic Failures | Are there hardcoded keys? Does sensitive data transit over plain HTTP? | [blocking] |
| A03: Injection | Is there any string concatenation building SQL, OS commands, or LDAP queries? | [blocking] |
| A04: Insecure Design | Is input validation missing (null, range, type)? Are internal paths or error stacks exposed? | [blocking] |
| A05: Security Misconfiguration | Is TLS verification disabled? Are there default passwords or debug mode left on? | [blocking] |
| A06: Vulnerable Components | Were new dependencies checked (`npm audit`, `pip audit`)? | [blocking] |
| A07: Identification & Auth Failures | Can the new auth/recovery flow be bypassed logically? | [suggestion] |
| A08: Software & Data Integrity Failures | Does deserialization trust external input? Is signature validation missing? | [blocking] |
| A09: Security Logging & Monitoring Failure | Are security events (login failures, permission denied) logged? | [suggestion] |
| A10: SSRF | Does the server make requests based on user-supplied URLs? Is there a whitelist? | [blocking] |

A07 and A09 are [suggestion] because they require broader system-level judgment beyond code patterns.

**3. Self-Check Output Format**

After the pre-check, the AI must output results in this format:

```
## Security Pre-Check

### Banned Pattern Scan
- Scan result: [Found / Not Found]
- (If found) Specific locations and fixes applied:

### OWASP Top 10 Self-Check
| Item     | Status       | Notes      |
|----------|--------------|------------|
| A01 ...  | ✅ / ❌ / N/A | ...        |
| A02 ...  | ...          | ...        |
| ...      | ...          | ...        |

### Pre-Check Conclusion
- [ ] All clear → proceed to 7-principle review
- [ ] Blocking items found → fixed before review
```

#### Principle 5 update

Add at the end of principle 5: "All security pre-check findings automatically carry [blocking] severity unless explicitly labeled [suggestion] in the checklist."

### rationale/code-review.md additions

Add a new section before "在 vibe coding 场景下更关键":

```
## 为什么安全预检在评审之前

安全漏洞和代码风格缺陷性质不同。风格缺陷在评审中可以讨论协商，但注入漏洞、硬编码密钥、权限缺失在合并前必须解决。

把安全预检放在七原则之前有两个作用：
1. **不可跳过** — 前置的关卡在人因上更显眼，不会被淹没在后续的评审讨论中
2. **输出可见** — 自检清单提供了可审计的证据，未来复查时一目了然

区分阻断和建议（如 A07/A09）是为了避免假阳性过多导致审查疲劳。
```

### CLAUDE.md update

In the "Rules to Load" table, update the Code Review row:

```
| Code Review | `rules/code-review.md` | Security pre-check (OWASP Top 10 + banned patterns) before 7 review principles |
```

### README.md update

In the rule index table, update row #5:
```
| 5 | [代码评审规则](rules/code-review.md) | 评审七原则 + 安全预检：OWASP Top 10 自查 + 禁止模式扫描 |
```

## Files Changed

| File | Change |
|------|--------|
| `rules/code-review.md` | Add Security Pre-Check section before principles; update principle 5 |
| `rationale/code-review.md` | Add rationale for security pre-check placement |
| `CLAUDE.md` | Update Rules to Load table |
| `README.md` | Update rule index row #5 |

## Change Log

Per the repo's self-application rule, a change log entry will be created in `docs/变更记录/`.
