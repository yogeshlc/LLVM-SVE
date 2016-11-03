// RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve < %s | FileCheck %s
// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR %s
ldnt1h  {z5.h}, p3/z, [x17, x16, lsl #1]  // 10100100-10010000-11001110-00100101
// CHECK: ldnt1h  {z5.h}, p3/z, [x17, x16, lsl #1] // encoding: [0x25,0xce,0x90,0xa4]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 10100100-10010000-11001110-00100101
LDNT1H  {Z5.H}, P3/Z, [X17, X16, LSL #1]  // 10100100-10010000-11001110-00100101
// CHECK: ldnt1h  {z5.h}, p3/z, [x17, x16, lsl #1] // encoding: [0x25,0xce,0x90,0xa4]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 10100100-10010000-11001110-00100101
ldnt1h  {z23.h}, p3/z, [x13, x8, lsl #1]  // 10100100-10001000-11001101-10110111
// CHECK: ldnt1h  {z23.h}, p3/z, [x13, x8, lsl #1] // encoding: [0xb7,0xcd,0x88,0xa4]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 10100100-10001000-11001101-10110111
LDNT1H  {Z23.H}, P3/Z, [X13, X8, LSL #1]  // 10100100-10001000-11001101-10110111
// CHECK: ldnt1h  {z23.h}, p3/z, [x13, x8, lsl #1] // encoding: [0xb7,0xcd,0x88,0xa4]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 10100100-10001000-11001101-10110111
ldnt1h  {z21.h}, p5/z, [x10, x21, lsl #1]  // 10100100-10010101-11010101-01010101
// CHECK: ldnt1h  {z21.h}, p5/z, [x10, x21, lsl #1] // encoding: [0x55,0xd5,0x95,0xa4]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 10100100-10010101-11010101-01010101
LDNT1H  {Z21.H}, P5/Z, [X10, X21, LSL #1]  // 10100100-10010101-11010101-01010101
// CHECK: ldnt1h  {z21.h}, p5/z, [x10, x21, lsl #1] // encoding: [0x55,0xd5,0x95,0xa4]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 10100100-10010101-11010101-01010101
ldnt1h  {z0.h}, p0/z, [x0, x0, lsl #1]  // 10100100-10000000-11000000-00000000
// CHECK: ldnt1h  {z0.h}, p0/z, [x0, x0, lsl #1] // encoding: [0x00,0xc0,0x80,0xa4]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 10100100-10000000-11000000-00000000
LDNT1H  {Z0.H}, P0/Z, [X0, X0, LSL #1]  // 10100100-10000000-11000000-00000000
// CHECK: ldnt1h  {z0.h}, p0/z, [x0, x0, lsl #1] // encoding: [0x00,0xc0,0x80,0xa4]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 10100100-10000000-11000000-00000000
