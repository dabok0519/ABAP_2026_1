*&---------------------------------------------------------------------*
*& Report z_zm_180_debug_test
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z_zm_180_debug_test.


"문제 1번
* 1. 데이터 선언 (인터널 테이블 및 구조체)
*TYPES: BEGIN OF ty_data,
*         id    TYPE i,
*         name  TYPE string,
*         score TYPE i,
*       END OF ty_data.
*
*DATA: lt_student TYPE TABLE OF ty_data,
*      ls_student TYPE ty_data.
*
* 2. 데이터 준비
*APPEND VALUE #( id = 1 name = 'Minseong' score = 80 ) TO lt_student.
*APPEND VALUE #( id = 2 name = 'James'    score = 90 ) TO lt_student.
*APPEND VALUE #( id = 3 name = 'Sophia'   score = 70 ) TO lt_student.
*
* 3. 메인 로직 (여기서부터 디버깅 시작!)
*WRITE: / '--- 성적 업데이트 시작 ---'.
*
*LOOP AT lt_student INTO ls_student.
*
*  " [연습 포인트 1] F5를 눌러 서브루틴 내부로 들어가보세요.
*  " [연습 포인트 2] F6을 눌러 서브루틴 결과를 바로 확인해보세요.
*  PERFORM update_score CHANGING ls_student-score.
*
*  MODIFY lt_student FROM ls_student.
*
*ENDLOOP.
*
*WRITE: / '--- 업데이트 완료 ---'.
*
* 4. 서브루틴 정의
*FORM update_score CHANGING p_score.
*  " [연습 포인트 3] F7을 눌러 로직 수행 후 루프 위치로 탈출해보세요.
*  p_score = p_score + 10.
*ENDFORM.


"문제 2번

DATA: gv_total   TYPE i VALUE 0,
      gv_counter TYPE i VALUE 0,
      gv_divisor TYPE i VALUE 5.

* 1. 기본 중단점 & Tracepoint 연습용 루프
WRITE: / '--- 루프 시작 ---'.


break-POINT 1.


DO 5 TIMES.
  gv_counter = sy-index.
  gv_total   = gv_total + ( sy-index * 10 ). " [연습: Watchpoint & Tracepoint]

enddo.



* 3. Exception Breakpoint 연습 (0 나누기 에러)
WRITE: / '--- 예외 발생 구간 ---'.
gv_divisor = 0.

TRY.
    gv_total = 100 / gv_divisor. " [연습: Exception Breakpoint]
  CATCH cx_sy_zerodivide.
    WRITE: / '에러 발생: 0으로 나눌 수 없습니다.'.
ENDTRY.

WRITE: / '--- 모든 실습 종료 ---'.
