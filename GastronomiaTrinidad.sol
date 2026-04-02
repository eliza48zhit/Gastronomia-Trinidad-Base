// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

/**
 * @title GastronomiaTrinidad
 * @dev Registro historico con Likes, Dislikes e Identificador de Chutney (Salsa de Frutas).
 * Nota: Codigo ASCII puro para evitar errores de visualizacion y compatibilidad.
 */
contract GastronomiaTrinidad {

    struct Plato {
        string nombre;
        string descripcion;
        string tipoChutney; // Ej: Mango, Tamarindo, Pepino, Pommerac
        uint256 likes;
        uint256 dislikes;
    }

    mapping(uint256 => Plato) public menuHistorico;
    uint256 public totalPlatos;

    constructor() {
        // Inauguramos con los Doubles
        registrarPlato(
            "Doubles", 
            "Dos panes fritos (bara) rellenos de garbanzos al curry (channa) y especias.",
            "Mango y Tamarindo"
        );
    }

    function registrarPlato(
        string memory _nombre, 
        string memory _descripcion, 
        string memory _tipoChutney
    ) public {
        require(bytes(_nombre).length + bytes(_descripcion).length <= 200, "Texto demasiado largo");
        
        totalPlatos++;
        menuHistorico[totalPlatos] = Plato({
            nombre: _nombre, 
            descripcion: _descripcion,
            tipoChutney: _tipoChutney,
            likes: 0,
            dislikes: 0
        });
    }

    function darLike(uint256 _id) public {
        require(_id > 0 && _id <= totalPlatos, "El plato no existe.");
        menuHistorico[_id].likes++;
    }

    function darDislike(uint256 _id) public {
        require(_id > 0 && _id <= totalPlatos, "El plato no existe.");
        menuHistorico[_id].dislikes++;
    }

    function consultarPlato(uint256 _id) public view returns (
        string memory nombre, 
        string memory descripcion, 
        string memory tipoChutney,
        uint256 likes, 
        uint256 dislikes
    ) {
        require(_id > 0 && _id <= totalPlatos, "ID invalido.");
        Plato storage p = menuHistorico[_id];
        return (p.nombre, p.descripcion, p.tipoChutney, p.likes, p.dislikes);
    }
}
