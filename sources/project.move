module YieldFarming::Aggregator {

    use aptos_framework::signer;

    struct Farm has store, key {
        owner: address,
        apy: u64, // Annual Percentage Yield
    }

    /// Registers a new yield farm with an initial APY.
    public fun register_farm(farmer: &signer, initial_apy: u64) {
        let farm = Farm {
            owner: signer::address_of(farmer),
            apy: initial_apy,
        };
        move_to(farmer, farm);
    }

    /// Updates the APY for a registered farm.
    public fun update_apy(farmer: &signer, new_apy: u64) acquires Farm {
        let farm = borrow_global_mut<Farm>(signer::address_of(farmer));
        farm.apy = new_apy;
    }
}
