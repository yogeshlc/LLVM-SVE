// RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve < %s | FileCheck %s
// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR %s
neg     z0.s, p0/m, z0.s  // 00000100-10010111-10100000-00000000
// CHECK: neg     z0.s, p0/m, z0.s // encoding: [0x00,0xa0,0x97,0x04]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000100-10010111-10100000-00000000
NEG     Z0.S, P0/M, Z0.S  // 00000100-10010111-10100000-00000000
// CHECK: neg     z0.s, p0/m, z0.s // encoding: [0x00,0xa0,0x97,0x04]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000100-10010111-10100000-00000000
neg     z23.s, p3/m, z13.s  // 00000100-10010111-10101101-10110111
// CHECK: neg     z23.s, p3/m, z13.s // encoding: [0xb7,0xad,0x97,0x04]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000100-10010111-10101101-10110111
NEG     Z23.S, P3/M, Z13.S  // 00000100-10010111-10101101-10110111
// CHECK: neg     z23.s, p3/m, z13.s // encoding: [0xb7,0xad,0x97,0x04]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000100-10010111-10101101-10110111
neg     z21.s, p5/m, z10.s  // 00000100-10010111-10110101-01010101
// CHECK: neg     z21.s, p5/m, z10.s // encoding: [0x55,0xb5,0x97,0x04]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000100-10010111-10110101-01010101
NEG     Z21.S, P5/M, Z10.S  // 00000100-10010111-10110101-01010101
// CHECK: neg     z21.s, p5/m, z10.s // encoding: [0x55,0xb5,0x97,0x04]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000100-10010111-10110101-01010101
neg     z31.s, p7/m, z31.s  // 00000100-10010111-10111111-11111111
// CHECK: neg     z31.s, p7/m, z31.s // encoding: [0xff,0xbf,0x97,0x04]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000100-10010111-10111111-11111111
NEG     Z31.S, P7/M, Z31.S  // 00000100-10010111-10111111-11111111
// CHECK: neg     z31.s, p7/m, z31.s // encoding: [0xff,0xbf,0x97,0x04]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000100-10010111-10111111-11111111
