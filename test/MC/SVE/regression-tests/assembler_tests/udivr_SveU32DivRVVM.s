// RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve < %s | FileCheck %s
// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR %s
udivr   z31.s, p7/m, z31.s, z31.s  // 00000100-10010111-00011111-11111111
// CHECK: udivr   z31.s, p7/m, z31.s, z31.s // encoding: [0xff,0x1f,0x97,0x04]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000100-10010111-00011111-11111111
UDIVR   Z31.S, P7/M, Z31.S, Z31.S  // 00000100-10010111-00011111-11111111
// CHECK: udivr   z31.s, p7/m, z31.s, z31.s // encoding: [0xff,0x1f,0x97,0x04]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000100-10010111-00011111-11111111
udivr   z21.s, p5/m, z21.s, z10.s  // 00000100-10010111-00010101-01010101
// CHECK: udivr   z21.s, p5/m, z21.s, z10.s // encoding: [0x55,0x15,0x97,0x04]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000100-10010111-00010101-01010101
UDIVR   Z21.S, P5/M, Z21.S, Z10.S  // 00000100-10010111-00010101-01010101
// CHECK: udivr   z21.s, p5/m, z21.s, z10.s // encoding: [0x55,0x15,0x97,0x04]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000100-10010111-00010101-01010101
udivr   z0.s, p0/m, z0.s, z0.s  // 00000100-10010111-00000000-00000000
// CHECK: udivr   z0.s, p0/m, z0.s, z0.s // encoding: [0x00,0x00,0x97,0x04]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000100-10010111-00000000-00000000
UDIVR   Z0.S, P0/M, Z0.S, Z0.S  // 00000100-10010111-00000000-00000000
// CHECK: udivr   z0.s, p0/m, z0.s, z0.s // encoding: [0x00,0x00,0x97,0x04]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000100-10010111-00000000-00000000
udivr   z23.s, p3/m, z23.s, z13.s  // 00000100-10010111-00001101-10110111
// CHECK: udivr   z23.s, p3/m, z23.s, z13.s // encoding: [0xb7,0x0d,0x97,0x04]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000100-10010111-00001101-10110111
UDIVR   Z23.S, P3/M, Z23.S, Z13.S  // 00000100-10010111-00001101-10110111
// CHECK: udivr   z23.s, p3/m, z23.s, z13.s // encoding: [0xb7,0x0d,0x97,0x04]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000100-10010111-00001101-10110111
