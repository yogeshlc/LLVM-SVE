// RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve < %s | FileCheck %s
// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR %s
ld2b    {z31.b, z0.b}, p7/z, [sp, #-2, mul vl]  // 10100100-00101111-11111111-11111111
// CHECK: ld2b    {z31.b, z0.b}, p7/z, [sp, #-2, mul vl] // encoding: [0xff,0xff,0x2f,0xa4]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 10100100-00101111-11111111-11111111
LD2B    {Z31.B, Z0.B}, P7/Z, [SP, #-2, MUL VL]  // 10100100-00101111-11111111-11111111
// CHECK: ld2b    {z31.b, z0.b}, p7/z, [sp, #-2, mul vl] // encoding: [0xff,0xff,0x2f,0xa4]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 10100100-00101111-11111111-11111111
ld2b    {z21.b, z22.b}, p5/z, [x10, #10, mul vl]  // 10100100-00100101-11110101-01010101
// CHECK: ld2b    {z21.b, z22.b}, p5/z, [x10, #10, mul vl] // encoding: [0x55,0xf5,0x25,0xa4]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 10100100-00100101-11110101-01010101
LD2B    {Z21.B, Z22.B}, P5/Z, [X10, #10, MUL VL]  // 10100100-00100101-11110101-01010101
// CHECK: ld2b    {z21.b, z22.b}, p5/z, [x10, #10, mul vl] // encoding: [0x55,0xf5,0x25,0xa4]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 10100100-00100101-11110101-01010101
ld2b    {z0.b, z1.b}, p0/z, [x0]  // 10100100-00100000-11100000-00000000
// CHECK: ld2b    {z0.b, z1.b}, p0/z, [x0] // encoding: [0x00,0xe0,0x20,0xa4]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 10100100-00100000-11100000-00000000
LD2B    {Z0.B, Z1.B}, P0/Z, [X0]  // 10100100-00100000-11100000-00000000
// CHECK: ld2b    {z0.b, z1.b}, p0/z, [x0] // encoding: [0x00,0xe0,0x20,0xa4]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 10100100-00100000-11100000-00000000
ld2b    {z23.b, z24.b}, p3/z, [x13, #-16, mul vl]  // 10100100-00101000-11101101-10110111
// CHECK: ld2b    {z23.b, z24.b}, p3/z, [x13, #-16, mul vl] // encoding: [0xb7,0xed,0x28,0xa4]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 10100100-00101000-11101101-10110111
LD2B    {Z23.B, Z24.B}, P3/Z, [X13, #-16, MUL VL]  // 10100100-00101000-11101101-10110111
// CHECK: ld2b    {z23.b, z24.b}, p3/z, [x13, #-16, mul vl] // encoding: [0xb7,0xed,0x28,0xa4]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 10100100-00101000-11101101-10110111
