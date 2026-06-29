*----------------------------------------------------------------------*
***INCLUDE Z_THIRDWEEK_1_USER_COMMAND_I01.
*----------------------------------------------------------------------*
MODULE user_command_0100 INPUT.
  CASE ok_code.
    when 'BACK'.
      LEAVE TO SCREEN 0.
     WHEN 'EXIT' OR 'CANC'.
      LEAVE PROGRAM.
  ENDCASE.
ENDMODULE.