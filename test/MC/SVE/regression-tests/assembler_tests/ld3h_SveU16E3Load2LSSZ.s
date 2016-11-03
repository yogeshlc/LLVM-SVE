// RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve < %s | FileCheck %s
// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR %s
ld3h    {z0.h, z1.h, z2.h}, p0/z, [x0, x0, lsl #1]  // 10100100-11000000-11000000-00000000
// CHECK: ld3h    {z0.h, z1.h, z2.h}, p0/z, [x0, x0, lsl #1] // encoding: [0x00,0xc0,0xc0,0xa4]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 10100100-11000000-11000000-00000000
LD3H    {Z0.H, Z1.H, Z2.H}, P0/Z, [X0, X0, LSL #1]  // 10100100-11000000-11000000-00000000
// CHECK: ld3h    {z0.h, z1.h, z2.h}, p0/z, [x0, x0, lsl #1] // encoding: [0x00,0xc0,0xc0,0xa4]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 10100100-11000000-11000000-00000000
ld3h    {z21.h, z22.h, z23.h}, p5/z, [x10, x21, lsl #1]  // 10100100-11010101-11010101-01010101
// CHECK: ld3h    {z21.h, z22.h, z23.h}, p5/z, [x10, x21, lsl #1] // encoding: [0x55,0xd5,0xd5,0xa4]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 10100100-11010101-11010101-01010101
LD3H    {Z21.H, Z22.H, Z23.H}, P5/Z, [X10, X21, LSL #1]  // 10100100-11010101-11010101-01010101
// CHECK: ld3h    {z21.h, z22.h, z23.h}, p5/z, [x10, x21, lsl #1] // encoding: [0x55,0xd5,0xd5,0xa4]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 10100100-11010101-11010101-01010101
ld3h    {z5.h, z6.h, z7.h}, p3/z, [x17, x16, lsl #1]  // 10100100-11010000-11001110-00100101
// CHECK: ld3h    {z5.h, z6.h, z7.h}, p3/z, [x17, x16, lsl #1] // encoding: [0x25,0xce,0xd0,0xa4]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 10100100-11010000-11001110-00100101
LD3H    {Z5.H, Z6.H, Z7.H}, P3/Z, [X17, X16, LSL #1]  // 10100100-11010000-11001110-00100101
// CHECK: ld3h    {z5.h, z6.h, z7.h}, p3/z, [x17, x16, lsl #1] // encoding: [0x25,0xce,0xd0,0xa4]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 10100100-11010000-11001110-00100101
ld3h    {z23.h, z24.h, z25.h}, p3/z, [x13, x8, lsl #1]  // 10100100-11001000-11001101-10110111
// CHECK: ld3h    {z23.h, z24.h, z25.h}, p3/z, [x13, x8, lsl #1] // encoding: [0xb7,0xcd,0xc8,0xa4]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 10100100-11001000-11001101-10110111
LD3H    {Z23.H, Z24.H, Z25.H}, P3/Z, [X13, X8, LSL #1]  // 10100100-11001000-11001101-10110111
// CHECK: ld3h    {z23.h, z24.h, z25.h}, p3/z, [x13, x8, lsl #1] // encoding: [0xb7,0xcd,0xc8,0xa4]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 10100100-11001000-11001101-10110111
