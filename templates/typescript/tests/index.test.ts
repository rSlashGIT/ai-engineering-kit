import { describe, expect, it } from 'vitest';
import { greet } from '../src/index.js';

describe('greet', () => {
  it('should return the default greeting', () => {
    expect(greet()).toBe('Hello, World!');
  });

  it('should greet a custom name', () => {
    expect(greet('TypeScript')).toBe('Hello, TypeScript!');
  });
});
