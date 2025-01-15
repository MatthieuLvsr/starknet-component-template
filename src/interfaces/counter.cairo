#[starknet::interface]
pub trait ICounter<TContractState> {
    fn increment(ref self: TContractState, value: u8);
    fn decrement(ref self: TContractState, value: u8);
    fn get_value(self: @TContractState) -> u8;
}