*&---------------------------------------------------------------------*
*& Report z_thirdweek_1
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z_thirdweek_1.
INCLUDE z_thirdweek_1_user_TOP.
INCLUDE Z_THIRDWEEK_1_O01.
INCLUDE Z_THIRDWEEK_1_I01.
INCLUDE z_thirdweek_1_user_F01.



START-OF-SELECTION.
PERFORM GET_DATA.
CALL SCREEN '100'.
