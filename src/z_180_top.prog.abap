*&---------------------------------------------------------------------*
*& Include z_180_top
*&---------------------------------------------------------------------*

TABLES: mara. " SELECT-OPTIONS 사용을 위해 필요


DATA gt_mara TYPE TABLE OF mara.


SELECTION-SCREEN BEGIN OF BLOCK b1 WITH FRAME TITLE TEXT-001.
* 1. 화면 선언 (이벤트 블록 밖으로 이동)
PARAMETERS: pv_mtart LIKE mara-mtart.
SELECT-OPTIONS: so_matnr FOR mara-matnr .

SELECTION-SCREEN END OF BLOCK b1.
