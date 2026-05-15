# Choosing Your Test Strategy

The TDD skill supports both integration tests and unit tests. Use this guide to pick the right strategy for each case.

## The Decision Framework

Ask these questions in order:

1. **Can I test this behavior through a public interface in under 100ms?**
   - Yes → Unit test at the module boundary
   - No → Go to question 2

2. **Does the behavior span multiple modules or external systems?**
   - Yes → Integration test
   - No → Go to question 3

3. **Is the logic complex enough that pinpointing the exact failure location matters?**
   - Yes → Unit test the pure logic
   - No → Integration test at the nearest public API (the module's documented interface that callers depend on)

## When Unit Tests Shine

Unit tests are the right tool when:

- **Pure business logic**: Validation, calculation, state machines, pricing rules. No I/O, no side effects. These should be blazing fast and deterministic.
- **Complex algorithms**: Sorting, parsing, encoding, search. You want instant feedback on specific edge cases.
- **Error handling paths**: Testing every error branch through integration tests is slow and often impossible. Unit tests let you exercise each path directly.
- **Refactoring safety net**: When extracting a deep module, unit tests on its interface give you confidence during the extraction itself.

```typescript
// Good unit test: pure logic, no I/O, fast
test("discount applies when cart total exceeds threshold", () => {
  const cart = cartWithTotal(150);
  const discounted = applyDiscount(cart, { threshold: 100, rate: 0.1 });
  expect(discounted.total).toBe(135);
});
```

## When Integration Tests Shine

Integration tests are the right tool when:

- **The value is in the wiring**: The bug pattern is "these two modules disagree on the contract" — not "this module computes wrong."
- **Side effects matter**: Database writes, file I/O, network calls. Mocking these makes the test lie to you.
- **User-facing flows**: Login → create → edit → publish. The test verifies the user's experience, not individual functions.

## The Spectrum

```
Pure logic   →   Module boundary   →   Cross-module   →   End-to-end
(fast, unit)     (unit/integration)     (integration)      (slow, e2e)

More unit ←————————————————————————————→ More integration
     ↑                                          ↑
  Faster feedback                          Higher confidence
  Easier to pinpoint                       Closer to real usage
```

## Rule of Thumb

> Test at the highest level that still gives you **fast, deterministic feedback**. If integration test = 2s and flaky, drop down to unit test the critical path. If unit test = 100 mocked calls, step up to integration test the real modules.

## Avoid These Traps

| Trap | Why it happens | Fix |
|---|---|---|
| Mocking everything | Fear of slowness | Start with real deps, mock only at system boundaries (see mocking.md) |
| Testing only internals | Module has no good public interface | Design the interface first, then test it |
| One huge e2e test | Trying to verify everything at once | Split into vertical slices |
| No unit tests at all | "Integration tests cover it" | Unit test the complex pure logic anyway |
