// RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve < %s | FileCheck %s
// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR %s
ld4w    {z0.s, z1.s, z2.s, z3.s}, p0/z, [x0, x0, lsl #2]  // 10100101-01100000-11000000-00000000
// CHECK: ld4w    {z0.s, z1.s, z2.s, z3.s}, p0/z, [x0, x0, lsl #2] // encoding: [0x00,0xc0,0x60,0xa5]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 10100101-01100000-11000000-00000000
LD4W    {Z0.S, Z1.S, Z2.S, Z3.S}, P0/Z, [X0, X0, LSL #2]  // 10100101-01100000-11000000-00000000
// CHECK: ld4w    {z0.s, z1.s, z2.s, z3.s}, p0/z, [x0, x0, lsl #2] // encoding: [0x00,0xc0,0x60,0xa5]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 10100101-01100000-11000000-00000000
ld4w    {z5.s, z6.s, z7.s, z8.s}, p3/z, [x17, x16, lsl #2]  // 10100101-01110000-11001110-00100101
// CHECK: ld4w    {z5.s, z6.s, z7.s, z8.s}, p3/z, [x17, x16, lsl #2] // encoding: [0x25,0xce,0x70,0xa5]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 10100101-01110000-11001110-00100101
LD4W    {Z5.S, Z6.S, Z7.S, Z8.S}, P3/Z, [X17, X16, LSL #2]  // 10100101-01110000-11001110-00100101
// CHECK: ld4w    {z5.s, z6.s, z7.s, z8.s}, p3/z, [x17, x16, lsl #2] // encoding: [0x25,0xce,0x70,0xa5]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 10100101-01110000-11001110-00100101
ld4w    {z23.s, z24.s, z25.s, z26.s}, p3/z, [x13, x8, lsl #2]  // 10100101-01101000-11001101-10110111
// CHECK: ld4w    {z23.s, z24.s, z25.s, z26.s}, p3/z, [x13, x8, lsl #2] // encoding: [0xb7,0xcd,0x68,0xa5]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 10100101-01101000-11001101-10110111
LD4W    {Z23.S, Z24.S, Z25.S, Z26.S}, P3/Z, [X13, X8, LSL #2]  // 10100101-01101000-11001101-10110111
// CHECK: ld4w    {z23.s, z24.s, z25.s, z26.s}, p3/z, [x13, x8, lsl #2] // encoding: [0xb7,0xcd,0x68,0xa5]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 10100101-01101000-11001101-10110111
ld4w    {z21.s, z22.s, z23.s, z24.s}, p5/z, [x10, x21, lsl #2]  // 10100101-01110101-11010101-01010101
// CHECK: ld4w    {z21.s, z22.s, z23.s, z24.s}, p5/z, [x10, x21, lsl #2] // encoding: [0x55,0xd5,0x75,0xa5]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 10100101-01110101-11010101-01010101
LD4W    {Z21.S, Z22.S, Z23.S, Z24.S}, P5/Z, [X10, X21, LSL #2]  // 10100101-01110101-11010101-01010101
// CHECK: ld4w    {z21.s, z22.s, z23.s, z24.s}, p5/z, [x10, x21, lsl #2] // encoding: [0x55,0xd5,0x75,0xa5]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 10100101-01110101-11010101-01010101
