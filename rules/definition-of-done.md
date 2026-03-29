# Definition of Done (Feature Completeness)

## Impact Scan (BEFORE coding)

Before implementing any feature, quickly map:
- Which UI components are affected
- Which backend logic is required
- Which database changes are needed
- Which permissions/policies are needed
- Which translations are needed (Hebrew + English)
- Which edge cases can break the flow

Then implement the full feature end-to-end.

## Feature is NOT complete unless:

1. **UI/UX** — Fully usable, no dead buttons, loading/empty/error states exist
2. **Business Logic** — Actions perform real behavior, state updates correctly
3. **Database** — Schema exists, relations handled, supports real usage
4. **Permissions** — Read/write access enforced, admin actions protected
5. **Validation** — Inputs validated (client + server), required fields enforced
6. **Storage** — If uploads: bucket configured, policies exist, preview works
7. **Admin/Settings** — If configurable: settings saved/loaded, defaults exist, actually affect behavior
8. **Localization** — No hardcoded text, all uses translation keys (he + en)
9. **Error Handling** — Failures handled, UI shows fallback, no crashes on missing data
10. **E2E Flow** — User triggers → backend processes → data saved → UI updates → permissions enforced

## Anti-Patterns (NEVER)

- Dead buttons or fake features
- UI without real logic behind it
- Settings that don't actually affect behavior
- Marking complete before full flow verified
- Building UI first and stopping there

## Decision Rule

> "If this part is missing — will the feature be broken, insecure, misleading, or unusable?"
> If yes → implement it.
