// RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve < %s | FileCheck %s
// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR %s
asr     z23.b, z13.b, z8.d  // 00000100-00101000-10000001-10110111
// CHECK: asr     z23.b, z13.b, z8.d // encoding: [0xb7,0x81,0x28,0x04]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000100-00101000-10000001-10110111
ASR     Z23.B, Z13.B, Z8.D  // 00000100-00101000-10000001-10110111
// CHECK: asr     z23.b, z13.b, z8.d // encoding: [0xb7,0x81,0x28,0x04]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000100-00101000-10000001-10110111
asr     z0.b, z0.b, z0.d  // 00000100-00100000-10000000-00000000
// CHECK: asr     z0.b, z0.b, z0.d // encoding: [0x00,0x80,0x20,0x04]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000100-00100000-10000000-00000000
ASR     Z0.B, Z0.B, Z0.D  // 00000100-00100000-10000000-00000000
// CHECK: asr     z0.b, z0.b, z0.d // encoding: [0x00,0x80,0x20,0x04]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000100-00100000-10000000-00000000
asr     z21.b, z10.b, z21.d  // 00000100-00110101-10000001-01010101
// CHECK: asr     z21.b, z10.b, z21.d // encoding: [0x55,0x81,0x35,0x04]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000100-00110101-10000001-01010101
ASR     Z21.B, Z10.B, Z21.D  // 00000100-00110101-10000001-01010101
// CHECK: asr     z21.b, z10.b, z21.d // encoding: [0x55,0x81,0x35,0x04]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000100-00110101-10000001-01010101
asr     z31.b, z31.b, z31.d  // 00000100-00111111-10000011-11111111
// CHECK: asr     z31.b, z31.b, z31.d // encoding: [0xff,0x83,0x3f,0x04]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000100-00111111-10000011-11111111
ASR     Z31.B, Z31.B, Z31.D  // 00000100-00111111-10000011-11111111
// CHECK: asr     z31.b, z31.b, z31.d // encoding: [0xff,0x83,0x3f,0x04]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000100-00111111-10000011-11111111
