module display_nft::rabbit_nft {
    use std::string::{String};
    use sui::package;
    use sui::display;
    use rabbit::display as rabbit_display;

    public struct RABBIT_NFT has drop {}

    public struct RabbitNFT has key, store {
        id: UID,
        name: String,
        image_url: String,
        description: String,
    }

    fun init(otw: RABBIT_NFT, ctx: &mut TxContext) {
        let keys = vector[
            b"name".to_string(),
            b"image_url".to_string(),
            b"description".to_string(),
            b"project_url".to_string(),
            b"creator".to_string(),
        ];

        let values = vector[
            b"Clove_NFT".to_string(),
            b"https://github.com/jakubGodula/NFT-challange/blob/main/imgs/clove.png?raw=true".to_string(),
            b"Magick Clove".to_string(),
            b"https://github.com/jakubGodula/NFT-challenge".to_string(),
            b"Jakub Godula".to_string(), ];

        let publisher = package::claim(otw, ctx);

        let mut display = display::new_with_fields<RabbitNFT>(
            &publisher, keys, values, ctx
        );

        display.update_version();

        transfer::public_transfer(publisher, ctx.sender());
        transfer::public_transfer(display, ctx.sender());
    }

    public fun mint(
        name: String,
        image_url: String,
        description: String,
        ctx: &mut TxContext
    ) {
        let nft = RabbitNFT {
            id: object::new(ctx),
            name,
            image_url,
            description,
        };

        transfer::public_transfer(nft, ctx.sender());
    }

    public fun feed_my_rabbit(display: &mut display::Display<RabbitNFT>) {
        rabbit_display::feed_rabbit(display);
    }
}
