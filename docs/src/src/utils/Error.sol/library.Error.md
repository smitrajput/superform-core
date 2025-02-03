# Error
[Git Source](https://github.com/smitrajput/superform-core/blob/2b1abb2f4e63862837f97d3914b36257db87d926/src/utils/Error.sol)


## Errors
### INVALID_INPUT_CHAIN_ID
*is emitted when the chain id input is invalid.*


```solidity
error INVALID_INPUT_CHAIN_ID();
```

### ZERO_ADDRESS
*error thrown when address input is address 0*


```solidity
error ZERO_ADDRESS();
```

### ZERO_AMOUNT
*error thrown when address input is address 0*


```solidity
error ZERO_AMOUNT();
```

### FORM_IMPLEMENTATION_ID_ALREADY_EXISTS
*error thrown when beacon id already exists*


```solidity
error FORM_IMPLEMENTATION_ID_ALREADY_EXISTS();
```

### NOT_CORE_STATE_REGISTRY
*thrown when msg.sender is not core state registry*


```solidity
error NOT_CORE_STATE_REGISTRY();
```

### NOT_EMERGENCY_QUEUE
*thrown when msg.sender is not emergency queue*


```solidity
error NOT_EMERGENCY_QUEUE();
```

### NOT_SUPERFORM
*thrown when msg.sender is not form*


```solidity
error NOT_SUPERFORM();
```

### NOT_TWO_STEP_SUPERFORM
*thrown when msg.sender is not two step form*


```solidity
error NOT_TWO_STEP_SUPERFORM();
```

### NOT_AMB_IMPLEMENTATION
*thrown when msg.sender is not a valid amb implementation*


```solidity
error NOT_AMB_IMPLEMENTATION();
```

### NOT_STATE_REGISTRY
*thrown when msg.sender is not state registry*


```solidity
error NOT_STATE_REGISTRY();
```

### NOT_ALLOWED_BROADCASTER
*thrown when msg.sender is not an allowed broadcaster*


```solidity
error NOT_ALLOWED_BROADCASTER();
```

### NOT_BROADCAST_REGISTRY
*thrown when msg.sender is not broadcast state registry*


```solidity
error NOT_BROADCAST_REGISTRY();
```

### NOT_BROADCAST_AMB_IMPLEMENTATION
*thrown when msg.sender is not broadcast amb implementation*


```solidity
error NOT_BROADCAST_AMB_IMPLEMENTATION();
```

### INVALID_BROADCAST_PAYLOAD
*thrown if the broadcast payload is invalid*


```solidity
error INVALID_BROADCAST_PAYLOAD();
```

### INVALID_DEPOSIT_TOKEN
*thrown if the underlying collateral mismatches*


```solidity
error INVALID_DEPOSIT_TOKEN();
```

### NOT_TWO_STEP_STATE_REGISTRY
*thrown when msg.sender is not two step state registry*


```solidity
error NOT_TWO_STEP_STATE_REGISTRY();
```

### NOT_PROTOCOL_ADMIN
*thrown when msg.sender is not protocol admin*


```solidity
error NOT_PROTOCOL_ADMIN();
```

### NOT_EMERGENCY_ADMIN
*thrown when msg.sender is not emergency admin*


```solidity
error NOT_EMERGENCY_ADMIN();
```

### NOT_SUPER_ROUTER
*thrown when msg.sender is not super router*


```solidity
error NOT_SUPER_ROUTER();
```

### NOT_MINTER
*thrown when msg.sender is not minter*


```solidity
error NOT_MINTER();
```

### NOT_BURNER
*thrown when msg.sender is not burner*


```solidity
error NOT_BURNER();
```

### NOT_MINTER_STATE_REGISTRY_ROLE
*thrown when msg.sender is not minter state registry*


```solidity
error NOT_MINTER_STATE_REGISTRY_ROLE();
```

### NOT_SUPERFORM_FACTORY
*if the msg-sender is not super form factory*


```solidity
error NOT_SUPERFORM_FACTORY();
```

### NOT_SUPER_REGISTRY
*thrown if the msg-sender is not super registry*


```solidity
error NOT_SUPER_REGISTRY();
```

### NOT_SWAPPER
*thrown if the msg-sender does not have SWAPPER role*


```solidity
error NOT_SWAPPER();
```

### NOT_PROCESSOR
*thrown if the msg-sender does not have PROCESSOR role*


```solidity
error NOT_PROCESSOR();
```

### NOT_UPDATER
*thrown if the msg-sender does not have UPDATER role*


```solidity
error NOT_UPDATER();
```

### NOT_RESCUER
*thrown if the msg-sender does not have RESCUER role*


```solidity
error NOT_RESCUER();
```

### BRIDGE_TOKENS_PENDING
*thrown when the bridge tokens haven't arrived to destination*


```solidity
error BRIDGE_TOKENS_PENDING();
```

### DISABLED
*thrown when trying to set again pseudo immutables in SuperRegistry*


```solidity
error DISABLED();
```

### NATIVE_TOKEN_TRANSFER_FAILURE
*thrown when the native tokens transfer has failed*


```solidity
error NATIVE_TOKEN_TRANSFER_FAILURE();
```

### CANNOT_REVOKE_LAST_ADMIN
*thrown when not possible to revoke last admin*


```solidity
error CANNOT_REVOKE_LAST_ADMIN();
```

### CANNOT_REVOKE_BROADCAST
*thrown when not possible to revoke last admin*


```solidity
error CANNOT_REVOKE_BROADCAST();
```

### INVALID_TIMELOCK_DELAY
*thrown if the delay is invalid*


```solidity
error INVALID_TIMELOCK_DELAY();
```

### RESCUE_ALREADY_PROPOSED
*thrown if rescue is already proposed*


```solidity
error RESCUE_ALREADY_PROPOSED();
```

### INVALID_TXDATA_CHAIN_ID
*is emitted when the chain id in the txdata is invalid*


```solidity
error INVALID_TXDATA_CHAIN_ID();
```

### INVALID_TXDATA_RECEIVER
*thrown the when validation of bridge txData fails due to wrong receiver*


```solidity
error INVALID_TXDATA_RECEIVER();
```

### INVALID_TXDATA_TOKEN
*thrown when the validation of bridge txData fails due to wrong token*


```solidity
error INVALID_TXDATA_TOKEN();
```

### INVALID_DEPOSIT_LIQ_DST_CHAIN_ID
*thrown when in deposits, the liqDstChainId doesn't match the stateReq dstChainId*


```solidity
error INVALID_DEPOSIT_LIQ_DST_CHAIN_ID();
```

### INVALID_ACTION
*when a certain action of the user is not allowed given the txData provided*


```solidity
error INVALID_ACTION();
```

### INVALID_TXDATA_NO_DESTINATIONCALL_ALLOWED
*thrown when the validation of bridge txData fails due to a destination call present*


```solidity
error INVALID_TXDATA_NO_DESTINATIONCALL_ALLOWED();
```

### INVALID_SWAP_OUTPUT
*thrown when dst swap output is less than minimum expected*


```solidity
error INVALID_SWAP_OUTPUT();
```

### DST_SWAP_ALREADY_PROCESSED
*thrown when try to process dst swap for same payload id*


```solidity
error DST_SWAP_ALREADY_PROCESSED();
```

### INVALID_INDEX
*thrown if index is invalid*


```solidity
error INVALID_INDEX();
```

### INVALID_DISUPTER
*thrown if msg.sender is not the refund address to dispute*


```solidity
error INVALID_DISUPTER();
```

### DISPUTE_TIME_ELAPSED
*thrown if the rescue passed dispute deadline*


```solidity
error DISPUTE_TIME_ELAPSED();
```

### RESCUE_LOCKED
*thrown if the rescue is still in timelocked state*


```solidity
error RESCUE_LOCKED();
```

### NO_TXDATA_PRESENT
*error thrown when txData must be present (in case of xChain acitons)*


```solidity
error NO_TXDATA_PRESENT();
```

### CALLER_NOT_MAILBOX
*hyperlane adapter specific error, when caller not hyperlane mailbox*


```solidity
error CALLER_NOT_MAILBOX();
```

### CALLER_NOT_RELAYER
*wormhole relayer specific error, when caller not wormhole relayer*


```solidity
error CALLER_NOT_RELAYER();
```

### CALLER_NOT_ENDPOINT
*layerzero adapter specific error, when caller not layerzero endpoint*


```solidity
error CALLER_NOT_ENDPOINT();
```

### INVALID_SRC_SENDER
*thrown when src chain sender is not valid*


```solidity
error INVALID_SRC_SENDER();
```

### INVALID_BROADCAST_FINALITY
*thrown when broadcast finality for wormhole is invalid*


```solidity
error INVALID_BROADCAST_FINALITY();
```

### INVALID_SRC_CHAIN_ID
*thrown when src chain is blocked from messaging*


```solidity
error INVALID_SRC_CHAIN_ID();
```

### DUPLICATE_PAYLOAD
*thrown when payload is not unique*


```solidity
error DUPLICATE_PAYLOAD();
```

### INVALID_CHAIN_ID
*is emitted when the chain id brought in the cross chain message is invalid*


```solidity
error INVALID_CHAIN_ID();
```

### INVALID_BRIDGE_ID
*thrown if ambId is not valid leading to an address 0 of the implementation*


```solidity
error INVALID_BRIDGE_ID();
```

### INVALID_PAYLOAD_ID
*thrown if payload id does not exist*


```solidity
error INVALID_PAYLOAD_ID();
```

### PAYLOAD_ALREADY_UPDATED
*is thrown is payload is already updated (during xChain deposits)*


```solidity
error PAYLOAD_ALREADY_UPDATED();
```

### PAYLOAD_ALREADY_PROCESSED
*is thrown is payload is already processed*


```solidity
error PAYLOAD_ALREADY_PROCESSED();
```

### ZERO_PAYLOAD_HASH
*is thrown if the payload hash is zero during `retryMessage` on Layezero implementation*


```solidity
error ZERO_PAYLOAD_HASH();
```

### INVALID_PAYLOAD_HASH
*is thrown if the payload hash is invalid during `retryMessage` on Layezero implementation*


```solidity
error INVALID_PAYLOAD_HASH();
```

### INVALID_PAYLOAD_UPDATE_REQUEST
*thrown if update payload function was called on a wrong payload*


```solidity
error INVALID_PAYLOAD_UPDATE_REQUEST();
```

### INVALID_DST_SWAP_AMOUNT
*thrown if payload update amount mismatch with dst swapper amount*


```solidity
error INVALID_DST_SWAP_AMOUNT();
```

### DIFFERENT_PAYLOAD_UPDATE_AMOUNTS_LENGTH
*thrown if payload is being updated with final amounts length different than amounts length*


```solidity
error DIFFERENT_PAYLOAD_UPDATE_AMOUNTS_LENGTH();
```

### DIFFERENT_PAYLOAD_UPDATE_TX_DATA_LENGTH
*thrown if payload is being updated with tx data length different than liq data length*


```solidity
error DIFFERENT_PAYLOAD_UPDATE_TX_DATA_LENGTH();
```

### NEGATIVE_SLIPPAGE
*thrown if the amounts being sent in update payload mean a negative slippage*


```solidity
error NEGATIVE_SLIPPAGE();
```

### PAYLOAD_NOT_UPDATED
*thrown if payload is not in UPDATED state*


```solidity
error PAYLOAD_NOT_UPDATED();
```

### CANNOT_UPDATE_WITHDRAW_TX_DATA
*thrown if withdrawal TX_DATA cannot be updated*


```solidity
error CANNOT_UPDATE_WITHDRAW_TX_DATA();
```

### WITHDRAW_TX_DATA_NOT_UPDATED
*thrown if withdrawal TX_DATA is not updated*


```solidity
error WITHDRAW_TX_DATA_NOT_UPDATED();
```

### QUORUM_NOT_REACHED
*thrown if message hasn't reached the specified level of quorum needed*


```solidity
error QUORUM_NOT_REACHED();
```

### INVALID_PROOF_BRIDGE_ID
*thrown if message amb and proof amb are the same*


```solidity
error INVALID_PROOF_BRIDGE_ID();
```

### DUPLICATE_PROOF_BRIDGE_ID
*thrown if a duplicate proof amb is found*


```solidity
error DUPLICATE_PROOF_BRIDGE_ID();
```

### INVALID_RESCUE_DATA
*thrown if the rescue data lengths are invalid*


```solidity
error INVALID_RESCUE_DATA();
```

### CROSS_CHAIN_TX_UNDERPAID
*thrown if not enough native fees is paid for amb to send the message*


```solidity
error CROSS_CHAIN_TX_UNDERPAID();
```

### ERC165_UNSUPPORTED
*thrown when a form is not ERC165 compatible*


```solidity
error ERC165_UNSUPPORTED();
```

### FORM_INTERFACE_UNSUPPORTED
*thrown when a form is not FORM interface compatible*


```solidity
error FORM_INTERFACE_UNSUPPORTED();
```

### FORM_DOES_NOT_EXIST
*thrown when a form does not exist*


```solidity
error FORM_DOES_NOT_EXIST();
```

### VAULT_FORM_IMPLEMENTATION_COMBINATION_EXISTS
*thrown when same vault and beacon is used to create new superform*


```solidity
error VAULT_FORM_IMPLEMENTATION_COMBINATION_EXISTS();
```

### ARRAY_LENGTH_MISMATCH
*thrown when there is an array length mismatch*


```solidity
error ARRAY_LENGTH_MISMATCH();
```

### SLIPPAGE_OUT_OF_BOUNDS
*thrown slippage is outside of bounds*


```solidity
error SLIPPAGE_OUT_OF_BOUNDS();
```

### INVALID_FORM_ID
*thrown when form id is larger than max uint16*


```solidity
error INVALID_FORM_ID();
```

### INVALID_SUPERFORMS_DATA
*thrown when the vaults data is invalid*


```solidity
error INVALID_SUPERFORMS_DATA();
```

### INVALID_CHAIN_IDS
*thrown when the chain ids data is invalid*


```solidity
error INVALID_CHAIN_IDS();
```

### INVALID_PAYLOAD
*thrown when the payload is invalid*


```solidity
error INVALID_PAYLOAD();
```

### SRC_SENDER_MISMATCH
*thrown if src senders mismatch in state sync*


```solidity
error SRC_SENDER_MISMATCH();
```

### SRC_TX_TYPE_MISMATCH
*thrown if src tx types mismatch in state sync*


```solidity
error SRC_TX_TYPE_MISMATCH();
```

### INVALID_PAYLOAD_STATUS
*thrown if the payload status is invalid*


```solidity
error INVALID_PAYLOAD_STATUS();
```

### FAILED_TO_EXECUTE_TXDATA
*thrown if liquidity bridge fails for erc20 tokens*


```solidity
error FAILED_TO_EXECUTE_TXDATA();
```

### FAILED_TO_EXECUTE_TXDATA_NATIVE
*thrown if liquidity bridge fails for native tokens*


```solidity
error FAILED_TO_EXECUTE_TXDATA_NATIVE();
```

### INSUFFICIENT_NATIVE_AMOUNT
*thrown if native amount is not at least equal to the amount in the request*


```solidity
error INSUFFICIENT_NATIVE_AMOUNT();
```

### EMERGENCY_WITHDRAW_INSUFFICIENT_BALANCE
*thrown when the form has insufficient balance for emergency withdraw*


```solidity
error EMERGENCY_WITHDRAW_INSUFFICIENT_BALANCE();
```

### EMERGENCY_WITHDRAW_PROCESSED_ALREADY
*thrown when emergency withdraw is already processed*


```solidity
error EMERGENCY_WITHDRAW_PROCESSED_ALREADY();
```

### DIRECT_DEPOSIT_INSUFFICIENT_ALLOWANCE
*thrown when the allowance in direct deposit is not correct*


```solidity
error DIRECT_DEPOSIT_INSUFFICIENT_ALLOWANCE();
```

### DIRECT_DEPOSIT_INVALID_DATA
*thrown when the amount in direct deposit is not correct*


```solidity
error DIRECT_DEPOSIT_INVALID_DATA();
```

### DIRECT_WITHDRAW_INVALID_COLLATERAL
*thrown when the collateral in direct withdraw is not correct*


```solidity
error DIRECT_WITHDRAW_INVALID_COLLATERAL();
```

### DIRECT_WITHDRAW_INVALID_LIQ_REQUEST
*thrown when the amount in direct withdraw is not correct*


```solidity
error DIRECT_WITHDRAW_INVALID_LIQ_REQUEST();
```

### XCHAIN_WITHDRAW_INVALID_LIQ_REQUEST
*thrown when the amount in xchain withdraw is not correct*


```solidity
error XCHAIN_WITHDRAW_INVALID_LIQ_REQUEST();
```

### WITHDRAW_COOLDOWN_PERIOD
*thrown when unlock has already been requested - cooldown period didn't pass yet*


```solidity
error WITHDRAW_COOLDOWN_PERIOD();
```

### LOCKED
*thrown when trying to finalize the payload but the withdraw is still locked*


```solidity
error LOCKED();
```

### EMPTY_TOKEN_NON_EMPTY_TXDATA
*thrown when liqData token is empty but txData is not*


```solidity
error EMPTY_TOKEN_NON_EMPTY_TXDATA();
```

### PAUSED
*if implementation formBeacon is PAUSED then users cannot perform any action*


```solidity
error PAUSED();
```

### NOT_PAYMENT_ADMIN
*- when msg.sender is not payment admin*


```solidity
error NOT_PAYMENT_ADMIN();
```

### ZERO_MSG_VALUE
*thrown when user pays zero*


```solidity
error ZERO_MSG_VALUE();
```

### FAILED_WITHDRAW
*thrown when payment withdrawal fails*


```solidity
error FAILED_WITHDRAW();
```

### DYNAMIC_URI_FROZEN
*thrown when the uri cannot be updated*


```solidity
error DYNAMIC_URI_FROZEN();
```

### CHAINLINK_MALFUNCTION
*thrown when chainlink is reporting an improper price*


```solidity
error CHAINLINK_MALFUNCTION();
```

### CHAINLINK_INCOMPLETE_ROUND
*thrown when chainlink is reporting an incomplete round*


```solidity
error CHAINLINK_INCOMPLETE_ROUND();
```

