pragma solidity ^0.4.16;

contract util{
    function uintToString(uint v) pure public returns (string) {
        uint maxlength = 100;
        bytes memory reversed = new bytes(maxlength);
        uint i = 0;
        while (v != 0) {
            uint8 remainder = uint8(v % 10);
            v = v / 10;
            reversed[i++] = byte(48 + remainder);
        }
        bytes memory s = new bytes(i); // i + 1 is inefficient
        for (uint j = 0; j < i; j++) {
            s[j] = reversed[i - j - 1]; // to avoid the off-by-one error
        }
    
        string memory str = string(s);  // memory isn't implicitly convertible to storage
        return str;
    }
}