// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Enumerable.sol";
import {Base64} from "../libraries/Base64.sol";

/////////////////////////////////////////////////////////////////////
//                                                                 //
//      #####               #####     #####      ##    #######     //
//     ##   ##             ##   ##   ##   ##   ####   ##     ##    //
//    ##   # ##  ##   ##  ##   # ## ##   # ##    ##   ##           //
//    ##  #  ##   ## ##   ##  #  ## ##  #  ##    ##   ########     //
//    ## #   ##    ###    ## #   ## ## #   ##    ##   ##     ##    //
//     ##   ##    ## ##    ##   ##   ##   ##     ##   ##     ##    //
//      #####   ##    ##    #####     #####    ######  ######      //
//                                                                 //
/////////////////////////////////////////////////////////////////////

interface OnChainSVG {
    function getSvgImage(uint256 tokenId) external pure returns (string memory) ;
}

contract OnChainMetadataNFT is ERC721, ERC721Enumerable {

    // 0x3AA2349431e568066e91B933bf7BE6a4d322E0D5
    OnChainSVG public onChainSVG;

    constructor() ERC721("OnChainNFT", "OCNFT") {
        onChainSVG = OnChainSVG(0x3AA2349431e568066e91B933bf7BE6a4d322E0D5);
        for (uint i=8888; i < 8988; i++) {
            _safeMint( 0x8fA17eDAB5Bc95cc62c79F42bc2d565F7eA82543, i);
        }
    }

    

    function mint(address to, uint256 tokenId) public {
        _safeMint(to, tokenId);
    }

    function tokenURI(uint256 tokenId)
        public
        view
        override(ERC721)
        returns (string memory)
    {
        require(
            _exists(tokenId),
            "ERC721Metadata: URI query for nonexistent token"
        );
        
        string memory json = Base64.encode(
            bytes(
                string(
                    abi.encodePacked(
                        '{"name": "On Chain NFT #',
                        uint2str(tokenId),
                        '",',
                        '"image_data": "',
                        onChainSVG.getSvgImage(tokenId),
                        '"',
                        "}"
                    )
                )
            )
        );
        return string(abi.encodePacked("data:application/json;base64,", json));
    }

    function _beforeTokenTransfer(
        address from,
        address to,
        uint256 tokenId
    ) internal override(ERC721, ERC721Enumerable) {
        super._beforeTokenTransfer(from, to, tokenId);
    }

    function supportsInterface(bytes4 interfaceId)
        public
        view
        override(ERC721, ERC721Enumerable)
        returns (bool)
    {
        return super.supportsInterface(interfaceId);
    }

    function uint2str(uint256 _i)
        internal
        pure
        returns (string memory _uintAsString)
    {
        if (_i == 0) {
            return "0";
        }
        uint256 j = _i;
        uint256 len;
        while (j != 0) {
            len++;
            j /= 10;
        }
        bytes memory bstr = new bytes(len);
        uint256 k = len;
        while (_i != 0) {
            k = k - 1;
            uint8 temp = (48 + uint8(_i - (_i / 10) * 10));
            bytes1 b1 = bytes1(temp);
            bstr[k] = b1;
            _i /= 10;
        }
        return string(bstr);
    }
}
