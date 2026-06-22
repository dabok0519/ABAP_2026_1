*&---------------------------------------------------------------------*
*& Report z_180_car
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z_180_car.

types : beGIN OF str_car,
        brand(40) type c ,
        model(40) type c ,
        mileage type i,
        fueltank_cap type i,
        fuel_efficiency(6) type c,
        end of str_car.

data coolcar type str_car.
PARAMETERS : trip_f type i , trip_m type i, country type c .

data result type f.


coolcar-brand = 'Mercedes'.
coolcar-model = 'SLR'.
coolcar-mileage = '10524'.
coolcar-fueltank_cap = '70'.


CASE country.
    WHEN 'G'.
     result = trip_f / ( trip_m / 100 ).

endcase.

WRITE : |  BRAND : { coolcar-brand } model : { coolcar-model } mileage : { coolcar-mileage } fueltank_cap : { coolcar-fueltank_cap } |.
