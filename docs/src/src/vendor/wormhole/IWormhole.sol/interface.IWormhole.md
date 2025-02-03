# IWormhole
[Git Source](https://github.com/smitrajput/superform-core/blob/2b1abb2f4e63862837f97d3914b36257db87d926/src/vendor/wormhole/IWormhole.sol)


## Functions
### publishMessage


```solidity
function publishMessage(
    uint32 nonce,
    bytes memory payload,
    uint8 consistencyLevel
)
    external
    payable
    returns (uint64 sequence);
```

### initialize


```solidity
function initialize() external;
```

### parseAndVerifyVM


```solidity
function parseAndVerifyVM(bytes calldata encodedVM)
    external
    view
    returns (VM memory vm, bool valid, string memory reason);
```

### verifyVM


```solidity
function verifyVM(VM memory vm) external view returns (bool valid, string memory reason);
```

### verifySignatures


```solidity
function verifySignatures(
    bytes32 hash,
    Signature[] memory signatures,
    GuardianSet memory guardianSet
)
    external
    pure
    returns (bool valid, string memory reason);
```

### parseVM


```solidity
function parseVM(bytes memory encodedVM) external pure returns (VM memory vm);
```

### quorum


```solidity
function quorum(uint256 numGuardians) external pure returns (uint256 numSignaturesRequiredForQuorum);
```

### getGuardianSet


```solidity
function getGuardianSet(uint32 index) external view returns (GuardianSet memory);
```

### getCurrentGuardianSetIndex


```solidity
function getCurrentGuardianSetIndex() external view returns (uint32);
```

### getGuardianSetExpiry


```solidity
function getGuardianSetExpiry() external view returns (uint32);
```

### governanceActionIsConsumed


```solidity
function governanceActionIsConsumed(bytes32 hash) external view returns (bool);
```

### isInitialized


```solidity
function isInitialized(address impl) external view returns (bool);
```

### chainId


```solidity
function chainId() external view returns (uint16);
```

### isFork


```solidity
function isFork() external view returns (bool);
```

### governanceChainId


```solidity
function governanceChainId() external view returns (uint16);
```

### governanceContract


```solidity
function governanceContract() external view returns (bytes32);
```

### messageFee


```solidity
function messageFee() external view returns (uint256);
```

### evmChainId


```solidity
function evmChainId() external view returns (uint256);
```

### nextSequence


```solidity
function nextSequence(address emitter) external view returns (uint64);
```

### parseContractUpgrade


```solidity
function parseContractUpgrade(bytes memory encodedUpgrade) external pure returns (ContractUpgrade memory cu);
```

### parseGuardianSetUpgrade


```solidity
function parseGuardianSetUpgrade(bytes memory encodedUpgrade) external pure returns (GuardianSetUpgrade memory gsu);
```

### parseSetMessageFee


```solidity
function parseSetMessageFee(bytes memory encodedSetMessageFee) external pure returns (SetMessageFee memory smf);
```

### parseTransferFees


```solidity
function parseTransferFees(bytes memory encodedTransferFees) external pure returns (TransferFees memory tf);
```

### parseRecoverChainId


```solidity
function parseRecoverChainId(bytes memory encodedRecoverChainId) external pure returns (RecoverChainId memory rci);
```

### submitContractUpgrade


```solidity
function submitContractUpgrade(bytes memory _vm) external;
```

### submitSetMessageFee


```solidity
function submitSetMessageFee(bytes memory _vm) external;
```

### submitNewGuardianSet


```solidity
function submitNewGuardianSet(bytes memory _vm) external;
```

### submitTransferFees


```solidity
function submitTransferFees(bytes memory _vm) external;
```

### submitRecoverChainId


```solidity
function submitRecoverChainId(bytes memory _vm) external;
```

## Events
### LogMessagePublished

```solidity
event LogMessagePublished(address indexed sender, uint64 sequence, uint32 nonce, bytes payload, uint8 consistencyLevel);
```

### ContractUpgraded

```solidity
event ContractUpgraded(address indexed oldContract, address indexed newContract);
```

### GuardianSetAdded

```solidity
event GuardianSetAdded(uint32 indexed index);
```

## Structs
### GuardianSet

```solidity
struct GuardianSet {
    address[] keys;
    uint32 expirationTime;
}
```

### Signature

```solidity
struct Signature {
    bytes32 r;
    bytes32 s;
    uint8 v;
    uint8 guardianIndex;
}
```

### VM

```solidity
struct VM {
    uint8 version;
    uint32 timestamp;
    uint32 nonce;
    uint16 emitterChainId;
    bytes32 emitterAddress;
    uint64 sequence;
    uint8 consistencyLevel;
    bytes payload;
    uint32 guardianSetIndex;
    Signature[] signatures;
    bytes32 hash;
}
```

### ContractUpgrade

```solidity
struct ContractUpgrade {
    bytes32 module;
    uint8 action;
    uint16 chain;
    address newContract;
}
```

### GuardianSetUpgrade

```solidity
struct GuardianSetUpgrade {
    bytes32 module;
    uint8 action;
    uint16 chain;
    GuardianSet newGuardianSet;
    uint32 newGuardianSetIndex;
}
```

### SetMessageFee

```solidity
struct SetMessageFee {
    bytes32 module;
    uint8 action;
    uint16 chain;
    uint256 messageFee;
}
```

### TransferFees

```solidity
struct TransferFees {
    bytes32 module;
    uint8 action;
    uint16 chain;
    uint256 amount;
    bytes32 recipient;
}
```

### RecoverChainId

```solidity
struct RecoverChainId {
    bytes32 module;
    uint8 action;
    uint256 evmChainId;
    uint16 newChainId;
}
```

