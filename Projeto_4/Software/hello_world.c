/*
 * "Hello World" example.
 *
 * This example prints 'Hello from Nios II' to the STDOUT stream. It runs on
 * the Nios II 'standard', 'full_featured', 'fast', and 'low_cost' example
 * designs. It runs with or without the MicroC/OS-II RTOS and requires a STDOUT
 * device in your system's hardware.
 * The memory footprint of this hosted application is ~69 kbytes by default
 * using the standard reference design.
 *
 * For a reduced footprint version of this template, and an explanation of how
 * to reduce the memory footprint for a given application, see the
 * "small_hello_world" template.
 *
 */

#include "alt_types.h"
#include "altera_avalon_pio_regs.h"
#include "system.h"
#include <stdio.h>
#include <unistd.h>
#include "altera_up_avalon_character_lcd.h"

static alt_u8 count;

void incDec(int op){
	if(op == 0){
		count++;

		IOWR_ALTERA_AVALON_PIO_DATA(LED_PIO_BASE,count);
	} else if(op == 1){
		count--;

		IOWR_ALTERA_AVALON_PIO_DATA(LED_PIO_BASE,count);
	}
}

int main(){
	int enter = 0;
	char lucas[] = "Lucas Coelho     ";
	char yago[] = "Yago Castro     ";

	char *l;
	char *y;

	l = &lucas;
	y = &yago;

	alt_up_character_lcd_dev *lcd;
	lcd = alt_up_character_lcd_open_dev("/dev/lcd");

	if(lcd == NULL){
		alt_printf("Error: could not open character LCD device\n");
		return 1;
	} else
		alt_printf ("Opened character LCD device\n");

	alt_up_character_lcd_init(lcd);

	while(1){
		enter = IORD_ALTERA_AVALON_PIO_DATA(ENTER_BASE);

		alt_up_character_lcd_set_cursor_pos(lcd, 0, 0);

		if(enter == 1){
			alt_up_character_lcd_string(lcd, l);
			incDec(0);
		} else{
			alt_up_character_lcd_string(lcd, y);
			incDec(1);
		}

		IOWR_ALTERA_AVALON_PIO_DATA(LED_R_BASE, IORD_ALTERA_AVALON_PIO_DATA(SW_BASE));

		usleep(100000);
	}

	return 0;
}
