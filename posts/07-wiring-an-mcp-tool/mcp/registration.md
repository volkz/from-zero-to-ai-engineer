# MCP Server Registration

Register the test-runner server in whichever client you use.
Both configurations point to the same `server.js`; only the config file location differs.

---

## Claude Code — `.claude/mcp_servers.json`

```json
{
  "mcpServers": {
    "test-runner": {
      "command": "node",
      "args": ["posts/07-wiring-an-mcp-tool/mcp/server.js"],
      "cwd": "${workspaceRoot}"
    }
  }
}
```

Or pass via the `--mcp-config` flag:

```bash
claude --mcp-config .claude/mcp_servers.json
```

---

## Cursor — `.cursor/mcp.json`

```json
{
  "mcpServers": {
    "test-runner": {
      "command": "node",
      "args": ["posts/07-wiring-an-mcp-tool/mcp/server.js"]
    }
  }
}
```

Cursor discovers `mcp.json` automatically when placed at the workspace root under `.cursor/`.

---

## Verifying the connection

After registering, open a fresh session and ask:

```
What MCP tools do you have available?
```

The model should respond with `run_tests_for_path` and its description.
Then test it:

```
Run the tests for src/users/users.service.ts
```

Expected: the model calls the tool, the tool runs `yarn test --testPathPattern="src/users/users.service.ts"`,
and returns the real test runner output — pass or fail.

---

## Security checklist before enabling any MCP server

| Check | Why |
|---|---|
| Does the tool accept arbitrary shell commands? | If yes, blast radius is unlimited — rethink. |
| Is path traversal blocked? | The server above rejects paths outside PROJECT_ROOT. |
| Is there a timeout? | The server uses 60s. Without it, a slow test suite hangs the model. |
| Is it read-only or write-enabled? | Write-enabled tools (file edit, DB write) need auth + audit logging. |
| Is the server from a trusted source? | Third-party MCP packs = supply chain risk; review before installing. |
