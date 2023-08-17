// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.18;

/* solhint-disable func-named-parameters, reason-string */
contract TokenWhale {
    address private _player;

    uint256 public totalSupply;
    mapping(address => uint256) public balanceOf;
    mapping(address => mapping(address => uint256)) public allowance;

    string public name = "Whale Token";
    string public symbol = "WHALE";
    uint256 public decimals = 18;

    constructor(address player) {
        _player = player;
        totalSupply = 1000;
        balanceOf[_player] = 1000;
    }

    function isComplete() public view returns (bool) {
        return balanceOf[_player] >= 1_000_000;
    }

    event Transfer(address indexed from, address indexed to, uint256 value);

    /**
     * @notice Bug: underflow on `transferFrom`
     *
     * @dev Solution:
     *
     * function _transfer(address from, address to, uint256 value) internal {
     *   unchecked {
     *       balanceOf[from] -= value;
     *       balanceOf[to] += value;
     *   }
     *
     *   emit Transfer(from, to, value);
     * }
     */
    function _transfer(address to, uint256 value) internal {
        unchecked {
            balanceOf[msg.sender] -= value;
            balanceOf[to] += value;
        }

        emit Transfer(msg.sender, to, value);
    }

    function transfer(address to, uint256 value) public {
        require(balanceOf[msg.sender] >= value);
        require(balanceOf[to] + value >= balanceOf[to]);

        _transfer(to, value);
    }

    event Approval(address indexed owner, address indexed spender, uint256 value);

    function approve(address spender, uint256 value) public {
        allowance[msg.sender][spender] = value;
        emit Approval(msg.sender, spender, value);
    }

    function transferFrom(address from, address to, uint256 value) public {
        require(balanceOf[from] >= value, "FROM: INSUFFICIENT_BALANCE");
        require(balanceOf[to] + value >= balanceOf[to], "TO: OVERFLOW");
        require(allowance[from][msg.sender] >= value, "ALLOWANCE: INSUFFICIENT_ALLOWANCE");

        unchecked {
            allowance[from][msg.sender] -= value;
        }

        _transfer(to, value);
    }
}
