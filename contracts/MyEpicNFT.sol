// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

//> Importamos algunos contratos desde OpenZeppelin.
// OpenZeppelin ya implementa el estándar NFT
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/utils/Counters.sol";
import "hardhat/console.sol";

// Importamos funcionalidades extras a nuestro contrato.
import {Base64} from "./libraries/Base64.sol";

//> Heredamos el contrato ERC721URIStorage desde nuestro contrato MyEpicNFT.
contract MyEpicNFT is ERC721URIStorage {
    //> Funcionalidad de OpenZeppelin para ayudarnos a realizar un seguimiento de tokenIds.
    using Counters for Counters.Counter;
    Counters.Counter private _tokenIds;

    uint256 public maxSupply = 50; // Para limitar el numero de nfts que puedo crear.

    //> Este es nuestro código SVG.
    // Lo unico que necesitamos cambiar es la palabra que se muestra, lo demás se queda igual.
    // Creamos una variable baseSvg para que todos nuestros NFT pueden usar.
    string baseSvg =
        "<svg xmlns='http://www.w3.org/2000/svg' preserveAspectRatio='xMinYMin meet' viewBox='0 0 350 350'><style>.base { fill: lime; font-family: console; font-size: 20px; font-style: italic; }</style><rect width='100%' height='100%' fill='black' /><text x='50%' y='50%' class='base' dominant-baseline='middle' text-anchor='middle'>";

    //> Creo tres matrices de palabras aleatorias.
    string[] firstWords = [
        "Aguila",
        "Avestruz",
        "Ballena",
        "Bisonte",
        "Bufalo",
        "Buho",
        "Buitre",
        "Burro",
        "Caballo",
        "Cabra",
        "Camaleon",
        "Camello",
        "Canario",
        "Castor",
        "Cebra",
        "Cerdo",
        "Ciervo",
        "Cobra",
        "Colibri",
        "Comadreja",
        "Condor",
        "Conejo",
        "Delfin",
        "Elefante",
        "Faisan",
        "Flamenco",
        "Foca",
        "Gallina",
        "Gallo",
        "Gato",
        "Gorila",
        "Guepardo",
        "Hamster",
        "Hiena",
        "Hipopotamo",
        "Jabali",
        "Jaguar",
        "Koala",
        "Lagarto",
        "Llama",
        "Lobo",
        "Loro",
        "Manati",
        "Mapache",
        "Mono",
        "Murcielago",
        "Nutria",
        "Orca",
        "Oso",
        "Paloma",
        "Panda",
        "Pato",
        "Pelicano",
        "Perro",
        "Puercoespin",
        "Puma",
        "Reno",
        "Serpiente",
        "Tapir",
        "Tejon",
        "Toro",
        "Vaca",
        "Zorrillo",
        "Chimpance",
        "Tigre",
        "Jirafa",
        "Zorro",
        "Rinoceronte",
        "Raton",
        "Topo",
        "Chinche",
        "Cochinilla",
        "Cucaracha",
        "Grillo",
        "Gusano",
        "Larva",
        "Libelula",
        "Lombriz",
        "Luciernaga",
        "Piojo",
        "Polilla",
        "Pulga",
        "Saltamonte",
        "Sanguijuela",
        "Almeja",
        "Babosa",
        "Calamar",
        "Cangrejo",
        "Caracol",
        "Cigarra",
        "Erizo",
        "Escarabajo",
        "Garrapata",
        "Gorgojo",
        "Hormiga",
        "Langosta",
        "Langostino",
        "Mariposa",
        "Mejillon",
        "Mosca",
        "Mosquito",
        "Ostra",
        "Pulpo",
        "Avispa",
        "Medusa",
        "Tiburon",
        "Morsa",
        "Ornitorrinco",
        "Mantarraya",
        "Rana",
        "Sapo",
        "Salamandra",
        "Clarinero",
        "Abeja",
        "Abejorro",
        "Tucan"
    ];
    string[] secondWords = [
        "Abogado",
        "Academico"
        "Administrador",
        "Administrativo",
        "Agronomo",
        "Alergologo",
        "Alergista",
        "Alergologa",
        "Alergista",
        "Almacenero",
        "Almacenista",
        "Almacenera",
        "Almacenista",
        "Anatomista",
        "Anestesiologo",
        "Anestesista",
        "Anestesiologa",
        "Anestesista",
        "Antologista",
        "Antropologo",
        "Arabista",
        "Archivero",
        "Arqueologo",
        "Arquitecto",
        "Asesor",
        "Asistente",
        "Astrofisico",
        "Astrologo",
        "Astronomo",
        "Atleta",
        "AT",
        "Autor",
        "Auxiliar",
        "Avicultor",
        "Bacteriologo",
        "Bedel",
        "Bibliografo",
        "Bibliotecario",
        "Biofisico",
        "Biografo",
        "Biologo",
        "Bioquimico",
        "Botanico",
        "Cancerologo",
        "Cardiologo",
        "Cartografo",
        "Castrador",
        "Catedratico",
        "Cirujano",
        "Citologo",
        "Climatologo",
        "Codirector",
        "Comadron",
        "Consejero",
        "Conserje",
        "Conservador",
        "Coordinador",
        "Cosmografo",
        "Cosmologo",
        "Criminalista",
        "Cronologo",
        "Decano",
        "Decorador",
        "Defensor",
        "Delegado",
        "Delineante",
        "Demografo",
        "Dentista",
        "Dermatologo",
        "Dibujante",
        "Directivo",
        "Director",
        "Dirigente",
        "Doctor",
        "Documentalista",
        "Ecologo",
        "Economista",
        "Educador",
        "Egiptologo",
        "Endocrinologo",
        "Enfermero",
        "Enologo",
        "Entomologo",
        "Epidemiologo",
        "Especialista",
        "Espeleologo",
        "Estadista",
        "Estadistico",
        "Etimologo",
        "Etimologista",
        "Etnografo",
        "Etnologo",
        "Etologo",
        "Examinador",
        "Facultativo",
        "Farmaceutico",
        "Farmacologo",
        "Filosofo",
        "Fiscal",
        "Fisico",
        "Fisiologo",
        "Fisioterapeuta",
        "Fonetista",
        "Foniatra",
        "Fonologo",
        "Forense",
        "Fotografo",
        "Funcionario",
        "Gemologo",
        "Genetista",
        "Geobotanica",
        "Geodesta",
        "Geofisico",
        "Geografo",
        "Geologo",
        "Geomantico",
        "Geometra",
        "Geoquimica",
        "Gerente",
        "Geriatra",
        "Gerontologo",
        "Gramatico",
        "Hematologo",
        "Hepatologo",
        "Hidrogeologo",
        "Hidrografo",
        "Hidrologo",
        "Higienista",
        "Hispanista",
        "Historiador",
        "Homeopata",
        "Informatico",
        "Inmunologo",
        "Inspector",
        "Interino",
        "Interventor",
        "Investigador",
        "Jardinero",
        "Jefe",
        "Juez",
        "Lector",
        "Lexicografo",
        "Lexicologo",
        "Licenciado",
        "Maestro",
        "Matematico",
        "Medico",
        "Meteorologo",
        "Micologo",
        "Microbiologico",
        "Microcirujano",
        "Mimografo",
        "Mineralogista",
        "Monitor",
        "Naturopata",
        "Nefrologo",
        "Neumologo",
        "Neuroanatomista",
        "Neurobiologo",
        "Neurocirujano",
        "Neuroembriologo",
        "Neurofisiologo",
        "Neurologo",
        "Nutrologo",
        "Oceanografo",
        "Odontologo",
        "Oficial",
        "Oficinista",
        "Oftalmologo",
        "Oncologo",
        "Optico",
        "Optometrista",
        "Ordenanza",
        "Orientador",
        "Ornitologo",
        "Ortopedico",
        "Ortopedista",
        "Osteologo",
        "Osteopata",
        "Otorrinolaringologo",
        "Paleobiologo",
        "Paleobotanico",
        "Paleografo",
        "Paleologo",
        "Paleontologo",
        "Patologo",
        "Pedagogo",
        "Pedicuro",
        "Periodista",
        "Ingeniero",
        "Piscicultor",
        "Podologo",
        "Portero",
        "Prehistoriador",
        "Presidente",
        "Proctologo",
        "Profesor",
        "Programador",
        "Protesico",
        "Proveedor",
        "Psicoanalista",
        "Psicologo",
        "Psicofisico",
        "Psicopedagogo",
        "Psicoterapeuta",
        "Psiquiatra",
        "Publicista",
        "Publicitario",
        "Puericultor",
        "Quimico",
        "Quiropractico",
        "Radioastronomo",
        "Radiofonista",
        "Radiologo",
        "Radiotecnico",
        "Radiotelefonista",
        "Radiotelegrafista",
        "Radioterapeuta",
        "Rector",
        "Sanitario",
        "Secretario",
        "Sexologo",
        "Sismologo",
        "Sociologo",
        "Subdelegado",
        "Subdirector",
        "Subsecretario",
        "Tecnico",
        "Telefonista",
        "Teologo",
        "Terapeuta",
        "Tocoginecologo",
        "Tocologo",
        "Toxicologo",
        "Traductor",
        "Transcriptor",
        "Traumatologo",
        "Tutor",
        "Urologo",
        "Veterinario",
        "Vicedecano",
        "Vicedirector",
        "Vicegerente",
        "Vicepresidente",
        "Vicerrector",
        "Vicesecretario",
        "Virologo",
        "Viticultor",
        "Vulcanologo",
        "Xilografo",
        "Zoologo",
        "Zootecnico"
    ];
    string[] thirdWords = [
        "Juvenil",
        "Dulce",
        "Comunista",
        "Amargo",
        "Diminuto",
        "Infantil",
        "Seco",
        "Capitalista",
        "Caro",
        "Renacentista",
        "Inteligente",
        "Fotografico",
        "Rubio",
        "Divertido",
        "Fuerte",
        "Fiel",
        "Debil",
        "Agradable",
        "Flexible",
        "Sucio",
        "Limpio",
        "Amable",
        "Moderno",
        "Aspero",
        "Valiente",
        "Suave",
        "Hermoso",
        "Rugoso",
        "Esponjoso",
        "Cruel",
        "Flojo",
        "Perfecto",
        "Culto",
        "Democratico",
        "Artistico",
        "Individual",
        "Religioso",
        "Regional",
        "Economico",
        "Historico",
        "Militante",
        "Familiar",
        "Mercantil",
        "Vanguardista",
        "Quirurgico",
        "Poderoso",
        "Machista",
        "Feminista",
        "Ateo",
        "Budista",
        "Renegado",
        "Calenton",
        "Travesti",
        "Sexista",
        "Morboso",
        "Mamon",
        "Turro",
        "Canelon",
        "Amragado",
        "Atrevido"
    ];

    //> Creamos eventos para consumirlos desde el FE.
    event NewEpicNFTMinted(address sender, uint256 tokenId);
    event getTotalNFTsMintedSoFar(uint256 maxSupply, uint256 currentSupply);

    //> Es necesario pasar el nombre de nuestro token NFTs y su símbolo.
    constructor() ERC721("SquareNFT", "SQUARE") {
        console.log("This is my NFT contract. Woah!");
    }

    //> Función para elegir aleatoriamente una palabra de cada matriz.
    function pickRandomFirstWord(uint256 tokenId)
        public
        view
        returns (string memory)
    {
        //> Usamos la funcion random
        uint256 rand = random(
            string(abi.encodePacked("FIRST_WORD", Strings.toString(tokenId)))
        );
        //> Aplaste el # entre 0 y la longitud de la matriz para evitar salirse de los límites.
        rand = rand % firstWords.length;
        return firstWords[rand];
    }

    function pickRandomSecondWord(uint256 tokenId)
        public
        view
        returns (string memory)
    {
        uint256 rand = random(
            string(abi.encodePacked("SECOND_WORD", Strings.toString(tokenId)))
        );
        rand = rand % secondWords.length;
        return secondWords[rand];
    }

    function pickRandomThirdWord(uint256 tokenId)
        public
        view
        returns (string memory)
    {
        uint256 rand = random(
            string(abi.encodePacked("THIRD_WORD", Strings.toString(tokenId)))
        );
        rand = rand % thirdWords.length;
        return thirdWords[rand];
    }

    //> Funcion para obtener un valor random
    function random(string memory input) internal pure returns (uint256) {
        return uint256(keccak256(abi.encodePacked(input)));
    }

    //> Funcion para que nuestros usuarios obtengan ses NFT.
    function makeAnEpicNFT() public {
        //> Obtiene el tokenId actual, comienza en 0.
        // _tokenIds: identificador único de nuestros NFT
        // es una variable de estado asi que el valor se almacena directamente en el contrato.
        uint256 newItemId = _tokenIds.current();

        //> Agrego validacion para que no se supere el max de nfts.
        require(newItemId < maxSupply, "No NFTs left :(");

        //> Tomamos 3 palabras random de los arrays.
        string memory first = pickRandomFirstWord(newItemId);
        string memory second = pickRandomSecondWord(newItemId);
        string memory third = pickRandomThirdWord(newItemId);
        string memory combinedWord = string(
            abi.encodePacked(first, second, third)
        );

        //> Concatenamos nuestras variables y cerramos las etiquetas <text> y <svg>.
        string memory finalSvg = string(
            abi.encodePacked(baseSvg, combinedWord, "</text></svg>")
        );

        //> Obtengo todos los metadatos JSON y se codifican en base64.
        string memory json = Base64.encode(
            bytes(
                string(
                    abi.encodePacked(
                        '{"name": "',
                        //> Enviamos la palabra generada como titulo de nuestro NFT.
                        combinedWord,
                        '", "description": "A highly acclaimed collection of squares.", "image": "data:image/svg+xml;base64,',
                        //> Agregamos data:image/svg+xml;base64 y luego agregamos nuestra codificación base64 a nuestro svg.
                        Base64.encode(bytes(finalSvg)),
                        '"}'
                    )
                )
            )
        );

        //> Al igual que antes, anteponemos data:application/json;base64 a nuestros datos.
        string memory finalTokenUri = string(
            abi.encodePacked("data:application/json;base64,", json)
        );

        //> Acuña el NFT al remitente usando msg.sender
        _safeMint(msg.sender, newItemId);

        //> Establece los datos de NFT.
        _setTokenURI(newItemId, finalTokenUri);

        //> Incrementa el contador para el proximo NFT que vaya a ser minteado.
        _tokenIds.increment();
        console.log(
            "An NFT w/ ID %s has been minted to %",
            newItemId,
            msg.sender
        );

        // Ejecutamos eventos.
        emit NewEpicNFTMinted(msg.sender, newItemId);
        emit getTotalNFTsMintedSoFar(maxSupply, newItemId);
    }

    function getCurrentTotalNFTs() public view returns (uint256) {
        return _tokenIds.current();
    }

    function getTotalNFTs() public view returns (uint256) {
        return maxSupply;
    }
}
