import crypto from 'crypto';
import { canonicalJsonBuffer } from './canonical-json.js';
import { config } from './config.js';

export function sha256Hex(input) {
  return crypto.createHash('sha256').update(input).digest('hex');
}

export function hashCanonicalObject(value) {
  return sha256Hex(canonicalJsonBuffer(value));
}

export function verifySignature({ accountId, signature, signingObject }) {
  if (!signature || typeof signature !== 'string') {
    return false;
  }

  if (config.signatureMode === 'none') {
    return signature.trim().length > 0;
  }

  if (config.signatureMode === 'hmac_sha256') {
    const secret = config.accountSecrets[accountId];
    if (!secret) {
      return false;
    }
    const expected = crypto
      .createHmac('sha256', secret)
      .update(canonicalJsonBuffer(signingObject))
      .digest('hex');

    if (expected.length !== signature.length) {
      return false;
    }

    return crypto.timingSafeEqual(Buffer.from(expected, 'utf8'), Buffer.from(signature, 'utf8'));
  }

  return false;
}
