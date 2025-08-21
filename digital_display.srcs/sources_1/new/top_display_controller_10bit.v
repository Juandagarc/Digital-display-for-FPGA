module top_display_controller_10bit (
    // Entradas
    input wire [9:0] binary_input,    // La entrada binaria principal de 10 bits de los switches
    input wire       negate_button,   // Botón para activar el complemento a 2 (negativo)

    // Salidas
    output wire [9:0] led_outputs,     // Salida para encender un LED por cada switch activado
    output wire [6:0] segments_d3,     // Dígito de los millares
    output wire [6:0] segments_d2,     // Dígito de las centenas
    output wire [6:0] segments_d1,     // Dígito de las decenas
    output wire [6:0] segments_d0      // Dígito de las unidades
);

    // --- Lógica para los LEDs ---
    // Conecta directamente la entrada de los switches a la salida de los LEDs.
    // Así, si un switch está en '1', su LED correspondiente se encenderá.
    assign led_outputs = binary_input;

    // --- Lógica para el Complemento a 2 ---
    // Wire para almacenar el valor que se enviará a los displays.
    // Será el número original o su versión en negativo (complemento a 2).
    wire [9:0] display_value;

    // Si el botón 'negate_button' está presionado (valor 1), calcula el complemento a 2.
    // Si no, usa el valor binario original.
    assign display_value = negate_button ? (~binary_input + 1'b1) : binary_input;

    // --- Lógica de Visualización (sin cambios) ---
    // Cable para los 4 dígitos BCD (16 bits)
    wire [15:0] bcd_digits;

    // Instancia del conversor de binario a BCD.
    // Ahora usa 'display_value' como entrada.
    translator bcd_converter (
        .binary_in(display_value),
        .bcd_out(bcd_digits)
    );

    // Dígito 3 (Millares)
    bcd_to_7_segment decoder_d3 (
        .bcd_in(bcd_digits[15:12]),
        .segments(segments_d3)
    );

    // Dígito 2 (Centenas)
    bcd_to_7_segment decoder_d2 (
        .bcd_in(bcd_digits[11:8]),
        .segments(segments_d2)
    );

    // Dígito 1 (Decenas)
    bcd_to_7_segment decoder_d1 (
        .bcd_in(bcd_digits[7:4]),
        .segments(segments_d1)
    );

    // Dígito 0 (Unidades)
    bcd_to_7_segment decoder_d0 (
        .bcd_in(bcd_digits[3:0]),
        .segments(segments_d0)
    );

endmodule