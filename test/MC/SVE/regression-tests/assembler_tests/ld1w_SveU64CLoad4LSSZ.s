// RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve < %s | FileCheck %s
// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR %s
ld1w    {z23.d}, p3/z, [x13, x8, lsl #2]  // 10100101-01101000-01001101-10110111
// CHECK: ld1w    {z23.d}, p3/z, [x13, x8, lsl #2] // encoding: [0xb7,0x4d,0x68,0xa5]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 10100101-01101000-01001101-10110111
LD1W    {Z23.D}, P3/Z, [X13, X8, LSL #2]  // 10100101-01101000-01001101-10110111
// CHECK: ld1w    {z23.d}, p3/z, [x13, x8, lsl #2] // encoding: [0xb7,0x4d,0x68,0xa5]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 10100101-01101000-01001101-10110111
ld1w    {z21.d}, p5/z, [x10, x21, lsl #2]  // 10100101-01110101-01010101-01010101
// CHECK: ld1w    {z21.d}, p5/z, [x10, x21, lsl #2] // encoding: [0x55,0x55,0x75,0xa5]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 10100101-01110101-01010101-01010101
LD1W    {Z21.D}, P5/Z, [X10, X21, LSL #2]  // 10100101-01110101-01010101-01010101
// CHECK: ld1w    {z21.d}, p5/z, [x10, x21, lsl #2] // encoding: [0x55,0x55,0x75,0xa5]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 10100101-01110101-01010101-01010101
ld1w    {z5.d}, p3/z, [x17, x16, lsl #2]  // 10100101-01110000-01001110-00100101
// CHECK: ld1w    {z5.d}, p3/z, [x17, x16, lsl #2] // encoding: [0x25,0x4e,0x70,0xa5]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 10100101-01110000-01001110-00100101
LD1W    {Z5.D}, P3/Z, [X17, X16, LSL #2]  // 10100101-01110000-01001110-00100101
// CHECK: ld1w    {z5.d}, p3/z, [x17, x16, lsl #2] // encoding: [0x25,0x4e,0x70,0xa5]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 10100101-01110000-01001110-00100101
ld1w    {z0.d}, p0/z, [x0, x0, lsl #2]  // 10100101-01100000-01000000-00000000
// CHECK: ld1w    {z0.d}, p0/z, [x0, x0, lsl #2] // encoding: [0x00,0x40,0x60,0xa5]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 10100101-01100000-01000000-00000000
LD1W    {Z0.D}, P0/Z, [X0, X0, LSL #2]  // 10100101-01100000-01000000-00000000
// CHECK: ld1w    {z0.d}, p0/z, [x0, x0, lsl #2] // encoding: [0x00,0x40,0x60,0xa5]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 10100101-01100000-01000000-00000000
