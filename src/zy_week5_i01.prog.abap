*&---------------------------------------------------------------------*
*& Include zy_week5_i01
*&---------------------------------------------------------------------*

MODULE exit INPUT.

CASE ok_code.
    WHEN 'BACK'.
      LEAVE TO SCREEN 0.
    WHEN 'EXIT' OR 'CANC'.
      LEAVE PROGRAM.
  ENDCASE.

ENDMODULE.
