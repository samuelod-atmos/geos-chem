!------------------------------------------------------------------------------
!                  GEOS-Chem Global Chemical Transport Model                  !
!------------------------------------------------------------------------------
!BOP
!
! !MODULE: gc_environment_mod.F90
!
! !DESCRIPTION: Module GC\_ENVIRONMENT\_MOD establishes the runtime
!  environment for the GEOS-Chem.  It is designed to receive model parameter
!  and geophysical environment information and allocate memory based upon it.
!\\
!\\
!  It provides routines to do the following:
!
! \begin{itemize}
! \item Allocate geo-spatial arrays
! \item Initialize met. field derived type.
! \item Initialize Chemistry, Metorology, Emissions, and Physics States
! \end{itemize}
!
! !INTERFACE:
!
MODULE GC_Environment_Mod
!
! !USES
!
  USE Precision_Mod

  IMPLICIT NONE
  PRIVATE
!
! !PUBLIC MEMBER FUNCTIONS:
!
  PUBLIC  :: GC_Allocate_All
  PUBLIC  :: GC_Init_StateObj
  PUBLIC  :: GC_Init_Grid
  PUBLIC  :: GC_Init_Extra
!
! !PRIVATE MEMBER FUNCTIONS:
!
#ifdef TOMAS
  PRIVATE :: INIT_TOMAS_MICROPHYSICS
#endif
!
! !REMARKS:
!  For consistency, we should probably move the met state initialization
!  to the same module where the met state derived type is contained.
!
! !REVISION HISTORY:
!  26 Jan 2012 - M. Long     - Created module file
!  See https://github.com/geoschem/geos-chem for complete history
!EOP
!------------------------------------------------------------------------------
!BOC
CONTAINS
!EOC
!------------------------------------------------------------------------------
!                  GEOS-Chem Global Chemical Transport Model                  !
!------------------------------------------------------------------------------
!BOP
!
! !IROUTINE: gc_allocate_all
!
! !DESCRIPTION: Subroutine GC\_ALLOCATE\_ALL allocates all LAT/LON
!  ALLOCATABLE arrays for global use by the GEOS-Chem either as a standalone
!  program or module.
!\\
!\\
! !INTERFACE:
!
  SUBROUTINE GC_Allocate_All( Input_Opt,                        &
                              State_Grid,      RC,              &
                              value_I_LO,      value_J_LO,      &
                              value_I_HI,      value_J_HI,      &
                              value_IM,        value_JM,        &
                              value_LM,                         &
                              value_IM_WORLD,  value_JM_WORLD,  &
                              value_LM_WORLD,  value_LLSTRAT )
!
! !USES:
!
#ifdef FASTJX
    USE CMN_FJX_Mod,     ONLY : Init_CMN_FJX
#endif
    USE ErrCode_Mod
    USE Input_Opt_Mod
    USE State_Grid_Mod,  ONLY : GrdState

    IMPLICIT NONE
!
! !INPUT PARAMETERS:
!
    TYPE(GrdState), INTENT(IN)    :: State_Grid       ! Grid State object
    INTEGER,        OPTIONAL      :: value_I_LO       ! Min local lon index
    INTEGER,        OPTIONAL      :: value_J_LO       ! Min local lat index
    INTEGER,        OPTIONAL      :: value_I_HI       ! Max local lon index
    INTEGER,        OPTIONAL      :: value_J_HI       ! Max local lat index
    INTEGER,        OPTIONAL      :: value_IM         ! Local # of lons
    INTEGER,        OPTIONAL      :: value_JM         ! Local # of lats
    INTEGER,        OPTIONAL      :: value_LM         ! Local # of levels
    INTEGER,        OPTIONAL      :: value_IM_WORLD   ! Global # of lons
    INTEGER,        OPTIONAL      :: value_JM_WORLD   ! Global # of lats
    INTEGER,        OPTIONAL      :: value_LM_WORLD   ! Global # of levels
    INTEGER,        OPTIONAL      :: value_LLSTRAT    ! # of strat. levels
!
! !INPUT/OUTPUT PARAMETERS:
!
    TYPE(OptInput), INTENT(INOUT) :: Input_Opt        ! Input Options object
!
! !OUTPUT PARAMETERS:
!
    INTEGER,        INTENT(OUT)   :: RC               ! Success or failure?
!
! !REMARKS:
!  For error checking, return up to the main routine w/ an error code.
!  This can be improved upon later.
!
! !REVISION HISTORY:
!  26 Jan 2012 - M. Long     - Initial version
!  See https://github.com/geoschem/geos-chem for complete history
!EOP
!------------------------------------------------------------------------------
!BOC

#ifdef MODEL_GEOS
    ! Integers
    INTEGER            :: LLTROP
#endif

    ! Strings
    INTEGER            :: LLSTRAT
    CHARACTER(LEN=255) :: ErrMsg, ThisLoc

    !=======================================================================
    ! GC_Allocate_All begins here!
    !=======================================================================

    ! Initialize
    RC       = GC_SUCCESS
    ErrMsg   = ''
    ThisLoc  = &
       ' -> at GC_Allocate_All  (in module GeosCore/gc_environment_mod.F90)'

#ifdef FASTJX
    ! Throw an error if FAST-JX is used for simulations other than Hg
    IF ( .not. Input_Opt%ITS_A_MERCURY_SIM ) THEN
       ErrMsg = 'FAST-JX is only supported in the Hg simulation!'
       CALL GC_Error( ErrMsg, RC, ThisLoc )
       RETURN
    ENDIF

    ! Initialize CMN_FJX_mod.F90
    CALL Init_CMN_FJX( Input_Opt,State_Grid, RC )

    ! Trap potential errors
    IF ( RC /= GC_SUCCESS ) THEN
       ErrMsg = 'Error encountered within call to "Init_CMN_FJX"!'
       CALL GC_Error( ErrMsg, RC, ThisLoc )
       RETURN
    ENDIF
#endif

  END SUBROUTINE GC_Allocate_All
!EOC
!------------------------------------------------------------------------------
!                  GEOS-Chem Global Chemical Transport Model                  !
!------------------------------------------------------------------------------
!BOP
!
! !IROUTINE: gc_init_stateobj
!
! !DESCRIPTION: Subroutine GC\_INIT\_STATEOBJ initializes the top-level data
!  structures that are either passed to/from GC or between GC components
!  (emis->transport->chem->diagnostics->etc)
!\\
!\\
! !INTERFACE:
!
  SUBROUTINE GC_Init_StateObj( Diag_List, TaggedDiag_List, Input_Opt,   &
                               State_Chm, State_Diag,      State_Grid,  &
                               State_Met, RC                           )
!
! !USES:
!
    USE DiagList_Mod
    USE TaggedDiagList_Mod
    USE Diagnostics_Mod
    USE ErrCode_Mod
    USE Input_Opt_Mod
    USE State_Chm_Mod
    USE State_Grid_Mod
    USE State_Met_Mod
    USE State_Diag_Mod
!
! !INPUT PARAMETERS:
!
    TYPE(DgnList),       INTENT(IN)    :: Diag_List   ! Diagnostics list object
    TYPE(TaggedDgnList), INTENT(IN)    :: TaggedDiag_List
!
! !INPUT/OUTPUT PARAMETERS:
!
    TYPE(OptInput),      INTENT(INOUT) :: Input_Opt   ! Input Options object
    TYPE(ChmState),      INTENT(INOUT) :: State_Chm   ! Chemistry State object
    TYPE(DgnState),      INTENT(INOUT) :: State_Diag  ! Diagnostics State object
    TYPE(GrdState),      INTENT(INOUT) :: State_Grid  ! Grid State object
    TYPE(MetState),      INTENT(INOUT) :: State_Met   ! Meteorology State object
!
! !OUTPUT PARAMETERS:
!
    INTEGER,             INTENT(OUT)   :: RC          ! Success or failure
!
! !REMARKS:
!  Need to add better error checking, currently we just return upon error.
!
! !REVISION HISTORY:
!  26 Jan 2012 - M. Long     - Initial version
!  See https://github.com/geoschem/geos-chem for complete history
!EOP
!------------------------------------------------------------------------------
!BOC
!
! !LOCAL VARIABLES:
!
    CHARACTER(LEN=255) :: ErrMsg, ThisLoc

    !=======================================================================
    ! Initialize
    !=======================================================================
    ErrMsg  = ''
    ThisLoc = ' -> at GC_Init_StateObj (in GeosCore/gc_environment_mod.F90)'

    !=======================================================================
    ! Initialize the Chemistry State object
    !=======================================================================
    CALL Init_State_Chm(  Input_Opt  = Input_Opt,   &  ! Input Options
                          State_Chm  = State_Chm,   &  ! Chemistry State
                          State_Grid = State_Grid,  &  ! Grid State
                          RC         = RC          )   ! Success or failure

    ! Trap potential errors
    IF ( RC /= GC_SUCCESS ) THEN
       ErrMsg = 'Error encountered within call to "Init_State_Chm"!'
       CALL GC_Error( ErrMsg, RC, ThisLoc )
       RETURN
    ENDIF

    !=======================================================================
    ! Initialize the Diagnostics State object
    !=======================================================================
    CALL Init_State_Diag( Input_Opt       = Input_Opt,                      &  
                          State_Chm       = State_Chm,                      &  
                          State_Grid      = State_Grid,                     &  
                          Diag_List       = Diag_List,                      &  
                          TaggedDiag_List = TaggedDiag_List,                &
                          State_Diag      = State_Diag,                     &  
                          RC              = RC                             )   

    ! Trap potential errors
    IF ( RC /= GC_SUCCESS ) THEN
       ErrMsg = 'Error encountered within call to "Init_State_Diag"!'
       CALL GC_Error( ErrMsg, RC, ThisLoc )
       RETURN
    ENDIF

    !=======================================================================
    ! Initialize the Meteorology State object
    !=======================================================================
    CALL Init_State_Met( Input_Opt   = Input_Opt,   &  ! Input Options
                         State_Grid  = State_Grid,  &  ! Grid State
                         State_Met   = State_Met,   &  ! Meteorology State
                         RC          = RC          )   ! Success or failure?

    ! Trap potential errors
    IF ( RC /= GC_SUCCESS ) THEN
       ErrMsg = 'Error encountered within call to "Init_State_Met"!'
       CALL GC_Error( ErrMsg, RC, ThisLoc )
       RETURN
    ENDIF

  END SUBROUTINE GC_Init_StateObj
!EOC
!------------------------------------------------------------------------------
!                  GEOS-Chem Global Chemical Transport Model                  !
!------------------------------------------------------------------------------
!BOP
!
! !IROUTINE: gc_init_grid
!
! !DESCRIPTION: Subroutine GC\_INIT\_GRID calls routines from
!  gc\_grid\_mod.F90 to initialize the horizontal grid parameters.
!\\
!\\
! !INTERFACE:
!
  SUBROUTINE GC_Init_Grid( Input_Opt, State_Grid, RC )
!
! !USES:
!
    USE ErrCode_Mod
#if !(defined( EXTERNAL_GRID ) || defined( EXTERNAL_FORCING ))
    USE GC_Grid_Mod,        ONLY : Compute_Grid
#endif
    USE Input_Opt_Mod,      ONLY : OptInput
    USE State_Grid_Mod,     ONLY : Allocate_State_Grid
    USE State_Grid_Mod,     ONLY : GrdState
!
! !INPUT PARAMETERS:
!
    TYPE(OptInput), INTENT(IN)    :: Input_Opt   ! Input Options object
!
! !INPUT/OUTPUT PARAMETERS:
!
    TYPE(GrdState), INTENT(INOUT) :: State_Grid  ! Grid State object
!
! !OUTPUT PARAMETERS:
!
    INTEGER,        INTENT(OUT)   :: RC          ! Success or failure?
!
! !REMARKS:
!  The module grid_mod.F90 has been modified to save grid parameters in 3D
!  format, which will facilitate interfacing GEOS-Chem to a GCM.
!                                                                             .
!  The module global_grid_mod.F90 contains several of the global grid arrays
!  (*_g) originally in grid_mod.F. These arrays are used in regridding GFED3
!  biomass emissions, which are available on a 0.5x0.5 global grid. The global
!  arrays may need to be used in the future for regridding other emissions for
!  nested grids.
!                                                                             .
! !REVISION HISTORY:
!  01 Mar 2012 - R. Yantosca - Initial version
!  See https://github.com/geoschem/geos-chem for complete history
!EOP
!------------------------------------------------------------------------------
!BOC
!
! !LOCAL VARIABLES:
!
    CHARACTER(LEN=255) :: ErrMsg, ThisLoc

    !=================================================================
    ! Define inputs depending on the grid that is selected
    !=================================================================

    ! Initialize
    RC      = GC_SUCCESS
    ErrMsg  = ''
    ThisLoc = &
       ' -> at GC_Init_Grid (in module GeosCore/gc_environment_mod.F90)'

    !=================================================================
    ! Initialize the horizontal grid
    !=================================================================

    ! Allocate State_Grid arrays
    CALL Allocate_State_Grid( Input_Opt, State_Grid, RC )
    IF ( RC /= GC_SUCCESS ) THEN
       ErrMsg = 'Error encountered in "Compute_Grid"!'
       CALL GC_Error( ErrMsg, RC, ThisLoc )
       RETURN
    ENDIF

#if !(defined( EXTERNAL_GRID ) || defined( EXTERNAL_FORCING ))
    ! Compute the grid centers & edges
    ! (skip if using an external model like GCHP or NASA/GEOS)
    CALL Compute_Grid( Input_Opt, State_Grid, RC)
    IF ( RC /= GC_SUCCESS ) THEN
       ErrMsg = 'Error encountered in "Compute_Grid"!'
       CALL GC_Error( ErrMsg, RC, ThisLoc )
       RETURN
    ENDIF
#endif

  END SUBROUTINE GC_Init_Grid
!EOC
!------------------------------------------------------------------------------
!                  GEOS-Chem Global Chemical Transport Model                  !
!------------------------------------------------------------------------------
!BOP
!
! !IROUTINE: gc_init_extra
!
! !DESCRIPTION: Suborutine GC\_INIT\_EXTRA initializes other GEOS-Chem
!  modules that have not been initialized in either GC\_Allocate\_All or
!  GC\_Init\_all.
!\\
!\\
! !INTERFACE:
!
  SUBROUTINE GC_Init_Extra( Diag_List,  Input_Opt,  State_Chm, &
                            State_Diag, State_Grid, RC )
!
! !USES:
!
    USE Aerosol_Mod,        ONLY : Init_Aerosol
    USE Carbon_Mod,         ONLY : Init_Carbon
    USE Carbon_Gases_Mod,   ONLY : Init_Carbon_Gases
    USE CO2_Mod,            ONLY : Init_CO2
    USE Depo_Mercury_Mod,   ONLY : Init_Depo_Mercury
    USE DiagList_Mod,       ONLY : DgnList
    USE Drydep_Mod,         ONLY : Init_Drydep
    USE Dust_Mod,           ONLY : Init_Dust
    USE ErrCode_Mod
    USE Error_Mod,          ONLY : Debug_Msg
    USE FullChem_Mod,       ONLY : Init_FullChem
    USE Get_Ndep_Mod,       ONLY : Init_Get_Ndep
    USE Global_CH4_Mod,     ONLY : Init_Global_CH4
    USE Input_Mod,          ONLY : Do_Error_Checks
    USE Input_Opt_Mod,      ONLY : OptInput
    USE Land_Mercury_Mod,   ONLY : Init_Land_Mercury
    USE Mercury_Mod,        ONLY : Init_Mercury
    USE Ocean_Mercury_Mod,  ONLY : Init_Ocean_Mercury
    USE POPs_Mod,           ONLY : Init_POPs
    USE Pressure_Mod,       ONLY : Init_Pressure
    USE Seasalt_Mod,        ONLY : Init_SeaSalt
    USE State_Chm_Mod,      ONLY : ChmState
    USE State_Diag_Mod,     ONLY : DgnState
    USE State_Grid_Mod,     ONLY : GrdState
    USE Sulfate_Mod,        ONLY : Init_Sulfate
    USE Tagged_CO_Mod,      ONLY : Init_Tagged_CO
    USE Tagged_O3_Mod,      ONLY : Init_Tagged_O3
    USE Vdiff_Mod,          ONLY : Init_Vdiff
    USE WetScav_Mod,        ONLY : Init_WetScav
!
! !INPUT PARAMETERS:
!
    TYPE(DgnList ), INTENT(IN)    :: Diag_List   ! Diagnostics list object
    TYPE(GrdState), INTENT(IN)    :: State_Grid  ! Grid State object
!
! !INPUT/OUTPUT PARAMETERS:
!
    TYPE(OptInput), INTENT(INOUT) :: Input_Opt   ! Input Options object
    TYPE(ChmState), INTENT(INOUT) :: State_Chm   ! Chemistry state object
    TYPE(DgnState), INTENT(INOUT) :: State_Diag  ! Diagnostics State object
!
! !INPUT/OUTPUT PARAMETERS:
!
    INTEGER,        INTENT(OUT)   :: RC          ! Success or failure?
!
! !REMARKS:
!  Several of the INIT routines now called within GC_Init_Extra had
!  originally been called from the Run method.  We now gather these INIT
!  routines here so that they may be called from the Initialization method.
!  This is necessary when connecting GEOS-Chem to the GEOS-5 GCM via ESMF.
!                                                                             .
!  Also note: In the case of a GEOS-Chem dry-run simulation, we will call
!  these initialization routines, but exit them before any arrays get
!  allocated.  This will help to reduce the amount of memory used.
!                                                                             .
! !REVISION HISTORY:
!  04 Mar 2013 - R. Yantosca - Initial revision
!  See https://github.com/geoschem/geos-chem for complete history
!EOP
!------------------------------------------------------------------------------
!BOC
!
! !LOCAL VARIABLES:
!
    CHARACTER(LEN=255) :: ErrMsg, ThisLoc

    !=======================================================================
    ! GC_Init_Extra begins here!
    !=======================================================================

    ! Initialize
    RC        = GC_SUCCESS
    ErrMsg    = ''
    ThisLoc   = &
       ' -> at GC_Init_Extra (in module GeosCore/gc_environment_mod.F90)'

    !=======================================================================
    ! Do some error checking before initializing modules
    !=======================================================================

    ! Make sure various input options are consistent with the
    ! species that are defined for the simulation
    CALL Do_Error_Checks( Input_Opt, RC )
    IF ( RC /= GC_SUCCESS ) THEN
       ErrMsg = 'Error encountered in "Do_Error_Checks"!'
       CALL GC_Error( ErrMsg, RC, ThisLoc )
       RETURN
    ENDIF

    !=======================================================================
    ! Initialize the hybrid pressure module.  Define Ap and Bp.
    !=======================================================================
    CALL Init_Pressure( Input_Opt, State_Grid, RC )
    IF ( RC /= GC_SUCCESS ) THEN
       ErrMsg = 'Error encountered in "Init_Pressure"!'
       CALL GC_Error( ErrMsg, RC, ThisLoc )
       RETURN
    ENDIF

    !=======================================================================
    ! Call setup routines for drydep
    !=======================================================================
    IF ( Input_Opt%LDRYD ) THEN

       ! Setup for dry deposition
       CALL Init_DryDep( Input_Opt,  State_Chm, State_Diag, State_Grid, RC )
       IF ( RC /= GC_SUCCESS ) THEN
          ErrMsg = 'Error encountered in "Init_Drydep"!'
          CALL GC_Error( ErrMsg, RC, ThisLoc )
          RETURN
       ENDIF
    ENDIF

    ! Exit for dry-run simulations
    IF ( Input_Opt%DryRun ) RETURN

    !=================================================================
    ! Call setup routines for wetdep
    !
    ! We need to initialize the wetdep module if either wet
    ! deposition or convection is turned on, so that we can do the
    ! large-scale and convective scavenging.  Also initialize the
    ! wetdep module if both wetdep and convection are turned off,
    ! but chemistry is turned on.  The INIT_WETSCAV routine will also
    ! allocate the H2O2s and SO2s arrays that are referenced in the
    ! convection code. (bmy, 9/23/15)
    !=================================================================
    IF ( Input_Opt%LCONV   .or.                                              &
         Input_Opt%LWETD   .or.                                              &
         Input_Opt%LCHEM ) THEN
       CALL Init_WetScav( Input_Opt, State_Chm, State_Diag, State_Grid, RC )
       IF ( RC /= GC_SUCCESS ) THEN
          ErrMsg = 'Error encountered in "Init_Wetscav"!'
          CALL GC_Error( ErrMsg, RC, ThisLoc )
          RETURN
       ENDIF
    ENDIF

    !=================================================================
    ! Call setup routines from other F90 modules
    !=================================================================

    !-----------------------------------------------------------------
    ! Call Init_VDIFF so that we can pass several values from
    ! Input_Opt to the vdiff_mod.F90. This has to be called
    ! after the geoschem_config.yml file has been read from disk.
    !-----------------------------------------------------------------
    IF ( Input_Opt%LTURB .and. Input_Opt%LNLPBL ) THEN
       CALL Init_Vdiff( Input_Opt, State_Chm, State_Grid, RC )
       IF ( RC /= GC_SUCCESS ) THEN
          ErrMsg = 'Error encountered in "Init_Vdiff"!'
          CALL GC_Error( ErrMsg, RC, ThisLoc )
          RETURN
       ENDIF
    ENDIF

    !-----------------------------------------------------------------
    ! Initialize the GET_NDEP_MOD for soil NOx deposition (bmy, 6/17/16)
    !-----------------------------------------------------------------
    CALL Init_Get_Ndep( Input_Opt, State_Chm, State_Diag, RC  )
    IF ( RC /= GC_SUCCESS ) THEN
       ErrMsg = 'Error encountered in "Init_Get_Ndep"!'
       CALL GC_Error( ErrMsg, RC, ThisLoc )
       RETURN
    ENDIF

    !-----------------------------------------------------------------
    ! Initialize "carbon_mod.F90"
    !-----------------------------------------------------------------
    IF ( Input_Opt%LCARB ) THEN
       CALL Init_Carbon( Input_Opt, State_Chm, State_Diag, State_Grid, RC )
       IF ( RC /= GC_SUCCESS ) THEN
          ErrMsg = 'Error encountered in ""!'
          CALL GC_Error( ErrMsg, RC, ThisLoc )
          RETURN
       ENDIF
    ENDIF

    !-----------------------------------------------------------------
    ! Initialize "dust_mod.F90"
    !-----------------------------------------------------------------
    IF ( Input_Opt%LDUST ) then
       CALL Init_Dust( Input_Opt, State_Chm, State_Diag, State_Grid, RC )
       IF ( RC /= GC_SUCCESS ) THEN
          ErrMsg = 'Error encountered in "Init_Dust"!'
          CALL GC_Error( ErrMsg, RC, ThisLoc )
          RETURN
       ENDIF
    ENDIF

    !-----------------------------------------------------------------
    ! Initialize "seasalt_mod.F90"
    !-----------------------------------------------------------------
    IF ( Input_Opt%LSSALT ) THEN
       CALL Init_Seasalt( Input_Opt, State_Chm, State_Diag, State_Grid, RC )
       IF ( RC /= GC_SUCCESS ) THEN
          ErrMsg = 'Error encountered in "Init_Seasalt"!'
          CALL GC_Error( ErrMsg, RC, ThisLoc )
          RETURN
       ENDIF
    ENDIF

    !-----------------------------------------------------------------
    ! Initialize "sulfate_mod.F90"
    !-----------------------------------------------------------------
    IF ( Input_Opt%LSULF ) THEN
       CALL Init_Sulfate( Input_Opt, State_Chm, State_Diag, State_Grid, RC )
       IF ( RC /= GC_SUCCESS ) THEN
          ErrMsg = 'Error encountered in "Init_Sulfate"!'
          CALL GC_Error( ErrMsg, RC, ThisLoc )
          RETURN
       ENDIF
    ENDIF

    !-----------------------------------------------------------------
    ! Initialize "aerosol_mod.F90"
    !-----------------------------------------------------------------
    IF ( Input_Opt%ITS_A_FULLCHEM_SIM .or. &
         Input_Opt%ITS_AN_AEROSOL_SIM ) THEN
       CALL Init_Aerosol( Input_Opt, State_Chm, State_Diag, State_Grid, RC )
       IF ( RC /= GC_SUCCESS ) THEN
          ErrMsg = 'Error encountered in "Init_Aerosol"!'
          CALL GC_Error( ErrMsg, RC, ThisLoc )
          RETURN
       ENDIF
    ENDIF

    !=================================================================
    ! Initialize simulation modules here
    !=================================================================

    !-----------------------------------------------------------------
    ! Fullchem via KPP
    !-----------------------------------------------------------------
    IF ( Input_Opt%ITS_A_FULLCHEM_SIM ) THEN
       CALL Init_FullChem( Input_Opt, State_Chm, State_Diag, RC )
       IF ( RC /= GC_SUCCESS ) THEN
          ErrMsg = 'Error encountered in "Init_FullChem"!'
          CALL GC_Error( ErrMsg, RC, ThisLoc )
          RETURN
       ENDIF
    ENDIF

    !-----------------------------------------------------------------
    ! Carbon gases via KPP
    !-----------------------------------------------------------------
    IF ( Input_Opt%ITS_A_CARBON_SIM ) THEN
       CALL Init_Carbon_Gases( Input_Opt,  State_Chm, State_Diag,             &
                               State_Grid, RC                                )
       IF ( RC /= GC_SUCCESS ) THEN
          ErrMsg = 'Error encountered in "Init_Carbon_Gases"!'
          CALL GC_Error( ErrMsg, RC, ThisLoc )
          RETURN
       ENDIF
    ENDIF

    !-----------------------------------------------------------------
    ! Mercury via KPP
    !-----------------------------------------------------------------
    IF ( Input_Opt%ITS_A_MERCURY_SIM ) THEN

       ! Main mercury module
       CALL Init_Mercury( Input_Opt, State_Grid, State_Chm, State_Diag, RC )
       IF ( RC /= GC_SUCCESS ) THEN
          ErrMsg = 'Error encountered in "Init_Mercury"!'
          CALL GC_Error( ErrMsg, RC, ThisLoc )
          RETURN
       ENDIF

       ! Land mercury module
       CALL Init_Land_Mercury( Input_Opt, State_Chm, RC )
       IF ( RC /= GC_SUCCESS ) THEN
          ErrMsg = 'Error encountered in "Init_Land_Mercury"!'
          CALL GC_Error( ErrMsg, RC, ThisLoc )
          RETURN
       ENDIF

       ! Mercury deposition module
       CALL Init_Depo_Mercury( Input_Opt, State_Chm, State_Grid, RC )
       IF ( RC /= GC_SUCCESS ) THEN
          ErrMsg = 'Error encountered in "Init_Depo_Mercury"!'
          CALL GC_Error( ErrMsg, RC, ThisLoc )
          RETURN
       ENDIF

       ! Ocean mercury module
       CALL Init_Ocean_Mercury( Input_Opt, State_Chm, State_Grid, RC )
       IF ( RC /= GC_SUCCESS ) THEN
          ErrMsg = 'Error encountered in "Init_Ocean_Mercury"!'
          CALL GC_Error( ErrMsg, RC, ThisLoc )
          RETURN
       ENDIF
    ENDIF

    !-----------------------------------------------------------------
    ! CO2
    !-----------------------------------------------------------------
    IF ( Input_Opt%ITS_A_CO2_SIM ) THEN
       CALL Init_CO2( Input_Opt, State_Grid, RC )
       IF ( RC /= GC_SUCCESS ) THEN
          ErrMsg = 'Error encountered in "Init_CO2"!'
          CALL GC_Error( ErrMsg, RC, ThisLoc )
          RETURN
       ENDIF
    ENDIF

    !-----------------------------------------------------------------
    ! CH4
    !-----------------------------------------------------------------
    IF ( Input_Opt%ITS_A_CH4_SIM ) THEN
       CALL Init_Global_Ch4( Input_Opt, State_Chm, State_Diag, State_Grid, RC )
       IF ( RC /= GC_SUCCESS ) THEN
          ErrMsg = 'Error encountered in "Init_Global_CH4"!'
          CALL GC_Error( ErrMsg, RC, ThisLoc )
          RETURN
       ENDIF
    ENDIF

    !-----------------------------------------------------------------
    ! Tagged CO
    !-----------------------------------------------------------------
    IF ( Input_Opt%ITS_A_TAGCO_SIM ) THEN
       CALL Init_Tagged_CO( Input_Opt, State_Diag, State_Grid, RC )
       IF ( RC /= GC_SUCCESS ) THEN
          ErrMsg = 'Error encountered in "Tagged_CO"!'
          CALL GC_Error( ErrMsg, RC, ThisLoc )
          RETURN
       ENDIF
    ENDIF


    !-----------------------------------------------------------------
    ! Tagged O3
    !-----------------------------------------------------------------
    IF ( Input_Opt%ITS_A_TAGO3_SIM ) THEN
       CALL Init_Tagged_O3( Input_Opt, State_Chm, State_Diag, RC )
       IF ( RC /= GC_SUCCESS ) THEN
          ErrMsg = 'Error encountered in "Init_Tagged_O3"!'
          CALL GC_Error( ErrMsg, RC, ThisLoc )
          RETURN
       ENDIF
    ENDIF

#ifdef TOMAS
    !-----------------------------------------------------------------
    ! TOMAS
    !-----------------------------------------------------------------

    ! Initialize the TOMAS microphysics package, if necessary
    CALL Init_Tomas_Microphysics( Input_Opt, State_Chm, State_Grid, RC )
#endif

    !-----------------------------------------------------------------
    ! POPs
    !-----------------------------------------------------------------
    IF ( Input_Opt%ITS_A_POPS_SIM ) THEN
       CALL Init_POPs( Input_Opt, State_Chm, State_Grid, RC )
       IF ( RC /= GC_SUCCESS ) THEN
          ErrMsg = 'Error encountered in "Init_POPs"!'
          CALL GC_Error( ErrMsg, RC, ThisLoc )
          RETURN
       ENDIF
    ENDIF

    IF ( Input_Opt%Verbose ) CALL DEBUG_MSG( '### a GC_INIT_EXTRA' )

  END SUBROUTINE GC_Init_Extra
!EOC
#ifdef TOMAS
!------------------------------------------------------------------------------
!                  GEOS-Chem Global Chemical Transport Model                  !
!------------------------------------------------------------------------------
!BOP
!
! !IROUTINE: init_tomas_microphysics
!
! !DESCRIPTION: Subroutine INIT\_TOMAS\_MICROPHYS will initialize the
!  TOMAS microphysics package.  This replaces the former subroutine
!  READ\_MICROPHYSICS\_MENU.
!\\
!\\
! !INTERFACE:
!
  SUBROUTINE INIT_TOMAS_MICROPHYSICS( Input_Opt, State_Chm, State_Grid, RC )
!
! !USES:
!
    USE ErrCode_Mod
    USE Input_Opt_Mod,      ONLY : OptInput
    USE State_Chm_Mod,      ONLY : ChmState
    USE State_Chm_Mod,      ONLY : Ind_
    USE State_Grid_Mod,     ONLY : GrdState
    USE TOMAS_MOD,          ONLY : INIT_TOMAS
!
! !INPUT PARAMETERS:
!
    TYPE(ChmState), INTENT(IN)    :: State_Chm   ! Chemistry State object
    TYPE(GrdState), INTENT(IN)    :: State_Grid  ! Grid State object
!
! !INPUT/OUTPUT PARAMETERS:
!
    TYPE(OptInput), INTENT(INOUT) :: Input_Opt   ! Input options
!
! !OUTPUT PARAMETERS:
!
    INTEGER,        INTENT(OUT)   :: RC          ! Success or failure
!
! !REMARKS:
!  We now invoke TOMAS by compiling GEOS-Chem and setting either the TOMAS=yes
!  (30 bins, default) or TOMAS40=yes (40 bins, optional) switches.  The old
!  LTOMAS logical switch is now obsolete because all of the TOMAS code is
!  segregated from the rest of GEOS-Chem with #ifdef blocks.  Therefore,
!  we no longer need to read the microphysics menu, but we still need to
!  apply some error checks and then call INIT_TOMAS. (bmy, 4/23/13)
!                                                                             .
!  The Ind_() function now defines all species ID's.  It returns -1 if
!  a species cannot be found.  The prior behavior was to return 0 if a
!  species wasn't found.  Therefore, in order to preserve the logic of the
!  error checks, we must force any -1's returned by Ind_() to 0's in
!  this subroutine.
!
! !REVISION HISTORY:
!  20 Jul 2004 - R. Yantosca - Initial version
!  See https://github.com/geoschem/geos-chem for complete history
!EOP
!------------------------------------------------------------------------------
!BOC
!
! !LOCAL VARIABLES:
!
    ! Scalars
    INTEGER            :: N, I

    ! Strings
    CHARACTER(LEN=255) :: ErrMsg, ThisLoc

    !=================================================================
    ! INIT_TOMAS_MICROPHYSICS begins here!
    !=================================================================

    ! Initialize
    RC      = GC_SUCCESS
    ErrMsg  = ''
    ThisLoc = ' -> at Init_Tomas_Microphysics (in GeosCore/gc_environment_mod.F90)'
    ! Exit if this is a dry-run
    IF ( Input_Opt%DryRun) RETURN

    ! Halt with error if we are trying to run TOMAS in a simulation
    ! that does not have any defined aerosols
    ! Turn off switches for simulations that don't use microphysics
    IF ( ( .not. Input_Opt%ITS_A_FULLCHEM_SIM )  .and. &
         ( .not. Input_Opt%ITS_AN_AEROSOL_SIM ) ) THEN
       ErrMsg = 'TOMAS needs to run with either a full-chemistry ' // &
                'or offline aerosol simulation!'
       CALL GC_Error( ErrMsg, RC, ThisLoc )
       RETURN
    ENDIF

    ! Halt with error if none of the TOMAS aerosol species are defined
    I = MAX( Ind_('NK01'  ,'A'), 0 ) &
      + MAX( Ind_('SF01'  ,'A'), 0 ) &
      + MAX( Ind_('SS01'  ,'A'), 0 ) &
      + MAX( Ind_('ECOB01','A'), 0 ) &
      + MAX( Ind_('ECIL01','A'), 0 ) &
      + MAX( Ind_('OCOB01','A'), 0 ) &
      + MAX( Ind_('OCIL01','A'), 0 ) &
      + MAX( Ind_('DUST01','A'), 0 )

    IF ( I == 0 ) THEN
       ErrMsg = 'None of the TOMAS aerosols are defined!'
       CALL GC_Error( ErrMsg, RC, ThisLoc )
       RETURN
    ENDIF

    ! Halt with error if sulfate aerosols are not defined
    IF( Ind_('SF01') > 0 .and. ( .not. Input_Opt%LSULF ) ) THEN
       ErrMsg = 'Need LSULF on for TOMAS-Sulfate to work (for now)'
       CALL GC_Error( ErrMsg, RC, ThisLoc )
       RETURN
    ENDIF

    ! Halt with error if carbonaceous aerosols are not defined
    I = MAX( Ind_('ECOB01','A'), 0 ) &
      + MAX( Ind_('ECIL01','A'), 0 ) &
      + MAX( Ind_('OCOB01','A'), 0 ) &
      + MAX( Ind_('OCIL01','A'), 0 )

    IF ( I > 0 .and. (.not. Input_Opt%LCARB ) ) THEN
       ErrMsg = 'Need LCARB on for TOMAS-carb to work (for now)'
       CALL GC_Error( ErrMsg, RC, ThisLoc )
       RETURN
    ENDIF

    !=================================================================
    ! All error checks are satisfied, so initialize TOMAS
    !=================================================================
    CALL INIT_TOMAS( Input_Opt, State_Chm, State_Grid, RC )
    IF ( RC /= GC_SUCCESS ) THEN
       ErrMsg = 'Error encountered in "Init_TOMAS"!'
       CALL GC_Error( ErrMsg, RC, ThisLoc )
       RETURN
    ENDIF

  END SUBROUTINE INIT_TOMAS_MICROPHYSICS
!EOC
#endif
END MODULE GC_Environment_Mod
