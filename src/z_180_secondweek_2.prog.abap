*&---------------------------------------------------------------------*
*& Report z_180_secondweek_2
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z_180_secondweek_2.

INCLUDE Z_180_TOP.
INCLUDE Z_180_F01.


INITIALIZATION.

  pv_mtart = 'HALB'.
  so_matnr-sign = 'I'.
  so_matnr-option = 'BT'.
  so_matnr-low = 'CCWA1281'.
  so_matnr-high = 'CCWA1300'.
APPEND so_matnr.


START-OF-SELECTION.
PERFORM SELECT_MARA.



END-OF-SELECTION.
PERFORM DISPLAY.
