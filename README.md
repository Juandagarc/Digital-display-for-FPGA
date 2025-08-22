# Primer ejercicio
Para el primer ejercicio debemos usar los diez switches del FPGA para encender las correspondientes luces LED en el FPGA.
Para realizar este punto lo primero que hacemos es iniciar un módulo en Verilog HDL llamada `top_hex_display_controller`
donde se está nuestro módulo principal de la tarea, acá vamos a crear un input 
con la siguiente estructura `input [7:0] binary_input`, esto nos creará directamente las 8 entradas de los swithces del FPGA (La razón de ser 8 es por el módelo del FPGA que íbamos a usar),
de forma similiar creamos 8 outputs llamados led_outputs que serán nuestras LEDS. Para que se enciendan las LEDS con los switchs lo que haremos es hacer una asignación en verilog donde
las salidas serán iguales a sus respectivas entradas, de esta forma `assign led_outputs = binary_input;`
# Segundo y tercer ejercicio
Estos puntos son muy parecidos así que los incluimos en uno solo. Para este punto requerimos de un módulo `hex_to_7_segment` con 4 entradas y 7 salidas (representando 4 switches por cada pantalla de 7 segmentos),
este módulo tiene algo importante que es la lógica para el encendido de cada una de las luces para cada número, por la disposición del FPGA que posee un ánodo común, nuestra lógica está escrita en activo bajo.
Para este punto ya tenemos todo lo necesario para un bit de la pantalla de 7 segmentos, pero para el siguiente ejercicio requerimos de utilizar más bits
