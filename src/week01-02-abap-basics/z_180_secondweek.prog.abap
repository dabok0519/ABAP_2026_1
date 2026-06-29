*&---------------------------------------------------------------------*
*& Report z_180_secondweek
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z_180_secondweek.

*--------------------------------------------------------------------------------------------------------------------------*
* 1. SFLIGHT(운항 정보) table을 사용하여 Airline Code, Flight Connection Number,
* Flight date, Air fair를 구조로 갖는 인터널 테이블을 만든 후, OPEN SQL을 통해 값을 담으세요.
* SQL구문 SELECT절에 ',' 콤마 사용시 New Syntax 오류가 납니다. 구 문법은 쉼표 X.
* cl_demo로 확인하기
*--------------------------------------------------------------------------------------------------------------------------*
TYPES : BEGIN OF ty_table,
        s_airline_code TYPE sflight-carrid,
        s_flight_connection_number TYPE sflight-connid,
        s_flight_date TYPE sflight-fldate,
        s_air_fair TYPE sflight-price,
        END OF ty_table.

DATA : gv_table TYPE TABLE OF ty_table.
DATA : gt_str TYPE ty_table.


SELECT carrid connid fldate price FROM sflight INTO TABLE gv_table.


cl_demo_output=>display( gv_table ).



*--------------------------------------------------------------------------------------------------------------------------*
* 1-1. 항공권 가격이 가장 '비싼' 데이터를 읽어오세요.(SORT 구문으로 정렬, READ table 구문 + 인덱스 활용)
* 단, 데이터 읽기에 실패한다면 '데이터 읽기에 실패했습니다.'를, 성공한다면 해당 스트럭처를 출력하도록 해주세요. (SY-SUBRC, 조건문 활용)
* 실패 시 [MESSAGE '데이터 읽기에 실패했습니다' TYPE 'E'.] 활용. 메시지를 출력하는 방법입니다!
* 정렬 시 구문 SORT (IT) BY columns Ascending/descending
* 테이블에서 특정 레코드를 가져오는 구문 read table (it) into (Structure) index (?)
* 스트럭쳐 출력이 잘 되면 index를 10000으로 바꿔서 데이터 읽기에 실패했을 때 매시지도 확인해서 캡쳐해주세요.
*--------------------------------------------------------------------------------------------------------------------------*

SORT gv_table BY s_air_fair DESCENDING.
READ TABLE gv_table INTO gt_str INDEX 1.


IF sy-subrc NE 0.
 MESSAGE '데이터 읽기에 실패했습니다.' TYPE 'E'.

ELSEIF sy-subrc EQ 0.
 cl_demo_output=>display( gt_str ).
ENDIF.


CLEAR gt_str.
CLEAR gv_table.

*--------------------------------------------------------------------------------------------------------------------------*
* 2. 싱가포르 공항에서 2시간 이상 운행되는 항공편은 기내식이 준비되어야 합니다. 기내식이 필요한 운항 일정을 Display 하기위해,
* SPFLI(운항 일정) 테이블을 활용해 출발도시가 'SINGAPORE'인 데이터들 중
* 비행시간이 2시간 이상인 데이터들의 Airline Code, Flight Connection Number,
*  Departure city, Arrival city, Flight time를 출력하도록 하세요.
*--------------------------------------------------------------------------------------------------------------------------*

TYPES : BEGIN OF ty_table2,
        s_airline_code TYPE spfli-carrid,
        s_flight_connection_number TYPE spfli-connid,
        s_departure_city TYPE spfli-cityfrom,
        s_arrival_city TYPE spfli-cityto,
        s_flight_time TYPE spfli-fltime,
        END OF ty_table2.

DATA : gv_table2 TYPE TABLE OF ty_table2.
DATA : gt_str2 TYPE ty_table2.

SELECT carrid connid cityfrom cityto fltime FROM spfli INTO TABLE gv_table2
WHERE fltime >= 120 AND cityfrom = 'SINGAPORE'.

cl_demo_output=>display( gv_table2 ).


CLEAR gv_table2.
CLEAR gt_str2.

**--------------------------------------------------------------------------------------------------------------------------*
** 3. spfli 테이블을 활용해  Airline Code가 'AA', 'AZ', 'DL'인 데이터들 중 Airline Code 별로 평균 이동 거리가
** 2,600 마일 이상인 데이터들의 Airline Code, 평균 이동 거리, 최대 이동 거리, 최소 이동거리를 출력하도록 하세요.
** CORRESPONDING FIELDS OF 사용하기(필드명에 근거하여 매핑)
** corresponding 쓸떈 별칭(as) 필수.
**--------------------------------------------------------------------------------------------------------------------------*

TYPES : BEGIN OF gt_num,
       carrid TYPE spfli-carrid,
       max_distance TYPE p DECIMALS 1,
       min_distance TYPE p DECIMALS 1,
       avg_distance TYPE p DECIMALS 1,
      END OF gt_num.

DATA gv_num TYPE gt_num.
DATA gt_itab TYPE TABLE OF gt_num.

SELECT carrid AS carrid AVG( distance ) AS avg_distance MAX( distance ) AS max_distance
MIN( distance ) AS min_distance
FROM spfli INTO  CORRESPONDING FIELDS OF TABLE gt_itab
WHERE carrid IN ( 'AA','AZ','DL' )
GROUP BY carrid
HAVING AVG( distance ) >= 2600.


cl_demo_output=>display( gt_itab ).





*--------------------------------------------------------------------------------------------------------------------------*
*4. 항공사 명칭/항공사 코드/항공편 연결 번호/항공편 일자/출발 도시/도착 도시/거리/거리 단위/
*    최대 좌석/점유 좌석/잔여 좌석을 구조로 갖는 테이블을 만들어 데이터를 출력하세요.
* 조건 1. 거리 단위가 마일일 경우 키로미터로 환산하고 거리 단위를 키로미터로 바꿔주세요.(직접 구글링 계산, 소수점 버림 함수- > ??? )
* 조건 2. 2019/01/01 이후 데이터만 출력하세요.
* 조건 3. 잔여 좌석이 남아있는 데이터만 오름차순으로 출력해주세요.
* 잔여 좌석은 seatsmax-seatsocc 로 계산하면 됩니다.
* 문제 푸는 동안 사용하는 DB 테이블은 SPFLI ,SCARR, SFLIGHT 입니다. (JOIN)
*--------------------------------------------------------------------------------------------------------------------------*

TYPES : BEGIN OF gt_str5,
        carrname TYPE scarr-carrname,
        carrid TYPE spfli-carrid,
        connid TYPE spfli-connid,
        fldate TYPE sflight-fldate,
        cityfrom TYPE spfli-cityfrom,
        cityto TYPE spfli-cityto,
        distance TYPE spfli-distance,
        distid TYPE spfli-distid,
        seatmax TYPE sflight-seatsmax,
        seatsoc TYPE sflight-seatsocc,
        seatrest TYPE i ,
        END OF gt_str5.

DATA gt_airinfo TYPE TABLE OF gt_str5.
DATA gs_airinfo TYPE gt_str5.

SELECT a~carrname , b~carrid , b~connid ,  c~fldate , b~cityfrom , b~cityto , b~distance , b~distid , c~seatsmax , c~seatsocc ,
 ( c~seatsmax - c~seatsocc ) AS s_rest_seat
FROM scarr AS a  INNER JOIN  spfli AS b ON a~carrid = b~carrid INNER JOIN sflight AS c ON b~carrid = c~carrid AND b~connid = c~connid
WHERE c~fldate >= '20190101' AND ( c~seatsmax - c~seatsocc ) >= 1
INTO TABLE @gt_airinfo.

SORT gt_airinfo BY seatrest ASCENDING fldate ASCENDING.

LOOP AT gt_airinfo INTO gs_airinfo.
    IF gs_airinfo-distid = 'MI'.
            gs_airinfo-distid = 'KM'.
            gs_airinfo-distance = trunc(  gs_airinfo-distance * ( '1.60934' ) ).
            MODIFY gt_airinfo FROM gs_airinfo INDEX sy-tabix.
            CLEAR gs_airinfo.
    ENDIF.

ENDLOOP.



cl_demo_output=>display( gt_airinfo ).

*--------------------------------------------------------------------------------------------------------------------------*
*참고 문제. spfli 테이블의 데이터를 활용해 다음 조건을 만족하는 모든 환승 경로를 찾아 출력하세요.
*--------------------------------------------------------------------------------------------------------------------------*
DATA: gt_flights  TYPE TABLE OF spfli,
      gs_flight1  TYPE spfli,
      gs_flight2  TYPE spfli.

SELECT * FROM spfli INTO TABLE gt_flights.

WRITE: AT 25 '< 환승 경로 탐지 프로그램 >', /.
SKIP 1.

LOOP AT gt_flights INTO gs_flight1 WHERE cityfrom = 'NEW YORK'.

  LOOP AT gt_flights INTO gs_flight2
    WHERE cityfrom = gs_flight1-cityto
      AND cityto   = 'SINGAPORE'.

    WRITE: / '환승 경로 발견!'.
    WRITE: / '-------------------------------------------------------------------'.
    WRITE: / '  1단계:', gs_flight1-carrid, gs_flight1-connid,
             ' | ', gs_flight1-cityfrom, ' -> ', gs_flight1-cityto.
    WRITE: / '  2단계:', gs_flight2-carrid, gs_flight2-connid,
             ' | ', gs_flight2-cityfrom, ' -> ', gs_flight2-cityto.
    WRITE: / '-------------------------------------------------------------------'.
    SKIP 1.

  ENDLOOP.

ENDLOOP.

IF sy-subrc <> 0.
  WRITE: / '검색된 환승 경로가 없습니다.'.
ENDIF.