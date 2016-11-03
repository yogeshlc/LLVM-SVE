; RUN: opt -mtriple=aarch64-linux-generic -mattr=+sve < %s  -loop-vectorize -force-vector-predication  -force-vector-width=4 -force-scalable-vectorization -force-vector-interleave=2 -O1  -S | FileCheck %s

; int unroll_reduction(int * restrict a, const unsigned n) {
;   unsigned i, s = 0;
;   for (i = 0; i < n; ++i)
;    s += a[i];

;   return s;
; }

target datalayout = "e-m:e-i64:64-i128:128-n32:64-S128"
target triple = "aarch64--linux-generic"

; Function Attrs: nounwind readonly
; CHECK-LABEL: @unroll_reduction(
; CHECK-LABEL: min.iters.checked:
; CHECK: [[INITICMP0:%[a-zA-Z0-9]+]] = icmp ugt <n x 4 x i64> %wide.end.idx.splat, seriesvector (i64 0, i64 1)
; [[PREDENTRY:%predicate.entry[0-9]+]] = propff <n x 4 x i1> shufflevector (<n x 4 x i1> insertelement (<n x 4 x i1> undef, i1 true, i32 0), <n x 4 x i1> undef, <n x 4 x i32> zeroinitializer), [[INITICMP0]]
; [[INITICMP1:%[a-zA-Z0-9]+]] = icmp ugt <n x 4 x i64> %wide.end.idx.splat, seriesvector (i64 elementcount (<n x 4 x i64> undef), i64 1)
; {{%predicate.entry[0-9]+}} = propff <n x 4 x i1> [[PREDENTRY]], [[INITICMP1]]

; CHECK-LABEL: vector.body:

; Predicate initialization
; CHECK:  %predicate = phi <n x 4 x i1> [ %predicate.entry, %min.iters.checked ], [ %predicate.next, %vector.body ]
; CHECK:  [[P2:%predicate[0-9]+]] = phi <n x 4 x i1> [ %predicate.entry{{[0-9]+}}, %min.iters.checked ], [ [[PNEXT:%predicate.next[0-9]+]], %vector.body ]

; Masked load with correct predicate
; CHECK-DAG:  %wide.masked.load = tail call <n x 4 x i32> @llvm.masked.load.nxv4i32(<n x 4 x i32>* {{%[0-9]+}}, i32 4, <n x 4 x i1> %predicate, <n x 4 x i32> undef), !tbaa !1
; CHECK-DAG:  %{{[0-9]+}} = getelementptr <n x 4 x i32>, <n x 4 x i32>* %{{[0-9]+}}, i64 1
; CHECK-DAG:  [[WML:%wide.masked.load[0-9]+]] = tail call <n x 4 x i32> @llvm.masked.load.nxv4i32(<n x 4 x i32>* {{%[0-9]+}}, i32 4, <n x 4 x i1> [[P2]], <n x 4 x i32> undef), !tbaa !1

; First unrolled chunk predicate update
; CHECK-DAG: [[I_UNROLL_NEXT:%[.a-zA-Z0-9]+]] = add nuw nsw i64 %index, mul (i64 elementcount (<n x 4 x i64> undef), i64 2)
; CHECK-DAG: [[T1:%[.a-zA-Z0-9]+]] = seriesvector i64 [[I_UNROLL_NEXT]], 1 as <n x 4 x i64>
; CHECK-DAG: [[T2:%[.a-zA-Z0-9]+]] = icmp ult <n x 4 x i64> [[T1]], %wide.end.idx.splat
; CHECK-DAG: %predicate.next = propff <n x 4 x i1> [[P2]], [[T2]]

; Second unrolled chunk predicate update
; CHECK: [[I_UNROLL_NEXT2:%[.a-zA-Z0-9]+]] = add i64 %index, add (i64 mul (i64 elementcount (<n x 4 x i64> undef), i64 2), i64 elementcount (<n x 4 x i64> undef))
; CHECK: [[T3:%[.a-zA-Z0-9]+]] = seriesvector i64 [[I_UNROLL_NEXT2]], 1 as <n x 4 x i64>
; CHECK: [[T4:%[.a-zA-Z0-9]+]] = icmp ult <n x 4 x i64> [[T3]], %wide.end.idx.splat
; CHECK: [[PNEXT]] = propff <n x 4 x i1> %predicate.next, [[T4]]

; Block repeat condition
; CHECK: [[EXIT:%[a-zA-Z0-9]+]] = test first true <n x 4 x i1> %predicate.next

; Exit block
; CHECK: br i1 [[EXIT]], label %vector.body, label %middle.block


; CHECK: middle.block:
; CHECK: @llvm.aarch64.sve.uaddv.nxv4i32
define i32 @unroll_reduction(i32* noalias nocapture readonly %a, i32 %n) #1 {
entry:
  %cmp.6 = icmp eq i32 %n, 0
  br i1 %cmp.6, label %for.end, label %for.body

for.body:                                         ; preds = %entry, %for.body
  %indvars.iv = phi i64 [ %indvars.iv.next, %for.body ], [ 0, %entry ]
  %s.08 = phi i32 [ %add, %for.body ], [ 0, %entry ]
  %arrayidx = getelementptr inbounds i32, i32* %a, i64 %indvars.iv
  %0 = load i32, i32* %arrayidx, align 4, !tbaa !1
  %add = add i32 %0, %s.08
  %indvars.iv.next = add nuw nsw i64 %indvars.iv, 1
  %lftr.wideiv = trunc i64 %indvars.iv.next to i32
  %exitcond = icmp eq i32 %lftr.wideiv, %n
  br i1 %exitcond, label %for.end, label %for.body

for.end:                                          ; preds = %for.body, %entry
  %s.0.lcssa = phi i32 [ 0, %entry ], [ %add, %for.body ]
  ret i32 %s.0.lcssa
}

attributes #0 = { nounwind "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="generic" "target-features"="+neon" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind readonly "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="generic" "target-features"="+sve" "unsafe-fp-math"="false" "use-soft-float"="false" }

!llvm.ident = !{!0}

!0 = !{!"clang version 3.7.0"}
!1 = !{!2, !2, i64 0}
!2 = !{!"int", !3, i64 0}
!3 = !{!"omnipotent char", !4, i64 0}
!4 = !{!"Simple C/C++ TBAA"}
