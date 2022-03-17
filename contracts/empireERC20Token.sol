// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract EmpireERC20Token is ERC20, Ownable {
    address payable ownedWallet;
    uint256 initialSupply = 1000000;

    event boughtToken(address buyer, address receiver, uint256 tokenAmount);

    uint256 public rate = 1000;

    constructor(address payable _myWallet) ERC20("empireERC20Token", "EMPE") {
        ownedWallet = _myWallet;
        _mint(msg.sender, initialSupply );
    }

    function mint(address to, uint256 amount) public onlyOwner {
        _mint(to, amount);
    }

    function buyToken(address receiver) public payable {
        require(msg.value >= 1 * 10**18, "You need to send more ether");
        ownedWallet.transfer(msg.value); 
        uint256 totalTokenToBuy = msg.value / 10**15; // 1 token -> 10**18 / 10**3 -> 10**15 wei
        _mint(receiver, totalTokenToBuy);
        emit boughtToken(msg.sender, receiver, totalTokenToBuy);
    }

    // get the ether balace from owner of token
    function OwnerEthBalance() public view onlyOwner returns(uint256){
        return address(ownedWallet).balance;
    }

}