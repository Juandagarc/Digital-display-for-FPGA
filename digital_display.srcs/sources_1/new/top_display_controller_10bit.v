module top_hex_display_controller (
    input wire [9:0] binary_input,
    input wire       negate_button,

    output wire [9:0] led_outputs,
    output wire [6:0] segments_d2, // Dígito más a la izquierda (0-3)
    output wire [6:0] segments_d1, // Dígito del medio (0-F)
    output wire [6:0] segments_d0  // Dígito más a la derecha (0-F)
);

    // Conexión directa de switches a LEDs
    assign led_outputs = binary_input;

    // Lógica del complemento a 2 (sigue funcionando igual)
    wire [9:0] display_value;
    assign display_value = negate_button ? (~binary_input + 1'b1) : binary_input;

    // --- LÓGICA DE DIVISIÓN PARA HEXADECIMAL ---
    wire [3:0] hex_d2; // Nibble para el dígito 2
    wire [3:0] hex_d1; // Nibble para el dígito 1
    wire [3:0] hex_d0; // Nibble para el dígito 0

    assign hex_d2 = {2'b00, display_value[9:8]}; // Bits 9 y 8. Rellenamos con 0s a la izquierda.
    assign hex_d1 = display_value[7:4];         // Bits 7 al 4
    assign hex_d0 = display_value[3:0];         // Bits 3 al 0

    // --- INSTANCIAS DE LOS DECODIFICADORES HEX --
    // Dígito 2 (MSB)
    hex_to_7_segment decoder_d2 (
        .hex_in(hex_d2),
        .segments(segments_d2)
    );

    // Dígito 1
    hex_to_7_segment decoder_d1 (
        .hex_in(hex_d1),
        .segments(segments_d1)
    );

    // Dígito 0 (LSB)
    hex_to_7_segment decoder_d0 (
        .hex_in(hex_d0),
        .segments(segments_d0)
    );

endmodule