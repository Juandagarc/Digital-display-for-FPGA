`timescale 1ns / 1ps

module tb_display_controller;

    // 1. Declarar las señales (con las nuevas añadidas)
    reg  [9:0] test_binary_input;
    reg        test_negate_button; // <<-- NUEVA SEÑAL para el botón
    wire [9:0] test_led_outputs;   // <<-- NUEVA SEÑAL para los LEDs
    wire [6:0] segments_d3, segments_d2, segments_d1, segments_d0;

    // 2. Instanciar el DUT (con las nuevas conexiones)
    top_display_controller_10bit dut (
        .binary_input(test_binary_input),
        .negate_button(test_negate_button), // <<-- NUEVA CONEXIÓN
        .led_outputs(test_led_outputs),     // <<-- NUEVA CONEXIÓN
        .segments_d3(segments_d3),
        .segments_d2(segments_d2),
        .segments_d1(segments_d1),
        .segments_d0(segments_d0)
    );

    // 3. Bloque de estímulos (con nuevas pruebas)
    initial begin
        $display("Iniciando simulación del controlador de display...");
        
        // Monitor mejorado para ver el estado del botón y el valor interno que se muestra
        $monitor("Tiempo=%0t | Switches: %4d | Negar: %b | LEDs: %b | Valor a mostrar: %4d",
                 $time, test_binary_input, test_negate_button, test_led_outputs, dut.display_value);

        // -- Casos de prueba --

        // Prueba 1: Número simple positivo y luego negativo
        test_binary_input = 10'd5;
        test_negate_button = 1'b0; // Botón no presionado
        #10;
        test_negate_button = 1'b1; // Botón presionado (debería mostrar 1019, que es -5)
        #10;

        // Prueba 2: Un número más grande
        test_binary_input = 10'd120;
        test_negate_button = 1'b0; // Positivo
        #10;
        test_negate_button = 1'b1; // Negativo (debería mostrar 904, que es -120)
        #10;
        
        // Prueba 3: Valor cero
        test_binary_input = 10'd0;
        test_negate_button = 1'b0;
        #10;
        test_negate_button = 1'b1; // Complemento a 2 de 0 es 0
        #10;
        
        // Prueba 4: Valor máximo
        test_binary_input = 10'd1023;
        test_negate_button = 1'b0; // Positivo
        #10;
        test_negate_button = 1'b1; // Negativo (debería mostrar 1, que es -1023 en C2 de 10 bits)
        #10;

        $display("Simulación finalizada.");
        $finish;
    end

endmodule