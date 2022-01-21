# Notas

### tokenURI

Es donde viven los datos reales de NFT. Generalmente se vincula a un archivo JSON llamado metadata que se parece a esto:

```json
{
    "name": "Spongebob Cowboy Pants",
    "description": "A silent hero. A watchful protector.",
    "image": "https://i.imgur.com/v7U019j.png"
}
```

Casi todos los NFT tienen un nombre, una descripción y un enlace a algo como un video, una imagen, etc. ¡Incluso puede tener atributos personalizados! Tenga cuidado con la estructura de sus metadatos, si su estructura no coincide con los requisitos de OpenSea , su NFT aparecerá roto en el sitio web.

Todo esto es parte de los estándares ERC721 y permite a las personas crear sitios web sobre datos NFT. Por ejemplo, OpenSea es un mercado para NFT. Y, cada NFT en OpenSea sigue el ERC721estándar de metadatos, lo que facilita que las personas compren/vendan NFT. Imagínese si todos siguieran sus propios estándares NFT y estructuraran sus metadatos como quisieran, ¡sería un caos!

