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

---

# Pasos que realizamos para crear los nft

> Links:
>
> [https://www.utilities-online.info/base64](https://www.utilities-online.info/base64)

## **Paso1**

Conseguimos nuestra imagen en svg.

```html
<svg xmlns="http://www.w3.org/2000/svg" preserveAspectRatio="xMinYMin meet" viewBox="0 0 350 350">
    <style>.base { fill: white; font-family: serif; font-size: 14px; }</style>
    <rect width="100%" height="100%" fill="black" />
    <text x="50%" y="50%" class="base" dominant-baseline="middle" text-anchor="middle">SupremeMishieThunder</text>
</svg>
```

## **Paso2**

Codificamos la imagen a Base64 y armamos el json.

- Podemos ver la imagen en el navegador como: **data:image/svg+xml;base64,INSERT_YOUR_BASE64_ENCODED_SVG_HERE** ([Ejemplo](PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHByZXNlcnZlQXNwZWN0UmF0aW89InhNaW5ZTWluIG1lZXQiIHZpZXdCb3g9IjAgMCAzNTAgMzUwIj4KICAgIDxzdHlsZT4uYmFzZSB7IGZpbGw6IHdoaXRlOyBmb250LWZhbWlseTogc2VyaWY7IGZvbnQtc2l6ZTogMTRweDsgfTwvc3R5bGU))

```json
{
    "name": "SupremeMishieThunder",
    "description": "An NFT from the highly acclaimed square collection",
    "image": "data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHByZXNlcnZlQXNwZWN0UmF0aW89InhNaW5ZTWluIG1lZXQiIHZpZXdCb3g9IjAgMCAzNTAgMzUwIj4KICAgIDxzdHlsZT4uYmFzZSB7IGZpbGw6IHdoaXRlOyBmb250LWZhbWlseTogc2VyaWY7IGZvbnQtc2l6ZTogMTRweDsgfTwvc3R5bGU+CiAgICA8cmVjdCB3aWR0aD0iMTAwJSIgaGVpZ2h0PSIxMDAlIiBmaWxsPSJibGFjayIgLz4KICAgIDx0ZXh0IHg9IjUwJSIgeT0iNTAlIiBjbGFzcz0iYmFzZSIgZG9taW5hbnQtYmFzZWxpbmU9Im1pZGRsZSIgdGV4dC1hbmNob3I9Im1pZGRsZSI+U3VwcmVtZU1pc2hpZVRodW5kZXI8L3RleHQ+Cjwvc3ZnPg=="
}
```

## **Paso3**

Codificamos todo el json a Base64

- Podemos ver el JSON en el navegador como: **data:application/json;base64,INSERT_YOUR_BASE64_ENCODED_JSON_HERE** ([Ejemplo](data:application/json;base64,ewogICAgIm5hbWUiOiAiU3VwcmVtZU1pc2hpZVRodW5kZXIiLAogICAgImRlc2NyaXB0aW9uIjogIkFuIE5GVCBmcm9tIHRoZSBoaWdobHkgYWNjbGFpbWVkIHNxdWFyZSBjb2xsZWN0aW9uIiwKICAgICJpbWFnZSI6ICJkYXRhOmltYWdlL3N2Zyt4bWw7YmFzZTY0LFBITjJaeUI0Yld4dWN6MGlhSFIwY0RvdkwzZDNkeTUzTXk1dmNtY3ZNakF3TUM5emRtY2lJSEJ5WlhObGNuWmxRWE53WldOMFVtRjBhVzg5SW5oTmFXNVpUV2x1SUcxbFpYUWlJSFpwWlhkQ2IzZzlJakFnTUNBek5UQWdNelV3SWo0S0lDQWdJRHh6ZEhsc1pUNHVZbUZ6WlNCN0lHWnBiR3c2SUhkb2FYUmxPeUJtYjI1MExXWmhiV2xzZVRvZ2MyVnlhV1k3SUdadmJuUXRjMmw2WlRvZ01UUndlRHNnZlR3dmMzUjViR1UrQ2lBZ0lDQThjbVZqZENCM2FXUjBhRDBpTVRBd0pTSWdhR1ZwWjJoMFBTSXhNREFsSWlCbWFXeHNQU0ppYkdGamF5SWdMejRLSUNBZ0lEeDBaWGgwSUhnOUlqVXdKU0lnZVQwaU5UQWxJaUJqYkdGemN6MGlZbUZ6WlNJZ1pHOXRhVzVoYm5RdFltRnpaV3hwYm1VOUltMXBaR1JzWlNJZ2RHVjRkQzFoYm1Ob2IzSTlJbTFwWkdSc1pTSStVM1Z3Y21WdFpVMXBjMmhwWlZSb2RXNWtaWEk4TDNSbGVIUStDand2YzNablBnPT0iCn0=))

```cmd
PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHByZXNlcnZlQXNwZWN0UmF0aW89InhNaW5ZTWluIG1lZXQiIHZpZXdCb3g9IjAgMCAzNTAgMzUwIj4KICAgIDxzdHlsZT4uYmFzZSB7IGZpbGw6IHdoaXRlOyBmb250LWZhbWlseTogc2VyaWY7IGZvbnQtc2l6ZTogMTRweDsgfTwvc3R5bGU+CiAgICA8cmVjdCB3aWR0aD0iMTAwJSIgaGVpZ2h0PSIxMDAlIiBmaWxsPSJibGFjayIgLz4KICAgIDx0ZXh0IHg9IjUwJSIgeT0iNTAlIiBjbGFzcz0iYmFzZSIgZG9taW5hbnQtYmFzZWxpbmU9Im1pZGRsZSIgdGV4dC1hbmNob3I9Im1pZGRsZSI+U3VwcmVtZU1pc2hpZVRodW5kZXI8L3RleHQ+Cjwvc3ZnPg==
```
