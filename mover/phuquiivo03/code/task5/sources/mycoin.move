module task5::qcoin{
  use sui::coin::{Self, Coin, TreasuryCap};
  use sui::url::{Self};

  // == Define Struct ==
  public struct QCOIN has drop {}

  fun init(witness: QCOIN, ctx: &mut TxContext){
    let (treasury_cap, metadata) = coin::create_currency(
      witness,
      8,
      b"PHUQUIIVO03",
      b"Phuquiivo03 Coin",
      b"ayyo phuquivo03 toichoi!",
      option::some(url::new_unsafe_from_bytes(b"https://s3.ap-southeast-1.amazonaws.com/openedu.net-production/images/QiLByH1v1w7HLwO4_notionavt.png")),
      ctx
    );

    transfer::public_freeze_object(metadata);
    transfer::public_transfer(treasury_cap, tx_context::sender(ctx))
  }

  /// == Manager can mint Coin ==
  public entry fun mint(
        treasury: &mut TreasuryCap<QCOIN>,
        amount: u64,
        recipient: address,
        ctx: &mut TxContext
    ) {
        coin::mint_and_transfer(treasury, amount, recipient, ctx);
  }

  /// == Manager can burn Coin ==
  public fun burn(
        treasury: &mut TreasuryCap<QCOIN>,
        coin: Coin<QCOIN>,
    ) {
        coin::burn(treasury, coin);
  }

  /// == Test ==
  #[test_only]
  public fun test_init(ctx: &mut TxContext) {
    init(QCOIN {}, ctx)
  }
}