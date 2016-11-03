; RUN: llc -verify-machineinstrs -mattr=+sve < %s | FileCheck %s

target datalayout = "e-m:e-i64:64-i128:128-n32:64-S128"
target triple = "aarch64--linux-gnueabi"

define i64 @rdvl_i8_as_i8() {
; CHECK-LABEL: rdvl_i8_as_i8:
; CHECK: rdvl x[[NUM_BYTES:[0-9]+]], #1
; CHECK-NEXT: and x0, x[[NUM_BYTES]], #0xff
; CHECK-NEXT: ret
  %count = elementcount <n x 16 x i8> zeroinitializer as i8
  %zext_count = zext i8 %count to i64
  ret i64 %zext_count
}

define i64 @rdvl_i8_as_i16() {
; CHECK-LABEL: rdvl_i8_as_i16:
; CHECK: rdvl x0, #1
; CHECK-NEXT: ret
  %count = elementcount <n x 16 x i8> zeroinitializer as i16
  %zext_count = zext i16 %count to i64
  ret i64 %zext_count
}

define i64 @rdvl_i8_as_i32() {
; CHECK-LABEL: rdvl_i8_as_i32:
; CHECK: rdvl x0, #1
; CHECK-NEXT: ret
  %count = elementcount <n x 16 x i8> zeroinitializer as i32
  %zext_count = zext i32 %count to i64
  ret i64 %zext_count
}

define i64 @rdvl_i8_as_i64() {
; CHECK-LABEL: rdvl_i8_as_i64:
; CHECK: rdvl x0, #1
; CHECK-NEXT: ret
  %count = elementcount <n x 16 x i8> zeroinitializer as i64
  ret i64 %count
}

define i64 @rdvl_i16_as_i8() {
; CHECK-LABEL: rdvl_i16_as_i8:
; CHECK: cnth x[[NUM_BYTES:[0-9]+]]
; CHECK-NEXT: ret
  %count = elementcount <n x 8 x i16> zeroinitializer as i8
  %zext_count = zext i8 %count to i64
  ret i64 %zext_count
}

define i64 @rdvl_i16_as_i16() {
; CHECK-LABEL: rdvl_i16_as_i16:
; CHECK: cnth x0
; CHECK-NEXT: ret
  %count = elementcount <n x 8 x i16> zeroinitializer as i16
  %zext_count = zext i16 %count to i64
  ret i64 %zext_count
}

define i64 @rdvl_i16_as_i32() {
; CHECK-LABEL: rdvl_i16_as_i32:
; CHECK: cnth x0
; CHECK-NEXT: ret
  %count = elementcount <n x 8 x i16> zeroinitializer as i32
  %zext_count = zext i32 %count to i64
  ret i64 %zext_count
}

define i64 @rdvl_i16_as_i64() {
; CHECK-LABEL: rdvl_i16_as_i64:
; CHECK: cnth x0
; CHECK-NEXT: ret
  %count = elementcount <n x 8 x i16> zeroinitializer as i64
  ret i64 %count
}

define i64 @rdvl_i32_as_i8() {
; CHECK-LABEL: rdvl_i32_as_i8:
; CHECK: cntw x0
; CHECK-NEXT: ret
  %count = elementcount <n x 4 x i32> zeroinitializer as i8
  %zext_count = zext i8 %count to i64
  ret i64 %zext_count
}

define i64 @rdvl_i32_as_i16() {
; CHECK-LABEL: rdvl_i32_as_i16:
; CHECK: cntw x0
; CHECK-NEXT: ret
  %count = elementcount <n x 4 x i32> zeroinitializer as i16
  %zext_count = zext i16 %count to i64
  ret i64 %zext_count
}

define i64 @rdvl_i32_as_i32() {
; CHECK-LABEL: rdvl_i32_as_i32:
; CHECK: cntw x0
; CHECK-NEXT: ret
  %count = elementcount <n x 4 x i32> zeroinitializer as i32
  %zext_count = zext i32 %count to i64
  ret i64 %zext_count
}

define i64 @rdvl_i32_as_i64() {
; CHECK-LABEL: rdvl_i32_as_i64:
; CHECK: cntw x0
; CHECK-NEXT: ret
  %count = elementcount <n x 4 x i32> zeroinitializer as i64
  ret i64 %count
}

define i64 @rdvl_i64_as_i8() {
; CHECK-LABEL: rdvl_i64_as_i8:
; CHECK: cntd x0
; CHECK-NEXT: ret
  %count = elementcount <n x 2 x i64> zeroinitializer as i8
  %zext_count = zext i8 %count to i64
  ret i64 %zext_count
}

define i64 @rdvl_i64_as_i16() {
; CHECK-LABEL: rdvl_i64_as_i16:
; CHECK: cntd x0
; CHECK-NEXT: ret
  %count = elementcount <n x 2 x i64> zeroinitializer as i16
  %zext_count = zext i16 %count to i64
  ret i64 %zext_count
}

define i64 @rdvl_f32_as_i32() {
; CHECK-LABEL: rdvl_f32_as_i32:
; CHECK: cntw x0
; CHECK-NEXT: ret
  %count = elementcount <n x 4 x float> zeroinitializer as i32
  %zext_count = zext i32 %count to i64
  ret i64 %zext_count
}

define i64 @rdvl_f32_as_i64() {
; CHECK-LABEL: rdvl_f32_as_i64:
; CHECK: cntw x0
; CHECK-NEXT: ret
  %count = elementcount <n x 4 x float> zeroinitializer as i64
  ret i64 %count
}

define i64 @rdvl_f64_as_i32() {
; CHECK-LABEL: rdvl_f64_as_i32:
; CHECK: cntd x0
; CHECK-NEXT: ret
  %count = elementcount <n x 2 x double> zeroinitializer as i32
  %zext_count = zext i32 %count to i64
  ret i64 %zext_count
}

define i64 @rdvl_i64_as_i32() {
; CHECK-LABEL: rdvl_i64_as_i32:
; CHECK: cntd x0
; CHECK-NEXT: ret
  %count = elementcount <n x 2 x i64> zeroinitializer as i32
  %zext_count = zext i32 %count to i64
  ret i64 %zext_count
}

define i64 @rdvl_f64_as_i64() {
; CHECK-LABEL: rdvl_f64_as_i64:
; CHECK: cntd x0
; CHECK-NEXT: ret
  %count = elementcount <n x 2 x double> zeroinitializer as i64
  ret i64 %count
}

define i64 @rdvl_i64_as_i64() {
; CHECK-LABEL: rdvl_i64_as_i64:
; CHECK: cntd x0
; CHECK-NEXT: ret
  %count = elementcount <n x 2 x i64> zeroinitializer as i64
  ret i64 %count
}
