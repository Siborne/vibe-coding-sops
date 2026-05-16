# Commit Message Rule

**Rule:** Commit messages MUST record WHY, not WHAT. Each commit body MUST answer four questions.

## The Four Questions

1. **What problem forced this change?** — Symptom, scope of impact
2. **What alternatives were considered?** — Why not take a simpler path
3. **What are the trade-offs or side effects?** — Cost, known limitations, benchmarks
4. **What might surprise someone?** — Non-obvious decisions or known gaps

## Example

### Good

```
payment: fix PayPal callback signature rejection on webhook replay

Users reported ~5% of PayPal payment callbacks were 403s over the weekend.
Root cause: PayPal occasionally replays the same webhook event (likely their
retry mechanism), and our nonce-based idempotency check returned 403 on the
second occurrence.

Alternatives considered:
- Option A: Return 200 for duplicate nonces (idempotent semantics). Simple,
  but buries the discrepancy in logs, making ops debugging hard.
- Option B: Log duplicate events, return 200, and notify ops.

Chose B. Added a deduplication_log table to track repeats.

Known limitation: currently only covers PayPal. Stripe webhook signature
verification (in billing/stripe_webhook.py) hasn't been synced yet — planned
for next week.
```

### Bad

```
fix payment bug
```
