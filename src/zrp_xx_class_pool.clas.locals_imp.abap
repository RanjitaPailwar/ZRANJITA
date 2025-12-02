*"* use this source file for the definition and implementation of
*"* local helper classes, interface definitions and type
*"* declarations

CLASS zcl_earth DEFINITION.

  PUBLIC SECTION.
    METHODS: start_engine
      RETURNING VALUE(r_value) TYPE string,
      leave_orbit
        RETURNING VALUE(r_value) TYPE string.

ENDCLASS.

CLASS zcl_earth IMPLEMENTATION.
  METHOD start_engine.
    r_value = 'We take off from the Planet earth for our mission Mars'.
  ENDMETHOD.
  METHOD leave_orbit.
    r_value = 'We leave Earth Orbit'.
  ENDMETHOD.
ENDCLASS.

CLASS zcl_planet1 DEFINITION.
PuBLIC SECTION.
  METHODS: enter_orbit
    RETURNING VALUE(r_value) TYPE string,
    leave_orbit
      RETURNING VALUE(r_value) TYPE string.
ENDCLASS.

CLASS zcl_planet1 IMPLEMENTATION.
METHOD enter_orbit.
    r_value = 'We enter Planet1 Orbit'.
  ENDMETHOD.
  METHOD leave_orbit.
    r_value = 'We leave Plant1 Orbit'.
  ENDMETHOD.
ENDCLASS.

CLASS zcl_mars DEFINITION.
puBLIC SECTION.
  METHODS: enter_orbit
    RETURNING VALUE(r_value) TYPE string,
    explore_mars
      RETURNING VALUE(r_value) TYPE string.
ENDCLASS.

CLASS zcl_mars IMPLEMENTATION.
METHOD enter_orbit.
    r_value = 'We enter in Mars Orbit'.
  ENDMETHOD.
  METHOD explore_mars.
    r_value = 'Roger! we have found water on Mars'.
  ENDMETHOD.
ENDCLASS.
