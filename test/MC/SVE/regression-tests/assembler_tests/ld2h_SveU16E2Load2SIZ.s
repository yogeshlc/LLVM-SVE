// RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve < %s | FileCheck %s
// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR %s
ld2h    {z23.h, z24.h}, p3/z, [x13, #-16, mul vl]  // 10100100-10101000-11101101-10110111
// CHECK: ld2h    {z23.h, z24.h}, p3/z, [x13, #-16, mul vl] // encoding: [0xb7,0xed,0xa8,0xa4]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 10100100-10101000-11101101-10110111
LD2H    {Z23.H, Z24.H}, P3/Z, [X13, #-16, MUL VL]  // 10100100-10101000-11101101-10110111
// CHECK: ld2h    {z23.h, z24.h}, p3/z, [x13, #-16, mul vl] // encoding: [0xb7,0xed,0xa8,0xa4]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 10100100-10101000-11101101-10110111
ld2h    {z21.h, z22.h}, p5/z, [x10, #10, mul vl]  // 10100100-10100101-11110101-01010101
// CHECK: ld2h    {z21.h, z22.h}, p5/z, [x10, #10, mul vl] // encoding: [0x55,0xf5,0xa5,0xa4]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 10100100-10100101-11110101-01010101
LD2H    {Z21.H, Z22.H}, P5/Z, [X10, #10, MUL VL]  // 10100100-10100101-11110101-01010101
// CHECK: ld2h    {z21.h, z22.h}, p5/z, [x10, #10, mul vl] // encoding: [0x55,0xf5,0xa5,0xa4]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 10100100-10100101-11110101-01010101
ld2h    {z31.h, z0.h}, p7/z, [sp, #-2, mul vl]  // 10100100-10101111-11111111-11111111
// CHECK: ld2h    {z31.h, z0.h}, p7/z, [sp, #-2, mul vl] // encoding: [0xff,0xff,0xaf,0xa4]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 10100100-10101111-11111111-11111111
LD2H    {Z31.H, Z0.H}, P7/Z, [SP, #-2, MUL VL]  // 10100100-10101111-11111111-11111111
// CHECK: ld2h    {z31.h, z0.h}, p7/z, [sp, #-2, mul vl] // encoding: [0xff,0xff,0xaf,0xa4]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 10100100-10101111-11111111-11111111
ld2h    {z0.h, z1.h}, p0/z, [x0]  // 10100100-10100000-11100000-00000000
// CHECK: ld2h    {z0.h, z1.h}, p0/z, [x0] // encoding: [0x00,0xe0,0xa0,0xa4]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 10100100-10100000-11100000-00000000
LD2H    {Z0.H, Z1.H}, P0/Z, [X0]  // 10100100-10100000-11100000-00000000
// CHECK: ld2h    {z0.h, z1.h}, p0/z, [x0] // encoding: [0x00,0xe0,0xa0,0xa4]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 10100100-10100000-11100000-00000000
