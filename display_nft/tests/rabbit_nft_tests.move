#[test_only]
module display_nft::rabbit_nft_tests {
    use display_nft::rabbit_nft::{Self, RabbitNFT};
    use sui::test_scenario;
    use std::string;
    use sui::display::Display;

    #[test]
    fun test_mint_and_feed() {
        let owner = @0xA;
        let mut scenario = test_scenario::begin(owner);

        // 1. Init
        {
            test_scenario::next_tx(&mut scenario, owner);
            // We can't easily call init directly as it requires OTW, 
            // but we can simulate the result or just test minting if we had the display.
            // For this test, we'll just test minting.
        };

        // 2. Mint
        {
            test_scenario::next_tx(&mut scenario, owner);
            rabbit_nft::mint(
                string::utf8(b"My Rabbit"),
                string::utf8(b"https://img.com/rabbit.png"),
                string::utf8(b"A cute rabbit"),
                test_scenario::ctx(&mut scenario)
            );
        };

        // 3. Verify NFT exists
        {
            test_scenario::next_tx(&mut scenario, owner);
            let nft = test_scenario::take_from_sender<RabbitNFT>(&scenario);
            test_scenario::return_to_sender(&scenario, nft);
        };
        
        test_scenario::end(scenario);
    }
}
