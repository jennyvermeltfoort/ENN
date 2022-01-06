#include <stdio.h>
#include <stdint.h>

#include "i2c.h"

void i2c_init(void)
{
    printf("i2c init.\n");
}


void i2c_write(uint8_t size, uint8_t * data)
{
    (void) size;
    (void) data;
}