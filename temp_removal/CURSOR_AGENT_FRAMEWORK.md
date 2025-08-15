## Cursor Agent Framework (GPT-5)

Purpose: Use your existing `.claude/agents` and hooks conventions while working in Cursor with GPT-5. This is a lightweight protocol that the assistant will honor during chat.

### Slash Commands

- /prime [area]
  - Quickly scan the codebase and build a working set in memory.
  - Examples: `/prime`, `/prime src`, `/prime telegram-mini-app`.

- /agent <name>
  - Activates a sub-agent by loading `.claude/agents/<name>.md` as the system prompt overlay for this session.
  - Example: `/agent qa-engineer`.

- /spawn <name>
  - Ephemeral sub-agent for a single task. The agent prompt applies to that task only.
  - Example: `/spawn performance-optimizer: profile vector cache`.

- /agents list
  - Lists available agents from `.claude/agents` (filenames without `.md`).

- /tools allow <comma-separated>
  - Request a restricted tool policy the assistant will honor (read_file, codebase_search, grep, web_search, etc.).
  - Example: `/tools allow read_file, codebase_search`.

- /tools deny <comma-separated>
  - Request that the assistant avoid listed tools.

- /status
  - Shows active agent and current tool policy.

- /end
  - Clears active sub-agent and resets tool policy to default.

### Notes

- Agents come from your existing `.claude/agents` directory.
- Tool policies are advisory constraints the assistant will follow within Cursor. They do not modify Cursor itself.
- If you use external MCP servers, keep managing them via your kirohooks scripts; this protocol does not alter your local MCP setup.

### Examples

1) Prime then test focus
```
/prime src
/agent qa-engineer
Write tests for `src/rails/router.py` edge cases.
```

2) Ephemeral performance check
```
/spawn performance-optimizer: analyze vector cache hit rate over last 1h
```

3) Tool scoping
```
/tools allow read_file, codebase_search
```


