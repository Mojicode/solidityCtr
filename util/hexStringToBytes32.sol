/* Converts a hexadecimal string, whose bytes equivalent length 
can be up to 32 bytes (at least only tested and meant for up to 32 bytes)
into a bytes32 type.
EXAMPLE I/O
I: "a0c3689df9ce9c3aee5c1ba34dd1649098e2a10f6b2b337bf26695318cc0b958"
O: bytes32: 0xa0c3689df9ce9c3aee5c1ba34dd1649098e2a10f6b2b337bf26695318cc0b958
Currently assumes the 0x prefix is omitted from the string.
Written in ASM for low gas footprint
from: https://gist.github.com/D-Nice/00da3124c2588b0eda839d8396b6c592
*/

contract hexStringToBytes32 {
    function parse(string _m) returns(bytes32) {
        bytes memory x = bytes(_m);
        uint len = x.length;
        delete x;
        assembly
        {
            let n := len
            len := sub(len, 1)
            let b := 0
            let o := 0
            let r := 0
        loop:
            n := sub(n, 1)
            div(n, 0x20) 0x20 mul 0x20 add _m add mload
            mod(n, 0x20)
            byte
            =: b
            // ensures valid hexadecimal character
            jumpi(invalidJumpLabel, lt(b, 0x30)) //can disable these checks to save some gas
            jumpi(num, lt(b, 0x3A))
            jumpi(invalidJumpLabel, lt(b, 0x41)) //can disable these checks to save some gas
            jumpi(ualpha, lt(b, 0x47))
            jumpi(invalidJumpLabel, lt(b, 0x61)) //can disable these checks to save some gas
            jumpi(lalpha, lt(b, 0x67))
            jump(invalidJumpLabel)
        num: 
            o := 0x30
            jump(loopcalc)
        lalpha:
            o := 0x57
            jump(loopcalc)
        ualpha:
            o := 0x37
            jump(loopcalc)
        loopcalc:
            sub(b, o)
            sub(len, n) 0x10 exp mul r add 
            =: r
            n 0 eq 1 sub
            loop
            jumpi
        loopend:
            0x0
            mstore
            return(0, 0x20)
        }
    }
}
