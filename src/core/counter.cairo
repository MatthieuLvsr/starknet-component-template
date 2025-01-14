#[starknet::contract]
pub mod CounterContract {
    use counter::component::counter::counter_component;

    component!(path: counter_component, storage: counter, event: CounterEvent);

    #[abi(embed_v0)]
    impl CounterImpl = counter_component::Counter<ContractState>;

    #[storage]
    struct Storage {
        #[substorage(v0)]
        counter: counter_component::Storage,
    }

    #[event]
    #[derive(Drop, starknet::Event, Debug, PartialEq)]
    pub enum Event {
        CounterEvent: counter_component::Event,
    }

    impl CounterPrivate = counter_component::CounterPrivate<ContractState>;

    #[constructor]
    fn constructor(ref self: ContractState) {
        self.counter._init();
    }
}
