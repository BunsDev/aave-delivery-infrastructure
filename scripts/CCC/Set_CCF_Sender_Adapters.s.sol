// SPDX-License-Identifier: BUSL-1.1
pragma solidity ^0.8.0;

import {ICrossChainForwarder} from '../../src/contracts/interfaces/ICrossChainForwarder.sol';
import '../BaseScript.sol';

abstract contract BaseCCFSenderAdapters is BaseScript {
  function getBridgeAdaptersToEnable(
    DeployerHelpers.Addresses memory addresses
  ) public view virtual returns (ICrossChainForwarder.ForwarderBridgeAdapterConfigInput[] memory);

  function _execute(DeployerHelpers.Addresses memory addresses) internal override {
    ICrossChainForwarder(addresses.crossChainController).enableBridgeAdapters(
      getBridgeAdaptersToEnable(addresses)
    );
  }
}

contract Ethereum is BaseCCFSenderAdapters {
  function TRANSACTION_NETWORK() public pure override returns (uint256) {
    return ChainIds.ETHEREUM;
  }

  function getBridgeAdaptersToEnable(
    DeployerHelpers.Addresses memory addresses
  ) public view override returns (ICrossChainForwarder.ForwarderBridgeAdapterConfigInput[] memory) {
    ICrossChainForwarder.ForwarderBridgeAdapterConfigInput[]
      memory bridgeAdaptersToEnable = new ICrossChainForwarder.ForwarderBridgeAdapterConfigInput[](
        15
      );

    // polygon path
    DeployerHelpers.Addresses memory addressesPolygon = _getAddresses(ChainIds.POLYGON);
    bridgeAdaptersToEnable[14] = ICrossChainForwarder.ForwarderBridgeAdapterConfigInput({
      currentChainBridgeAdapter: addresses.polAdapter,
      destinationBridgeAdapter: addressesPolygon.polAdapter,
      destinationChainId: addressesPolygon.chainId
    });
    bridgeAdaptersToEnable[0] = ICrossChainForwarder.ForwarderBridgeAdapterConfigInput({
      currentChainBridgeAdapter: addresses.ccipAdapter,
      destinationBridgeAdapter: addressesPolygon.ccipAdapter,
      destinationChainId: addressesPolygon.chainId
    });
    bridgeAdaptersToEnable[1] = ICrossChainForwarder.ForwarderBridgeAdapterConfigInput({
      currentChainBridgeAdapter: addresses.lzAdapter,
      destinationBridgeAdapter: addressesPolygon.lzAdapter,
      destinationChainId: addressesPolygon.chainId
    });
    bridgeAdaptersToEnable[2] = ICrossChainForwarder.ForwarderBridgeAdapterConfigInput({
      currentChainBridgeAdapter: addresses.hlAdapter,
      destinationBridgeAdapter: addressesPolygon.hlAdapter,
      destinationChainId: addressesPolygon.chainId
    });

    // avalanche path
    DeployerHelpers.Addresses memory addressesAvax = _getAddresses(ChainIds.AVALANCHE);

    bridgeAdaptersToEnable[3] = ICrossChainForwarder.ForwarderBridgeAdapterConfigInput({
      currentChainBridgeAdapter: addresses.ccipAdapter,
      destinationBridgeAdapter: addressesAvax.ccipAdapter,
      destinationChainId: addressesAvax.chainId
    });
    bridgeAdaptersToEnable[4] = ICrossChainForwarder.ForwarderBridgeAdapterConfigInput({
      currentChainBridgeAdapter: addresses.lzAdapter,
      destinationBridgeAdapter: addressesAvax.lzAdapter,
      destinationChainId: addressesAvax.chainId
    });
    bridgeAdaptersToEnable[5] = ICrossChainForwarder.ForwarderBridgeAdapterConfigInput({
      currentChainBridgeAdapter: addresses.hlAdapter,
      destinationBridgeAdapter: addressesAvax.hlAdapter,
      destinationChainId: addressesAvax.chainId
    });

    // binance path
    DeployerHelpers.Addresses memory addressesBNB = _getAddresses(ChainIds.BNB);

    bridgeAdaptersToEnable[6] = ICrossChainForwarder.ForwarderBridgeAdapterConfigInput({
      currentChainBridgeAdapter: addresses.lzAdapter,
      destinationBridgeAdapter: addressesBNB.lzAdapter,
      destinationChainId: addressesBNB.chainId
    });
    bridgeAdaptersToEnable[7] = ICrossChainForwarder.ForwarderBridgeAdapterConfigInput({
      currentChainBridgeAdapter: addresses.hlAdapter,
      destinationBridgeAdapter: addressesBNB.hlAdapter,
      destinationChainId: addressesBNB.chainId
    });
    bridgeAdaptersToEnable[8] = ICrossChainForwarder.ForwarderBridgeAdapterConfigInput({
      currentChainBridgeAdapter: addresses.ccipAdapter,
      destinationBridgeAdapter: addressesBNB.ccipAdapter,
      destinationChainId: addressesBNB.chainId
    });

    // rollups
    DeployerHelpers.Addresses memory addressesOp = _getAddresses(ChainIds.OPTIMISM);
    bridgeAdaptersToEnable[9] = ICrossChainForwarder.ForwarderBridgeAdapterConfigInput({
      currentChainBridgeAdapter: addresses.opAdapter,
      destinationBridgeAdapter: addressesOp.opAdapter,
      destinationChainId: addressesOp.chainId
    });

    DeployerHelpers.Addresses memory addressesArb = _getAddresses(ChainIds.ARBITRUM);
    bridgeAdaptersToEnable[10] = ICrossChainForwarder.ForwarderBridgeAdapterConfigInput({
      currentChainBridgeAdapter: addresses.arbAdapter,
      destinationBridgeAdapter: addressesArb.arbAdapter,
      destinationChainId: addressesArb.chainId
    });

    DeployerHelpers.Addresses memory addressesMetis = _getAddresses(ChainIds.METIS);
    bridgeAdaptersToEnable[11] = ICrossChainForwarder.ForwarderBridgeAdapterConfigInput({
      currentChainBridgeAdapter: addresses.metisAdapter,
      destinationBridgeAdapter: addressesMetis.metisAdapter,
      destinationChainId: addressesMetis.chainId
    });
    DeployerHelpers.Addresses memory addressesBase = _getAddresses(ChainIds.BASE);
    bridgeAdaptersToEnable[12] = ICrossChainForwarder.ForwarderBridgeAdapterConfigInput({
      currentChainBridgeAdapter: addresses.baseAdapter,
      destinationBridgeAdapter: addressesBase.baseAdapter,
      destinationChainId: addressesBase.chainId
    });

    // same chain path
    bridgeAdaptersToEnable[13] = ICrossChainForwarder.ForwarderBridgeAdapterConfigInput({
      currentChainBridgeAdapter: addresses.sameChainAdapter,
      destinationBridgeAdapter: addresses.sameChainAdapter,
      destinationChainId: addresses.chainId
    });

    return bridgeAdaptersToEnable;
  }
}

contract Polygon is BaseCCFSenderAdapters {
  function TRANSACTION_NETWORK() public pure override returns (uint256) {
    return ChainIds.POLYGON;
  }

  function getBridgeAdaptersToEnable(
    DeployerHelpers.Addresses memory addresses
  ) public view override returns (ICrossChainForwarder.ForwarderBridgeAdapterConfigInput[] memory) {
    ICrossChainForwarder.ForwarderBridgeAdapterConfigInput[]
      memory bridgeAdaptersToEnable = new ICrossChainForwarder.ForwarderBridgeAdapterConfigInput[](
        4
      );

    // ethereum path
    DeployerHelpers.Addresses memory ethereumAddresses = _getAddresses(ChainIds.ETHEREUM);

    bridgeAdaptersToEnable[0] = ICrossChainForwarder.ForwarderBridgeAdapterConfigInput({
      currentChainBridgeAdapter: addresses.ccipAdapter,
      destinationBridgeAdapter: ethereumAddresses.ccipAdapter,
      destinationChainId: ethereumAddresses.chainId
    });
    bridgeAdaptersToEnable[1] = ICrossChainForwarder.ForwarderBridgeAdapterConfigInput({
      currentChainBridgeAdapter: addresses.lzAdapter,
      destinationBridgeAdapter: ethereumAddresses.lzAdapter,
      destinationChainId: ethereumAddresses.chainId
    });
    bridgeAdaptersToEnable[2] = ICrossChainForwarder.ForwarderBridgeAdapterConfigInput({
      currentChainBridgeAdapter: addresses.hlAdapter,
      destinationBridgeAdapter: ethereumAddresses.hlAdapter,
      destinationChainId: ethereumAddresses.chainId
    });
    bridgeAdaptersToEnable[3] = ICrossChainForwarder.ForwarderBridgeAdapterConfigInput({
      currentChainBridgeAdapter: addresses.polAdapter,
      destinationBridgeAdapter: ethereumAddresses.polAdapter,
      destinationChainId: ethereumAddresses.chainId
    });
    return bridgeAdaptersToEnable;
  }
}

contract Avalanche is BaseCCFSenderAdapters {
  function TRANSACTION_NETWORK() public pure override returns (uint256) {
    return ChainIds.AVALANCHE;
  }

  function getBridgeAdaptersToEnable(
    DeployerHelpers.Addresses memory addresses
  ) public view override returns (ICrossChainForwarder.ForwarderBridgeAdapterConfigInput[] memory) {
    ICrossChainForwarder.ForwarderBridgeAdapterConfigInput[]
      memory bridgeAdaptersToEnable = new ICrossChainForwarder.ForwarderBridgeAdapterConfigInput[](
        3
      );

    // ethereum path
    DeployerHelpers.Addresses memory ethereumAddresses = _getAddresses(ChainIds.ETHEREUM);

    bridgeAdaptersToEnable[0] = ICrossChainForwarder.ForwarderBridgeAdapterConfigInput({
      currentChainBridgeAdapter: addresses.ccipAdapter,
      destinationBridgeAdapter: ethereumAddresses.ccipAdapter,
      destinationChainId: ethereumAddresses.chainId
    });
    bridgeAdaptersToEnable[1] = ICrossChainForwarder.ForwarderBridgeAdapterConfigInput({
      currentChainBridgeAdapter: addresses.lzAdapter,
      destinationBridgeAdapter: ethereumAddresses.lzAdapter,
      destinationChainId: ethereumAddresses.chainId
    });
    bridgeAdaptersToEnable[2] = ICrossChainForwarder.ForwarderBridgeAdapterConfigInput({
      currentChainBridgeAdapter: addresses.hlAdapter,
      destinationBridgeAdapter: ethereumAddresses.hlAdapter,
      destinationChainId: ethereumAddresses.chainId
    });

    return bridgeAdaptersToEnable;
  }
}

contract Ethereum_testnet is BaseCCFSenderAdapters {
  function TRANSACTION_NETWORK() public pure override returns (uint256) {
    return TestNetChainIds.ETHEREUM_SEPOLIA;
  }

  function getBridgeAdaptersToEnable(
    DeployerHelpers.Addresses memory addresses
  ) public view override returns (ICrossChainForwarder.ForwarderBridgeAdapterConfigInput[] memory) {
    ICrossChainForwarder.ForwarderBridgeAdapterConfigInput[]
      memory bridgeAdaptersToEnable = new ICrossChainForwarder.ForwarderBridgeAdapterConfigInput[](
        9
      );

    // polygon path
    DeployerHelpers.Addresses memory addressesPolygon = _getAddresses(
      TestNetChainIds.POLYGON_MUMBAI
    );

    bridgeAdaptersToEnable[0] = ICrossChainForwarder.ForwarderBridgeAdapterConfigInput({
      currentChainBridgeAdapter: addresses.ccipAdapter,
      destinationBridgeAdapter: addressesPolygon.ccipAdapter,
      destinationChainId: addressesPolygon.chainId
    });
    bridgeAdaptersToEnable[1] = ICrossChainForwarder.ForwarderBridgeAdapterConfigInput({
      currentChainBridgeAdapter: addresses.lzAdapter,
      destinationBridgeAdapter: addressesPolygon.lzAdapter,
      destinationChainId: addressesPolygon.chainId
    });
    bridgeAdaptersToEnable[2] = ICrossChainForwarder.ForwarderBridgeAdapterConfigInput({
      currentChainBridgeAdapter: addresses.hlAdapter,
      destinationBridgeAdapter: addressesPolygon.hlAdapter,
      destinationChainId: addressesPolygon.chainId
    });

    //     avalanche path
    DeployerHelpers.Addresses memory addressesAvax = _getAddresses(TestNetChainIds.AVALANCHE_FUJI);

    bridgeAdaptersToEnable[3] = ICrossChainForwarder.ForwarderBridgeAdapterConfigInput({
      currentChainBridgeAdapter: addresses.ccipAdapter,
      destinationBridgeAdapter: addressesAvax.ccipAdapter,
      destinationChainId: addressesAvax.chainId
    });
    bridgeAdaptersToEnable[4] = ICrossChainForwarder.ForwarderBridgeAdapterConfigInput({
      currentChainBridgeAdapter: addresses.lzAdapter,
      destinationBridgeAdapter: addressesAvax.lzAdapter,
      destinationChainId: addressesAvax.chainId
    });
    bridgeAdaptersToEnable[5] = ICrossChainForwarder.ForwarderBridgeAdapterConfigInput({
      currentChainBridgeAdapter: addresses.hlAdapter,
      destinationBridgeAdapter: addressesAvax.hlAdapter,
      destinationChainId: addressesAvax.chainId
    });

    // binance path
    DeployerHelpers.Addresses memory addressesBNB = _getAddresses(TestNetChainIds.BNB_TESTNET);

    bridgeAdaptersToEnable[6] = ICrossChainForwarder.ForwarderBridgeAdapterConfigInput({
      currentChainBridgeAdapter: addresses.lzAdapter,
      destinationBridgeAdapter: addressesBNB.lzAdapter,
      destinationChainId: addressesBNB.chainId
    });
    bridgeAdaptersToEnable[7] = ICrossChainForwarder.ForwarderBridgeAdapterConfigInput({
      currentChainBridgeAdapter: addresses.hlAdapter,
      destinationBridgeAdapter: addressesBNB.hlAdapter,
      destinationChainId: addressesBNB.chainId
    });

    //     rollups
    //    DeployerHelpers.Addresses memory addressesOp = _getAddresses(TestNetChainIds.OPTIMISM_GOERLI);
    //    bridgeAdaptersToEnable[8] = ICrossChainForwarder.ForwarderBridgeAdapterConfigInput({
    //      currentChainBridgeAdapter: addresses.opAdapter,
    //      destinationBridgeAdapter: addressesOp.opAdapter,
    //      destinationChainId: addressesOp.chainId
    //    });
    //
    //    DeployerHelpers.Addresses memory addressesArb = _getAddresses(TestNetChainIds.ARBITRUM_GOERLI);
    //    bridgeAdaptersToEnable[9] = ICrossChainForwarder.ForwarderBridgeAdapterConfigInput({
    //      currentChainBridgeAdapter: addresses.arbAdapter,
    //      destinationBridgeAdapter: addressesArb.arbAdapter,
    //      destinationChainId: addressesArb.chainId
    //    });
    //
    //    DeployerHelpers.Addresses memory addressesMetis = _getAddresses(TestNetChainIds.METIS_TESTNET);
    //    bridgeAdaptersToEnable[10] = ICrossChainForwarder.ForwarderBridgeAdapterConfigInput({
    //      currentChainBridgeAdapter: addresses.metisAdapter,
    //      destinationBridgeAdapter: addressesMetis.metisAdapter,
    //      destinationChainId: addressesMetis.chainId
    //    });
    //    DeployerHelpers.Addresses memory addressesBase = _getAddresses(ChainIds.BASE_GOERLI);
    //    bridgeAdaptersToEnable[11] = ICrossChainForwarder.ForwarderBridgeAdapterConfigInput({
    //      currentChainBridgeAdapter: addresses.baseAdapter,
    //      destinationBridgeAdapter: addressesBase.baseAdapter,
    //      destinationChainId: addressesBase.chainId
    //    });

    // same chain path
    bridgeAdaptersToEnable[8] = ICrossChainForwarder.ForwarderBridgeAdapterConfigInput({
      currentChainBridgeAdapter: addresses.sameChainAdapter,
      destinationBridgeAdapter: addresses.sameChainAdapter,
      destinationChainId: addresses.chainId
    });
    return bridgeAdaptersToEnable;
  }
}

contract Polygon_testnet is BaseCCFSenderAdapters {
  function TRANSACTION_NETWORK() public pure override returns (uint256) {
    return TestNetChainIds.POLYGON_MUMBAI;
  }

  function getBridgeAdaptersToEnable(
    DeployerHelpers.Addresses memory addresses
  ) public view override returns (ICrossChainForwarder.ForwarderBridgeAdapterConfigInput[] memory) {
    ICrossChainForwarder.ForwarderBridgeAdapterConfigInput[]
      memory bridgeAdaptersToEnable = new ICrossChainForwarder.ForwarderBridgeAdapterConfigInput[](
        3
      );

    // ethereum path
    DeployerHelpers.Addresses memory ethereumAddresses = _getAddresses(
      TestNetChainIds.ETHEREUM_SEPOLIA
    );

    bridgeAdaptersToEnable[0] = ICrossChainForwarder.ForwarderBridgeAdapterConfigInput({
      currentChainBridgeAdapter: addresses.ccipAdapter,
      destinationBridgeAdapter: ethereumAddresses.ccipAdapter,
      destinationChainId: ethereumAddresses.chainId
    });
    bridgeAdaptersToEnable[1] = ICrossChainForwarder.ForwarderBridgeAdapterConfigInput({
      currentChainBridgeAdapter: addresses.lzAdapter,
      destinationBridgeAdapter: ethereumAddresses.lzAdapter,
      destinationChainId: ethereumAddresses.chainId
    });
    bridgeAdaptersToEnable[2] = ICrossChainForwarder.ForwarderBridgeAdapterConfigInput({
      currentChainBridgeAdapter: addresses.hlAdapter,
      destinationBridgeAdapter: ethereumAddresses.hlAdapter,
      destinationChainId: ethereumAddresses.chainId
    });

    return bridgeAdaptersToEnable;
  }
}

contract Avalanche_testnet is BaseCCFSenderAdapters {
  function TRANSACTION_NETWORK() public pure override returns (uint256) {
    return TestNetChainIds.AVALANCHE_FUJI;
  }

  function getBridgeAdaptersToEnable(
    DeployerHelpers.Addresses memory addresses
  ) public view override returns (ICrossChainForwarder.ForwarderBridgeAdapterConfigInput[] memory) {
    ICrossChainForwarder.ForwarderBridgeAdapterConfigInput[]
      memory bridgeAdaptersToEnable = new ICrossChainForwarder.ForwarderBridgeAdapterConfigInput[](
        3
      );

    // ethereum path
    DeployerHelpers.Addresses memory ethereumAddresses = _getAddresses(
      TestNetChainIds.ETHEREUM_SEPOLIA
    );

    bridgeAdaptersToEnable[0] = ICrossChainForwarder.ForwarderBridgeAdapterConfigInput({
      currentChainBridgeAdapter: addresses.ccipAdapter,
      destinationBridgeAdapter: ethereumAddresses.ccipAdapter,
      destinationChainId: ethereumAddresses.chainId
    });
    bridgeAdaptersToEnable[1] = ICrossChainForwarder.ForwarderBridgeAdapterConfigInput({
      currentChainBridgeAdapter: addresses.lzAdapter,
      destinationBridgeAdapter: ethereumAddresses.lzAdapter,
      destinationChainId: ethereumAddresses.chainId
    });
    bridgeAdaptersToEnable[2] = ICrossChainForwarder.ForwarderBridgeAdapterConfigInput({
      currentChainBridgeAdapter: addresses.hlAdapter,
      destinationBridgeAdapter: ethereumAddresses.hlAdapter,
      destinationChainId: ethereumAddresses.chainId
    });

    return bridgeAdaptersToEnable;
  }
}