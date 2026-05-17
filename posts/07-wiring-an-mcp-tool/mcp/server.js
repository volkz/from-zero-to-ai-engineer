/**
 * Minimal MCP server — one safe tool: run_tests_for_path
 *
 * Install: npm install @modelcontextprotocol/sdk
 * Run:     node server.js   (from the project root as cwd)
 *
 * Security: rejects path traversal; 60-second test timeout; read-only to the filesystem.
 */

import { Server } from '@modelcontextprotocol/sdk/server/index.js';
import { StdioServerTransport } from '@modelcontextprotocol/sdk/server/stdio.js';
import {
  CallToolRequestSchema,
  ListToolsRequestSchema,
} from '@modelcontextprotocol/sdk/types.js';
import { execSync } from 'child_process';
import { existsSync } from 'fs';
import path from 'path';

const PROJECT_ROOT = process.cwd();

// ── Tool definitions ──────────────────────────────────────────────────────────

const TOOLS = [
  {
    name: 'run_tests_for_path',
    description:
      'Run the test suite scoped to a source file or directory. ' +
      'Returns the test runner output and exit code. ' +
      'Use this to verify that a change passes tests before claiming complete.',
    inputSchema: {
      type: 'object',
      properties: {
        path: {
          type: 'string',
          description: 'Relative path to the source file or directory to test.',
        },
      },
      required: ['path'],
    },
  },
];

// ── Server setup ──────────────────────────────────────────────────────────────

const server = new Server(
  { name: 'test-runner', version: '1.0.0' },
  { capabilities: { tools: {} } },
);

server.setRequestHandler(ListToolsRequestSchema, async () => ({ tools: TOOLS }));

server.setRequestHandler(CallToolRequestSchema, async (request) => {
  const { name, arguments: args } = request.params;

  if (name !== 'run_tests_for_path') {
    return { content: [{ type: 'text', text: `Unknown tool: ${name}` }], isError: true };
  }

  const { path: sourcePath } = args;

  // Security: reject paths that escape the project root
  const resolved = path.resolve(PROJECT_ROOT, sourcePath);
  if (!resolved.startsWith(PROJECT_ROOT + path.sep) && resolved !== PROJECT_ROOT) {
    return {
      content: [{ type: 'text', text: 'Error: path traversal rejected' }],
      isError: true,
    };
  }

  if (!existsSync(resolved)) {
    return {
      content: [{ type: 'text', text: `Error: path does not exist: ${sourcePath}` }],
      isError: true,
    };
  }

  try {
    const output = execSync(
      `yarn test --testPathPattern="${sourcePath}" --passWithNoTests 2>&1`,
      { timeout: 60_000, cwd: PROJECT_ROOT },
    ).toString();
    return { content: [{ type: 'text', text: output }] };
  } catch (err) {
    // Non-zero exit = tests failed — this is signal, not an error in the tool itself
    const output = err.stdout?.toString() ?? err.stderr?.toString() ?? err.message;
    return { content: [{ type: 'text', text: output }], isError: true };
  }
});

// ── Start ─────────────────────────────────────────────────────────────────────

const transport = new StdioServerTransport();
await server.connect(transport);
