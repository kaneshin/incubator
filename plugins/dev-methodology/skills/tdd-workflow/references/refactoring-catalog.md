# Refactoring Catalog

A catalog of safe refactorings to apply during the Green phase of TDD. Each refactoring preserves behavior while improving code structure.

## Extract Method

**When:** Method is too long or contains code that should be reusable

**Before:**
```javascript
function printOwing(invoice) {
  console.log('***********************');
  console.log('**** Customer Owes ****');
  console.log('***********************');

  let outstanding = 0;
  for (const order of invoice.orders) {
    outstanding += order.amount;
  }

  console.log(`Name: ${invoice.customer}`);
  console.log(`Amount: ${outstanding}`);
}
```

**After:**
```javascript
function printOwing(invoice) {
  printBanner();
  const outstanding = calculateOutstanding(invoice);
  printDetails(invoice.customer, outstanding);
}

function printBanner() {
  console.log('***********************');
  console.log('**** Customer Owes ****');
  console.log('***********************');
}

function calculateOutstanding(invoice) {
  let result = 0;
  for (const order of invoice.orders) {
    result += order.amount;
  }
  return result;
}

function printDetails(customer, outstanding) {
  console.log(`Name: ${customer}`);
  console.log(`Amount: ${outstanding}`);
}
```

## Inline Method

**When:** Method body is as clear as its name

**Before:**
```javascript
function rating(driver) {
  return moreThanFiveLateDeliveries(driver) ? 2 : 1;
}

function moreThanFiveLateDeliveries(driver) {
  return driver.numberOfLateDeliveries > 5;
}
```

**After:**
```javascript
function rating(driver) {
  return driver.numberOfLateDeliveries > 5 ? 2 : 1;
}
```

## Extract Variable

**When:** Expression is complex or used multiple times

**Before:**
```javascript
function price(order) {
  return order.quantity * order.itemPrice -
    Math.max(0, order.quantity - 500) * order.itemPrice * 0.05 +
    Math.min(order.quantity * order.itemPrice * 0.1, 100);
}
```

**After:**
```javascript
function price(order) {
  const basePrice = order.quantity * order.itemPrice;
  const quantityDiscount = Math.max(0, order.quantity - 500) * order.itemPrice * 0.05;
  const shipping = Math.min(basePrice * 0.1, 100);
  return basePrice - quantityDiscount + shipping;
}
```

## Inline Variable

**When:** Variable name doesn't add clarity beyond expression

**Before:**
```javascript
function isExpensive(order) {
  const basePrice = order.basePrice;
  return basePrice > 1000;
}
```

**After:**
```javascript
function isExpensive(order) {
  return order.basePrice > 1000;
}
```

## Rename Variable/Method

**When:** Name doesn't clearly express intent

**Before:**
```javascript
function calc(n) {
  const t = n * 0.08;
  return n + t;
}
```

**After:**
```javascript
function calculateTotalWithTax(subtotal) {
  const tax = subtotal * 0.08;
  return subtotal + tax;
}
```

## Introduce Parameter Object

**When:** Group of parameters naturally go together

**Before:**
```javascript
function amountInvoiced(startDate, endDate) { ... }
function amountReceived(startDate, endDate) { ... }
function amountOverdue(startDate, endDate) { ... }
```

**After:**
```javascript
class DateRange {
  constructor(startDate, endDate) {
    this.start = startDate;
    this.end = endDate;
  }
}

function amountInvoiced(dateRange) { ... }
function amountReceived(dateRange) { ... }
function amountOverdue(dateRange) { ... }
```

## Replace Magic Number with Constant

**When:** Literal values have domain meaning

**Before:**
```javascript
function potentialEnergy(mass, height) {
  return mass * 9.81 * height;
}
```

**After:**
```javascript
const GRAVITY = 9.81;

function potentialEnergy(mass, height) {
  return mass * GRAVITY * height;
}
```

## Decompose Conditional

**When:** Complex conditional logic obscures intent

**Before:**
```javascript
function charge(date, quantity) {
  if (date.isBefore(SUMMER_START) || date.isAfter(SUMMER_END)) {
    return quantity * winterRate + winterServiceCharge;
  } else {
    return quantity * summerRate;
  }
}
```

**After:**
```javascript
function charge(date, quantity) {
  if (isWinter(date)) {
    return winterCharge(quantity);
  } else {
    return summerCharge(quantity);
  }
}

function isWinter(date) {
  return date.isBefore(SUMMER_START) || date.isAfter(SUMMER_END);
}

function winterCharge(quantity) {
  return quantity * winterRate + winterServiceCharge;
}

function summerCharge(quantity) {
  return quantity * summerRate;
}
```

## Consolidate Conditional Expression

**When:** Multiple conditionals have the same outcome

**Before:**
```javascript
function disabilityAmount(employee) {
  if (employee.seniority < 2) return 0;
  if (employee.monthsDisabled > 12) return 0;
  if (employee.isPartTime) return 0;
  // calculate disability amount
}
```

**After:**
```javascript
function disabilityAmount(employee) {
  if (isNotEligibleForDisability(employee)) return 0;
  // calculate disability amount
}

function isNotEligibleForDisability(employee) {
  return employee.seniority < 2
    || employee.monthsDisabled > 12
    || employee.isPartTime;
}
```

## Replace Nested Conditional with Guard Clauses

**When:** Special cases obscure normal flow

**Before:**
```javascript
function getPayAmount(employee) {
  let result;
  if (employee.isSeparated) {
    result = { amount: 0, reason: 'separated' };
  } else {
    if (employee.isRetired) {
      result = { amount: 0, reason: 'retired' };
    } else {
      result = { amount: normalPay(employee), reason: 'active' };
    }
  }
  return result;
}
```

**After:**
```javascript
function getPayAmount(employee) {
  if (employee.isSeparated) {
    return { amount: 0, reason: 'separated' };
  }
  if (employee.isRetired) {
    return { amount: 0, reason: 'retired' };
  }
  return { amount: normalPay(employee), reason: 'active' };
}
```

## Remove Dead Code

**When:** Code is never executed

**Before:**
```javascript
function handleRequest(request) {
  if (request.type === 'legacy') {
    // This code path no longer occurs in production
    return legacyHandler(request);
  }
  return modernHandler(request);
}
```

**After:**
```javascript
function handleRequest(request) {
  return modernHandler(request);
}
```

## Replace Loop with Pipeline

**When:** Collection processing can be expressed declaratively

**Before:**
```javascript
function getTotalOutstanding(invoices) {
  let result = 0;
  for (const invoice of invoices) {
    if (invoice.status === 'outstanding') {
      result += invoice.amount;
    }
  }
  return result;
}
```

**After:**
```javascript
function getTotalOutstanding(invoices) {
  return invoices
    .filter(invoice => invoice.status === 'outstanding')
    .reduce((total, invoice) => total + invoice.amount, 0);
}
```

## Replace Conditional with Polymorphism

**When:** Type checking determines behavior

**Before:**
```javascript
function plumage(bird) {
  switch (bird.type) {
    case 'EuropeanSwallow':
      return 'average';
    case 'AfricanSwallow':
      return bird.numberOfCoconuts > 2 ? 'tired' : 'average';
    case 'NorwegianBlueParrot':
      return bird.voltage > 100 ? 'scorched' : 'beautiful';
    default:
      return 'unknown';
  }
}
```

**After:**
```javascript
class Bird {
  plumage() { return 'unknown'; }
}

class EuropeanSwallow extends Bird {
  plumage() { return 'average'; }
}

class AfricanSwallow extends Bird {
  plumage() {
    return this.numberOfCoconuts > 2 ? 'tired' : 'average';
  }
}

class NorwegianBlueParrot extends Bird {
  plumage() {
    return this.voltage > 100 ? 'scorched' : 'beautiful';
  }
}
```

## Split Loop

**When:** Loop does multiple things

**Before:**
```javascript
function processReport(people) {
  let youngest = people[0] ? people[0].age : Infinity;
  let totalSalary = 0;

  for (const person of people) {
    if (person.age < youngest) youngest = person.age;
    totalSalary += person.salary;
  }

  return { youngest, averageSalary: totalSalary / people.length };
}
```

**After:**
```javascript
function processReport(people) {
  return {
    youngest: youngestAge(people),
    averageSalary: averageSalary(people)
  };
}

function youngestAge(people) {
  return Math.min(...people.map(p => p.age));
}

function averageSalary(people) {
  const total = people.reduce((sum, p) => sum + p.salary, 0);
  return total / people.length;
}
```

## Encapsulate Collection

**When:** Direct access to collection allows uncontrolled modification

**Before:**
```javascript
class Person {
  constructor() {
    this.courses = [];
  }

  getCourses() {
    return this.courses;
  }
}

// Client code can modify directly
const person = new Person();
person.getCourses().push(newCourse); // Bypasses encapsulation
```

**After:**
```javascript
class Person {
  constructor() {
    this._courses = [];
  }

  getCourses() {
    return [...this._courses]; // Return copy
  }

  addCourse(course) {
    this._courses.push(course);
  }

  removeCourse(course) {
    const index = this._courses.indexOf(course);
    if (index !== -1) this._courses.splice(index, 1);
  }
}
```

## Replace Constructor with Factory Function

**When:** Constructor has limitations (can't return different types, name must match class)

**Before:**
```javascript
class Employee {
  constructor(name, typeCode) {
    this.name = name;
    this.typeCode = typeCode;
  }
}

const engineer = new Employee('Alice', 'E');
const manager = new Employee('Bob', 'M');
```

**After:**
```javascript
function createEmployee(name, typeCode) {
  switch (typeCode) {
    case 'E': return new Engineer(name);
    case 'M': return new Manager(name);
    default: throw new Error(`Unknown type: ${typeCode}`);
  }
}

const engineer = createEmployee('Alice', 'E');
const manager = createEmployee('Bob', 'M');
```

## Refactoring Workflow

For any refactoring:

1. **Ensure tests are green** - All tests passing before starting
2. **Make one refactoring change** - Single, focused transformation
3. **Run tests** - Verify behavior preserved
4. **Commit if green, revert if red** - Never continue with failing tests
5. **Repeat** - Next refactoring only after tests pass

## When to Refactor

**During TDD Green phase:**
- After making tests pass
- Before writing next test
- When code duplication appears

**When code smells appear:**
- Long methods (>20 lines)
- Large classes (>300 lines)
- Long parameter lists (>3 parameters)
- Duplicated code
- Complex conditionals
- Magic numbers
- Unclear names

**Before adding features:**
- Make code easy to change first
- Then add the feature
- Commit refactoring separately

## When NOT to Refactor

**During Red or failing tests:**
- Fix tests first
- Then refactor

**When refactoring doesn't add value:**
- Code works and won't change
- Cost exceeds benefit
- Rewrite would be simpler

**When deadline is critical:**
- Refactor after delivery
- Or refactor only what's needed for current feature

## Quick Refactoring Checklist

Before refactoring:
- [ ] All tests passing
- [ ] Identify specific smell or improvement
- [ ] Know which refactoring pattern to apply

During refactoring:
- [ ] Make small, incremental changes
- [ ] Run tests after each change
- [ ] Keep tests green

After refactoring:
- [ ] All tests still passing
- [ ] Code is clearer than before
- [ ] Commit with descriptive message
