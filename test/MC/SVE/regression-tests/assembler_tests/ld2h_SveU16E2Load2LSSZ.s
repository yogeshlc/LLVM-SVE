// RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve < %s | FileCheck %s
// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR %s
ld2h    {z23.h, z24.h}, p3/z, [x13, x8, lsl #1]  // 10100100-10101000-11001101-10110111
// CHECK: ld2h    {z23.h, z24.h}, p3/z, [x13, x8, lsl #1] // encoding: [0xb7,0xcd,0xa8,0xa4]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 10100100-10101000-11001101-10110111
LD2H    {Z23.H, Z24.H}, P3/Z, [X13, X8, LSL #1]  // 10100100-10101000-11001101-10110111
// CHECK: ld2h    {z23.h, z24.h}, p3/z, [x13, x8, lsl #1] // encoding: [0xb7,0xcd,0xa8,0xa4]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 10100100-10101000-11001101-10110111
ld2h    {z0.h, z1.h}, p0/z, [x0, x0, lsl #1]  // 10100100-10100000-11000000-00000000
// CHECK: ld2h    {z0.h, z1.h}, p0/z, [x0, x0, lsl #1] // encoding: [0x00,0xc0,0xa0,0xa4]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 10100100-10100000-11000000-00000000
LD2H    {Z0.H, Z1.H}, P0/Z, [X0, X0, LSL #1]  // 10100100-10100000-11000000-00000000
// CHECK: ld2h    {z0.h, z1.h}, p0/z, [x0, x0, lsl #1] // encoding: [0x00,0xc0,0xa0,0xa4]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 10100100-10100000-11000000-00000000
ld2h    {z5.h, z6.h}, p3/z, [x17, x16, lsl #1]  // 10100100-10110000-11001110-00100101
// CHECK: ld2h    {z5.h, z6.h}, p3/z, [x17, x16, lsl #1] // encoding: [0x25,0xce,0xb0,0xa4]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 10100100-10110000-11001110-00100101
LD2H    {Z5.H, Z6.H}, P3/Z, [X17, X16, LSL #1]  // 10100100-10110000-11001110-00100101
// CHECK: ld2h    {z5.h, z6.h}, p3/z, [x17, x16, lsl #1] // encoding: [0x25,0xce,0xb0,0xa4]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 10100100-10110000-11001110-00100101
ld2h    {z21.h, z22.h}, p5/z, [x10, x21, lsl #1]  // 10100100-10110101-11010101-01010101
// CHECK: ld2h    {z21.h, z22.h}, p5/z, [x10, x21, lsl #1] // encoding: [0x55,0xd5,0xb5,0xa4]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 10100100-10110101-11010101-01010101
LD2H    {Z21.H, Z22.H}, P5/Z, [X10, X21, LSL #1]  // 10100100-10110101-11010101-01010101
// CHECK: ld2h    {z21.h, z22.h}, p5/z, [x10, x21, lsl #1] // encoding: [0x55,0xd5,0xb5,0xa4]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 10100100-10110101-11010101-01010101
