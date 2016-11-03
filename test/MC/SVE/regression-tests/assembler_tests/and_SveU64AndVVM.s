// RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve < %s | FileCheck %s
// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR %s
and     z31.d, p7/m, z31.d, z31.d  // 00000100-11011010-00011111-11111111
// CHECK: and     z31.d, p7/m, z31.d, z31.d // encoding: [0xff,0x1f,0xda,0x04]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000100-11011010-00011111-11111111
AND     Z31.D, P7/M, Z31.D, Z31.D  // 00000100-11011010-00011111-11111111
// CHECK: and     z31.d, p7/m, z31.d, z31.d // encoding: [0xff,0x1f,0xda,0x04]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000100-11011010-00011111-11111111
and     z21.d, p5/m, z21.d, z10.d  // 00000100-11011010-00010101-01010101
// CHECK: and     z21.d, p5/m, z21.d, z10.d // encoding: [0x55,0x15,0xda,0x04]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000100-11011010-00010101-01010101
AND     Z21.D, P5/M, Z21.D, Z10.D  // 00000100-11011010-00010101-01010101
// CHECK: and     z21.d, p5/m, z21.d, z10.d // encoding: [0x55,0x15,0xda,0x04]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000100-11011010-00010101-01010101
and     z23.d, p3/m, z23.d, z13.d  // 00000100-11011010-00001101-10110111
// CHECK: and     z23.d, p3/m, z23.d, z13.d // encoding: [0xb7,0x0d,0xda,0x04]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000100-11011010-00001101-10110111
AND     Z23.D, P3/M, Z23.D, Z13.D  // 00000100-11011010-00001101-10110111
// CHECK: and     z23.d, p3/m, z23.d, z13.d // encoding: [0xb7,0x0d,0xda,0x04]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000100-11011010-00001101-10110111
and     z0.d, p0/m, z0.d, z0.d  // 00000100-11011010-00000000-00000000
// CHECK: and     z0.d, p0/m, z0.d, z0.d // encoding: [0x00,0x00,0xda,0x04]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000100-11011010-00000000-00000000
AND     Z0.D, P0/M, Z0.D, Z0.D  // 00000100-11011010-00000000-00000000
// CHECK: and     z0.d, p0/m, z0.d, z0.d // encoding: [0x00,0x00,0xda,0x04]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000100-11011010-00000000-00000000
