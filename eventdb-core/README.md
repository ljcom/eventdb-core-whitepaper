# EventDB Core

EventDB Core is a deterministic integrity layer for enterprise event history.
It defines append-only Event recording, hash chaining, signed issuance, window sealing,
snapshot checkpoints, and optional anchoring.

## Repository Layout

- `00-admin/`: project context, writing rules, roadmap, and memory.
- `01-whitepaper/`: conceptual and architectural documentation.
- `02-diagrams/`: draw.io sources for architecture and process views.
- `03-spec/`: normative protocol and verification specification.
- `04-mvp/`: MVP schema, sample artifacts, and walkthrough.
- `05-implementation/`: adapter, API, and operational implementation notes.

## Core Positioning

EventDB Core is not a blockchain replacement and not a legal truth engine.
It provides tamper-evident integrity verification under institutional governance boundaries.

## Document Status

Current document set is draft (`Version 0.1`) and intended for iterative review.
