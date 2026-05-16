# Meaningful Comments Rule

**Rule:** Comments MUST explain WHY, not WHAT. If a comment doesn't fit one of the seven types below, delete it.

## The Seven Comment Types

### 1. TODO

Mark incomplete work. MUST include enough context for the next person to know what's missing and why it was deferred.

```python
# BAD
# TODO: optimize
for item in items:
    for other in items:
        compare(item, other)

# GOOD
# TODO: This O(n²) comparison is fine for n<100 (current max dataset ~60).
# If data scales up, switch to a spatial index (R-tree or geohash).
# See Notion design doc §3.
for item in items:
    for other in items:
        compare(item, other)
```

### 2. References

When implementing a paper algorithm, porting external code, or following documented behavior, link to the source. Use permanent URLs. Note any deviations from the reference.

```python
# Based on "Fast Polygon Triangulation" (Narkhede & Manocha, 1995)
# https://www.cs.unc.edu/~dm/CODE/GEM/chapter.html
# Deviation: the original assumes CCW vertex order; our input is CW,
# so the orientation() sign check is flipped at L45.
def triangulate(polygon):
    ...
```

### 3. Correctness Justification

Explain WHY unusual-looking code is actually correct. The code shows the steps; the comment explains why the steps work.

```python
# This looks like a double subtraction, but fee_ratio is already the
# net ratio (1 - tax_rate), so price * fee_ratio directly gives the
# take-home amount. No second subtraction needed.
net_amount = price * fee_ratio
```

### 4. Lessons Learned

If a fix took 30+ minutes to debug and the fix isn't obvious, record it. Past-you didn't know this was necessary; future readers won't either.

```python
# CRITICAL: Set Content-Type BEFORE starting streaming writes, or HTTP/2
# causes Flask to defer flush and the client misses the first chunk.
# Debug trail: client always missing first frame → packet capture showed
# push_promise sent AFTER data frame → Flask's send_header() skipped in
# streaming mode. Fix: explicitly set headers before first yield.
response.headers.add("Content-Type", "text/event-stream")
response.headers.add("X-Accel-Buffering", "no")
```

### 5. Magic Constant Rationale

Every non-obvious constant needs a reason. "It just worked when I tried 3" is valid information — it tells the reader this value wasn't derived and may need tuning.

```python
# 3s: AWS ALB default idle timeout is 60s; pinging every 20s is enough.
# Chose 3s (not 20s) because some enterprise proxies drop at 10s.
# Conservative, and the cost is negligible.
HEARTBEAT_INTERVAL = 3

# 16-bit: CRC-16 has >99.99% error detection for frames under 200 bytes.
# CRC-32 would add 2 bytes per frame — significant for 60-byte typical frames.
CRC_WIDTH = 16
```

### 6. Load-Bearing Details

If correctness depends on a seemingly trivial implementation detail, call it out. Otherwise refactoring will silently break it.

```python
# MUST be BTreeSet, not HashSet — the iteration below relies on
# lexicographic order to merge adjacent intervals in O(n), not O(n²).
# Someone changed this to HashSet in 2023 "because lookup is faster";
# 10k-interval merge went from 50ms to 3s. See issue #4221.
occupied: BTreeSet<Range>
```

### 7. "Why Not X"

When you deliberately avoid the obvious solution, explain why. Otherwise someone will "fix" it later and break things.

```python
# NOT using Django ORM's bulk_create() here because it doesn't fire
# post_save signals, and we need the signal to sync Elasticsearch.
# The per-row save() loop looks slow but the batch is <200 items
# and this runs in a background task.
for obj in items:
    obj.save()
```
