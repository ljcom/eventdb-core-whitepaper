# 13-security-and-threat-model.md
EventDB Core - Security and Threat Model
Version: 0.1
Status: Draft
Change Log Reference: 00-admin/PROJECT_MEMORY.md

This section defines the conceptual threat model for EventDB Core and maps core mitigations to deterministic integrity controls. The focus is integrity risk in Event history and verification artifacts, not full organizational cybersecurity coverage.

## 1. Security Scope

EventDB Core protects integrity properties through three primary mechanisms:

- hash linkage for tamper-evident sequence continuity;
- signature verification for accountable issuance;
- Seal checkpoints for bounded integrity commitments.

These mechanisms are designed to detect unauthorized modification, omission, or inconsistency in recorded history. They do not replace endpoint security, legal controls, or business process validation.

## 2. Threat: Event Tampering

### 2.1 Threat Description

An attacker modifies Event content after issuance, including payload fields, ordering fields, or signer-related metadata.

### 2.2 Mitigation

- Canonical hashing binds Event content to deterministic digest output.
- Event signature binds signer accountability to defined signing input.
- Re-verification of hash and signature SHOULD detect unauthorized content changes.

### 2.3 Residual Limit

If invalid data is recorded and signed at issuance time, integrity controls preserve that data as-is. They do not prove factual correctness of business content.

## 3. Threat: Chain Rewriting

### 3.1 Threat Description

An attacker attempts to rewrite history by editing prior Events, inserting synthetic Events, or reordering sequence positions.

### 3.2 Mitigation

- `prev_hash` linkage across Events makes unauthorized edits propagate forward as detectable mismatches.
- Deterministic ordering rules make reordering attempts machine-detectable.
- Seal checkpoints provide periodic commitment boundaries that increase rewrite cost and detection likelihood.

### 3.3 Residual Limit

A fully compromised control domain with access to signing keys and operational systems may attempt coordinated falsification. EventDB Core improves detectability but does not eliminate all insider-risk scenarios without governance and monitoring controls.

## 4. Threat: Key Compromise

### 4.1 Threat Description

An attacker gains unauthorized access to an Account signing key and issues seemingly valid Events or Seals.

### 4.2 Mitigation

- Signature verification ensures artifacts are attributable to a specific compromised Account.
- Governance policies SHOULD support key rotation, revocation, and incident-scoped verification review.
- Seal and Chain continuity analysis SHOULD help bound compromise impact windows.

### 4.3 Residual Limit

Cryptographic validity alone cannot distinguish authorized use from unauthorized use of the same key. Key lifecycle governance remains mandatory.

## 5. Threat: Seal Omission

### 5.1 Threat Description

Expected Seal generation is skipped, delayed, or selectively omitted to reduce integrity visibility for certain Event windows.

### 5.2 Mitigation

- Deterministic window policy and expected Seal cadence SHOULD make omission observable.
- `prev_seal_hash` continuity can expose missing checkpoint progression.
- Verification policy SHOULD treat unexpected Seal gaps as integrity incidents requiring investigation.

### 5.3 Residual Limit

Seal omission detection depends on governance-defined schedule enforcement and review discipline. Technical controls alone cannot enforce organizational process compliance.

## 6. Threat: Snapshot Abuse

### 6.1 Threat Description

A stale, manipulated, or selectively generated Snapshot is used to misrepresent current verified state or to conceal historical inconsistencies.

### 6.2 Mitigation

- Snapshots MUST be derivable from verified Chain and Seal evidence.
- Verification workflows SHOULD allow fallback to underlying Event and Seal artifacts.
- Snapshot-to-Chain consistency checks SHOULD be required before trust elevation.

### 6.3 Residual Limit

Snapshot is a performance artifact. If operations rely on Snapshot output without periodic underlying verification, detection latency increases.

## 7. Threat: Anchor Replay Attack

### 7.1 Threat Description

An attacker replays previously valid Anchor evidence in an inappropriate context to imply freshness, continuity, or state equivalence that does not exist.

### 7.2 Mitigation

- Anchor verification MUST bind external evidence to specific Chain and Seal identifiers.
- Verification SHOULD include sequence context and expected checkpoint progression, not hash match alone.
- External timestamp comparison SHOULD be used to detect stale replayed publication claims.

### 7.3 Residual Limit

Anchor evidence confirms publication consistency, not full state freshness or business validity. Policy controls are required to define acceptable staleness and replay handling.

## 8. Protection Limits and Non-Claims

EventDB Core protections are bounded. The model:

- detects many forms of tampering and continuity violation;
- attributes signed artifacts to Accounts;
- supports checkpoint-based integrity verification.

The model does not automatically provide:

- business truth validation;
- legal validity determination;
- endpoint, network, or operator hardening;
- immunity to compromised governance processes.

Accordingly, cryptographic integrity evidence MUST be combined with institutional governance, key management, monitoring, and legal controls.

## 9. Security Posture Summary

EventDB Core SHOULD be interpreted as an integrity assurance layer with deterministic verification guarantees and explicit limitations. Hash, signature, and Seal mechanisms materially improve tamper-evident accountability, while residual risk management remains a governance and operations responsibility.
