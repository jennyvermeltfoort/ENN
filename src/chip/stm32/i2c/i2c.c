#include <stdint.h>
#include <stdio.h>

#include "i2c.h"

#include "i2c_reg.h"

void i2c_init(void) { printf("i2c init.\n"); }

void i2c_read(uint8_t size, uint8_t *data)
{
    (void)size;
    (void)data;

    uint16_t test = 0;
    uint16_t test2 = 0;

    test |= I2C_OAR1_ADDMODE_SET(BIT_SET);
    test2 = I2C_OAR1_ADDMODE_GET(test);

    printf("%d, %d\n", test, test2);
}

void i2c_write(uint8_t size, uint8_t *data)
{
    (void)size;
    (void)data;
}