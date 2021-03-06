// RUN: llvm-mc -triple=aarch64-none-linux-gnu  -mattr=+sve < %s | FileCheck %s
// RUN: not llvm-mc -triple=aarch64-none-linux-gnu  -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR %s
dupm    z23.h, #0xfff9  // 00000101-11000000-11101101-10110111
// CHECK: dupm    z23.h, #0xfff9
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000101-11000000-11101101-10110111
DUPM    Z23.H, #0xFFF9  // 00000101-11000000-11101101-10110111
// CHECK: dupm    z23.h, #0xfff9
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000101-11000000-11101101-10110111
dupm    z5.b, #0x81  // 00000101-11000000-00001110-00100101
// CHECK: dupm    z5.b, #0x81
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000101-11000000-00001110-00100101
DUPM    Z5.B, #0x81  // 00000101-11000000-00001110-00100101
// CHECK: dupm    z5.b, #0x81
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000101-11000000-00001110-00100101
dupm    z0.d, #0xe0000000000003ff  // 00000101-11000010-00011001-10000000
// CHECK: mov     z0.d, #0xe0000000000003ff
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000101-11000010-00011001-10000000
DUPM    Z0.D, #0xE0000000000003FF  // 00000101-11000010-00011001-10000000
// CHECK: mov     z0.d, #0xe0000000000003ff
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000101-11000010-00011001-10000000
dupm    z1.d, #0xffff00000003ffff  // 00000101-11000010-10000100-00100001
// CHECK: mov     z1.d, #0xffff00000003ffff
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000101-11000010-10000100-00100001
DUPM    Z1.D, #0xFFFF00000003FFFF  // 00000101-11000010-10000100-00100001
// CHECK: mov     z1.d, #0xffff00000003ffff
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000101-11000010-10000100-00100001
dupm    z21.h, #0xffc1  // 00000101-11000001-01010101-01010101
// CHECK: dupm    z21.h, #0xffc1
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000101-11000001-01010101-01010101
DUPM    Z21.H, #0xFFC1  // 00000101-11000001-01010101-01010101
// CHECK: dupm    z21.h, #0xffc1
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000101-11000001-01010101-01010101
dupm    z0.s, #0x1  // 00000101-11000000-00000000-00000000
// CHECK: dupm    z0.s, #0x1
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000101-11000000-00000000-00000000
DUPM    Z0.S, #0x1  // 00000101-11000000-00000000-00000000
// CHECK: dupm    z0.s, #0x1
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000101-11000000-00000000-00000000
