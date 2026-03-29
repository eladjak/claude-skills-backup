# Error Handling (better-result)

Use `better-result` for business logic. `try/catch` ONLY at 3rd party boundaries.

```
3rd party that throws? → try/catch at boundary → return Result
Your business logic?   → Result.ok / Result.err / Result.gen directly
Chaining Results?      → Result.gen(function* () { ... })
```

```typescript
// Wrap 3rd party → Result
const fetchFromAPI = async (url: string): Promise<Result<Data, ApiError>> => {
  try {
    const response = await fetch(url);
    return Result.ok(await response.json());
  } catch (e) {
    return Result.err(new ApiError("Fetch failed", { cause: e }));
  }
};
```
