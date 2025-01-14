use counter::core::counter::CounterContract;
use counter::component::counter::counter_component::{Increment};
use counter::interfaces::counter::{ICounterDispatcher, ICounterDispatcherTrait};
use starknet::{syscalls::deploy_syscall, ContractAddress};

fn deploy() -> (ICounterDispatcher, ContractAddress) {
    let (address, _) = deploy_syscall(
        CounterContract::TEST_CLASS_HASH.try_into().unwrap(), 0, array![].span(), false,
    )
        .unwrap();
    (ICounterDispatcher { contract_address: address }, address)
}

#[test]
fn test_initial_value() {
    let (counter, _) = deploy();
    assert_eq!(counter.get_value(), 0);
}

#[test]
fn test_increment() {    
    let (counter, _) = deploy();
    counter.increment(5);
    assert_eq!(counter.get_value(), 5);
}

#[test]
fn test_increment_event() {
    let (counter, contract_address) = deploy();

    counter.increment(5);

    assert_eq!(
        starknet::testing::pop_log(contract_address),
        Option::Some(CounterContract::Event::CounterEvent(Increment {new_value: 5}.into())),
    );
}
