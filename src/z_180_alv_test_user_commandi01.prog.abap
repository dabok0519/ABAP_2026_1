*----------------------------------------------------------------------*
***INCLUDE Z_180_ALV_TEST_USER_COMMANDI01.
*----------------------------------------------------------------------*
*&---------------------------------------------------------------------*
*&      Module  USER_COMMAND_0100  INPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE user_command_0100 INPUT.

  " 이 변수에 OO 이벤트에서 보낸 'EXIT'이나 상단 바의 'BACK'이 담깁니다.
  ok_code = sy-ucomm.
  CLEAR sy-ucomm.

  CASE ok_code.
    WHEN 'BACK' OR 'EXIT' OR 'CANC'.
      " 모든 객체를 메모리에서 해제하고 화면을 나갑니다.
      FREE: go_grid, go_dock.
      LEAVE TO TRANSACTION sy-tcode. " 또는 SET SCREEN 0. LEAVE SCREEN.
  ENDCASE.
ENDMODULE.
