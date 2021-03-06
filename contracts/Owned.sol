pragma solidity ^0.4.4;

contract Owned {
    address private owner;
    address private newOwner;

    modifier onlyOwner() {
        require (msg.sender == owner);
        _;
    }

    event LogOwnedNew (address _sender);
        // Constructor
    constructor ()
        public
    {
        owner = msg.sender;
        emit LogOwnedNew(msg.sender);
    }

    event LogOwnedChangeOwner (address _sender, address _newOwner);
        // 2-step ownership transfer function
        // This is the first step where the original owner requests the transfer
    function changeOwner(address _newOwner)
        onlyOwner
        public
        returns(bool _success)
    {
        require(_newOwner != 0);

        newOwner = _newOwner;
        emit LogOwnedChangeOwner(msg.sender, _newOwner);
        return true;
    }

    event LogOwnedConfirmChangeOwner (address _sender, address _newOwner);
        // 2-step ownership transfer function
        // This is the second step where the new  owner confirms the transfer
    function confirmChangeOwner()
        public
        returns(bool _success)
    {
        require(msg.sender == newOwner); //check the sender is the correct address

        owner = newOwner;
        delete newOwner;

        emit LogOwnedConfirmChangeOwner(msg.sender, newOwner);
        return true;
    } 

    function getInfoOwner()
        view
        public
        returns (address _owner)
    {
        return owner;
    }

    function getInfoNewOwner()
        view
        public
        returns (address _newOwner)
    {
        return newOwner;
    }   
}
