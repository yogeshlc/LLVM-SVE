// RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve < %s | FileCheck %s
// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR %s
ldff1sh {z0.d}, p0/z, [x0, x0, lsl #1]  // 10100101-00000000-01100000-00000000
// CHECK: ldff1sh {z0.d}, p0/z, [x0, x0, lsl #1] // encoding: [0x00,0x60,0x00,0xa5]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 10100101-00000000-01100000-00000000
LDFF1SH {Z0.D}, P0/Z, [X0, X0, LSL #1]  // 10100101-00000000-01100000-00000000
// CHECK: ldff1sh {z0.d}, p0/z, [x0, x0, lsl #1] // encoding: [0x00,0x60,0x00,0xa5]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 10100101-00000000-01100000-00000000
ldff1sh {z31.d}, p7/z, [sp, xzr, lsl #1]  // 10100101-00011111-01111111-11111111
// CHECK: ldff1sh {z31.d}, p7/z, [sp, xzr, lsl #1] // encoding: [0xff,0x7f,0x1f,0xa5]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 10100101-00011111-01111111-11111111
LDFF1SH {Z31.D}, P7/Z, [SP, XZR, LSL #1]  // 10100101-00011111-01111111-11111111
// CHECK: ldff1sh {z31.d}, p7/z, [sp, xzr, lsl #1] // encoding: [0xff,0x7f,0x1f,0xa5]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 10100101-00011111-01111111-11111111
ldff1sh {z21.d}, p5/z, [x10, x21, lsl #1]  // 10100101-00010101-01110101-01010101
// CHECK: ldff1sh {z21.d}, p5/z, [x10, x21, lsl #1] // encoding: [0x55,0x75,0x15,0xa5]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 10100101-00010101-01110101-01010101
LDFF1SH {Z21.D}, P5/Z, [X10, X21, LSL #1]  // 10100101-00010101-01110101-01010101
// CHECK: ldff1sh {z21.d}, p5/z, [x10, x21, lsl #1] // encoding: [0x55,0x75,0x15,0xa5]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 10100101-00010101-01110101-01010101
ldff1sh {z23.d}, p3/z, [x13, x8, lsl #1]  // 10100101-00001000-01101101-10110111
// CHECK: ldff1sh {z23.d}, p3/z, [x13, x8, lsl #1] // encoding: [0xb7,0x6d,0x08,0xa5]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 10100101-00001000-01101101-10110111
LDFF1SH {Z23.D}, P3/Z, [X13, X8, LSL #1]  // 10100101-00001000-01101101-10110111
// CHECK: ldff1sh {z23.d}, p3/z, [x13, x8, lsl #1] // encoding: [0xb7,0x6d,0x08,0xa5]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 10100101-00001000-01101101-10110111
