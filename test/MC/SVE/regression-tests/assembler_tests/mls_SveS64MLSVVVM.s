// RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve < %s | FileCheck %s
// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR %s
mls     z23.d, p3/m, z13.d, z8.d  // 00000100-11001000-01101101-10110111
// CHECK: mls     z23.d, p3/m, z13.d, z8.d // encoding: [0xb7,0x6d,0xc8,0x04]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000100-11001000-01101101-10110111
MLS     Z23.D, P3/M, Z13.D, Z8.D  // 00000100-11001000-01101101-10110111
// CHECK: mls     z23.d, p3/m, z13.d, z8.d // encoding: [0xb7,0x6d,0xc8,0x04]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000100-11001000-01101101-10110111
mls     z21.d, p5/m, z10.d, z21.d  // 00000100-11010101-01110101-01010101
// CHECK: mls     z21.d, p5/m, z10.d, z21.d // encoding: [0x55,0x75,0xd5,0x04]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000100-11010101-01110101-01010101
MLS     Z21.D, P5/M, Z10.D, Z21.D  // 00000100-11010101-01110101-01010101
// CHECK: mls     z21.d, p5/m, z10.d, z21.d // encoding: [0x55,0x75,0xd5,0x04]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000100-11010101-01110101-01010101
mls     z0.d, p0/m, z0.d, z0.d  // 00000100-11000000-01100000-00000000
// CHECK: mls     z0.d, p0/m, z0.d, z0.d // encoding: [0x00,0x60,0xc0,0x04]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000100-11000000-01100000-00000000
MLS     Z0.D, P0/M, Z0.D, Z0.D  // 00000100-11000000-01100000-00000000
// CHECK: mls     z0.d, p0/m, z0.d, z0.d // encoding: [0x00,0x60,0xc0,0x04]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000100-11000000-01100000-00000000
mls     z31.d, p7/m, z31.d, z31.d  // 00000100-11011111-01111111-11111111
// CHECK: mls     z31.d, p7/m, z31.d, z31.d // encoding: [0xff,0x7f,0xdf,0x04]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000100-11011111-01111111-11111111
MLS     Z31.D, P7/M, Z31.D, Z31.D  // 00000100-11011111-01111111-11111111
// CHECK: mls     z31.d, p7/m, z31.d, z31.d // encoding: [0xff,0x7f,0xdf,0x04]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000100-11011111-01111111-11111111
