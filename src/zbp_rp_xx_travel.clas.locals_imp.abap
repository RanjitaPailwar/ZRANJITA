CLASS lhc_Travel DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.

    METHODS get_instance_authorizations FOR INSTANCE AUTHORIZATION
      IMPORTING keys REQUEST requested_authorizations FOR Travel RESULT result.

    METHODS get_global_authorizations FOR GLOBAL AUTHORIZATION
      IMPORTING REQUEST requested_authorizations FOR Travel RESULT result.
    METHODS copyTravel FOR MODIFY
      IMPORTING keys FOR ACTION Travel~copyTravel.
    METHODS earlynumbering_create FOR NUMBERING
      IMPORTING entities FOR CREATE Travel.

    METHODS earlynumbering_cba_Booking FOR NUMBERING
      IMPORTING entities FOR CREATE Travel\_Booking.

ENDCLASS.

CLASS lhc_Travel IMPLEMENTATION.

  METHOD get_instance_authorizations.
  ENDMETHOD.

  METHOD get_global_authorizations.
  ENDMETHOD.

  METHOD earlynumbering_create.
    DATA : entity        TYPE STRUCTURE FOR CREATE zrp_xx_travel,
           travel_id_max TYPE /dmo/travel_id.
*  Write logic to resolve the empty primary key problem for travel
*Step1: we will ensure that the travel Id is not set for the record which is coming
    LOOP AT entities INTO entity WHERE TravelId IS NOT INITIAL.

      APPEND CORRESPONDING #( entity ) TO mapped-travel.

    ENDLOOP.
*Step2: Get the sequence number from SNRO
    DATA(entities_wo_travelid) = entities.
    DELETE entities_wo_travelid WHERE TravelId IS NOT INITIAL.
    TRY.
        cl_numberrange_runtime=>number_get(
          EXPORTING
*    ignore_buffer     =
            nr_range_nr       = '01'
            object            = '/DMO/TRAVL'
            quantity          =  CONV #( lines( entities_wo_travelid ) )
          IMPORTING
            number            = DATA(number_range_key)
            returncode        = DATA(number_range_return_code)
            returned_quantity = DATA(number_range_return_quantity)
        ).
*CATCH cx_nr_object_not_found.
      CATCH cx_number_ranges INTO DATA(lx_number_ranges).
*Step3: If there is an exception will throw error
        LOOP AT entities_wo_travelid INTO entity.
          APPEND VALUE #( %cid = entity-%cid
                         %key = entity-%key
                         %msg = lx_number_ranges ) TO reported-travel.

          APPEND VALUE #( %cid = entity-%cid
                          %key = entity-%key ) TO failed-travel.
        ENDLOOP.
        EXIT.
    ENDTRY.
    CASE number_range_return_code.
      WHEN '1'.
*  Step4: Handle the special cases where the number range exceeds the critical percantage
        LOOP AT entities_wo_travelid INTO entity.
          APPEND VALUE #( %cid = entity-%cid
                         %key = entity-%key
                         %msg = NEW /dmo/cm_flight_messages(
             textid                = /dmo/cm_flight_messages=>number_range_depleted

            severity              = if_abap_behv_message=>severity-warning )
            ) TO reported-travel.

        ENDLOOP.
      WHEN '2' OR '3'.
*  Step5: The number range returns the last number, or the number range gets exhuasted
        LOOP AT entities_wo_travelid INTO entity.
          APPEND VALUE #( %cid = entity-%cid
                         %key = entity-%key
                         %msg = NEW /dmo/cm_flight_messages(
             textid                = /dmo/cm_flight_messages=>not_sufficient_numbers

            severity              = if_abap_behv_message=>severity-warning )
            ) TO reported-travel.

          APPEND VALUE #( %cid = entity-%cid
                           %key = entity-%key
                           %fail-cause = if_abap_behv=>cause-conflict
                           ) TO failed-travel.
        ENDLOOP.
    ENDCASE.



*Step6: Final check or all the numbers

    ASSERT number_range_return_quantity = lines( entities_wo_travelid ).
*Step7: Loop over all the incoming travel data and assign the numbers from the no range and return
*mapped data which will then go the RAP Framework

    travel_id_max = number_range_key - number_range_return_quantity.

    LOOP AT entities_wo_travelid INTO entity.
      travel_id_max += 1.

      entity-TravelId = travel_id_max.

      APPEND VALUE #(
                    %cid = entity-%cid
                    %key = entity-%key ) TO mapped-travel.

    ENDLOOP.
  ENDMETHOD.

  METHOD earlynumbering_cba_Booking.
    DATA: max_booking_id TYPE /dmo/booking_id.
*  Step1 :- Get all the travel requests and their booking data
    READ ENTITIES OF zrp_xx_travel IN LOCAL MODE
    ENTITY travel BY \_Booking
    FROM CORRESPONDING #( entities )
    LINK DATA(bookings).

    LOOP AT entities ASSIGNING FIELD-SYMBOL(<travel_group>)
    GROUP BY <travel_group>-TravelId.

*  Step2:- Get the highest booking number which is already there
      LOOP AT bookings INTO DATA(ls_bookings) USING KEY entity
        WHERE source-TravelId = <travel_group>-TravelId.

        IF max_booking_id < ls_bookings-target-BookingId.
          max_booking_id = ls_bookings-target-BookingId.
        ENDIF.

      ENDLOOP.
*  Step3:- Get the assigned booking numbers for the incoming requests
      LOOP AT entities INTO DATA(ls_entity) USING KEY entity
        WHERE TravelId = <travel_group>-TravelId.

        LOOP AT ls_entity-%target INTO DATA(ls_target) .
          IF max_booking_id < ls_target-BookingId.
            max_booking_id = ls_target-BookingId.
          ENDIF.
        ENDLOOP.

      ENDLOOP.
* Step4:- we will Loop over the enetites of the travel with the same travel id.
      LOOP AT entities ASSIGNING FIELD-SYMBOL(<travel>) USING KEY entity
      WHERE TravelId = <travel_group>-TravelId.

      ENDLOOP.
* Step5:- assign new booking ids to the booking entity inside each travel
      LOOP AT <travel>-%target ASSIGNING FIELD-SYMBOL(<booking_wo_numbers>).
        APPEND CORRESPONDING #( <booking_wo_numbers> )
        TO mapped-booking ASSIGNING FIELD-SYMBOL(<mapped_booking>).
        IF <mapped_booking>-BookingId IS INITIAL.
          max_booking_id += 10.
          <mapped_booking>-BookingId = max_booking_id.
        ENDIF.
      ENDLOOP.
    ENDLOOP.
  ENDMETHOD.

  METHOD copyTravel.
* Create internal table for travel, booking and booking Suppl
data: travels type table for create zrp_xx_travel\\Travel,
      bookings_cba type table for create zrp_xx_travel\\Travel\_Booking,
      booksupp_cba type table for create zrp_xx_travel\\Booking\_BookingSupplement.


*  This is the method where we will write our logic for Copy Travel data action.
* Step1:- Remove all the instances with empty container id %CID
 READ TABLE keys wITH KEY %CID = '' iNTO data(key_with_initial_cid).

* Step2:- We will Read all the Travel data and its composition child Booking and
* Booking supplement data using EML {Parent and its childs }
* Step3:- Fill the Travel internal table for travel data creation-%CID
* Step4:- Fill the Booking internal table for booking creation - %CID_REF
* Step5:- Fill the Booking supplement internal table for booking suppl creation
* Step6:- Modify Entity EML to create new BO instance using the existing data

  ENDMETHOD.

ENDCLASS.
