// RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve < %s | FileCheck %s
// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR %s
fmsb    z23.d, p3/m, z13.d, z8.d  // 01100101-11101000-10101101-10110111
// CHECK: fmsb    z23.d, p3/m, z13.d, z8.d // encoding: [0xb7,0xad,0xe8,0x65]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 01100101-11101000-10101101-10110111
FMSB    Z23.D, P3/M, Z13.D, Z8.D  // 01100101-11101000-10101101-10110111
// CHECK: fmsb    z23.d, p3/m, z13.d, z8.d // encoding: [0xb7,0xad,0xe8,0x65]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 01100101-11101000-10101101-10110111
fmsb    z0.d, p0/m, z0.d, z0.d  // 01100101-11100000-10100000-00000000
// CHECK: fmsb    z0.d, p0/m, z0.d, z0.d // encoding: [0x00,0xa0,0xe0,0x65]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 01100101-11100000-10100000-00000000
FMSB    Z0.D, P0/M, Z0.D, Z0.D  // 01100101-11100000-10100000-00000000
// CHECK: fmsb    z0.d, p0/m, z0.d, z0.d // encoding: [0x00,0xa0,0xe0,0x65]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 01100101-11100000-10100000-00000000
fmsb    z31.d, p7/m, z31.d, z31.d  // 01100101-11111111-10111111-11111111
// CHECK: fmsb    z31.d, p7/m, z31.d, z31.d // encoding: [0xff,0xbf,0xff,0x65]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 01100101-11111111-10111111-11111111
FMSB    Z31.D, P7/M, Z31.D, Z31.D  // 01100101-11111111-10111111-11111111
// CHECK: fmsb    z31.d, p7/m, z31.d, z31.d // encoding: [0xff,0xbf,0xff,0x65]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 01100101-11111111-10111111-11111111
fmsb    z21.d, p5/m, z10.d, z21.d  // 01100101-11110101-10110101-01010101
// CHECK: fmsb    z21.d, p5/m, z10.d, z21.d // encoding: [0x55,0xb5,0xf5,0x65]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 01100101-11110101-10110101-01010101
FMSB    Z21.D, P5/M, Z10.D, Z21.D  // 01100101-11110101-10110101-01010101
// CHECK: fmsb    z21.d, p5/m, z10.d, z21.d // encoding: [0x55,0xb5,0xf5,0x65]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 01100101-11110101-10110101-01010101
