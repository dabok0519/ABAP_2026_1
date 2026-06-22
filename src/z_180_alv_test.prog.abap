*&---------------------------------------------------------------------*
*& Report z_180_alv_test
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z_180_alv_test.


INCLUDE z_mara_alv_top.   " 2단계: 선언부
INCLUDE z_mara_alv_f01.   " 3단계: 로직부

START-OF-SELECTION.
  PERFORM get_data.
         " 데이터 가져오기T

  call ScREEN '100'.


INCLUDE z_180_alv_test_user_commandi01.
