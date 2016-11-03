// RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve < %s | FileCheck %s
// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR %s
ldff1h  {z0.d}, p0/z, [x0, z0.d, sxtw #1]  // 11000100-11100000-01100000-00000000
// CHECK: ldff1h  {z0.d}, p0/z, [x0, z0.d, sxtw #1] // encoding: [0x00,0x60,0xe0,0xc4]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 11000100-11100000-01100000-00000000
LDFF1H  {Z0.D}, P0/Z, [X0, Z0.D, SXTW #1]  // 11000100-11100000-01100000-00000000
// CHECK: ldff1h  {z0.d}, p0/z, [x0, z0.d, sxtw #1] // encoding: [0x00,0x60,0xe0,0xc4]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 11000100-11100000-01100000-00000000
ldff1h  {z23.d}, p3/z, [x13, z8.d, sxtw #1]  // 11000100-11101000-01101101-10110111
// CHECK: ldff1h  {z23.d}, p3/z, [x13, z8.d, sxtw #1] // encoding: [0xb7,0x6d,0xe8,0xc4]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 11000100-11101000-01101101-10110111
LDFF1H  {Z23.D}, P3/Z, [X13, Z8.D, SXTW #1]  // 11000100-11101000-01101101-10110111
// CHECK: ldff1h  {z23.d}, p3/z, [x13, z8.d, sxtw #1] // encoding: [0xb7,0x6d,0xe8,0xc4]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 11000100-11101000-01101101-10110111
ldff1h  {z31.d}, p7/z, [sp, z31.d, sxtw #1]  // 11000100-11111111-01111111-11111111
// CHECK: ldff1h  {z31.d}, p7/z, [sp, z31.d, sxtw #1] // encoding: [0xff,0x7f,0xff,0xc4]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 11000100-11111111-01111111-11111111
LDFF1H  {Z31.D}, P7/Z, [SP, Z31.D, SXTW #1]  // 11000100-11111111-01111111-11111111
// CHECK: ldff1h  {z31.d}, p7/z, [sp, z31.d, sxtw #1] // encoding: [0xff,0x7f,0xff,0xc4]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 11000100-11111111-01111111-11111111
ldff1h  {z21.d}, p5/z, [x10, z21.d, sxtw #1]  // 11000100-11110101-01110101-01010101
// CHECK: ldff1h  {z21.d}, p5/z, [x10, z21.d, sxtw #1] // encoding: [0x55,0x75,0xf5,0xc4]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 11000100-11110101-01110101-01010101
LDFF1H  {Z21.D}, P5/Z, [X10, Z21.D, SXTW #1]  // 11000100-11110101-01110101-01010101
// CHECK: ldff1h  {z21.d}, p5/z, [x10, z21.d, sxtw #1] // encoding: [0x55,0x75,0xf5,0xc4]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 11000100-11110101-01110101-01010101
