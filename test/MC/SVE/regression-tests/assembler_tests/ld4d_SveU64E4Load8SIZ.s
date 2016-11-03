// RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve < %s | FileCheck %s
// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR %s
ld4d    {z21.d, z22.d, z23.d, z24.d}, p5/z, [x10, #20, mul vl]  // 10100101-11100101-11110101-01010101
// CHECK: ld4d    {z21.d, z22.d, z23.d, z24.d}, p5/z, [x10, #20, mul vl] // encoding: [0x55,0xf5,0xe5,0xa5]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 10100101-11100101-11110101-01010101
LD4D    {Z21.D, Z22.D, Z23.D, Z24.D}, P5/Z, [X10, #20, MUL VL]  // 10100101-11100101-11110101-01010101
// CHECK: ld4d    {z21.d, z22.d, z23.d, z24.d}, p5/z, [x10, #20, mul vl] // encoding: [0x55,0xf5,0xe5,0xa5]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 10100101-11100101-11110101-01010101
ld4d    {z23.d, z24.d, z25.d, z26.d}, p3/z, [x13, #-32, mul vl]  // 10100101-11101000-11101101-10110111
// CHECK: ld4d    {z23.d, z24.d, z25.d, z26.d}, p3/z, [x13, #-32, mul vl] // encoding: [0xb7,0xed,0xe8,0xa5]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 10100101-11101000-11101101-10110111
LD4D    {Z23.D, Z24.D, Z25.D, Z26.D}, P3/Z, [X13, #-32, MUL VL]  // 10100101-11101000-11101101-10110111
// CHECK: ld4d    {z23.d, z24.d, z25.d, z26.d}, p3/z, [x13, #-32, mul vl] // encoding: [0xb7,0xed,0xe8,0xa5]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 10100101-11101000-11101101-10110111
ld4d    {z31.d, z0.d, z1.d, z2.d}, p7/z, [sp, #-4, mul vl]  // 10100101-11101111-11111111-11111111
// CHECK: ld4d    {z31.d, z0.d, z1.d, z2.d}, p7/z, [sp, #-4, mul vl] // encoding: [0xff,0xff,0xef,0xa5]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 10100101-11101111-11111111-11111111
LD4D    {Z31.D, Z0.D, Z1.D, Z2.D}, P7/Z, [SP, #-4, MUL VL]  // 10100101-11101111-11111111-11111111
// CHECK: ld4d    {z31.d, z0.d, z1.d, z2.d}, p7/z, [sp, #-4, mul vl] // encoding: [0xff,0xff,0xef,0xa5]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 10100101-11101111-11111111-11111111
ld4d    {z0.d, z1.d, z2.d, z3.d}, p0/z, [x0]  // 10100101-11100000-11100000-00000000
// CHECK: ld4d    {z0.d, z1.d, z2.d, z3.d}, p0/z, [x0] // encoding: [0x00,0xe0,0xe0,0xa5]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 10100101-11100000-11100000-00000000
LD4D    {Z0.D, Z1.D, Z2.D, Z3.D}, P0/Z, [X0]  // 10100101-11100000-11100000-00000000
// CHECK: ld4d    {z0.d, z1.d, z2.d, z3.d}, p0/z, [x0] // encoding: [0x00,0xe0,0xe0,0xa5]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 10100101-11100000-11100000-00000000
