CLASS zrp_xx_class_pool DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
    data: itab type table of string.
    methods: reach_to_mars.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zrp_xx_class_pool IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.
  me->reach_to_mars(  ).

  out->write( itab ).

  ENDMETHOD.
  METHOD reach_to_mars.
      data(lo_earth) = new zcl_earth(  ).
      data(lo_planet1) = new zcl_planet1(  ).
      data(lo_mars) = new zcl_mars(  ).

      data : lv_text type string.
      lv_text = lo_earth->start_engine(  ).
      append lv_text to itab.
      lv_text = lo_earth->leave_orbit(  ).
      append lv_text to itab.
      lv_text = lo_planet1->enter_orbit(  ).
      append lv_text to itab.
      lv_text = lo_planet1->leave_orbit(  ).
      append lv_text to itab.
      lv_text = lo_mars->enter_orbit(  ).
      append lv_text to itab.
      lv_text = lo_mars->explore_mars(  ).
      append lv_text to itab.

  ENDMETHOD.

ENDCLASS.
