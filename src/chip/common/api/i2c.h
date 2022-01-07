#ifndef __I2C_H
#define __I2C_H

void i2c_init(void);
void i2c_read(uint8_t size, uint8_t * data);
void i2c_write(uint8_t size, uint8_t * data);

#endif /* __I2C_H */