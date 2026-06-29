*----------------------------------------------------------------------*
***INCLUDE Z_180_ALV_TEST_USER_COMMANDI01.
*----------------------------------------------------------------------*
MODULE user_command_0100 INPUT.
  ok_code = sy-ucomm.
  CLEAR sy-ucomm.

  CASE ok_code.
    WHEN 'BACK' OR 'EXIT' OR 'CANC'.
      FREE: go_grid, go_dock.
      LEAVE TO TRANSACTION sy-tcode.
  ENDCASE.
ENDMODULE.