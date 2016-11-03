// RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve < %s | FileCheck %s
// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR %s
ld2d    {z21.d, z22.d}, p5/z, [x10, #10, mul vl]  // 10100101-10100101-11110101-01010101
// CHECK: ld2d    {z21.d, z22.d}, p5/z, [x10, #10, mul vl] // encoding: [0x55,0xf5,0xa5,0xa5]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 10100101-10100101-11110101-01010101
LD2D    {Z21.D, Z22.D}, P5/Z, [X10, #10, MUL VL]  // 10100101-10100101-11110101-01010101
// CHECK: ld2d    {z21.d, z22.d}, p5/z, [x10, #10, mul vl] // encoding: [0x55,0xf5,0xa5,0xa5]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 10100101-10100101-11110101-01010101
ld2d    {z0.d, z1.d}, p0/z, [x0]  // 10100101-10100000-11100000-00000000
// CHECK: ld2d    {z0.d, z1.d}, p0/z, [x0] // encoding: [0x00,0xe0,0xa0,0xa5]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 10100101-10100000-11100000-00000000
LD2D    {Z0.D, Z1.D}, P0/Z, [X0]  // 10100101-10100000-11100000-00000000
// CHECK: ld2d    {z0.d, z1.d}, p0/z, [x0] // encoding: [0x00,0xe0,0xa0,0xa5]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 10100101-10100000-11100000-00000000
ld2d    {z23.d, z24.d}, p3/z, [x13, #-16, mul vl]  // 10100101-10101000-11101101-10110111
// CHECK: ld2d    {z23.d, z24.d}, p3/z, [x13, #-16, mul vl] // encoding: [0xb7,0xed,0xa8,0xa5]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 10100101-10101000-11101101-10110111
LD2D    {Z23.D, Z24.D}, P3/Z, [X13, #-16, MUL VL]  // 10100101-10101000-11101101-10110111
// CHECK: ld2d    {z23.d, z24.d}, p3/z, [x13, #-16, mul vl] // encoding: [0xb7,0xed,0xa8,0xa5]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 10100101-10101000-11101101-10110111
ld2d    {z31.d, z0.d}, p7/z, [sp, #-2, mul vl]  // 10100101-10101111-11111111-11111111
// CHECK: ld2d    {z31.d, z0.d}, p7/z, [sp, #-2, mul vl] // encoding: [0xff,0xff,0xaf,0xa5]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 10100101-10101111-11111111-11111111
LD2D    {Z31.D, Z0.D}, P7/Z, [SP, #-2, MUL VL]  // 10100101-10101111-11111111-11111111
// CHECK: ld2d    {z31.d, z0.d}, p7/z, [sp, #-2, mul vl] // encoding: [0xff,0xff,0xaf,0xa5]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 10100101-10101111-11111111-11111111
