// RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve < %s | FileCheck %s
// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR %s
asr     z23.b, z13.b, #8  // 00000100-00101000-10010001-10110111
// CHECK: asr     z23.b, z13.b, #8 // encoding: [0xb7,0x91,0x28,0x04]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000100-00101000-10010001-10110111
ASR     Z23.B, Z13.B, #8  // 00000100-00101000-10010001-10110111
// CHECK: asr     z23.b, z13.b, #8 // encoding: [0xb7,0x91,0x28,0x04]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000100-00101000-10010001-10110111
asr     z21.b, z10.b, #3  // 00000100-00101101-10010001-01010101
// CHECK: asr     z21.b, z10.b, #3 // encoding: [0x55,0x91,0x2d,0x04]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000100-00101101-10010001-01010101
ASR     Z21.B, Z10.B, #3  // 00000100-00101101-10010001-01010101
// CHECK: asr     z21.b, z10.b, #3 // encoding: [0x55,0x91,0x2d,0x04]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000100-00101101-10010001-01010101
asr     z31.b, z31.b, #1  // 00000100-00101111-10010011-11111111
// CHECK: asr     z31.b, z31.b, #1 // encoding: [0xff,0x93,0x2f,0x04]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000100-00101111-10010011-11111111
ASR     Z31.B, Z31.B, #1  // 00000100-00101111-10010011-11111111
// CHECK: asr     z31.b, z31.b, #1 // encoding: [0xff,0x93,0x2f,0x04]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000100-00101111-10010011-11111111
asr     z0.b, z0.b, #8  // 00000100-00101000-10010000-00000000
// CHECK: asr     z0.b, z0.b, #8 // encoding: [0x00,0x90,0x28,0x04]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000100-00101000-10010000-00000000
ASR     Z0.B, Z0.B, #8  // 00000100-00101000-10010000-00000000
// CHECK: asr     z0.b, z0.b, #8 // encoding: [0x00,0x90,0x28,0x04]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000100-00101000-10010000-00000000
