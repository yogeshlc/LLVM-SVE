// RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve < %s | FileCheck %s
// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR %s
ldff1h  {z0.h}, p0/z, [x0, x0, lsl #1]  // 10100100-10100000-01100000-00000000
// CHECK: ldff1h  {z0.h}, p0/z, [x0, x0, lsl #1] // encoding: [0x00,0x60,0xa0,0xa4]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 10100100-10100000-01100000-00000000
LDFF1H  {Z0.H}, P0/Z, [X0, X0, LSL #1]  // 10100100-10100000-01100000-00000000
// CHECK: ldff1h  {z0.h}, p0/z, [x0, x0, lsl #1] // encoding: [0x00,0x60,0xa0,0xa4]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 10100100-10100000-01100000-00000000
ldff1h  {z21.h}, p5/z, [x10, x21, lsl #1]  // 10100100-10110101-01110101-01010101
// CHECK: ldff1h  {z21.h}, p5/z, [x10, x21, lsl #1] // encoding: [0x55,0x75,0xb5,0xa4]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 10100100-10110101-01110101-01010101
LDFF1H  {Z21.H}, P5/Z, [X10, X21, LSL #1]  // 10100100-10110101-01110101-01010101
// CHECK: ldff1h  {z21.h}, p5/z, [x10, x21, lsl #1] // encoding: [0x55,0x75,0xb5,0xa4]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 10100100-10110101-01110101-01010101
ldff1h  {z23.h}, p3/z, [x13, x8, lsl #1]  // 10100100-10101000-01101101-10110111
// CHECK: ldff1h  {z23.h}, p3/z, [x13, x8, lsl #1] // encoding: [0xb7,0x6d,0xa8,0xa4]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 10100100-10101000-01101101-10110111
LDFF1H  {Z23.H}, P3/Z, [X13, X8, LSL #1]  // 10100100-10101000-01101101-10110111
// CHECK: ldff1h  {z23.h}, p3/z, [x13, x8, lsl #1] // encoding: [0xb7,0x6d,0xa8,0xa4]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 10100100-10101000-01101101-10110111
ldff1h  {z31.h}, p7/z, [sp, xzr, lsl #1]  // 10100100-10111111-01111111-11111111
// CHECK: ldff1h  {z31.h}, p7/z, [sp, xzr, lsl #1] // encoding: [0xff,0x7f,0xbf,0xa4]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 10100100-10111111-01111111-11111111
LDFF1H  {Z31.H}, P7/Z, [SP, XZR, LSL #1]  // 10100100-10111111-01111111-11111111
// CHECK: ldff1h  {z31.h}, p7/z, [sp, xzr, lsl #1] // encoding: [0xff,0x7f,0xbf,0xa4]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 10100100-10111111-01111111-11111111
