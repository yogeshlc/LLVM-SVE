// RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve < %s | FileCheck %s
// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR %s
ld2d    {z5.d, z6.d}, p3/z, [x17, x16, lsl #3]  // 10100101-10110000-11001110-00100101
// CHECK: ld2d    {z5.d, z6.d}, p3/z, [x17, x16, lsl #3] // encoding: [0x25,0xce,0xb0,0xa5]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 10100101-10110000-11001110-00100101
LD2D    {Z5.D, Z6.D}, P3/Z, [X17, X16, LSL #3]  // 10100101-10110000-11001110-00100101
// CHECK: ld2d    {z5.d, z6.d}, p3/z, [x17, x16, lsl #3] // encoding: [0x25,0xce,0xb0,0xa5]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 10100101-10110000-11001110-00100101
ld2d    {z0.d, z1.d}, p0/z, [x0, x0, lsl #3]  // 10100101-10100000-11000000-00000000
// CHECK: ld2d    {z0.d, z1.d}, p0/z, [x0, x0, lsl #3] // encoding: [0x00,0xc0,0xa0,0xa5]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 10100101-10100000-11000000-00000000
LD2D    {Z0.D, Z1.D}, P0/Z, [X0, X0, LSL #3]  // 10100101-10100000-11000000-00000000
// CHECK: ld2d    {z0.d, z1.d}, p0/z, [x0, x0, lsl #3] // encoding: [0x00,0xc0,0xa0,0xa5]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 10100101-10100000-11000000-00000000
ld2d    {z23.d, z24.d}, p3/z, [x13, x8, lsl #3]  // 10100101-10101000-11001101-10110111
// CHECK: ld2d    {z23.d, z24.d}, p3/z, [x13, x8, lsl #3] // encoding: [0xb7,0xcd,0xa8,0xa5]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 10100101-10101000-11001101-10110111
LD2D    {Z23.D, Z24.D}, P3/Z, [X13, X8, LSL #3]  // 10100101-10101000-11001101-10110111
// CHECK: ld2d    {z23.d, z24.d}, p3/z, [x13, x8, lsl #3] // encoding: [0xb7,0xcd,0xa8,0xa5]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 10100101-10101000-11001101-10110111
ld2d    {z21.d, z22.d}, p5/z, [x10, x21, lsl #3]  // 10100101-10110101-11010101-01010101
// CHECK: ld2d    {z21.d, z22.d}, p5/z, [x10, x21, lsl #3] // encoding: [0x55,0xd5,0xb5,0xa5]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 10100101-10110101-11010101-01010101
LD2D    {Z21.D, Z22.D}, P5/Z, [X10, X21, LSL #3]  // 10100101-10110101-11010101-01010101
// CHECK: ld2d    {z21.d, z22.d}, p5/z, [x10, x21, lsl #3] // encoding: [0x55,0xd5,0xb5,0xa5]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 10100101-10110101-11010101-01010101
