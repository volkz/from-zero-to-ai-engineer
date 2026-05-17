---
name: grpc-error-handling
description: >
  Fires when writing, editing, or reviewing a gRPC service method, proto definition, or
  NestJS microservice handler. Provides the correct RpcException pattern and flags HTTP
  exception anti-patterns.
trigger: semantic
---

# gRPC Error Handling

## When this skill fires

- Writing or editing a `@GrpcMethod` / `@GrpcStreamMethod` handler
- Adding or modifying a `.proto` service definition
- Reviewing microservice code that throws exceptions

## Rule

Every gRPC handler **must** throw `RpcException` from `@nestjs/microservices`.
HTTP exception classes are forbidden.

## Correct pattern

```typescript
import { RpcException } from '@nestjs/microservices';
import { status } from '@grpc/grpc-js';

async getUser(request: GetUserRequest): Promise<GetUserResponse> {
  const user = await this.userRepository.find(request.id);
  if (!user) {
    throw new RpcException({
      code: status.NOT_FOUND,
      message: `User ${request.id} not found`,
    });
  }
  return { user };
}
```

## Forbidden patterns

```typescript
throw new NotFoundException(...)      // ❌ HTTP exception in gRPC
throw new HttpException('...', 400)   // ❌ HTTP status in gRPC
throw new Error('...')                // ❌ loses gRPC status code
```

## Why this matters

gRPC callers read `status.code`, not HTTP status codes. An HTTP exception becomes
`UNKNOWN (2)` on the wire — all structured error data is lost. `RpcException` + a
`@grpc/grpc-js` status enum maps directly to what the generated client expects.

## Verification

After any change to a gRPC handler:

1. `grep -rn "HttpException\|BadRequestException\|NotFoundException" src/` — zero hits in gRPC service files
2. Run tests with `yarn test` and confirm non-zero exit on failure
