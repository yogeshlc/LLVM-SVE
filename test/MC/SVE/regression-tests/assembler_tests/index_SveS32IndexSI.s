// RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve < %s | FileCheck %s
// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR %s
index   z23.s, w13, #8  // 00000100-10101000-01000101-10110111
// CHECK: index   z23.s, w13, #8 // encoding: [0xb7,0x45,0xa8,0x04]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000100-10101000-01000101-10110111
INDEX   Z23.S, W13, #8  // 00000100-10101000-01000101-10110111
// CHECK: index   z23.s, w13, #8 // encoding: [0xb7,0x45,0xa8,0x04]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000100-10101000-01000101-10110111
index   z21.s, w10, #-11  // 00000100-10110101-01000101-01010101
// CHECK: index   z21.s, w10, #-11 // encoding: [0x55,0x45,0xb5,0x04]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000100-10110101-01000101-01010101
INDEX   Z21.S, W10, #-11  // 00000100-10110101-01000101-01010101
// CHECK: index   z21.s, w10, #-11 // encoding: [0x55,0x45,0xb5,0x04]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000100-10110101-01000101-01010101
index   z0.s, w0, #0  // 00000100-10100000-01000100-00000000
// CHECK: index   z0.s, w0, #0 // encoding: [0x00,0x44,0xa0,0x04]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000100-10100000-01000100-00000000
INDEX   Z0.S, W0, #0  // 00000100-10100000-01000100-00000000
// CHECK: index   z0.s, w0, #0 // encoding: [0x00,0x44,0xa0,0x04]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000100-10100000-01000100-00000000
index   z31.s, wzr, #-1  // 00000100-10111111-01000111-11111111
// CHECK: index   z31.s, wzr, #-1 // encoding: [0xff,0x47,0xbf,0x04]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000100-10111111-01000111-11111111
INDEX   Z31.S, WZR, #-1  // 00000100-10111111-01000111-11111111
// CHECK: index   z31.s, wzr, #-1 // encoding: [0xff,0x47,0xbf,0x04]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000100-10111111-01000111-11111111
