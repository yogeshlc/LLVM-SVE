// RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve < %s | FileCheck %s
// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR %s
sqincp  x23, p13.b, w23  // 00100101-00101000-10001001-10110111
// CHECK: sqincp  x23, p13.b, w23 // encoding: [0xb7,0x89,0x28,0x25]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00100101-00101000-10001001-10110111
SQINCP  X23, P13.B, W23  // 00100101-00101000-10001001-10110111
// CHECK: sqincp  x23, p13.b, w23 // encoding: [0xb7,0x89,0x28,0x25]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00100101-00101000-10001001-10110111
sqincp  xzr, p15.b, wzr  // 00100101-00101000-10001001-11111111
// CHECK: sqincp  xzr, p15.b, wzr // encoding: [0xff,0x89,0x28,0x25]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00100101-00101000-10001001-11111111
SQINCP  XZR, P15.B, WZR  // 00100101-00101000-10001001-11111111
// CHECK: sqincp  xzr, p15.b, wzr // encoding: [0xff,0x89,0x28,0x25]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00100101-00101000-10001001-11111111
sqincp  x0, p0.b, w0  // 00100101-00101000-10001000-00000000
// CHECK: sqincp  x0, p0.b, w0 // encoding: [0x00,0x88,0x28,0x25]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00100101-00101000-10001000-00000000
SQINCP  X0, P0.B, W0  // 00100101-00101000-10001000-00000000
// CHECK: sqincp  x0, p0.b, w0 // encoding: [0x00,0x88,0x28,0x25]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00100101-00101000-10001000-00000000
sqincp  x21, p10.b, w21  // 00100101-00101000-10001001-01010101
// CHECK: sqincp  x21, p10.b, w21 // encoding: [0x55,0x89,0x28,0x25]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00100101-00101000-10001001-01010101
SQINCP  X21, P10.B, W21  // 00100101-00101000-10001001-01010101
// CHECK: sqincp  x21, p10.b, w21 // encoding: [0x55,0x89,0x28,0x25]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00100101-00101000-10001001-01010101
