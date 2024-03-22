// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

contract Price {
    uint256 private _price;
    address private _owner;
    address private _oracle;
    uint256 private _updatedAt;

    constructor() {
        _owner = msg.sender;
    }

    /**
    * Sets the oracle address to prevent anyone else from
    * calling the "setPrice" method
    */
    function setOracle(address oracle) external {
        require(msg.sender == _owner, "Only owner can call this");
        _oracle = oracle;
    }

    // A simple event to make price data requests
    event PriceRequest();

    /**
    * Emit an event that will be picked up by the Kenshi
    * Oracle Network and sent to your oracle for processing
    
    */
    function requestPrice() external {
        emit PriceRequest();
        _updatedAt = block.timestamp;
    }

    function latestRoundData() external view
        returns (
            uint80 roundId,
            uint256 answer,
            uint256 startedAt,
            uint256 updatedAt,
            uint80 answeredInRound
        ) 
        {
            roundId = 0;
            answer = _price;
            startedAt = 0;
            updatedAt = _updatedAt;
            answeredInRound = 0;
        }



    /**
    * This method will be called by the Kenshi Oracle Network
    * with the result returned from your oracle
    */
    function setPrice(uint256 price) external {
        require(msg.sender == _oracle, "Only oracle can call this");
        _price = price;
    }

    /**
    * This function simply returns the price set by the oracle

    function getPrice() external view returns (uint256) {
        return _price;
    }
    */
}