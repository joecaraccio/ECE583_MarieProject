`timescale 1ns / 1ps
//Design Team 5
//Joe Caraccio, Ben Miller, Noah Fiter
//Transmitter System
module top(
input [7:0]switches,
input btn1,
input clk,
output TxD
); 

wire [7:0] test1;
assign test1 = switches;

assign btnwire = btn1;
transmitter trans1 (
    clk,
    btnwire,
    test1,
    TxD
    );


endmodule
