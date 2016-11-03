// RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve < %s | FileCheck %s
// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR %s
ldff1sh {z23.d}, p3/z, [x13, z8.d, sxtw #1]  // 11000100-11101000-00101101-10110111
// CHECK: ldff1sh {z23.d}, p3/z, [x13, z8.d, sxtw #1] // encoding: [0xb7,0x2d,0xe8,0xc4]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 11000100-11101000-00101101-10110111
LDFF1SH {Z23.D}, P3/Z, [X13, Z8.D, SXTW #1]  // 11000100-11101000-00101101-10110111
// CHECK: ldff1sh {z23.d}, p3/z, [x13, z8.d, sxtw #1] // encoding: [0xb7,0x2d,0xe8,0xc4]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 11000100-11101000-00101101-10110111
ldff1sh {z31.d}, p7/z, [sp, z31.d, sxtw #1]  // 11000100-11111111-00111111-11111111
// CHECK: ldff1sh {z31.d}, p7/z, [sp, z31.d, sxtw #1] // encoding: [0xff,0x3f,0xff,0xc4]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 11000100-11111111-00111111-11111111
LDFF1SH {Z31.D}, P7/Z, [SP, Z31.D, SXTW #1]  // 11000100-11111111-00111111-11111111
// CHECK: ldff1sh {z31.d}, p7/z, [sp, z31.d, sxtw #1] // encoding: [0xff,0x3f,0xff,0xc4]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 11000100-11111111-00111111-11111111
ldff1sh {z0.d}, p0/z, [x0, z0.d, sxtw #1]  // 11000100-11100000-00100000-00000000
// CHECK: ldff1sh {z0.d}, p0/z, [x0, z0.d, sxtw #1] // encoding: [0x00,0x20,0xe0,0xc4]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 11000100-11100000-00100000-00000000
LDFF1SH {Z0.D}, P0/Z, [X0, Z0.D, SXTW #1]  // 11000100-11100000-00100000-00000000
// CHECK: ldff1sh {z0.d}, p0/z, [x0, z0.d, sxtw #1] // encoding: [0x00,0x20,0xe0,0xc4]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 11000100-11100000-00100000-00000000
ldff1sh {z21.d}, p5/z, [x10, z21.d, sxtw #1]  // 11000100-11110101-00110101-01010101
// CHECK: ldff1sh {z21.d}, p5/z, [x10, z21.d, sxtw #1] // encoding: [0x55,0x35,0xf5,0xc4]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 11000100-11110101-00110101-01010101
LDFF1SH {Z21.D}, P5/Z, [X10, Z21.D, SXTW #1]  // 11000100-11110101-00110101-01010101
// CHECK: ldff1sh {z21.d}, p5/z, [x10, z21.d, sxtw #1] // encoding: [0x55,0x35,0xf5,0xc4]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 11000100-11110101-00110101-01010101
