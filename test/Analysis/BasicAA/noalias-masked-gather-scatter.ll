; RUN: opt < %s -basicaa -aa-eval -print-all-alias-modref-info -disable-output 2>&1 | FileCheck %s
; ModuleID = 'masked_gather_scatter.c'
source_filename = "masked_gather_scatter.c"
target datalayout = "e-m:e-i64:64-i128:128-n32:64-S128"
target triple = "aarch64-none--elf"

; Function Attrs: nounwind
define void @somefunc(double* nocapture %ptr, i32 %idx1, i32 %idx2) #0 {
entry:
  %local_array = alloca [1024 x double], align 8
  %0 = bitcast [1024 x double]* %local_array to i8*
  call void @llvm.lifetime.start(i64 8192, i8* %0) #3
  call void @llvm.memset.p0i8.i64(i8* %0, i8 0, i64 8192, i32 8, i1 false)
  %predicate.entry = propff <n x 2 x i1> shufflevector (<n x 2 x i1> insertelement (<n x 2 x i1> undef, i1 true, i32 0), <n x 2 x i1> undef, <n x 2 x i32> zeroinitializer), icmp ult (<n x 2 x i64> seriesvector (i64 0, i64 1), <n x 2 x i64> shufflevector (<n x 2 x i64> insertelement (<n x 2 x i64> undef, i64 342, i32 0), <n x 2 x i64> undef, <n x 2 x i32> zeroinitializer))
  %1 = getelementptr inbounds [1024 x double], [1024 x double]* %local_array, i64 0, i64 0
  br label %vector.body

vector.body:                                      ; preds = %vector.body, %entry
  %index = phi i64 [ 0, %entry ], [ %index.next, %vector.body ]
  %predicate = phi <n x 2 x i1> [ %predicate.entry, %entry ], [ %predicate.next, %vector.body ]
  %2 = icmp ult i64 %index, 342
  call void @llvm.assume(i1 %2)
  %3 = trunc i64 %index to i32
  %4 = mul nuw nsw i32 %3, 3
  %5 = seriesvector i32 %4, 3 as <n x 2 x i32>
  %6 = getelementptr double, double* %ptr, <n x 2 x i32> %5
  %7 = call <n x 2 x double> @llvm.masked.gather.nxv2f64(<n x 2 x double*> %6, i32 8, <n x 2 x i1> %predicate, <n x 2 x double> undef), !tbaa !1
  %8 = fadd fast <n x 2 x double> %7, shufflevector (<n x 2 x double> insertelement (<n x 2 x double> undef, double 3.000000e+00, i32 0), <n x 2 x double> undef, <n x 2 x i32> zeroinitializer)
  %9 = trunc i64 %index to i32
  %10 = mul nuw nsw i32 %9, 3
  %11 = seriesvector i32 %10, 3 as <n x 2 x i32>
  %12 = getelementptr double, double* %1, <n x 2 x i32> %11
  call void @llvm.masked.scatter.nxv2f64(<n x 2 x double> %8, <n x 2 x double*> %12, i32 8, <n x 2 x i1> %predicate), !tbaa !1
  %index.next = add nuw nsw i64 %index, elementcount (<n x 2 x i64> undef)
  %13 = add nuw nsw i64 %index, elementcount (<n x 2 x i64> undef)
  %14 = seriesvector i64 %13, 1 as <n x 2 x i64>
  %15 = icmp ult <n x 2 x i64> %14, shufflevector (<n x 2 x i64> insertelement (<n x 2 x i64> undef, i64 342, i32 0), <n x 2 x i64> undef, <n x 2 x i32> zeroinitializer)
  %predicate.next = propff <n x 2 x i1> %predicate, %15
  %16 = test first true <n x 2 x i1> %predicate.next
  br i1 %16, label %vector.body, label %for.cond.cleanup, !llvm.loop !5

for.cond.cleanup:                                 ; preds = %vector.body
  %idxprom4 = sext i32 %idx2 to i64
  %arrayidx5 = getelementptr inbounds [1024 x double], [1024 x double]* %local_array, i64 0, i64 %idxprom4
  %17 = load double, double* %arrayidx5, align 8, !tbaa !1
  %idxprom6 = sext i32 %idx1 to i64
  %arrayidx7 = getelementptr inbounds double, double* %ptr, i64 %idxprom6
  %18 = load double, double* %arrayidx7, align 8, !tbaa !1
  %add8 = fadd fast double %18, %17
  store double %add8, double* %arrayidx7, align 8, !tbaa !1
  call void @llvm.lifetime.end(i64 8192, i8* nonnull %0) #3
  ret void
}

; Function Attrs: argmemonly nounwind
declare void @llvm.lifetime.start(i64, i8* nocapture) #1

; Function Attrs: argmemonly nounwind
declare void @llvm.memset.p0i8.i64(i8* nocapture, i8, i64, i32, i1) #1

; Function Attrs: argmemonly nounwind
declare void @llvm.lifetime.end(i64, i8* nocapture) #1

; Function Attrs: argmemonly nounwind readonly
declare <n x 2 x double> @llvm.masked.gather.nxv2f64(<n x 2 x double*>, i32, <n x 2 x i1>, <n x 2 x double>) #2

; Function Attrs: argmemonly nounwind
declare void @llvm.masked.scatter.nxv2f64(<n x 2 x double>, <n x 2 x double*>, i32, <n x 2 x i1>) #1

; Function Attrs: nounwind
declare void @llvm.assume(i1) #3

attributes #0 = { nounwind "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="true" "no-jump-tables"="false" "no-nans-fp-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="generic" "target-features"="+neon,+sve" "unsafe-fp-math"="true" "use-soft-float"="false" }
attributes #1 = { argmemonly nounwind }
attributes #2 = { argmemonly nounwind readonly }
attributes #3 = { nounwind }

!llvm.ident = !{!0}

!0 = !{!"clang version 3.9.0"}
!1 = !{!2, !2, i64 0}
!2 = !{!"double", !3, i64 0}
!3 = !{!"omnipotent char", !4, i64 0}
!4 = !{!"Simple C/C++ TBAA"}
!5 = distinct !{!5, !6, !7}
!6 = !{!"llvm.loop.vectorize.width", i32 1}
!7 = !{!"llvm.loop.interleave.count", i32 1}

;; Verify results for gather and scatter:
; CHECK: Just Ref:  Ptr: double* %ptr  <->  %7 = call <n x 2 x double> @llvm.masked.gather.nxv2f64(<n x 2 x double*> %6, i32 8, <n x 2 x i1> %predicate, <n x 2 x double> undef), !tbaa !1
; CHECK: NoModRef:  Ptr: [1024 x double]* %local_array <->  %7 = call <n x 2 x double> @llvm.masked.gather.nxv2f64(<n x 2 x double*> %6, i32 8, <n x 2 x i1> %predicate, <n x 2 x double> undef), !tbaa !1
; CHECK: NoModRef:  Ptr: i8* %0        <->  %7 = call <n x 2 x double> @llvm.masked.gather.nxv2f64(<n x 2 x double*> %6, i32 8, <n x 2 x i1> %predicate, <n x 2 x double> undef), !tbaa !1
; CHECK: NoModRef:  Ptr: double* %1    <->  %7 = call <n x 2 x double> @llvm.masked.gather.nxv2f64(<n x 2 x double*> %6, i32 8, <n x 2 x i1> %predicate, <n x 2 x double> undef), !tbaa !1
; CHECK: NoModRef:  Ptr: double* %arrayidx5    <->  %7 = call <n x 2 x double> @llvm.masked.gather.nxv2f64(<n x 2 x double*> %6, i32 8, <n x 2 x i1> %predicate, <n x 2 x double> undef), !tbaa !1
; CHECK: Just Ref:  Ptr: double* %arrayidx7    <->  %7 = call <n x 2 x double> @llvm.masked.gather.nxv2f64(<n x 2 x double*> %6, i32 8, <n x 2 x i1> %predicate, <n x 2 x double> undef), !tbaa !1
; CHECK: NoModRef:  Ptr: double* %ptr  <->  call void @llvm.masked.scatter.nxv2f64(<n x 2 x double> %8, <n x 2 x double*> %12, i32 8, <n x 2 x i1> %predicate), !tbaa !1
; CHECK: Both ModRef:  Ptr: [1024 x double]* %local_array      <->  call void @llvm.masked.scatter.nxv2f64(<n x 2 x double> %8, <n x 2 x double*> %12, i32 8, <n x 2 x i1> %predicate), !tbaa !1
; CHECK: Both ModRef:  Ptr: i8* %0     <->  call void @llvm.masked.scatter.nxv2f64(<n x 2 x double> %8, <n x 2 x double*> %12, i32 8, <n x 2 x i1> %predicate), !tbaa !1
; CHECK: Both ModRef:  Ptr: double* %1 <->  call void @llvm.masked.scatter.nxv2f64(<n x 2 x double> %8, <n x 2 x double*> %12, i32 8, <n x 2 x i1> %predicate), !tbaa !1
; CHECK: Both ModRef:  Ptr: double* %arrayidx5 <->  call void @llvm.masked.scatter.nxv2f64(<n x 2 x double> %8, <n x 2 x double*> %12, i32 8, <n x 2 x i1> %predicate), !tbaa !1
; CHECK: NoModRef:  Ptr: double* %arrayidx7    <->  call void @llvm.masked.scatter.nxv2f64(<n x 2 x double> %8, <n x 2 x double*> %12, i32 8, <n x 2 x i1> %predicate), !tbaa !1
; CHECK: NoModRef:   call void @llvm.lifetime.start(i64 8192, i8* %0) #3 <->   %7 = call <n x 2 x double> @llvm.masked.gather.nxv2f64(<n x 2 x double*> %6, i32 8, <n x 2 x i1> %predicate, <n x 2 x double> undef), !tbaa !1
; CHECK: Both ModRef:   call void @llvm.lifetime.start(i64 8192, i8* %0) #3 <->   call void @llvm.masked.scatter.nxv2f64(<n x 2 x double> %8, <n x 2 x double*> %12, i32 8, <n x 2 x i1> %predicate), !tbaa !1
; CHECK: NoModRef:   call void @llvm.memset.p0i8.i64(i8* %0, i8 0, i64 8192, i32 8, i1 false) <->   %7 = call <n x 2 x double> @llvm.masked.gather.nxv2f64(<n x 2 x double*> %6, i32 8, <n x 2 x i1> %predicate, <n x 2 x double> undef), !tbaa !1
; CHECK: Just Mod:   call void @llvm.memset.p0i8.i64(i8* %0, i8 0, i64 8192, i32 8, i1 false) <->   call void @llvm.masked.scatter.nxv2f64(<n x 2 x double> %8, <n x 2 x double*> %12, i32 8, <n x 2 x i1> %predicate), !tbaa !1
; CHECK: NoModRef:   call void @llvm.assume(i1 %2) <->   %7 = call <n x 2 x double> @llvm.masked.gather.nxv2f64(<n x 2 x double*> %6, i32 8, <n x 2 x i1> %predicate, <n x 2 x double> undef), !tbaa !1
; CHECK: NoModRef:   call void @llvm.assume(i1 %2) <->   call void @llvm.masked.scatter.nxv2f64(<n x 2 x double> %8, <n x 2 x double*> %12, i32 8, <n x 2 x i1> %predicate), !tbaa !1
; CHECK: NoModRef:   %7 = call <n x 2 x double> @llvm.masked.gather.nxv2f64(<n x 2 x double*> %6, i32 8, <n x 2 x i1> %predicate, <n x 2 x double> undef), !tbaa !1 <->   call void @llvm.lifetime.start(i64 8192, i8* %0) #3
; CHECK: NoModRef:   %7 = call <n x 2 x double> @llvm.masked.gather.nxv2f64(<n x 2 x double*> %6, i32 8, <n x 2 x i1> %predicate, <n x 2 x double> undef), !tbaa !1 <->   call void @llvm.memset.p0i8.i64(i8* %0, i8 0, i64 8192, i32 8, i1 false)
; CHECK: NoModRef:   %7 = call <n x 2 x double> @llvm.masked.gather.nxv2f64(<n x 2 x double*> %6, i32 8, <n x 2 x i1> %predicate, <n x 2 x double> undef), !tbaa !1 <->   call void @llvm.assume(i1 %2)
; CHECK: NoModRef:   %7 = call <n x 2 x double> @llvm.masked.gather.nxv2f64(<n x 2 x double*> %6, i32 8, <n x 2 x i1> %predicate, <n x 2 x double> undef), !tbaa !1 <->   call void @llvm.masked.scatter.nxv2f64(<n x 2 x double> %8, <n x 2 x double*> %12, i32 8, <n x 2 x i1> %predicate), !tbaa !1
; CHECK: NoModRef:   %7 = call <n x 2 x double> @llvm.masked.gather.nxv2f64(<n x 2 x double*> %6, i32 8, <n x 2 x i1> %predicate, <n x 2 x double> undef), !tbaa !1 <->   call void @llvm.lifetime.end(i64 8192, i8* nonnull %0) #3
; CHECK: Both ModRef:   call void @llvm.masked.scatter.nxv2f64(<n x 2 x double> %8, <n x 2 x double*> %12, i32 8, <n x 2 x i1> %predicate), !tbaa !1 <->   call void @llvm.lifetime.start(i64 8192, i8* %0) #3
; CHECK: Both ModRef:   call void @llvm.masked.scatter.nxv2f64(<n x 2 x double> %8, <n x 2 x double*> %12, i32 8, <n x 2 x i1> %predicate), !tbaa !1 <->   call void @llvm.memset.p0i8.i64(i8* %0, i8 0, i64 8192, i32 8, i1 false)
; CHECK: NoModRef:   call void @llvm.masked.scatter.nxv2f64(<n x 2 x double> %8, <n x 2 x double*> %12, i32 8, <n x 2 x i1> %predicate), !tbaa !1 <->   call void @llvm.assume(i1 %2)
; CHECK: NoModRef:   call void @llvm.masked.scatter.nxv2f64(<n x 2 x double> %8, <n x 2 x double*> %12, i32 8, <n x 2 x i1> %predicate), !tbaa !1 <->   %7 = call <n x 2 x double> @llvm.masked.gather.nxv2f64(<n x 2 x double*> %6, i32 8, <n x 2 x i1> %predicate, <n x 2 x double> undef), !tbaa !1
; CHECK: Both ModRef:   call void @llvm.masked.scatter.nxv2f64(<n x 2 x double> %8, <n x 2 x double*> %12, i32 8, <n x 2 x i1> %predicate), !tbaa !1 <->   call void @llvm.lifetime.end(i64 8192, i8* nonnull %0) #3
; CHECK: NoModRef:   call void @llvm.lifetime.end(i64 8192, i8* nonnull %0) #3 <->   %7 = call <n x 2 x double> @llvm.masked.gather.nxv2f64(<n x 2 x double*> %6, i32 8, <n x 2 x i1> %predicate, <n x 2 x double> undef), !tbaa !1
; CHECK: Both ModRef:   call void @llvm.lifetime.end(i64 8192, i8* nonnull %0) #3 <->   call void @llvm.masked.scatter.nxv2f64(<n x 2 x double> %8, <n x 2 x double*> %12, i32 8, <n x 2 x i1> %predicate), !tbaa !1
