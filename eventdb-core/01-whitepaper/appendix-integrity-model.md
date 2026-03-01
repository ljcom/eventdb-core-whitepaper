# appendix-integrity-model.md
EventDB Core - Appendix: Integrity Model
Version: 0.1
Status: Draft
Change Log Reference: 00-admin/PROJECT_MEMORY.md

This appendix defines a compact formal model for EventDB Core integrity behavior. The notation is intentionally minimal and is used to express deterministic verification conditions.

## 1. Event Sequence

Let a Chain contain an ordered Event sequence:

- `E1, E2, E3, ..., En`

where `Ei` is the canonical Event envelope at position `i`.
Order is deterministic and append-only at the integrity layer.

## 2. Event Hash Recurrence

Let `H(x)` be the canonical hash function.
Define a genesis value `H0` for chain start.

For `n >= 1`:

- `Hn = H(En || Hn-1)`

Interpretation:

- `Hn` is the cumulative integrity state at Event `n`.
- `En` is canonical Event input.
- `Hn-1` is prior chain integrity state.
- `||` denotes deterministic byte concatenation under canonical encoding rules.

## 3. Seal Recurrence

Let `window_hash_n` be the deterministic commitment hash for Seal window `n`.
Define a genesis Seal value `S0`.

For `n >= 1`:

- `Sn = H(window_hash_n || Sn-1)`

Interpretation:

- `Sn` is Seal chain state at window `n`.
- `Sn-1` enforces continuity between consecutive Seals.

## 4. Tamper Propagation Property

The recurrence model has forward dependency.
If any past input changes, all downstream states change.

Formally:

- If `Ek` is modified for some `k <= n`, then `Hk` changes.
- Because `Hk` is input to `Hk+1`, all `Hi` for `i > k` also change.
- The same applies to Seal continuity: modifying `window_hash_k` or `Sk-1` changes `Sk` and all later `Si`.

This is the tamper propagation property.

## 5. Integrity Verification Condition

A Chain segment passes integrity verification only if all conditions hold:

- each Event is canonical and valid;
- each `prev_hash` corresponds to recomputed prior hash state;
- each Event signature is valid for canonical covered input;
- each Seal recomputes to expected `Sn` and links correctly to `Sn-1`.

Equivalently, verification passes when recomputed recurrence states match recorded recurrence states for the same scope.
Any mismatch is a verification failure.

## 6. Anchor Timestamp Externalization

Anchoring externalizes a selected local commitment (typically Seal-related) to an external system that records publication time.

Conceptually:

- local commitment `C` is published externally;
- external record associates `C` with an external timestamp `T_ext`;
- later verification checks that external `C` equals locally recomputed `C`.

This provides evidence that commitment `C` existed no later than `T_ext` under the external system's timestamp semantics.
It does not establish business truth or legal validity.
