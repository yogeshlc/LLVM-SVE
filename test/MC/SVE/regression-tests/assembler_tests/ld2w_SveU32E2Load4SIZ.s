// RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve < %s | FileCheck %s
// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR %s
ld2w    {z0.s, z1.s}, p0/z, [x0]  // 10100101-00100000-11100000-00000000
// CHECK: ld2w    {z0.s, z1.s}, p0/z, [x0] // encoding: [0x00,0xe0,0x20,0xa5]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 10100101-00100000-11100000-00000000
LD2W    {Z0.S, Z1.S}, P0/Z, [X0]  // 10100101-00100000-11100000-00000000
// CHECK: ld2w    {z0.s, z1.s}, p0/z, [x0] // encoding: [0x00,0xe0,0x20,0xa5]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 10100101-00100000-11100000-00000000
ld2w    {z31.s, z0.s}, p7/z, [sp, #-2, mul vl]  // 10100101-00101111-11111111-11111111
// CHECK: ld2w    {z31.s, z0.s}, p7/z, [sp, #-2, mul vl] // encoding: [0xff,0xff,0x2f,0xa5]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 10100101-00101111-11111111-11111111
LD2W    {Z31.S, Z0.S}, P7/Z, [SP, #-2, MUL VL]  // 10100101-00101111-11111111-11111111
// CHECK: ld2w    {z31.s, z0.s}, p7/z, [sp, #-2, mul vl] // encoding: [0xff,0xff,0x2f,0xa5]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 10100101-00101111-11111111-11111111
ld2w    {z21.s, z22.s}, p5/z, [x10, #10, mul vl]  // 10100101-00100101-11110101-01010101
// CHECK: ld2w    {z21.s, z22.s}, p5/z, [x10, #10, mul vl] // encoding: [0x55,0xf5,0x25,0xa5]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 10100101-00100101-11110101-01010101
LD2W    {Z21.S, Z22.S}, P5/Z, [X10, #10, MUL VL]  // 10100101-00100101-11110101-01010101
// CHECK: ld2w    {z21.s, z22.s}, p5/z, [x10, #10, mul vl] // encoding: [0x55,0xf5,0x25,0xa5]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 10100101-00100101-11110101-01010101
ld2w    {z23.s, z24.s}, p3/z, [x13, #-16, mul vl]  // 10100101-00101000-11101101-10110111
// CHECK: ld2w    {z23.s, z24.s}, p3/z, [x13, #-16, mul vl] // encoding: [0xb7,0xed,0x28,0xa5]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 10100101-00101000-11101101-10110111
LD2W    {Z23.S, Z24.S}, P3/Z, [X13, #-16, MUL VL]  // 10100101-00101000-11101101-10110111
// CHECK: ld2w    {z23.s, z24.s}, p3/z, [x13, #-16, mul vl] // encoding: [0xb7,0xed,0x28,0xa5]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 10100101-00101000-11101101-10110111
