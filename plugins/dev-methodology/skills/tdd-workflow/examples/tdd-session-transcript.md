# Complete TDD Session Transcript

This example demonstrates a complete TDD session implementing a `ShoppingCart` class with add, remove, and total calculation features.

## Session Overview

**Goal:** Implement a shopping cart that can add items, remove items, and calculate total price

**Approach:** Test-Driven Development (Red → Green → Refactor)

## Iteration 1: Empty cart should have zero total

### Red: Write failing test

```javascript
// shopping-cart.test.js
describe('ShoppingCart', () => {
  test('shouldReturnZeroForEmptyCart', () => {
    const cart = new ShoppingCart();
    expect(cart.getTotal()).toBe(0);
  });
});
```

**Run tests:**
```
FAIL shopping-cart.test.js
  ● ShoppingCart › shouldReturnZeroForEmptyCart
    ReferenceError: ShoppingCart is not defined
```

✅ Test fails as expected (class doesn't exist)

### Green: Minimal implementation

```javascript
// shopping-cart.js
class ShoppingCart {
  getTotal() {
    return 0;
  }
}

module.exports = ShoppingCart;
```

**Run tests:**
```
PASS shopping-cart.test.js
  ✓ shouldReturnZeroForEmptyCart (2ms)
```

✅ Test passes with minimal code

### Refactor: Nothing to refactor yet

Code is simple and clear. Move to next test.

---

## Iteration 2: Add single item to cart

### Red: Write failing test

```javascript
test('shouldReturnItemPriceWhenOneItemAdded', () => {
  const cart = new ShoppingCart();
  cart.addItem({ name: 'Book', price: 10 });
  expect(cart.getTotal()).toBe(10);
});
```

**Run tests:**
```
FAIL shopping-cart.test.js
  ● ShoppingCart › shouldReturnItemPriceWhenOneItemAdded
    TypeError: cart.addItem is not a function
```

✅ Test fails (addItem method doesn't exist)

### Green: Implement addItem

```javascript
class ShoppingCart {
  constructor() {
    this.items = [];
  }

  addItem(item) {
    this.items.push(item);
  }

  getTotal() {
    if (this.items.length === 0) return 0;
    return this.items[0].price;
  }
}
```

**Run tests:**
```
PASS shopping-cart.test.js
  ✓ shouldReturnZeroForEmptyCart (1ms)
  ✓ shouldReturnItemPriceWhenOneItemAdded (1ms)
```

✅ Both tests pass (using simplest logic—just return first item price)

### Refactor: Clean up

Code is still simple. No refactoring needed yet.

---

## Iteration 3: Add multiple items

### Red: Write failing test

```javascript
test('shouldReturnSumWhenMultipleItemsAdded', () => {
  const cart = new ShoppingCart();
  cart.addItem({ name: 'Book', price: 10 });
  cart.addItem({ name: 'Pen', price: 2 });
  cart.addItem({ name: 'Notebook', price: 5 });
  expect(cart.getTotal()).toBe(17);
});
```

**Run tests:**
```
FAIL shopping-cart.test.js
  ● ShoppingCart › shouldReturnSumWhenMultipleItemsAdded
    Expected: 17
    Received: 10
```

✅ Test fails (only returns first item price)

### Green: Implement sum logic

```javascript
class ShoppingCart {
  constructor() {
    this.items = [];
  }

  addItem(item) {
    this.items.push(item);
  }

  getTotal() {
    return this.items.reduce((sum, item) => sum + item.price, 0);
  }
}
```

**Run tests:**
```
PASS shopping-cart.test.js
  ✓ shouldReturnZeroForEmptyCart (1ms)
  ✓ shouldReturnItemPriceWhenOneItemAdded (1ms)
  ✓ shouldReturnSumWhenMultipleItemsAdded (2ms)
```

✅ All tests pass with real implementation

### Refactor: Extract method

Notice `reduce` logic could be clearer with a helper:

```javascript
class ShoppingCart {
  constructor() {
    this.items = [];
  }

  addItem(item) {
    this.items.push(item);
  }

  getTotal() {
    return this.calculateSum();
  }

  calculateSum() {
    return this.items.reduce((sum, item) => sum + item.price, 0);
  }
}
```

**Run tests:**
```
PASS shopping-cart.test.js
  ✓ shouldReturnZeroForEmptyCart (1ms)
  ✓ shouldReturnItemPriceWhenOneItemAdded (1ms)
  ✓ shouldReturnSumWhenMultipleItemsAdded (1ms)
```

✅ Refactoring preserved behavior

---

## Iteration 4: Remove item from cart

### Red: Write failing test

```javascript
test('shouldRemoveItemFromCart', () => {
  const cart = new ShoppingCart();
  const book = { name: 'Book', price: 10 };
  const pen = { name: 'Pen', price: 2 };

  cart.addItem(book);
  cart.addItem(pen);
  cart.removeItem(book);

  expect(cart.getTotal()).toBe(2);
});
```

**Run tests:**
```
FAIL shopping-cart.test.js
  ● ShoppingCart › shouldRemoveItemFromCart
    TypeError: cart.removeItem is not a function
```

✅ Test fails (removeItem doesn't exist)

### Green: Implement removeItem

```javascript
class ShoppingCart {
  constructor() {
    this.items = [];
  }

  addItem(item) {
    this.items.push(item);
  }

  removeItem(item) {
    const index = this.items.indexOf(item);
    if (index !== -1) {
      this.items.splice(index, 1);
    }
  }

  getTotal() {
    return this.calculateSum();
  }

  calculateSum() {
    return this.items.reduce((sum, item) => sum + item.price, 0);
  }
}
```

**Run tests:**
```
PASS shopping-cart.test.js
  ✓ shouldReturnZeroForEmptyCart (1ms)
  ✓ shouldReturnItemPriceWhenOneItemAdded (1ms)
  ✓ shouldReturnSumWhenMultipleItemsAdded (1ms)
  ✓ shouldRemoveItemFromCart (2ms)
```

✅ All tests pass

### Refactor: Nothing needed

Code is clear and concise.

---

## Iteration 5: Handle removing non-existent item

### Red: Write failing test

```javascript
test('shouldHandleRemovingNonExistentItem', () => {
  const cart = new ShoppingCart();
  const book = { name: 'Book', price: 10 };

  cart.addItem(book);
  cart.removeItem({ name: 'Pen', price: 2 }); // Different item

  expect(cart.getTotal()).toBe(10); // Book still in cart
});
```

**Run tests:**
```
PASS shopping-cart.test.js
  ✓ shouldReturnZeroForEmptyCart (1ms)
  ✓ shouldReturnItemPriceWhenOneItemAdded (1ms)
  ✓ shouldReturnSumWhenMultipleItemsAdded (1ms)
  ✓ shouldRemoveItemFromCart (1ms)
  ✓ shouldHandleRemovingNonExistentItem (1ms)
```

✅ Test already passes! (indexOf returns -1, splice doesn't execute)

### Green: Already green

No code changes needed.

### Refactor: Add clarity

While the code works, we can make the intent clearer:

```javascript
removeItem(item) {
  const index = this.findItemIndex(item);
  if (this.itemExists(index)) {
    this.items.splice(index, 1);
  }
}

findItemIndex(item) {
  return this.items.indexOf(item);
}

itemExists(index) {
  return index !== -1;
}
```

**Run tests:**
```
PASS shopping-cart.test.js
  ✓ shouldReturnZeroForEmptyCart (1ms)
  ✓ shouldReturnItemPriceWhenOneItemAdded (1ms)
  ✓ shouldReturnSumWhenMultipleItemsAdded (1ms)
  ✓ shouldRemoveItemFromCart (1ms)
  ✓ shouldHandleRemovingNonExistentItem (1ms)
```

✅ Refactoring successful

---

## Iteration 6: Add quantity support

### Red: Write failing test

```javascript
test('shouldHandleItemQuantities', () => {
  const cart = new ShoppingCart();
  cart.addItem({ name: 'Book', price: 10 }, 3);

  expect(cart.getTotal()).toBe(30);
});
```

**Run tests:**
```
FAIL shopping-cart.test.js
  ● ShoppingCart › shouldHandleItemQuantities
    Expected: 30
    Received: 10
```

✅ Test fails (quantity parameter ignored)

### Green: Implement quantity

```javascript
class ShoppingCart {
  constructor() {
    this.items = [];
  }

  addItem(item, quantity = 1) {
    for (let i = 0; i < quantity; i++) {
      this.items.push(item);
    }
  }

  removeItem(item) {
    const index = this.findItemIndex(item);
    if (this.itemExists(index)) {
      this.items.splice(index, 1);
    }
  }

  getTotal() {
    return this.calculateSum();
  }

  calculateSum() {
    return this.items.reduce((sum, item) => sum + item.price, 0);
  }

  findItemIndex(item) {
    return this.items.indexOf(item);
  }

  itemExists(index) {
    return index !== -1;
  }
}
```

**Run tests:**
```
PASS shopping-cart.test.js
  ✓ shouldReturnZeroForEmptyCart (1ms)
  ✓ shouldReturnItemPriceWhenOneItemAdded (1ms)
  ✓ shouldReturnSumWhenMultipleItemsAdded (1ms)
  ✓ shouldRemoveItemFromCart (1ms)
  ✓ shouldHandleRemovingNonExistentItem (1ms)
  ✓ shouldHandleItemQuantities (2ms)
```

✅ All tests pass

### Refactor: Better data structure

Storing duplicates is inefficient. Refactor to store quantity:

```javascript
class ShoppingCart {
  constructor() {
    this.items = new Map(); // item -> quantity
  }

  addItem(item, quantity = 1) {
    const currentQuantity = this.items.get(item) || 0;
    this.items.set(item, currentQuantity + quantity);
  }

  removeItem(item) {
    this.items.delete(item);
  }

  getTotal() {
    return this.calculateSum();
  }

  calculateSum() {
    let total = 0;
    for (const [item, quantity] of this.items) {
      total += item.price * quantity;
    }
    return total;
  }
}
```

**Run tests:**
```
PASS shopping-cart.test.js
  ✓ shouldReturnZeroForEmptyCart (1ms)
  ✓ shouldReturnItemPriceWhenOneItemAdded (1ms)
  ✓ shouldReturnSumWhenMultipleItemsAdded (1ms)
  ✓ shouldRemoveItemFromCart (1ms)
  ✓ shouldHandleRemovingNonExistentItem (1ms)
  ✓ shouldHandleItemQuantities (1ms)
```

✅ Major refactoring successful—all tests still pass!

---

## Final Code

```javascript
// shopping-cart.js
class ShoppingCart {
  constructor() {
    this.items = new Map();
  }

  addItem(item, quantity = 1) {
    const currentQuantity = this.items.get(item) || 0;
    this.items.set(item, currentQuantity + quantity);
  }

  removeItem(item) {
    this.items.delete(item);
  }

  getTotal() {
    return this.calculateSum();
  }

  calculateSum() {
    let total = 0;
    for (const [item, quantity] of this.items) {
      total += item.price * quantity;
    }
    return total;
  }
}

module.exports = ShoppingCart;
```

## Key Lessons from This Session

### 1. Small Steps
Each test added one small piece of functionality. Never tried to implement everything at once.

### 2. Simplest Implementation First
- Iteration 1: Hard-coded `return 0`
- Iteration 2: Just returned first item
- Iteration 3: Implemented real sum logic

### 3. Tests Drive Design
Tests revealed the need for:
- Constructor to initialize state
- addItem and removeItem methods
- Quantity support
- Better data structure (Map instead of Array)

### 4. Refactoring Safety
The switch from Array to Map (major refactoring) was safe because tests verified behavior throughout.

### 5. One Test at a Time
Never wrote multiple tests ahead of implementation. Each test drove exactly one implementation cycle.

### 6. Always Run All Tests
After every change, ran the full test suite to catch regressions immediately.

## Session Statistics

- **Iterations:** 6
- **Tests written:** 6
- **Tests passing:** 6/6 (100%)
- **Refactorings:** 3 (extract method, clarity improvement, data structure change)
- **Lines of production code:** 24
- **Lines of test code:** 35
- **Time:** ~15 minutes

## What Made This Session Successful

✅ **Strict TDD discipline:** Never wrote code without a failing test
✅ **Minimal implementations:** Always chose simplest code first
✅ **Frequent test runs:** Ran tests after every change
✅ **Safe refactoring:** Only refactored when green
✅ **Small commits:** Could have committed after each green phase
✅ **Clear test names:** Each test name documented behavior

## Common Deviations to Avoid

❌ Writing all tests upfront before implementation
❌ Implementing features not yet tested
❌ Skipping test runs during refactoring
❌ Adding "nice to have" features without tests
❌ Large refactorings without incremental test runs
❌ Continuing when tests are red

This session demonstrates TDD done correctly: disciplined, incremental, test-driven.
