pragma solidity ^0.4.16;

contract util{
    function intToString(int32 v) public pure returns (string memory) {
        uint maxlength = 100;
        bytes memory reversed = new bytes(maxlength);
        uint i = 0;
        while (v != 0) {
            int8 remainder = int8(v % 10) + 48;
            v = v / 10;
            bytes1 byt;
            assembly{mstore(add(byt, 1), remainder)}
            reversed[i++] = byt;
        }
        bytes memory s = new bytes(i); // i + 1 is inefficient
        for (uint j = 0; j < i; j++) {
            s[j] = reversed[i - j - 1]; // to avoid the off-by-one error
        }
        // bytes memory b = new bytes(4);
        // assembly { mstore(add(b, 4), v) }
        
        string memory str = string(s);  // memory isn't implicitly convertible to storage
        return str;
    }
}