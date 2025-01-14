
# StarkNet Smart Contract Project with Components

## Project Overview

This project demonstrates a clean and modular implementation of a StarkNet smart contract using components. The primary objective is to provide a well-structured example of a counter contract with a component-based architecture. The project is designed to be easily extensible and follow best practices in StarkNet contract development.

---

## Architecture

The project is organized into the following structure:

```
.
├── LICENSE
├── README.md
├── Scarb.lock
├── Scarb.toml
├── src
│   ├── component
│   │   └── counter.cairo
│   ├── core
│   │   └── counter.cairo
│   ├── interfaces
│   │   └── counter.cairo
│   └── lib.cairo
└── tests
    └── integration_tests.cairo
```

### Key Components

#### 1. **Component Layer**
The `component` folder contains modular implementations, such as `counter_component`, which defines the logic for managing a counter's state and emitting events.

#### 2. **Core Layer**
The `core` folder defines the main `CounterContract`, which integrates the components and exposes a constructor and public methods.

#### 3. **Interfaces Layer**
The `interfaces` folder defines traits (like `ICounter`) that specify the contract's public API.

#### 4. **Tests**
The `tests` folder contains integration tests to validate the functionality of the contract, including initialization, incrementing the counter, and event emission.

---

## Installation

To get started with this project, you need to have the following tools installed:

- [StarkNet CLI](https://github.com/starkware-libs/cairo-lang)
- [Scarb](https://docs.swmansion.com/scarb/)

### Steps

1. Clone the repository:
   ```bash
   git clone https://github.com/MatthieuLvsr/starknet-component-template
   cd starknet-component-template
   ```

2. Install dependencies and build project:
   ```bash
   scarb build
   ```

3. Run tests:
   ```bash
   scarb test
   ```

---

## Smart Contract Implementation

### Counter Component (`src/component/counter.cairo`)

This file defines the core logic for the counter, including the `increment` function and state management. It also emits an `Increment` event.

### Counter Contract (`src/core/counter.cairo`)

The main contract integrates the counter component and defines the contract's storage and event structure.

### Interface (`src/interfaces/counter.cairo`)

Defines the `ICounter` trait, which specifies the public API for the contract.

---

## Tests

The `tests/integration_tests.cairo` file contains integration tests for the following scenarios:

1. **Initialization**
   - Verifies that the counter starts at `0`.

2. **Increment**
   - Ensures that calling `increment` updates the counter's value.

3. **Event Emission**
   - Validates that an `Increment` event is emitted with the correct value.

### Example Test Case
```rust
#[test]
fn test_increment_event() {
    let (counter, contract_address) = deploy();

    counter.increment(5);

    assert_eq!(
        starknet::testing::pop_log(contract_address),
        Option::Some(CounterContract::Event::CounterEvent(Increment {new_value: 5}.into())),
    );
}
```

---

## Extensibility

This project is designed to be modular and extensible. To add new functionality:

1. Create a new component in the `component` folder.
2. Update the core contract to integrate the component.
3. Define a new interface if necessary.
4. Update the `lib.cairo` file to manage the structure of your package

---

## License

This project is licensed under the Apache-2.0 License. See the `LICENSE` file for details.

---

## Acknowledgments

- [StarkNet By Example](https://starknet-by-example.voyager.online/)
- [Cairo Documentation](https://book.cairo-lang.org/)
