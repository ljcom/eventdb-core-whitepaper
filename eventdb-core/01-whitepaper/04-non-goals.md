# 04-non-goals.md
EventDB Core - Non-Goals
Version: 0.1
Status: Draft
Change Log Reference: 00-admin/PROJECT_MEMORY.md

This section defines explicit non-goals of EventDB Core to preserve architectural clarity and prevent scope drift. EventDB Core specifies a deterministic integrity layer for append-only Event history, accountable signing, and tamper-evident verification. Components or claims outside this integrity scope are out of model boundary.

EventDB Core is NOT a blockchain replacement.
The model does not require or attempt to replicate global consensus behavior as a mandatory baseline. Its purpose is to provide institution-compatible integrity verification within explicit governance boundaries.

EventDB Core is NOT a cryptocurrency system.
It does not define monetary units, issuance mechanics, exchange behavior, or payment-layer incentives. Economic token mechanics are outside core specification scope.

EventDB Core is NOT a tokenization engine.
It does not define representation, issuance, transfer, or lifecycle semantics for tokenized rights or instruments. Asset token models are profile-level concerns and are excluded from core definitions.

EventDB Core is NOT a marketplace.
It does not define participant matching, pricing, settlement negotiation, or market governance functions. Transaction-market design is outside the integrity-layer mandate.

EventDB Core is NOT a legal enforcement tool.
Integrity evidence MAY support legal review, but it does not create automatic legal force, enforceability, or jurisdictional validity. Legal interpretation remains external to core protocol behavior.

EventDB Core is NOT a physical asset authenticity verifier.
The model verifies integrity of recorded digital evidence, not physical state or provenance truth of real-world objects. Physical authenticity requires external attestation, inspection, and domain-specific controls.

These non-goals preserve the intended positioning of EventDB Core as a bounded integrity architecture. The system provides deterministic tamper-evident history and accountable verification primitives, while business truth, legal validity, market behavior, and physical-world authenticity remain explicitly outside core claims.
