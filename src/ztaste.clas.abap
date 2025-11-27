CLASS ztaste DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
    class-METHODS : sum_two_number iMPORTING p_num1 tYPE i
                                             p_num2 tYPE i
                                   expORTING output_sum tyPE i.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS ZTASTE IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.

  ztaste=>sum_two_number(
    EXPORTING
      p_num1     =  40
      p_num2     =  50
    IMPORTING
      output_sum = data(lv_output)
  ).

  out->write(
    EXPORTING
      data   = |sum of two numbers are = { lv_output }|



  ).
  ENDMETHOD.


     METHOD sum_two_number.
   output_sum = p_num1 + p_num2.
  ENDMETHOD.
ENDCLASS.
