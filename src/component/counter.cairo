#[starknet::component]
pub mod counter_component {

    #[storage]
    struct Storage {
        value: u8,
    }

    #[derive(Drop, starknet::Event, Debug, PartialEq)]
    pub struct Increment{
        pub new_value: u8
    }

    #[derive(Drop, starknet::Event, Debug, PartialEq)]
    pub struct Decrement{
        pub new_value: u8
    }

    #[event]
    #[derive(Drop, starknet::Event, Debug, PartialEq)]
    pub enum Event {
        Increment: Increment,
        Decrement: Decrement,
    }

    #[embeddable_as(Counter)]
    impl CounterImpl<
        TContractState, +HasComponent<TContractState>,
    > of counter::interfaces::counter::ICounter<ComponentState<TContractState>> {
        fn increment(ref self: ComponentState<TContractState>, value: u8){
            let current_value = self.value.read();
            self.value.write(current_value + value);
            self.emit(Increment{new_value: current_value + value});
        }
        fn decrement(ref self: ComponentState<TContractState>, value: u8){
            let current_value = self.value.read();
            assert(current_value >= value, 'Counter not high enough');
            self.value.write(current_value - value);
            self.emit(Decrement{new_value: current_value - value});
        }
        fn get_value(self: @ComponentState<TContractState>) -> u8{
            self.value.read()
        }
    }

    #[generate_trait]
    pub impl CounterPrivate<
        TContractState, +HasComponent<TContractState>,
    > of PrivateTrait<TContractState> {
        fn _init(ref self: ComponentState<TContractState>){
            self.value.write(0);
        }
    }
}