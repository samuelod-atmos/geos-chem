! ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
! 
! Parameter Module File
! 
! Generated by KPP-2.2 symbolic chemistry Kinetics PreProcessor
!       (http://www.cs.vt.edu/~asandu/Software/KPP)
! KPP is distributed under GPL, the general public licence
!       (http://www.gnu.org/copyleft/gpl.html)
! (C) 1995-1997, V. Damian & A. Sandu, CGRER, Univ. Iowa
! (C) 1997-2005, A. Sandu, Michigan Tech, Virginia Tech
!     With important contributions from:
!        M. Damian, Villanova University, USA
!        R. Sander, Max-Planck Institute for Chemistry, Mainz, Germany
! 
! File                 : gckpp_Parameters.f90
! Time                 : Wed Sep 15 15:20:39 2010
! Working directory    : /mnt/lstr04/srv/home/c/ccarouge/KPP/geoschem_kppfiles/v8-03-02/standard
! Equation file        : gckpp.kpp
! Output root filename : gckpp
! 
! ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~



MODULE gckpp_Parameters

  USE gckpp_Precision
  PUBLIC
  SAVE


! NSPEC - Number of chemical species
  INTEGER, PARAMETER :: NSPEC = 106 
! NVAR - Number of Variable species
  INTEGER, PARAMETER :: NVAR = 90 
! NVARACT - Number of Active species
  INTEGER, PARAMETER :: NVARACT = 75 
! NFIX - Number of Fixed species
  INTEGER, PARAMETER :: NFIX = 16 
! NREACT - Number of reactions
  INTEGER, PARAMETER :: NREACT = 310 
! NVARST - Starting of variables in conc. vect.
  INTEGER, PARAMETER :: NVARST = 1 
! NFIXST - Starting of fixed in conc. vect.
  INTEGER, PARAMETER :: NFIXST = 91 
! NONZERO - Number of nonzero entries in Jacobian
  INTEGER, PARAMETER :: NONZERO = 900 
! LU_NONZERO - Number of nonzero entries in LU factoriz. of Jacobian
  INTEGER, PARAMETER :: LU_NONZERO = 1041 
! CNVAR - (NVAR+1) Number of elements in compressed row format
  INTEGER, PARAMETER :: CNVAR = 91 
! CNEQN - (NREACT+1) Number stoicm elements in compressed col format
  INTEGER, PARAMETER :: CNEQN = 311 
! NHESS - Length of Sparse Hessian
  INTEGER, PARAMETER :: NHESS = 854 
! NLOOKAT - Number of species to look at
  INTEGER, PARAMETER :: NLOOKAT = 106 
! NMONITOR - Number of species to monitor
  INTEGER, PARAMETER :: NMONITOR = 0 
! NMASS - Number of atoms to check mass balance
  INTEGER, PARAMETER :: NMASS = 1 

! Index declaration for variable species in C and VAR
!   VAR(ind_spc) = C(ind_spc)

  INTEGER, PARAMETER :: ind_DRYCH2O = 1 
  INTEGER, PARAMETER :: ind_DRYH2O2 = 2 
  INTEGER, PARAMETER :: ind_DRYHNO3 = 3 
  INTEGER, PARAMETER :: ind_DRYN2O5 = 4 
  INTEGER, PARAMETER :: ind_DRYNO2 = 5 
  INTEGER, PARAMETER :: ind_DRYO3 = 6 
  INTEGER, PARAMETER :: ind_DRYPAN = 7 
  INTEGER, PARAMETER :: ind_DRYPMN = 8 
  INTEGER, PARAMETER :: ind_DRYPPN = 9 
  INTEGER, PARAMETER :: ind_DRYR4N2 = 10 
  INTEGER, PARAMETER :: ind_SO4 = 11 
  INTEGER, PARAMETER :: ind_MSA = 12 
  INTEGER, PARAMETER :: ind_CO2 = 13 
  INTEGER, PARAMETER :: ind_DRYDEP = 14 
  INTEGER, PARAMETER :: ind_LISOPOH = 15 
  INTEGER, PARAMETER :: ind_C3H8 = 16 
  INTEGER, PARAMETER :: ind_H2O2 = 17 
  INTEGER, PARAMETER :: ind_PPN = 18 
  INTEGER, PARAMETER :: ind_GPAN = 19 
  INTEGER, PARAMETER :: ind_SO2 = 20 
  INTEGER, PARAMETER :: ind_PAN = 21 
  INTEGER, PARAMETER :: ind_ALK4 = 22 
  INTEGER, PARAMETER :: ind_C2H6 = 23 
  INTEGER, PARAMETER :: ind_HNO2 = 24 
  INTEGER, PARAMETER :: ind_N2O5 = 25 
  INTEGER, PARAMETER :: ind_MAOP = 26 
  INTEGER, PARAMETER :: ind_MAP = 27 
  INTEGER, PARAMETER :: ind_MP = 28 
  INTEGER, PARAMETER :: ind_HNO4 = 29 
  INTEGER, PARAMETER :: ind_R4P = 30 
  INTEGER, PARAMETER :: ind_RA3P = 31 
  INTEGER, PARAMETER :: ind_RB3P = 32 
  INTEGER, PARAMETER :: ind_RP = 33 
  INTEGER, PARAMETER :: ind_DMS = 34 
  INTEGER, PARAMETER :: ind_ETP = 35 
  INTEGER, PARAMETER :: ind_GP = 36 
  INTEGER, PARAMETER :: ind_PP = 37 
  INTEGER, PARAMETER :: ind_PRPN = 38 
  INTEGER, PARAMETER :: ind_INPN = 39 
  INTEGER, PARAMETER :: ind_MRP = 40 
  INTEGER, PARAMETER :: ind_IAP = 41 
  INTEGER, PARAMETER :: ind_VRP = 42 
  INTEGER, PARAMETER :: ind_ISNP = 43 
  INTEGER, PARAMETER :: ind_PMN = 44 
  INTEGER, PARAMETER :: ind_RIP = 45 
  INTEGER, PARAMETER :: ind_ISOP = 46 
  INTEGER, PARAMETER :: ind_CO = 47 
  INTEGER, PARAMETER :: ind_PRPE = 48 
  INTEGER, PARAMETER :: ind_ACET = 49 
  INTEGER, PARAMETER :: ind_GLYC = 50 
  INTEGER, PARAMETER :: ind_MVN2 = 51 
  INTEGER, PARAMETER :: ind_A3O2 = 52 
  INTEGER, PARAMETER :: ind_B3O2 = 53 
  INTEGER, PARAMETER :: ind_HNO3 = 54 
  INTEGER, PARAMETER :: ind_R4N1 = 55 
  INTEGER, PARAMETER :: ind_MAN2 = 56 
  INTEGER, PARAMETER :: ind_RIO1 = 57 
  INTEGER, PARAMETER :: ind_IALD = 58 
  INTEGER, PARAMETER :: ind_MRO2 = 59 
  INTEGER, PARAMETER :: ind_KO2 = 60 
  INTEGER, PARAMETER :: ind_HAC = 61 
  INTEGER, PARAMETER :: ind_ATO2 = 62 
  INTEGER, PARAMETER :: ind_PRN1 = 63 
  INTEGER, PARAMETER :: ind_VRO2 = 64 
  INTEGER, PARAMETER :: ind_ISN1 = 65 
  INTEGER, PARAMETER :: ind_IAO2 = 66 
  INTEGER, PARAMETER :: ind_INO2 = 67 
  INTEGER, PARAMETER :: ind_RCHO = 68 
  INTEGER, PARAMETER :: ind_CH2O = 69 
  INTEGER, PARAMETER :: ind_PO2 = 70 
  INTEGER, PARAMETER :: ind_ALD2 = 71 
  INTEGER, PARAMETER :: ind_R4O2 = 72 
  INTEGER, PARAMETER :: ind_R4N2 = 73 
  INTEGER, PARAMETER :: ind_ETO2 = 74 
  INTEGER, PARAMETER :: ind_MGLY = 75 
  INTEGER, PARAMETER :: ind_MEK = 76 
  INTEGER, PARAMETER :: ind_MVK = 77 
  INTEGER, PARAMETER :: ind_MAO3 = 78 
  INTEGER, PARAMETER :: ind_RIO2 = 79 
  INTEGER, PARAMETER :: ind_MACR = 80 
  INTEGER, PARAMETER :: ind_RCO3 = 81 
  INTEGER, PARAMETER :: ind_NO2 = 82 
  INTEGER, PARAMETER :: ind_MCO3 = 83 
  INTEGER, PARAMETER :: ind_HO2 = 84 
  INTEGER, PARAMETER :: ind_NO = 85 
  INTEGER, PARAMETER :: ind_MO2 = 86 
  INTEGER, PARAMETER :: ind_NO3 = 87 
  INTEGER, PARAMETER :: ind_GCO3 = 88 
  INTEGER, PARAMETER :: ind_O3 = 89 
  INTEGER, PARAMETER :: ind_OH = 90 

! Index declaration for fixed species in C
!   C(ind_spc)

  INTEGER, PARAMETER :: ind_ACTA = 91 
  INTEGER, PARAMETER :: ind_CH4 = 92 
  INTEGER, PARAMETER :: ind_EMISSION = 93 
  INTEGER, PARAMETER :: ind_EOH = 94 
  INTEGER, PARAMETER :: ind_GLCO3 = 95 
  INTEGER, PARAMETER :: ind_GLP = 96 
  INTEGER, PARAMETER :: ind_GLPAN = 97 
  INTEGER, PARAMETER :: ind_GLYX = 98 
  INTEGER, PARAMETER :: ind_H2 = 99 
  INTEGER, PARAMETER :: ind_H2O = 100 
  INTEGER, PARAMETER :: ind_HCOOH = 101 
  INTEGER, PARAMETER :: ind_MNO3 = 102 
  INTEGER, PARAMETER :: ind_MOH = 103 
  INTEGER, PARAMETER :: ind_O2 = 104 
  INTEGER, PARAMETER :: ind_RCOOH = 105 
  INTEGER, PARAMETER :: ind_ROH = 106 

! Index declaration for fixed species in FIX
!    FIX(indf_spc) = C(ind_spc) = C(NVAR+indf_spc)

  INTEGER, PARAMETER :: indf_ACTA = 1 
  INTEGER, PARAMETER :: indf_CH4 = 2 
  INTEGER, PARAMETER :: indf_EMISSION = 3 
  INTEGER, PARAMETER :: indf_EOH = 4 
  INTEGER, PARAMETER :: indf_GLCO3 = 5 
  INTEGER, PARAMETER :: indf_GLP = 6 
  INTEGER, PARAMETER :: indf_GLPAN = 7 
  INTEGER, PARAMETER :: indf_GLYX = 8 
  INTEGER, PARAMETER :: indf_H2 = 9 
  INTEGER, PARAMETER :: indf_H2O = 10 
  INTEGER, PARAMETER :: indf_HCOOH = 11 
  INTEGER, PARAMETER :: indf_MNO3 = 12 
  INTEGER, PARAMETER :: indf_MOH = 13 
  INTEGER, PARAMETER :: indf_O2 = 14 
  INTEGER, PARAMETER :: indf_RCOOH = 15 
  INTEGER, PARAMETER :: indf_ROH = 16 

! NJVRP - Length of sparse Jacobian JVRP
  INTEGER, PARAMETER :: NJVRP = 489 

! NSTOICM - Length of Sparse Stoichiometric Matrix
  INTEGER, PARAMETER :: NSTOICM = 1255 

END MODULE gckpp_Parameters

