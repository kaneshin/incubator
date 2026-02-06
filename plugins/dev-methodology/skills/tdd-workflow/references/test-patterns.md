# Test Patterns and Anti-Patterns

## Common Test Patterns

### Arrange-Act-Assert (AAA)

Structure tests in three clear phases:

```javascript
test('shouldCalculateDiscountedPrice', () => {
  // Arrange: Set up test data
  const originalPrice = 100;
  const discountPercent = 20;

  // Act: Execute the behavior
  const result = calculateDiscount(originalPrice, discountPercent);

  // Assert: Verify the outcome
  expect(result).toBe(80);
});
```

**Benefits:**
- Clear test structure
- Easy to understand test intent
- Separates setup from verification

### Test Data Builders

Create reusable builders for complex test objects:

```javascript
class OrderBuilder {
  constructor() {
    this.items = [];
    this.discountPercent = 0;
  }

  withItem(price) {
    this.items.push(price);
    return this;
  }

  withDiscount(percent) {
    this.discountPercent = percent;
    return this;
  }

  build() {
    return {
      items: this.items,
      discount: this.discountPercent
    };
  }
}

test('shouldApplyDiscountToTotal', () => {
  const order = new OrderBuilder()
    .withItem(50)
    .withItem(30)
    .withDiscount(10)
    .build();

  expect(calculateTotal(order)).toBe(72);
});
```

### Parameterized Tests

Test multiple cases with same logic:

```javascript
test.each([
  [[], 0],
  [[5], 5],
  [[1, 2, 3], 6],
  [[10, -5, 3], 8]
])('sum(%j) should return %i', (input, expected) => {
  expect(sum(input)).toBe(expected);
});
```

### Test Doubles (Mocks, Stubs, Fakes)

**Stub:** Provides predetermined responses
```javascript
const emailStub = {
  send: () => true
};
```

**Mock:** Verifies interactions occurred
```javascript
const emailMock = {
  send: jest.fn()
};

sendWelcomeEmail(user, emailMock);
expect(emailMock.send).toHaveBeenCalledWith(user.email, 'Welcome!');
```

**Fake:** Working implementation for testing
```javascript
class FakeDatabase {
  constructor() {
    this.data = new Map();
  }

  save(id, value) {
    this.data.set(id, value);
  }

  get(id) {
    return this.data.get(id);
  }
}
```

## Anti-Patterns to Avoid

### Anti-Pattern 1: Testing Implementation Details

❌ **Bad:**
```javascript
test('shouldUseReduceToCalculateSum', () => {
  const spy = jest.spyOn(Array.prototype, 'reduce');
  sum([1, 2, 3]);
  expect(spy).toHaveBeenCalled();
});
```

✅ **Good:**
```javascript
test('shouldReturnSumOfAllNumbers', () => {
  expect(sum([1, 2, 3])).toBe(6);
});
```

**Why:** Tests should verify behavior, not implementation. Implementation can change without breaking behavior.

### Anti-Pattern 2: Fragile Tests (Too Many Assertions)

❌ **Bad:**
```javascript
test('shouldProcessOrder', () => {
  const result = processOrder(order);
  expect(result.id).toBeDefined();
  expect(result.total).toBe(100);
  expect(result.tax).toBe(8);
  expect(result.shipping).toBe(5.99);
  expect(result.grandTotal).toBe(113.99);
  expect(result.status).toBe('pending');
  expect(result.createdAt).toBeInstanceOf(Date);
});
```

✅ **Good:**
```javascript
test('shouldCalculateCorrectGrandTotal', () => {
  const result = processOrder(order);
  expect(result.grandTotal).toBe(113.99);
});

test('shouldSetStatusToPending', () => {
  const result = processOrder(order);
  expect(result.status).toBe('pending');
});
```

**Why:** One assertion per test makes failures easier to diagnose.

### Anti-Pattern 3: Interdependent Tests

❌ **Bad:**
```javascript
let user;

test('shouldCreateUser', () => {
  user = createUser('alice');
  expect(user.name).toBe('alice');
});

test('shouldUpdateUser', () => {
  updateUser(user, { name: 'bob' });
  expect(user.name).toBe('bob');
});
```

✅ **Good:**
```javascript
test('shouldCreateUser', () => {
  const user = createUser('alice');
  expect(user.name).toBe('alice');
});

test('shouldUpdateUser', () => {
  const user = createUser('alice');
  updateUser(user, { name: 'bob' });
  expect(user.name).toBe('bob');
});
```

**Why:** Tests should run independently in any order.

### Anti-Pattern 4: Testing Too Much at Once

❌ **Bad:**
```javascript
test('shouldProcessCheckoutFlow', () => {
  const cart = createCart();
  addToCart(cart, item1);
  addToCart(cart, item2);
  applyDiscount(cart, '10OFF');
  const order = checkout(cart, paymentInfo);
  processPayment(order);
  sendConfirmation(order);
  updateInventory(order);

  expect(order.status).toBe('confirmed');
  expect(inventory.get(item1.id)).toBe(9);
});
```

✅ **Good:**
```javascript
test('shouldCreateOrderFromCart', () => {
  const cart = createCart([item1, item2]);
  const order = checkout(cart, paymentInfo);
  expect(order.items).toEqual([item1, item2]);
});

test('shouldUpdateInventoryAfterOrder', () => {
  const order = createOrder([item1]);
  updateInventory(order);
  expect(inventory.get(item1.id)).toBe(9);
});
```

**Why:** Small, focused tests are easier to understand and maintain.

### Anti-Pattern 5: Test Logic

❌ **Bad:**
```javascript
test('shouldValidatePasswords', () => {
  const passwords = ['weak', 'Strong1', 'VeryStr0ng!'];

  for (const password of passwords) {
    const result = validate(password);
    if (password.length < 8) {
      expect(result).toBe(false);
    } else {
      expect(result).toBe(true);
    }
  }
});
```

✅ **Good:**
```javascript
test('shouldRejectShortPasswords', () => {
  expect(validate('weak')).toBe(false);
});

test('shouldAcceptStrongPasswords', () => {
  expect(validate('Strong1')).toBe(true);
});
```

**Why:** Tests should be simple and obvious. Logic in tests makes them harder to trust.

### Anti-Pattern 6: Unclear Test Names

❌ **Bad:**
```javascript
test('test1', () => { ... });
test('passwordTest', () => { ... });
test('itWorks', () => { ... });
```

✅ **Good:**
```javascript
test('shouldRejectPasswordShorterThanEightCharacters', () => { ... });
test('shouldAcceptPasswordWithUppercaseAndNumber', () => { ... });
test('shouldReturnErrorMessageForInvalidPassword', () => { ... });
```

**Why:** Test names document behavior. Good names make failures self-explanatory.

## Test Organization

### Group Related Tests

```javascript
describe('Password Validator', () => {
  describe('length validation', () => {
    test('shouldRejectPasswordShorterThanEight', () => { ... });
    test('shouldAcceptPasswordOfEightCharacters', () => { ... });
    test('shouldAcceptPasswordLongerThanEight', () => { ... });
  });

  describe('character requirements', () => {
    test('shouldRejectPasswordWithoutUppercase', () => { ... });
    test('shouldRejectPasswordWithoutNumber', () => { ... });
    test('shouldAcceptPasswordWithAllRequirements', () => { ... });
  });
});
```

### Setup and Teardown

```javascript
describe('Database operations', () => {
  let db;

  beforeEach(() => {
    db = new FakeDatabase();
  });

  afterEach(() => {
    db.clear();
  });

  test('shouldSaveUser', () => {
    db.save('user1', { name: 'Alice' });
    expect(db.get('user1')).toEqual({ name: 'Alice' });
  });

  test('shouldDeleteUser', () => {
    db.save('user1', { name: 'Alice' });
    db.delete('user1');
    expect(db.get('user1')).toBeUndefined();
  });
});
```

## Test Coverage Principles

**Focus on behavior, not coverage percentage:**
- 100% coverage doesn't mean bug-free code
- Uncovered code should be tested, but coverage is a means not an end
- Test important behaviors thoroughly rather than trivial getters/setters

**Prioritize tests by value:**
1. Business-critical logic
2. Complex algorithms
3. Edge cases and error handling
4. Integration points
5. Simple utilities (lower priority)

**When to write more tests:**
- Bug found in production → add test that would have caught it
- Confusing behavior → test documents expected behavior
- Refactoring planned → tests protect against regressions

**When not to write tests:**
- Trivial code (getters, simple property assignments)
- Framework code (already tested by framework authors)
- Generated code (test the generator instead)

## Testing Different Layers

### Unit Tests

Test individual functions/methods in isolation:

```javascript
test('shouldCalculateTaxForOrder', () => {
  const order = { subtotal: 100 };
  expect(calculateTax(order)).toBe(8);
});
```

**Characteristics:**
- Fast (milliseconds)
- Isolated (no external dependencies)
- Focused (one function/method)

### Integration Tests

Test multiple components working together:

```javascript
test('shouldSaveOrderToDatabase', async () => {
  const order = createOrder([item1, item2]);
  await orderRepository.save(order);

  const saved = await orderRepository.findById(order.id);
  expect(saved).toEqual(order);
});
```

**Characteristics:**
- Slower (seconds)
- Multiple components
- May use real or fake dependencies

### End-to-End Tests

Test complete user workflows:

```javascript
test('shouldCompleteCheckoutFlow', async () => {
  await page.goto('/products');
  await page.click('[data-testid="add-to-cart"]');
  await page.goto('/cart');
  await page.fill('[name="email"]', 'user@example.com');
  await page.click('[data-testid="checkout"]');

  await expect(page.locator('[data-testid="confirmation"]')).toBeVisible();
});
```

**Characteristics:**
- Slowest (10+ seconds)
- Complete system
- Real dependencies

**Test pyramid:** Many unit tests, fewer integration tests, few end-to-end tests.

## Quick Reference

**Good test characteristics:**
- ✅ Fast
- ✅ Isolated
- ✅ Repeatable
- ✅ Self-validating
- ✅ Timely (written first)

**Test smells:**
- ❌ Slow tests
- ❌ Flaky tests (randomly fail)
- ❌ Fragile tests (break on refactoring)
- ❌ Obscure tests (hard to understand)
- ❌ Tests with logic (if/loops)
