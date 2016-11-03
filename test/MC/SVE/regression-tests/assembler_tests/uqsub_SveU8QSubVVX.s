// RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve < %s | FileCheck %s
// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR %s
uqsub   z23.b, z13.b, z8.b  // 00000100-00101000-00011101-10110111
// CHECK: uqsub   z23.b, z13.b, z8.b // encoding: [0xb7,0x1d,0x28,0x04]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000100-00101000-00011101-10110111
UQSUB   Z23.B, Z13.B, Z8.B  // 00000100-00101000-00011101-10110111
// CHECK: uqsub   z23.b, z13.b, z8.b // encoding: [0xb7,0x1d,0x28,0x04]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000100-00101000-00011101-10110111
uqsub   z31.b, z31.b, z31.b  // 00000100-00111111-00011111-11111111
// CHECK: uqsub   z31.b, z31.b, z31.b // encoding: [0xff,0x1f,0x3f,0x04]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000100-00111111-00011111-11111111
UQSUB   Z31.B, Z31.B, Z31.B  // 00000100-00111111-00011111-11111111
// CHECK: uqsub   z31.b, z31.b, z31.b // encoding: [0xff,0x1f,0x3f,0x04]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000100-00111111-00011111-11111111
uqsub   z0.b, z0.b, z0.b  // 00000100-00100000-00011100-00000000
// CHECK: uqsub   z0.b, z0.b, z0.b // encoding: [0x00,0x1c,0x20,0x04]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000100-00100000-00011100-00000000
UQSUB   Z0.B, Z0.B, Z0.B  // 00000100-00100000-00011100-00000000
// CHECK: uqsub   z0.b, z0.b, z0.b // encoding: [0x00,0x1c,0x20,0x04]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000100-00100000-00011100-00000000
uqsub   z21.b, z10.b, z21.b  // 00000100-00110101-00011101-01010101
// CHECK: uqsub   z21.b, z10.b, z21.b // encoding: [0x55,0x1d,0x35,0x04]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000100-00110101-00011101-01010101
UQSUB   Z21.B, Z10.B, Z21.B  // 00000100-00110101-00011101-01010101
// CHECK: uqsub   z21.b, z10.b, z21.b // encoding: [0x55,0x1d,0x35,0x04]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000100-00110101-00011101-01010101
