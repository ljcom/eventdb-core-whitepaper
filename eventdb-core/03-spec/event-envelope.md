# event-envelope.md
EventDB Core - Event Envelope (Compatibility Specification)
Version: 0.1
Status: Draft


This file provides a compatibility alias for `03-spec/03-event-envelope.md`.
Normative envelope rules are defined in that numbered specification.

## Namespace Metadata Rule

- `namespace_id` MAY be included in Event metadata.
- If present, `namespace_id` MUST be included in canonical hash coverage.
- If present, `namespace_id` MUST be immutable once the Event is recorded.
- `namespace_id` MUST be interpreted only as a ledger boundary identifier.

Namespace metadata MUST NOT introduce business logic.
Namespace metadata MUST NOT alter Chain or Seal behavior.
