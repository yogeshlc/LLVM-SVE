// RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve < %s | FileCheck %s
// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR %s
fcvt    z0.s, p0/m, z0.h  // 01100101-10001001-10100000-00000000
// CHECK: fcvt    z0.s, p0/m, z0.h // encoding: [0x00,0xa0,0x89,0x65]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 01100101-10001001-10100000-00000000
FCVT    Z0.S, P0/M, Z0.H  // 01100101-10001001-10100000-00000000
// CHECK: fcvt    z0.s, p0/m, z0.h // encoding: [0x00,0xa0,0x89,0x65]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 01100101-10001001-10100000-00000000
fcvt    z31.s, p7/m, z31.h  // 01100101-10001001-10111111-11111111
// CHECK: fcvt    z31.s, p7/m, z31.h // encoding: [0xff,0xbf,0x89,0x65]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 01100101-10001001-10111111-11111111
FCVT    Z31.S, P7/M, Z31.H  // 01100101-10001001-10111111-11111111
// CHECK: fcvt    z31.s, p7/m, z31.h // encoding: [0xff,0xbf,0x89,0x65]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 01100101-10001001-10111111-11111111
fcvt    z23.s, p3/m, z13.h  // 01100101-10001001-10101101-10110111
// CHECK: fcvt    z23.s, p3/m, z13.h // encoding: [0xb7,0xad,0x89,0x65]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 01100101-10001001-10101101-10110111
FCVT    Z23.S, P3/M, Z13.H  // 01100101-10001001-10101101-10110111
// CHECK: fcvt    z23.s, p3/m, z13.h // encoding: [0xb7,0xad,0x89,0x65]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 01100101-10001001-10101101-10110111
fcvt    z21.s, p5/m, z10.h  // 01100101-10001001-10110101-01010101
// CHECK: fcvt    z21.s, p5/m, z10.h // encoding: [0x55,0xb5,0x89,0x65]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 01100101-10001001-10110101-01010101
FCVT    Z21.S, P5/M, Z10.H  // 01100101-10001001-10110101-01010101
// CHECK: fcvt    z21.s, p5/m, z10.h // encoding: [0x55,0xb5,0x89,0x65]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 01100101-10001001-10110101-01010101
