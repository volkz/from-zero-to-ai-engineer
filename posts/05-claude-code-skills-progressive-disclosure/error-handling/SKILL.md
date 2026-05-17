---
name: error-handling
description: >
  Fires when adding, reviewing, or refactoring error handling in any service method,
  controller, or handler. Covers HTTP layer (AppException pattern), gRPC layer
  (RpcException + status enum), and shared domain errors. Includes what to avoid:
  silent catches, bare Error throws, HTTP exceptions in gRPC code paths.
trigger: semantic
---

# Error Handling

## Which layer are you in?

| Layer | Exception type | Import |
|---|---|---|
| HTTP (NestJS controller / REST) | `AppException` extends `HttpException` | `@your-org/common` |
| gRPC (NestJS microservice handler) | `RpcException` | `@nestjs/microservices` |
| Domain (pure business logic) | Custom domain error classes | your local `errors/` module |

Never mix layers: an HTTP exception in a gRPC handler becomes `UNKNOWN (2)` on the
wire; a gRPC status code in an HTTP response is meaningless to the browser.

---

## HTTP layer — AppException pattern

```typescript
import { AppException } from '@your-org/common';
import { HttpStatus } from '@nestjs/common';

// Preferred: typed domain message
throw new AppException(HttpStatus.NOT_FOUND, 'USER_NOT_FOUND', {
  userId: request.userId,
});

// Fallback when AppException is not available: wrap HttpException
import { HttpException, HttpStatus } from '@nestjs/common';
throw new HttpException({ code: 'USER_NOT_FOUND' }, HttpStatus.NOT_FOUND);
```

**What AppException adds over HttpException:** structured `code` field (machine-readable
for clients), optional `context` object (logged, not exposed), consistent response shape.

---

## gRPC layer — RpcException pattern

```typescript
import { RpcException } from '@nestjs/microservices';
import { status } from '@grpc/grpc-js';

throw new RpcException({
  code: status.NOT_FOUND,
  message: `User ${request.userId} not found`,
});
```

**Status enum reference (most-used):**

| `@grpc/grpc-js` status | Meaning |
|---|---|
| `status.OK` | Success |
| `status.NOT_FOUND` | Resource absent |
| `status.INVALID_ARGUMENT` | Bad input |
| `status.ALREADY_EXISTS` | Duplicate |
| `status.INTERNAL` | Unexpected server error |
| `status.UNAUTHENTICATED` | Missing / invalid credentials |
| `status.PERMISSION_DENIED` | Valid credentials, wrong role |

---

## Domain layer — domain error classes

```typescript
// Define in errors/ module — no HTTP or gRPC imports
export class UserNotFoundError extends Error {
  constructor(public readonly userId: string) {
    super(`User ${userId} not found`);
    this.name = 'UserNotFoundError';
  }
}

// In service (pure business logic):
throw new UserNotFoundError(request.userId);

// In HTTP controller (translate to HTTP):
catch (err) {
  if (err instanceof UserNotFoundError)
    throw new AppException(HttpStatus.NOT_FOUND, 'USER_NOT_FOUND', { userId: err.userId });
  throw err; // let global filter handle unknown errors
}

// In gRPC handler (translate to RpcException):
catch (err) {
  if (err instanceof UserNotFoundError)
    throw new RpcException({ code: status.NOT_FOUND, message: err.message });
  throw err;
}
```

---

## Forbidden patterns

```typescript
// ❌ Silent catch — swallows errors, makes the silent-failure hunter's job harder
try { ... } catch (_) {}

// ❌ Bare Error throw in HTTP or gRPC — loses structured error data
throw new Error('Something went wrong');

// ❌ HTTP exception in gRPC handler — caller receives UNKNOWN (2)
throw new NotFoundException('User not found');

// ❌ console.error without re-throw in a service — error disappears into logs
catch (err) { console.error(err); }
```

---

## Verification

After adding or changing any error handler:

1. Run `yarn test` — non-zero exit means the test runner caught it; a passing test that only
   asserts the happy path is not sufficient.
2. For gRPC handlers: `grep -rn "HttpException\|NotFoundException\|BadRequestException" src/`
   — zero hits in gRPC service files.
3. For HTTP handlers: `grep -rn "RpcException" src/controllers/` — zero hits; RpcException
   belongs only in microservice files.
