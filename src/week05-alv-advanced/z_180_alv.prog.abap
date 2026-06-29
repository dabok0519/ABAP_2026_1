*&---------------------------------------------------------------------*
*& Report z_180_alv
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z_180_alv.



INCLUDE ZY_WEEK5_TOP.                            .    " Global Data

INCLUDE ZY_WEEK5_I01.                            .  " PAI-Modules
INCLUDE ZY_WEEK5_F01.                           .  " FORM-Routines
 INCLUDE ZY_WEEK5_O01.                           .  " PBO-Modules

START-OF-SELECTION.

  PERFORM get_data.

  CALL SCREEN '100'.
