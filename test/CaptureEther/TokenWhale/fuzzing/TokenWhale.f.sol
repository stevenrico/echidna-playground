// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.18;

import { TokenWhale } from "contracts/CaptureEther/TokenWhale.sol";

/**
 * @notice Fuzz TokenWhale contract
 *
 * @dev Run in the terminal:
 *
 * `echidna test/CaptureEther/TokenWhale/fuzzing/TokenWhale.f.sol --config echidna.config.yaml --contract FuzzTokenWhale`
 */

/* solhint-disable func-name-mixedcase */
contract FuzzTokenWhale is TokenWhale {
    address private _echidna = msg.sender;

    constructor() TokenWhale(_echidna) { }

    function echidna_ItTestsBalanceOf() public view returns (bool) {
        return balanceOf[_echidna] <= 1000;
    }
}
