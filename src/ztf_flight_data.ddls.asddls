@EndUserText.label: 'second CDS table function'
@ClientHandling.algorithm:#SESSION_VARIABLE
@ClientHandling.type: #CLIENT_DEPENDENT
define table function ZTF_FLIGHT_DATA
with parameters
    p_carrier_id : /dmo/carrier_id
  returns
    {
      key client          : abap.clnt;
      key carrier_id      : /dmo/carrier_id;
      key connection_id   : /dmo/connection_id;
      key flight_date     : /dmo/flight_date;
      price             : /dmo/flight_price;
      currency_code     : /dmo/currency_code;
      plane_type_id     : /dmo/plane_type_id;
      seats_max         : /dmo/plane_seats_max;
      seats_occupied    : /dmo/plane_seats_occupied;
    }
  implemented by method ZCL_FLIGHT_AMDP_CLASS=>GET_FLIGHTS;