; RUN: opt -mtriple=aarch64--linux-gnu -mattr=+sve < %s  -S -O3 -insert-superword-control-flow -stats -o - 2>&1 | FileCheck %s
; REQUIRES: asserts

; ModuleID = 'test.c'
source_filename = "test.c"
target datalayout = "e-m:e-i64:64-i128:128-n32:64-S128"
target triple = "aarch64--linux-gnu"

; Function Attrs: norecurse nounwind
define void @foo(i32* noalias nocapture readonly %a, float* noalias nocapture %b, float* noalias nocapture readonly %c, float* noalias nocapture readonly %d, float* noalias nocapture %e, i32 %n, i32* noalias nocapture readonly %m) #0 {
entry:
  %predicate.entry = propff <n x 2 x i1> shufflevector (<n x 2 x i1> insertelement (<n x 2 x i1> undef, i1 true, i32 0), <n x 2 x i1> undef, <n x 2 x i32> zeroinitializer), icmp ult (<n x 2 x i64> seriesvector (i64 0, i64 1), <n x 2 x i64> shufflevector (<n x 2 x i64> insertelement (<n x 2 x i64> undef, i64 1024, i32 0), <n x 2 x i64> undef, <n x 2 x i32> zeroinitializer))
  br label %vector.body

; CHECK-LABEL: vector.body:
; CHECK: guarded.block
; CHECK: unconditional.block
; CHECK: guarded.block
; CHECK: unconditional.block
vector.body:                                      ; preds = %vector.body, %entry
  %index = phi i64 [ 0, %entry ], [ %index.next, %vector.body ]
  %predicate = phi <n x 2 x i1> [ %predicate.entry, %entry ], [ %predicate.next, %vector.body ]
  %0 = icmp ult i64 %index, 1024
  call void @llvm.assume(i1 %0)
  %1 = getelementptr inbounds i32, i32* %a, i64 %index
  %2 = bitcast i32* %1 to <n x 2 x i32>*
  %wide.masked.load = call <n x 2 x i32> @llvm.masked.load.nxv2i32(<n x 2 x i32>* %2, i32 4, <n x 2 x i1> %predicate, <n x 2 x i32> undef), !tbaa !1
  %3 = icmp slt <n x 2 x i32> %wide.masked.load, shufflevector (<n x 2 x i32> insertelement (<n x 2 x i32> undef, i32 10, i32 0), <n x 2 x i32> undef, <n x 2 x i32> zeroinitializer)
  %4 = getelementptr inbounds float, float* %c, i64 %index
  %5 = bitcast float* %4 to <n x 2 x float>*
  %wide.masked.load27 = call <n x 2 x float> @llvm.masked.load.nxv2f32(<n x 2 x float>* %5, i32 4, <n x 2 x i1> %predicate, <n x 2 x float> undef), !tbaa !5
  %6 = getelementptr inbounds float, float* %d, i64 %index
  %7 = bitcast float* %6 to <n x 2 x float>*
  %wide.masked.load28 = call <n x 2 x float> @llvm.masked.load.nxv2f32(<n x 2 x float>* %7, i32 4, <n x 2 x i1> %predicate, <n x 2 x float> undef), !tbaa !5
  %8 = getelementptr inbounds i32, i32* %m, i64 %index
  %9 = bitcast i32* %8 to <n x 2 x i32>*
  %wide.masked.load29 = call <n x 2 x i32> @llvm.masked.load.nxv2i32(<n x 2 x i32>* %9, i32 4, <n x 2 x i1> %predicate, <n x 2 x i32> undef)
  %10 = fsub <n x 2 x float> %wide.masked.load27, %wide.masked.load28
  %11 = sext <n x 2 x i32> %wide.masked.load29 to <n x 2 x i64>
  %12 = getelementptr float, float* %e, <n x 2 x i64> %11
  %13 = xor <n x 2 x i1> %3, shufflevector (<n x 2 x i1> insertelement (<n x 2 x i1> undef, i1 true, i32 0), <n x 2 x i1> undef, <n x 2 x i32> zeroinitializer)
  %14 = and <n x 2 x i1> %predicate, %13
  call void @llvm.masked.scatter.nxv2f32(<n x 2 x float> %10, <n x 2 x float*> %12, i32 4, <n x 2 x i1> %14), !tbaa !5
  %15 = fadd <n x 2 x float> %wide.masked.load27, %wide.masked.load28
  %16 = sext <n x 2 x i32> %wide.masked.load29 to <n x 2 x i64>
  %17 = getelementptr float, float* %b, <n x 2 x i64> %16
  %18 = and <n x 2 x i1> %predicate, %3
  call void @llvm.masked.scatter.nxv2f32(<n x 2 x float> %15, <n x 2 x float*> %17, i32 4, <n x 2 x i1> %18), !tbaa !5
  %index.next = add nuw nsw i64 %index, elementcount (<n x 2 x i64> undef)
  %19 = add nuw nsw i64 %index, elementcount (<n x 2 x i64> undef)
  %20 = seriesvector i64 %19, 1 as <n x 2 x i64>
  %21 = icmp ult <n x 2 x i64> %20, shufflevector (<n x 2 x i64> insertelement (<n x 2 x i64> undef, i64 1024, i32 0), <n x 2 x i64> undef, <n x 2 x i32> zeroinitializer)
  %predicate.next = propff <n x 2 x i1> %predicate, %21
  %22 = test first true <n x 2 x i1> %predicate.next
  br i1 %22, label %vector.body, label %for.cond.cleanup, !llvm.loop !7

for.cond.cleanup:                                 ; preds = %vector.body
  ret void
}

; Function Attrs: argmemonly nounwind readonly
declare <n x 2 x i32> @llvm.masked.load.nxv2i32(<n x 2 x i32>*, i32, <n x 2 x i1>, <n x 2 x i32>) #1

; Function Attrs: argmemonly nounwind readonly
declare <n x 2 x float> @llvm.masked.load.nxv2f32(<n x 2 x float>*, i32, <n x 2 x i1>, <n x 2 x float>) #1

; Function Attrs: nounwind
declare void @llvm.masked.scatter.nxv2f32(<n x 2 x float>, <n x 2 x float*>, i32, <n x 2 x i1>) #2

; Function Attrs: nounwind
declare void @llvm.assume(i1) #2

attributes #0 = { norecurse nounwind "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="generic" "target-features"="+neon,+sve" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { argmemonly nounwind readonly }
attributes #2 = { nounwind }

!llvm.ident = !{!0}

!0 = !{!"clang version 3.9.0"}
!1 = !{!2, !2, i64 0}
!2 = !{!"int", !3, i64 0}
!3 = !{!"omnipotent char", !4, i64 0}
!4 = !{!"Simple C/C++ TBAA"}
!5 = !{!6, !6, i64 0}
!6 = !{!"float", !3, i64 0}
!7 = distinct !{!7, !8, !9}
!8 = !{!"llvm.loop.vectorize.width", i32 1}
!9 = !{!"llvm.loop.interleave.count", i32 1}

; CHECK-LABEL: Statistics Collected
; CHECK:  2 boscc - Number of masked stores that
