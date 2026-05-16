# 有意义注释规则

注释不应解释"代码做了什么"——代码本身已经说明了。注释应解释"为什么这样做"，即代码无法自述的信息。

## 注释类型与示例

以下七类注释是值得写的。如果一段注释不属于其中任何一类，考虑删掉它。

### 1. TODO

标记尚未完成或未打磨的代码。必须包含足够上下文，让接手者知道还缺什么、为什么被延期。

```python
# ❌ 不行
# TODO: optimize
for item in items:
    for other in items:
        compare(item, other)

# ✅ 可以
# TODO: 这段 O(n²) 比较在 n<100 时没问题，当前最大数据集 ~60 条。
# 规模放大后需要建立空间索引（R-tree 或 geohash）。详见 Notion 设计文档第 3 节。
for item in items:
    for other in items:
        compare(item, other)
```

### 2. 参考资料

当代码实现论文算法、借鉴外部代码或遵循文档规定的行为时，给出外部链接。使用永久链接，并注明与参考实现的差异。

```python
# 基于 "Fast Polygon Triangulation" (Narkhede & Manocha, 1995)
# https://www.cs.unc.edu/~dm/CODE/GEM/chapter.html
# 与原文算法的差异：原文假设逆时针顶点序，我们输入是顺时针，
# 所以 orientation() 的符号判断在 L45 取了反。
def triangulate(polygon):
    ...
```

### 3. 正确性说明

解释为什么不寻常的代码能产生正确结果。代码展示了步骤，注释说明这些步骤为何奏效。

```python
# 这里看起来像是多减了一次手续费，但实际上 fee_ratio 已经是扣除后的
# 净值比例（1 - tax_rate），所以 price * fee_ratio 算出来就是到手金额。
# 不需要再减一次——直接赋值给 net_amount 是对的。
net_amount = price * fee_ratio
```

### 4. 血泪教训

如果你花了 30 分钟以上才调通、且修复方式不明显，就把它记下来。过去的你不知道需要这一步，未来的读者也不会知道。

```python
# CRITICAL: 必须先设置 Content-Type 再启动流式写入，否则 HTTP/2 下
# Flask 会延迟 flush 导致客户端收不到第一个 chunk。
# 排查过程：客户端永远缺第一帧 → 抓包发现 push_promise 在 data frame
# 之后才发送 → Flask 的 send_header() 在流式模式下被跳过了。
# 修复方法：显式调用 response.headers.add() 并在第一个 yield 之前
# 手动触发 header flush。
response.headers.add("Content-Type", "text/event-stream")
response.headers.add("X-Accel-Buffering", "no")
```

### 5. 常数的理由

魔法数字也需要解释。为什么是 1492？为什么是 16 位？它是随手选的、测试得出的还是正确性所需？即便是"随意选的"也是有用信息。

```python
# → 3 秒：AWS ALB 默认空闲超时是 60 秒，每 20 秒发一次心跳足以保活。
# 这里选 3 秒而非 20 秒是因为某些企业代理 10 秒就断——3 秒保守且成本可忽略。
HEARTBEAT_INTERVAL = 3

# → 16 位：CRC-16 对 200 字节以内的帧误码检测率 > 99.99%，够用。
# 换成 CRC-32 会多 2 字节帧开销，对 60 字节的典型帧不小。
CRC_WIDTH = 16
```

### 6. 承重细节

如果正确性依赖一个看似无关紧要的实现细节，务必点出来，否则后续重构很容易在不经意间破坏正确性。

```python
# 必须是 BTreeSet 而非 HashSet——下面的迭代按字典序遍历，
# 合并相邻区间时需要这个顺序才能保证 O(n) 而非 O(n²)。
# 2023 年有人把这里改成 HashSet，"因为查找更快"，结果 10k 区间合并
# 从 50ms 变成 3s，详见 issue #4221。
occupied: BTreeSet<Range>
```

### 7. "为什么不用 X"

当你刻意避开显而易见的做法时，说明理由。否则总会有人后来"修复"它，把东西搞坏。

```python
# 这里不用 Django ORM 的 bulk_create() 是因为它不触发 post_save signal，
# 而我们需要 signal 来同步 ElasticSearch 索引。
# 循环逐条 save() 看起来慢，但实际批量操作量 < 200 条，且发生在后台任务中。
for obj in items:
    obj.save()
```
