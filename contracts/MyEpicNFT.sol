// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

//> Importamos algunos contratos desde OpenZeppelin.
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/utils/Counters.sol";
import "hardhat/console.sol";

//> Heredamos el contrato ERC721URIStorage desde nuestro contrato MyEpicNFT.
contract MyEpicNFT is ERC721URIStorage {
    //> Funcionalidad de OpenZeppelin para ayudarnos a realizar un seguimiento de tokenIds.
    using Counters for Counters.Counter;
    Counters.Counter private _tokenIds;

    //> Es necesario pasar el nombre de nuestro token NFTs y su símbolo.
    constructor() ERC721("SquareNFT", "SQUARE") {
        console.log("This is my NFT contract. Woah!");
    }

    //> Funcion para que nuestros usuarios obtengan ses NFT.
    function makeAnEpicNFT() public {
        //> Obtiene el tokenId actual, comienza en 0.
        uint256 newItemId = _tokenIds.current();

        //> Acuña el NFT al remitente usando msg.sender
        _safeMint(msg.sender, newItemId);

        //> Establece los datos de NFT.
        _setTokenURI(newItemId, "blah");

        //> Incrementa el contador para el proximo NFT que vaya a ser minteado.
        _tokenIds.increment();
    }
}
