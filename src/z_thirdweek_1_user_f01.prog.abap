*&---------------------------------------------------------------------*
*& Include z_thirdweek_1_user_f01
*&---------------------------------------------------------------------*

FORM GET_DATA.
" 데이터 조회 PERFORM GET_DATA
SELECT * FROM SFLIGHT INTO CORRESPONDING FIELDS OF TABLE GT_SFLIGHT
WHERE carrid IN s_carrid
ORDER BY CARRID CONNID.
ENDFORM.
