# Documentation MCPs

## Always use together: Context7 (docs) + Octocode (real code)

| MCP | Tools | Purpose |
|-----|-------|---------|
| Context7 | `resolve-library-id`, `query-docs` | Official library documentation |
| Octocode | `githubSearchCode`, `githubGetFileContent`, `githubSearchRepositories` | Real implementations from GitHub |
| Stitch | `build_site`, `get_screen_code`, `get_screen_image` | UI design + code generation |
| DeepWiki | `read_wiki_structure`, `ask_question` | GitHub repo documentation |

## Workflow: Context7 (docs) → Octocode (real usage) → Stitch (UI) → DeepWiki (if needed)
## Fallback: WebSearch / WebFetch for anything not covered
