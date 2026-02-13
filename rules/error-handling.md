# Error Handling (better-result)

**Default:** Use `better-result` for all business logic.
**Exception:** `try/catch` ONLY at 3rd party boundaries to wrap into `Result`.

## Decision Tree

```
Is it 3rd party code that can throw? (fetch, fs, JSON.parse, etc.)
  └─ YES → Wrap with try/catch at the boundary → Return Result
  └─ NO → Is it your business logic?
       └─ YES → Use Result types directly (Result.ok, Result.err, Result.gen)
       └─ NO → Is it already returning Result?
            └─ YES → Chain with .map, .andThen, or Result.gen
            └─ NO → Wrap it to return Result
```

## Valid Patterns

```typescript
// ✅ GOOD: Business logic uses Result
const validateUser = (input: UserInput): Result<User, ValidationError> => {
  if (!input.email) {
    return Result.err(new ValidationError("Email required"));
  }
  return Result.ok({ email: input.email, name: input.name });
};

// ✅ GOOD: Wrap 3rd party at boundary, then Result everywhere else
const fetchFromAPI = async (url: string): Promise<Result<Data, ApiError>> => {
  try {
    const response = await fetch(url);  // 3rd party - can throw
    const data = await response.json();
    return Result.ok(data);
  } catch (e) {
    return Result.err(new ApiError("Fetch failed", { cause: e }));
  }
};

// ✅ GOOD: Wrapping JSON.parse (can throw on invalid input)
const parseJSON = <T>(input: string): Result<T, ParseError> => {
  return Result.try(() => JSON.parse(input) as T)
    .mapErr((e) => new ParseError("Invalid JSON", { cause: e }));
};

// ✅ GOOD: Chaining Results with Result.gen
const processUser = Result.gen(function* () {
  const input = yield* validateInput(rawInput);
  const user = yield* fetchUser(input.id);
  const enriched = yield* enrichUserData(user);
  return enriched;
});

// ✅ GOOD: Async with Result.fromPromise
const data = await Result.fromPromise(
  fetch("https://api.com"),
  (e) => new NetworkError(e)
);
```

## Invalid Patterns

```typescript
// ❌ BAD: try/catch in business logic
const processOrder = async (order: Order) => {
  try {
    const validated = validateOrder(order);
    const saved = await saveOrder(validated);
    return saved;
  } catch (e) {
    console.error(e);  // Swallowed error, no type safety
    return null;
  }
};

// ❌ BAD: Throwing in business logic
const validateOrder = (order: Order): ValidOrder => {
  if (!order.items.length) {
    throw new Error("Order must have items");  // Don't throw!
  }
  return order as ValidOrder;
};
```

## Quick Reference

| Situation | Pattern |
|-----------|---------|
| Your function can fail | Return `Result<T, E>` |
| Calling 3rd party that throws | Wrap in `try/catch`, return `Result` |
| Chaining multiple Results | Use `Result.gen(function* () { ... })` |
| Handling Result | Use `.match({ ok, err })` |
| Converting Promise to Result | Use `Result.tryPromise()` or `Result.fromPromise()` |
| Creating domain errors | Extend `TaggedError` |

## Skill

Use `better-result-adopt` skill for migration patterns and advanced usage.
