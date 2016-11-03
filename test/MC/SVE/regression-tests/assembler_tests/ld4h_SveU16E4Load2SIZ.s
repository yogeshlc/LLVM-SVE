// RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve < %s | FileCheck %s
// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR %s
ld4h    {z31.h, z0.h, z1.h, z2.h}, p7/z, [sp, #-4, mul vl]  // 10100100-11101111-11111111-11111111
// CHECK: ld4h    {z31.h, z0.h, z1.h, z2.h}, p7/z, [sp, #-4, mul vl] // encoding: [0xff,0xff,0xef,0xa4]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 10100100-11101111-11111111-11111111
LD4H    {Z31.H, Z0.H, Z1.H, Z2.H}, P7/Z, [SP, #-4, MUL VL]  // 10100100-11101111-11111111-11111111
// CHECK: ld4h    {z31.h, z0.h, z1.h, z2.h}, p7/z, [sp, #-4, mul vl] // encoding: [0xff,0xff,0xef,0xa4]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 10100100-11101111-11111111-11111111
ld4h    {z23.h, z24.h, z25.h, z26.h}, p3/z, [x13, #-32, mul vl]  // 10100100-11101000-11101101-10110111
// CHECK: ld4h    {z23.h, z24.h, z25.h, z26.h}, p3/z, [x13, #-32, mul vl] // encoding: [0xb7,0xed,0xe8,0xa4]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 10100100-11101000-11101101-10110111
LD4H    {Z23.H, Z24.H, Z25.H, Z26.H}, P3/Z, [X13, #-32, MUL VL]  // 10100100-11101000-11101101-10110111
// CHECK: ld4h    {z23.h, z24.h, z25.h, z26.h}, p3/z, [x13, #-32, mul vl] // encoding: [0xb7,0xed,0xe8,0xa4]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 10100100-11101000-11101101-10110111
ld4h    {z0.h, z1.h, z2.h, z3.h}, p0/z, [x0]  // 10100100-11100000-11100000-00000000
// CHECK: ld4h    {z0.h, z1.h, z2.h, z3.h}, p0/z, [x0] // encoding: [0x00,0xe0,0xe0,0xa4]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 10100100-11100000-11100000-00000000
LD4H    {Z0.H, Z1.H, Z2.H, Z3.H}, P0/Z, [X0]  // 10100100-11100000-11100000-00000000
// CHECK: ld4h    {z0.h, z1.h, z2.h, z3.h}, p0/z, [x0] // encoding: [0x00,0xe0,0xe0,0xa4]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 10100100-11100000-11100000-00000000
ld4h    {z21.h, z22.h, z23.h, z24.h}, p5/z, [x10, #20, mul vl]  // 10100100-11100101-11110101-01010101
// CHECK: ld4h    {z21.h, z22.h, z23.h, z24.h}, p5/z, [x10, #20, mul vl] // encoding: [0x55,0xf5,0xe5,0xa4]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 10100100-11100101-11110101-01010101
LD4H    {Z21.H, Z22.H, Z23.H, Z24.H}, P5/Z, [X10, #20, MUL VL]  // 10100100-11100101-11110101-01010101
// CHECK: ld4h    {z21.h, z22.h, z23.h, z24.h}, p5/z, [x10, #20, mul vl] // encoding: [0x55,0xf5,0xe5,0xa4]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 10100100-11100101-11110101-01010101
