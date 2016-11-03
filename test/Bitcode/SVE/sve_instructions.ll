; RUN: llvm-as < %s | llvm-dis | FileCheck %s

;CHECK: define <n x 2 x i32> @seriesvector(i32 %a) {
;CHECK:   %1 = seriesvector i32 %a, %a as <n x 2 x i32>
;CHECK:   %2 = add <n x 2 x i32> seriesvector (i32 0, i32 2), %1
;CHECK:   ret <n x 2 x i32> %2
;CHECK: }
define <n x 2 x i32> @seriesvector(i32 %a) {
  %1 = seriesvector i32 %a, %a as <n x 2 x i32>
  %2 = add <n x 2 x i32> seriesvector (i32 0, i32 2), %1
  ret <n x 2 x i32> %2
}

;CHECK: define i1 @test(<n x 2 x i1> %a) {
;CHECK:   %1 = test all false <n x 2 x i1> %a
;CHECK:   ret i1 %1
;CHECK: }
define i1 @test(<n x 2 x i1> %a) {
  %1 = test all false <n x 2 x i1> %a
  ret i1 %1
}

;CHECK: define i64 @elementcount() {
;CHECK:   %1 = elementcount <n x 2 x double> undef as i64
;CHECK:   %2 = add i64 %1, elementcount (<n x 2 x double> undef)
;CHECK:   ret i64 %2
;CHECK: }
define i64 @elementcount() {
  %1 = elementcount <n x 2 x double> undef as i64
  %2 = add i64 %1, elementcount (<n x 2 x double> undef)
  ret i64 %2
}

;CHECK: define <n x 2 x i1> @propff() {
;CHECK:   %1 = propff <n x 2 x i1> zeroinitializer, zeroinitializer
;CHECK:   ret <n x 2 x i1> %1
;CHECK: }
define <n x 2 x i1> @propff() {
  %1 = propff <n x 2 x i1> zeroinitializer, zeroinitializer
  ret <n x 2 x i1> %1
}
