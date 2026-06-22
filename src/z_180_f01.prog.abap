*&---------------------------------------------------------------------*
*& Include z_180_f01
*&---------------------------------------------------------------------*




PERFORM SELECT_MARA.
PERFORM DISPLAY.


FORM SELECT_MARA.
    SELECT * FROM mara INTO TABLE gt_mara
    WHERE mtart EQ pv_mtart AND matnr IN so_matnr.

ENDFORM.


FORM DISPLAY.

    cl_demo_output=>display( gt_mara ).

ENDFORM.
