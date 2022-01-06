
#ifndef __SPI_H
#define __SPI_H

void spi_init(void);
void spi_read(uint8_t size, uint8_t * data);
void spi_write(uint8_t size, uint8_t * data);

#endif /* __SPI_H */