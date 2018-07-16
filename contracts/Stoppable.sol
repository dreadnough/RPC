pragma solidity ^0.4.4;

import "./Owned.sol";

contract Stoppable is Owned {
    bool private stop;

    modifier onlyIfRunning () {require (!stop); _;}

    event LogStoppableNew (address _sender);
    constructor ()
        public
    {
        emit LogStoppableNew (msg.sender);
    }

    event LogStoppableStopContract (address _sender);
        // Function to soft stop the contract
    function stopContract ()
        onlyOwner
        public
        returns (bool _success)
    {
        stop = true;

        emit LogStoppableStopContract (msg.sender);
        return true;
    }

    event LogStoppableResumeContract (address _sender);
        // Function to soft resume the contract
    function resumeContract ()
        onlyOwner
        public
        returns (bool _success)
    {
        stop = false;

        emit LogStoppableResumeContract (msg.sender);
        return true;
    }

    function isStopped ()
        public
        view
        returns (bool _stop)
    {
        return stop;
    }
}
