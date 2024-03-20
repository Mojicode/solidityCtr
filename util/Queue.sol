// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

struct chargeInfo {
    uint actMoney;
    uint totalGas;
    uint leftGas;
}

struct Queue {
    chargeInfo[] data;
    uint front;
    uint rear;
}
 
library QueueOp
{
    // length
    function length(Queue storage self) public view returns (uint256) {
        return (self.rear - self.front + self.data.length) % self.data.length;
    }
    // push
    function push(Queue storage self, chargeInfo memory data) internal
    {
        require((self.rear + 1) % self.data.length == self.front, "Queue is full");

        self.data[self.rear] = data;
        self.rear = (self.rear + 1) % self.data.length;
    }
    // pop
    function pop(Queue storage self) internal returns (chargeInfo memory ciRet)
    {
        require(self.rear != self.front, "Queue is empty");

        chargeInfo memory ci = self.data[self.front];
        // delete self.data[self.front];
        self.front = (self.front + 1) % self.data.length;
        return ci;
    }
    // peak
    function peek(Queue storage self) internal view returns (chargeInfo memory ciRet) 
    {
        require(self.rear != self.front, "Queue is empty");
        return self.data[self.front];
    }
}

