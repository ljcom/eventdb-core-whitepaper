# namespace-example.md
EventDB Core - Namespace Verification Example
Version: 0.1
Status: Draft
Change Log Reference: 00-admin/PROJECT_MEMORY.md

## 1. Scope

This document provides a step-by-step protocol narrative showing namespace-scoped chain, sealing, and verification behavior.
Namespace labels are illustrative only.

## 2. Example A: Single Namespace (`default`)

1. Initialize namespace boundary `default`.
2. Create Chain `chain-a` under (`default`, `chain-a`).
3. Append Event sequence in deterministic order for `chain-a`.
4. Define a window for `chain-a` using contiguous sequence boundaries.
5. Compute and record Seal for (`default`, `chain-a`, `window-1`).
6. Verify Event chain for namespace `default` and chain `chain-a`.
7. Verify Seal continuity for namespace `default` and chain `chain-a`.

Result requirement: all integrity checks MUST be evaluated only within namespace `default`.

## 3. Example B: Two Namespaces (`coffee` and `rwa`)

1. Initialize namespace boundaries `coffee` and `rwa`.
2. Create Chain `chain-1` under (`coffee`, `chain-1`).
3. Create Chain `chain-1` under (`rwa`, `chain-1`).
4. Append Events to (`coffee`, `chain-1`) and append separate Events to (`rwa`, `chain-1`).
5. Define and close windows independently for each namespace-chain pair.
6. Compute Seal for (`coffee`, `chain-1`, `window-1`).
7. Compute Seal for (`rwa`, `chain-1`, `window-1`).
8. Verify chain and Seal continuity in `coffee` scope.
9. Verify chain and Seal continuity in `rwa` scope.
10. Reject any verification input that mixes Events from `coffee` and `rwa` in one chain check.

Result requirement: namespace boundaries MUST isolate replay, sealing, and verification outcomes even when `chain_id` labels are equal.

## 4. Conformance Notes

- A window MUST be defined per (`namespace_id`, `chain_id`).
- A Seal MUST NOT include Events from other namespaces.
- Verification MUST execute within one namespace boundary at a time.
- Namespace scoping MUST NOT change hash or Seal mechanics.
