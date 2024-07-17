Solidity
pragma solidity ^0.8.0;

/*

This contract allows users to bid on a Dutch  using Ether. The auction ends after 30 minutes, and the highest bidder wins the Dutch. The owner of the contract receives the highest bid.

*/

contract DutchAuction {
    address payable public owner;
    uint public startPrice;
    uint public auctionEnd;
    uint public highestBid;
    address public highestBidder;

    constructor() {
        owner = payable(msg.sender);
        startPrice = 100 ether; // Starting price of the Dutch
        auctionEnd = block.timestamp + 30 minutes; // Auction ends in 30 minutes
    }

    function bid() public payable {
        require(block.timestamp < auctionEnd, "Auction has ended");
        require(msg.value >= startPrice, "Bid must be greater than or equal to starting price");

        if (msg.value > highestBid) {
            highestBid = msg.value;
            highestBidder = msg.sender;
        }
    }

    function getHighestBid() public view returns (uint) {
        return highestBid;
    }

    function getHighestBidder() public view returns (address) {
        return highestBidder;
    }

    function endAuction() public {
        require(block.timestamp >= auctionEnd, "Auction has not ended yet");
        require(highestBidder != address(0), "No bids were made");

        owner.transfer(highestBid); // Transfer the highest bid to the owner
    }
}
