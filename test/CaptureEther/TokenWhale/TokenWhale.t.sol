// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.18;

import { Test } from "@forge-std/Test.sol";
import { TokenWhale } from "contracts/CaptureEther/TokenWhale.sol";

/* solhint-disable func-name-mixedcase, func-named-parameters */
contract TokenWhaleTest is Test {
    TokenWhale private _contract;

    address private _owner;

    address private _player;
    address private _associate;

    function setUp() external {
        _owner = vm.addr(1000);
        vm.label(_owner, "[OWNER | 1000]");
        vm.deal(_owner, 10 ether);

        _player = vm.addr(2000);
        vm.label(_player, "[PLAYER | 2000]");
        vm.deal(_player, 10 ether);

        _contract = new TokenWhale(_player);

        _associate = vm.addr(3000);
        vm.label(_associate, "[ASSOCIATE | 3000]");
        vm.deal(_associate, 10 ether);
    }

    function test_IsComplete() external {
        vm.prank(_player);
        _contract.approve(_associate, 1000);

        vm.prank(_associate);
        _contract.transferFrom(_player, address(0), 1000);

        vm.prank(_associate);
        _contract.transfer(_player, 1_000_000);

        assertTrue(_contract.isComplete());
    }
}
