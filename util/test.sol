pragma solidity ^0.4.16;
contract test{
    
    uint8 public age;

    function setAge(uint8 num) public
    { 
        age=num;
        sha256("test");
    }
    
    function getsha256(int32[] nums) public view returns(string)
    {
        bytes32 sha = sha256("test");
        bytes memory bytesStringTrimmed = new bytes(32);
        for (uint j = 0; j < 32; j++) {
            bytesStringTrimmed[j] = sha[j];
        }
        return string(bytesStringTrimmed);
    }
    function testint64(uint64 testnum) public view returns(uint64)
    {
        return testnum;
    }

    function getAge() public view returns(uint8 aa)
    { 
        return age;
    }
}