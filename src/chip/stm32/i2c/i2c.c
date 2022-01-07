#include <stdint.h>
#include <stdio.h>

#include "i2c.h"

#define VMSR(_val, _mask, _shift) ((_val & _mask) >> _shift)
#define VMSL(_val, _mask, _shift) ((_val & _mask) << _shift)

#define CR1_PE_MASK 0X01U
#define CR1_PE_SHIFT 1

#define CR1_PE_SET(_val) VMSL(_val, CR1_PE_MASK, CR1_PE_SHIFT)
#define CR1_SMBUS_SET(_val) VMSL(_val, CR1_SMBUS_MASK, CR1_SMBUS_SHIFT)
#define CR1_SMBTYPE_SET(_val) VMSL(_val, CR1_SMBTYPE_MASK, CR1_SMBTYPE_SHIFT)
#define CR1_ENARP_SET(_val) VMSL(_val, CR1_ENARP_MASK, CR1_ENARP_SHIFT)
#define CR1_ENPEC_SET(_val) VMSL(_val, CR1_ENPEC_MASK, CR1_ENPEC_SHIFT)
#define CR1_ENGC_SET(_val) VMSL(_val, CR1_ENGC_MASK, CR1ENGCE_SHIFT)
#define CR1_PE_SET(_val) VMSL(_val, CR1_PE_MASK, CR1_PE_SHIFT)

void i2c_init(void) { printf("i2c init.\n"); }

void i2c_read(uint8_t size, uint8_t *data)
{
  (void)size;
  (void)data;
}

void i2c_write(uint8_t size, uint8_t *data)
{
  (void)size;
  (void)data;
}