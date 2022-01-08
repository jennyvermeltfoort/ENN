#ifndef __MACRO_H
#define __MACRO_H

#define VMSR(_val, _mask, _shift) ((_val >> _shift) & _mask)
#define VMSL(_val, _mask, _shift) ((_val & _mask) << _shift)

#define BIT_SET 1
#define BIT_UNSET 0

#endif /* __MACRO_H */