CLASS zrp_xx_eml DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    DATA: lv_oper TYPE c VALUE 'C'.
    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zrp_xx_eml IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.
    CASE lv_oper.
      WHEN 'R'.

        READ ENTITIES OF zrp_xx_travel
        ENTITY Travel
        ALL FIELDS WITH
        VALUE #( ( TravelId = '00000008' )
                 ( TravelId = '00000009' )
                 ( TravelId = '00000001' ) )
          RESULT DATA(lt_result)
          FAILED DATA(lt_failed)
          REPORTED DATA(lt_messages).

        out->write( lt_result ) .
        out->write( lt_failed ) .
        out->write( lt_messages ) .


      WHEN 'C'.
        DATA(lv_description) = 'RAP with Ranjita'.
        DATA(lv_Agency) = '070016'.
        DATA(lv_customer) = '000699'.

        MODIFY ENTITIES OF zrp_xx_travel
        ENTITY Travel
        CREATE FIELDS ( TravelId AgencyId CustomerId BeginDate EndDate Description OverallStatus )
         WITH VALUE #(
         (
            %cid = 'RANJITA'
            TravelId = '0089567'
            AgencyId = lv_Agency
            CustomerId = lv_customer
            BeginDate = cl_abap_context_info=>get_system_date( )
            EndDate = cl_abap_context_info=>get_system_date( ) + 30
            Description = lv_description
            OverallStatus = 'N'

          )
           (
            %cid = 'Vedika'
            TravelId = '0089566'
            AgencyId = lv_Agency
            CustomerId = lv_customer
            BeginDate = cl_abap_context_info=>get_system_date( )
            EndDate = cl_abap_context_info=>get_system_date( ) + 30
            Description = lv_description
            OverallStatus = 'N'

         )
             (
             %cid = 'Vaani'
            TravelId = '00000008'
            AgencyId = lv_Agency
            CustomerId = lv_customer
            BeginDate = cl_abap_context_info=>get_system_date( )
            EndDate = cl_abap_context_info=>get_system_date( ) + 30
            Description = lv_description
            OverallStatus = 'N'

         )
          )

       MAPPED DATA(lt_mapped)
       FAILED lt_failed
       REPORTED lt_messages.

        COMMIT ENTITIES.
        out->write( lt_mapped ) .
        out->write( lt_failed ) .
        out->write( lt_messages ) .

      WHEN 'U'.

        lv_description = 'Ranjita'.
        lv_agency = '070004'.
        MODIFY ENTITIES OF zrp_xx_travel
          ENTITY Travel
              UPDATE FIELDS (  AgencyId  Description  )
           WITH VALUE #(
           (


              AgencyId = lv_Agency
              Description = lv_description


            )
             (


              AgencyId = lv_Agency
              Description = lv_description


           )

            )

         MAPPED lt_mapped
         FAILED lt_failed
         REPORTED lt_messages.

        COMMIT ENTITIES.
        out->write( lt_mapped ) .
        out->write( lt_failed ) .
        out->write( lt_messages ) .

      WHEN 'D'.

    ENDCASE.
  ENDMETHOD.
ENDCLASS.
