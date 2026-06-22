*&---------------------------------------------------------------------*
*& Report z_180_debugging
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z_180_debugging.


* Define variables
DATA: usr_locked TYPE bapislockd.

* Perform BAPI call
CALL FUNCTION 'BAPI_USER_GET_DETAIL'
  DESTINATION sy-sysid
  EXPORTING
    username = sy-uname
  IMPORTING
    islocked = usr_locked.

IF usr_locked = 'UUUU'.
  WRITE 'Safe unlocked'.
ELSE.
  WRITE 'Safe locked'.
ENDIF.
