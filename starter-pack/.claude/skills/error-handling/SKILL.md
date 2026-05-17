---
name: error-handling
description: "Applies project error-handling conventions when the user asks to fix an error, handle an exception, or add error handling to a function. Fires on: 'handle this error', 'add error handling', 'what should I throw here', 'catch this', 'error boundary'."
trigger: semantic
version: 1.0.0
owner: "[FILL IN — your team or handle]"
last_reviewed: 2026-05-17
---

# Error Handling Skill

## Convention (from AGENTS.md)

All errors thrown at the service layer must extend the project's base exception class. Raw `Error` objects must never cross service boundaries.

```typescript
// Wrong — leaks implementation details across boundaries
throw new Error('User not found');

// Right — typed, catchable, loggable
throw new AppException(ErrorCode.NOT_FOUND, 'User not found', { userId });
```

## When this skill activates

Apply these rules whenever:
- Adding try/catch blocks to service methods
- Translating errors from external APIs or databases
- Writing gRPC service methods (must use `RpcException`)
- Adding error handling to HTTP controllers

## HTTP layer

```typescript
// Controllers translate AppException → HTTP response
// Let the global exception filter handle the mapping.
// Do NOT catch AppException in controllers.
```

## gRPC layer

```typescript
// gRPC methods must throw RpcException, not AppException
import { RpcException } from '@nestjs/microservices';
throw new RpcException({ code: status.NOT_FOUND, message: 'User not found' });
```

## What to avoid

- Do not swallow errors with empty catch blocks.
- Do not use `console.error` — use the logger with the error object.
- Do not re-throw a different error type without logging the original.
- Do not add error handling to code you are not currently modifying.

## Customization

Replace `AppException` and `ErrorCode` with your project's actual exception class.
See AGENTS.md for the import path and available error codes.
