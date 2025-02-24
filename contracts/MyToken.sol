// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract GPPCCR {
    string public name = "Pessoas Pobres com Computadores Ruins 5.0 coin";
    string public symbol = "GPPCCR";
    uint8 public decimals = 8;
    uint256 public totalSupply = 1000000 * 10 ** uint256(decimals); // 1M tokens
    string public tokenURI = "https://drive.google.com/file/d/1GXWOkk2CvK97M3_i74PZqCXPyrkwKDOb/view?usp=sharing";

    mapping(address => uint256) public balanceOf;
    mapping(address => mapping(address => uint256)) public allowance;

    event Transfer(address indexed from, address indexed to, uint256 value);
    event Approval(address indexed owner, address indexed spender, uint256 value);

    constructor() {
        balanceOf[msg.sender] = totalSupply;
    }

    function transfer(address to, uint256 value) external returns (bool) {
        require(to != address(0), "Endereco Invalido");
        require(balanceOf[msg.sender] >= value, "Saldo insuficiente");

        balanceOf[msg.sender] -= value;
        balanceOf[to] += value;
        emit Transfer(msg.sender, to, value);
        return true;
    }

    function approve(address spender, uint256 value) external returns (bool) {
        allowance[msg.sender][spender] = value;
        emit Approval(msg.sender, spender, value);
        return true;
    }

    function transferFrom(address from, address to, uint256 value) external returns (bool) {
        require(from != address(0), "Endereco Invalido");
        require(to != address(0), "Endereco de destino Invalido");

        require(balanceOf[from] >= value, "Saldo insuficiente");
        require(allowance[from][msg.sender] >= value, "Permissao Insuficiente");

        balanceOf[from] -= value;
        balanceOf[to] += value;
        allowance[from][msg.sender] -= value;

        emit Transfer(from, to, value);
        return true;
    }
}
