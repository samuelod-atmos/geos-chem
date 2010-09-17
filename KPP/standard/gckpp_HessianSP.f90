! ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
! 
! Sparse Hessian Data Structures File
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
! File                 : gckpp_HessianSP.f90
! Time                 : Wed Sep 15 15:20:39 2010
! Working directory    : /mnt/lstr04/srv/home/c/ccarouge/KPP/geoschem_kppfiles/v8-03-02/standard
! Equation file        : gckpp.kpp
! Output root filename : gckpp
! 
! ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~



MODULE gckpp_HessianSP

  PUBLIC
  SAVE


! Hessian Sparse Data
! 

  INTEGER, PARAMETER, DIMENSION(360) :: IHESS_I_0 = (/ &
      11, 12, 13, 13, 13, 13, 15, 16, 17, 17, 17, 18, &
      19, 20, 20, 20, 21, 22, 22, 23, 23, 24, 24, 25, &
      26, 26, 27, 27, 28, 28, 29, 29, 30, 30, 31, 31, &
      32, 32, 33, 33, 34, 34, 35, 35, 36, 36, 37, 37, &
      38, 38, 39, 39, 40, 40, 41, 41, 42, 42, 43, 43, &
      43, 43, 44, 44, 44, 45, 45, 45, 46, 46, 46, 47, &
      47, 47, 47, 47, 47, 47, 47, 47, 47, 47, 47, 47, &
      47, 47, 47, 47, 48, 48, 48, 48, 49, 49, 49, 49, &
      49, 49, 49, 49, 50, 50, 50, 50, 50, 50, 50, 50, &
      50, 50, 50, 50, 51, 51, 51, 51, 52, 52, 52, 52, &
      52, 52, 52, 52, 52, 53, 53, 53, 53, 53, 53, 53, &
      53, 53, 54, 54, 54, 54, 54, 54, 54, 54, 54, 54, &
      54, 54, 54, 54, 54, 54, 54, 54, 54, 54, 55, 55, &
      55, 55, 55, 56, 56, 56, 56, 56, 57, 57, 57, 57, &
      57, 57, 58, 58, 58, 58, 58, 58, 58, 58, 58, 59, &
      59, 59, 59, 59, 59, 60, 60, 60, 60, 60, 60, 61, &
      61, 61, 61, 61, 61, 61, 61, 61, 61, 61, 61, 61, &
      61, 61, 62, 62, 62, 62, 62, 63, 63, 63, 63, 63, &
      63, 64, 64, 64, 64, 64, 64, 65, 65, 65, 65, 65, &
      66, 66, 66, 66, 66, 66, 67, 67, 67, 67, 67, 67, &
      68, 68, 68, 68, 68, 68, 68, 68, 68, 68, 68, 68, &
      68, 68, 68, 68, 68, 68, 68, 68, 68, 68, 68, 68, &
      68, 68, 68, 69, 69, 69, 69, 69, 69, 69, 69, 69, &
      69, 69, 69, 69, 69, 69, 69, 69, 69, 69, 69, 69, &
      69, 69, 69, 69, 69, 69, 69, 69, 69, 69, 69, 69, &
      69, 69, 69, 69, 69, 69, 69, 69, 69, 69, 69, 69, &
      69, 69, 69, 69, 69, 69, 69, 69, 69, 69, 69, 69, &
      69, 69, 69, 69, 69, 69, 69, 69, 69, 69, 69, 70, &
      70, 70, 70, 70, 70, 71, 71, 71, 71, 71, 71, 71, &
      71, 71, 71, 71, 71, 71, 71, 71, 71, 71, 71, 71 /)
  INTEGER, PARAMETER, DIMENSION(360) :: IHESS_I_1 = (/ &
      71, 71, 71, 71, 71, 71, 72, 72, 72, 72, 72, 72, &
      72, 72, 72, 72, 73, 73, 73, 73, 73, 74, 74, 74, &
      74, 74, 74, 74, 74, 74, 74, 74, 74, 74, 74, 75, &
      75, 75, 75, 75, 75, 75, 75, 75, 75, 75, 75, 75, &
      75, 75, 75, 75, 75, 75, 75, 75, 75, 76, 76, 76, &
      76, 76, 76, 76, 76, 76, 76, 76, 76, 76, 76, 76, &
      76, 76, 77, 77, 77, 77, 77, 77, 77, 77, 77, 78, &
      78, 78, 78, 78, 78, 78, 78, 78, 79, 79, 79, 79, &
      79, 79, 80, 80, 80, 80, 80, 80, 80, 80, 80, 80, &
      81, 81, 81, 81, 81, 81, 81, 81, 82, 82, 82, 82, &
      82, 82, 82, 82, 82, 82, 82, 82, 82, 82, 82, 82, &
      82, 82, 82, 82, 82, 82, 82, 82, 82, 82, 82, 82, &
      82, 82, 82, 82, 82, 82, 82, 82, 82, 82, 82, 82, &
      82, 82, 82, 82, 82, 82, 82, 82, 82, 82, 82, 82, &
      82, 82, 83, 83, 83, 83, 83, 83, 83, 83, 83, 83, &
      83, 83, 83, 83, 83, 83, 83, 83, 83, 83, 83, 83, &
      83, 83, 83, 83, 83, 83, 83, 83, 83, 83, 83, 83, &
      83, 83, 83, 83, 83, 83, 83, 84, 84, 84, 84, 84, &
      84, 84, 84, 84, 84, 84, 84, 84, 84, 84, 84, 84, &
      84, 84, 84, 84, 84, 84, 84, 84, 84, 84, 84, 84, &
      84, 84, 84, 84, 84, 84, 84, 84, 84, 84, 84, 84, &
      84, 84, 84, 84, 84, 84, 84, 84, 84, 84, 84, 84, &
      84, 84, 84, 84, 84, 84, 84, 84, 84, 84, 84, 84, &
      84, 84, 84, 84, 84, 84, 84, 84, 84, 84, 84, 84, &
      84, 84, 84, 84, 84, 84, 84, 84, 84, 84, 84, 84, &
      84, 84, 84, 84, 84, 84, 84, 84, 84, 84, 84, 85, &
      85, 85, 85, 85, 85, 85, 85, 85, 85, 85, 85, 85, &
      85, 85, 85, 85, 85, 85, 85, 85, 85, 85, 85, 85, &
      85, 85, 85, 86, 86, 86, 86, 86, 86, 86, 86, 86, &
      86, 86, 86, 86, 86, 86, 86, 86, 86, 86, 86, 86 /)
  INTEGER, PARAMETER, DIMENSION(134) :: IHESS_I_2 = (/ &
      86, 86, 86, 86, 86, 86, 86, 86, 86, 86, 86, 86, &
      86, 86, 86, 86, 86, 86, 86, 86, 86, 86, 86, 86, &
      86, 86, 86, 86, 86, 86, 86, 86, 86, 86, 86, 86, &
      87, 87, 87, 87, 87, 87, 87, 87, 87, 87, 87, 87, &
      87, 87, 87, 87, 87, 87, 88, 88, 88, 88, 88, 88, &
      88, 89, 89, 89, 89, 89, 89, 89, 89, 89, 89, 89, &
      89, 89, 89, 89, 89, 90, 90, 90, 90, 90, 90, 90, &
      90, 90, 90, 90, 90, 90, 90, 90, 90, 90, 90, 90, &
      90, 90, 90, 90, 90, 90, 90, 90, 90, 90, 90, 90, &
      90, 90, 90, 90, 90, 90, 90, 90, 90, 90, 90, 90, &
      90, 90, 90, 90, 90, 90, 90, 90, 90, 90, 90, 90, &
      90, 90 /)
  INTEGER, PARAMETER, DIMENSION(854) :: IHESS_I = (/&
    IHESS_I_0, IHESS_I_1, IHESS_I_2 /)

  INTEGER, PARAMETER, DIMENSION(360) :: IHESS_J_0 = (/ &
      20, 34, 46, 47, 80, 83, 46, 16, 17, 84, 90, 81, &
      82, 20, 34, 34, 82, 22, 22, 23, 23, 24, 85, 82, &
      26, 78, 27, 83, 28, 84, 29, 82, 30, 72, 31, 52, &
      32, 53, 33, 81, 34, 34, 35, 74, 36, 84, 37, 70, &
      38, 63, 39, 67, 40, 59, 41, 66, 42, 64, 43, 51, &
      56, 65, 44, 44, 78, 45, 57, 79, 46, 46, 46, 46, &
      47, 48, 50, 58, 59, 59, 66, 66, 66, 69, 69, 71, &
      75, 75, 77, 80, 46, 48, 48, 48, 32, 49, 53, 53, &
      53, 72, 72, 72, 50, 51, 58, 64, 64, 64, 65, 65, &
      65, 66, 66, 66, 51, 51, 51, 51, 16, 31, 52, 52, &
      52, 52, 72, 72, 72, 16, 32, 53, 53, 53, 53, 72, &
      72, 72, 22, 23, 34, 51, 54, 57, 59, 64, 65, 66, &
      67, 67, 67, 68, 69, 71, 75, 76, 80, 82, 55, 55, &
      55, 55, 73, 56, 56, 56, 56, 80, 57, 57, 57, 57, &
      79, 79, 45, 57, 57, 57, 58, 58, 79, 79, 79, 40, &
      59, 59, 59, 59, 80, 60, 60, 60, 60, 76, 76, 44, &
      58, 59, 59, 59, 61, 62, 65, 65, 65, 66, 66, 66, &
      70, 70, 49, 62, 62, 62, 62, 38, 48, 63, 63, 63, &
      63, 42, 64, 64, 64, 64, 77, 43, 65, 65, 65, 65, &
      41, 58, 66, 66, 66, 66, 39, 46, 67, 67, 67, 67, &
      30, 31, 42, 43, 51, 51, 52, 52, 52, 55, 55, 55, &
      56, 56, 63, 63, 65, 65, 67, 67, 68, 68, 70, 70, &
      72, 72, 72, 27, 28, 34, 34, 44, 44, 46, 48, 51, &
      51, 51, 52, 53, 55, 55, 55, 56, 56, 56, 57, 57, &
      57, 58, 59, 59, 59, 60, 62, 62, 62, 63, 63, 63, &
      64, 64, 64, 65, 66, 66, 66, 67, 67, 67, 69, 69, &
      70, 70, 70, 71, 72, 74, 77, 78, 78, 78, 79, 79, &
      79, 80, 81, 83, 83, 84, 85, 85, 86, 86, 86, 37, &
      48, 70, 70, 70, 70, 33, 35, 48, 55, 55, 55, 60, &
      60, 60, 63, 63, 63, 70, 70, 70, 71, 71, 72, 72 /)
  INTEGER, PARAMETER, DIMENSION(360) :: IHESS_J_1 = (/ &
      72, 74, 74, 74, 74, 77, 22, 22, 30, 55, 55, 55, &
      72, 72, 72, 72, 55, 60, 62, 72, 73, 23, 23, 35, &
      72, 72, 72, 74, 74, 74, 74, 74, 81, 81, 81, 51, &
      51, 51, 56, 56, 56, 58, 59, 60, 61, 62, 62, 64, &
      64, 64, 66, 66, 66, 75, 75, 77, 80, 57, 57, 59, &
      60, 60, 62, 64, 64, 66, 66, 72, 72, 72, 76, 76, &
      79, 79, 46, 67, 67, 67, 77, 77, 79, 79, 79, 26, &
      58, 78, 78, 78, 78, 78, 80, 80, 45, 46, 79, 79, &
      79, 79, 46, 67, 67, 67, 79, 79, 79, 80, 80, 80, &
      33, 68, 68, 81, 81, 81, 81, 81, 24, 29, 43, 44, &
      44, 51, 51, 51, 52, 53, 55, 55, 55, 56, 56, 56, &
      57, 59, 60, 62, 63, 63, 63, 64, 65, 65, 65, 66, &
      67, 67, 67, 70, 72, 74, 78, 78, 79, 81, 81, 82, &
      82, 82, 82, 82, 82, 83, 84, 84, 85, 85, 85, 85, &
      87, 87, 27, 51, 51, 51, 52, 53, 55, 56, 57, 59, &
      60, 60, 60, 62, 62, 62, 62, 63, 64, 64, 64, 65, &
      66, 67, 70, 71, 71, 72, 74, 75, 75, 78, 78, 79, &
      81, 82, 83, 83, 83, 83, 83, 17, 20, 44, 44, 46, &
      47, 48, 50, 51, 51, 51, 51, 52, 52, 52, 52, 53, &
      53, 53, 53, 55, 55, 56, 56, 57, 57, 57, 57, 58, &
      59, 59, 59, 59, 60, 60, 61, 62, 62, 62, 63, 63, &
      64, 64, 64, 64, 65, 65, 65, 66, 66, 66, 66, 67, &
      67, 67, 67, 69, 69, 70, 70, 70, 70, 71, 72, 72, &
      72, 72, 74, 74, 74, 74, 74, 77, 78, 78, 79, 79, &
      79, 79, 80, 81, 81, 82, 83, 83, 83, 84, 84, 84, &
      84, 84, 84, 84, 85, 85, 86, 86, 86, 87, 89, 51, &
      52, 53, 55, 56, 57, 59, 60, 62, 63, 64, 65, 66, &
      67, 70, 72, 74, 78, 79, 81, 82, 83, 84, 85, 85, &
      85, 85, 85, 28, 34, 34, 48, 51, 51, 52, 52, 53, &
      53, 55, 55, 56, 56, 57, 57, 59, 59, 60, 60, 60 /)
  INTEGER, PARAMETER, DIMENSION(134) :: IHESS_J_2 = (/ &
      62, 62, 62, 63, 63, 64, 64, 65, 65, 66, 66, 67, &
      67, 70, 70, 72, 72, 72, 74, 74, 78, 78, 79, 79, &
      81, 81, 83, 83, 83, 83, 83, 84, 85, 86, 86, 86, &
      22, 23, 34, 46, 48, 54, 68, 69, 71, 75, 76, 80, &
      82, 82, 84, 85, 87, 87, 36, 50, 82, 83, 84, 85, &
      86, 44, 46, 48, 58, 77, 78, 80, 81, 82, 83, 84, &
      84, 85, 86, 89, 90, 16, 17, 20, 22, 23, 24, 26, &
      27, 28, 29, 30, 31, 32, 33, 34, 35, 36, 37, 38, &
      39, 40, 41, 42, 43, 44, 45, 46, 46, 47, 48, 48, &
      49, 50, 54, 58, 58, 61, 68, 69, 71, 73, 75, 76, &
      77, 77, 80, 80, 82, 83, 84, 84, 84, 84, 85, 87, &
      89, 90 /)
  INTEGER, PARAMETER, DIMENSION(854) :: IHESS_J = (/&
    IHESS_J_0, IHESS_J_1, IHESS_J_2 /)

  INTEGER, PARAMETER, DIMENSION(360) :: IHESS_K_0 = (/ &
      90, 90, 89, 90, 89, 85, 90, 90, 90, 84, 90, 82, &
      88, 90, 87, 90, 83, 87, 90, 87, 90, 90, 90, 87, &
      90, 84, 90, 84, 90, 86, 90, 84, 90, 84, 90, 84, &
      90, 84, 90, 84, 87, 90, 90, 84, 90, 88, 90, 84, &
      90, 84, 90, 84, 90, 84, 90, 84, 90, 84, 90, 84, &
      84, 84, 89, 90, 82, 90, 84, 84, 87, 89, 90, 89, &
      90, 89, 90, 89, 83, 86, 83, 85, 86, 87, 90, 90, &
      87, 90, 89, 89, 89, 87, 89, 90, 90, 90, 83, 85, &
      86, 83, 85, 86, 90, 85, 89, 83, 85, 86, 83, 85, &
      86, 83, 85, 86, 83, 84, 85, 86, 90, 90, 83, 84, &
      85, 86, 83, 85, 86, 90, 90, 83, 84, 85, 86, 83, &
      85, 86, 87, 87, 87, 85, 90, 85, 85, 85, 85, 85, &
      83, 85, 86, 87, 87, 87, 87, 87, 87, 90, 83, 84, &
      85, 86, 90, 83, 84, 85, 86, 87, 83, 84, 85, 86, &
      83, 86, 90, 83, 85, 86, 89, 90, 83, 85, 86, 90, &
      83, 84, 85, 86, 90, 83, 84, 85, 86, 87, 90, 90, &
      89, 83, 85, 86, 90, 86, 83, 85, 86, 83, 85, 86, &
      83, 86, 90, 83, 84, 85, 86, 90, 87, 83, 84, 85, &
      86, 90, 83, 84, 85, 86, 90, 90, 83, 84, 85, 86, &
      90, 90, 83, 84, 85, 86, 90, 87, 83, 84, 85, 86, &
      90, 90, 90, 90, 83, 86, 83, 85, 86, 83, 85, 86, &
      83, 86, 83, 86, 83, 86, 83, 86, 87, 90, 83, 86, &
      83, 85, 86, 90, 90, 87, 90, 89, 90, 89, 89, 83, &
      85, 86, 86, 86, 83, 85, 86, 83, 85, 86, 83, 85, &
      86, 89, 83, 85, 86, 86, 83, 85, 86, 83, 85, 86, &
      83, 85, 86, 86, 83, 85, 86, 83, 85, 86, 87, 90, &
      83, 85, 86, 90, 86, 86, 89, 83, 85, 86, 83, 85, &
      86, 89, 86, 86, 88, 88, 86, 88, 86, 88, 89, 90, &
      90, 83, 84, 85, 86, 90, 90, 89, 83, 85, 86, 83, &
      85, 86, 83, 85, 86, 83, 85, 86, 87, 90, 83, 85 /)
  INTEGER, PARAMETER, DIMENSION(360) :: IHESS_K_1 = (/ &
      86, 74, 83, 85, 86, 89, 87, 90, 90, 83, 85, 86, &
      83, 84, 85, 86, 84, 85, 85, 85, 90, 87, 90, 90, &
      83, 85, 86, 74, 83, 84, 85, 86, 83, 85, 86, 83, &
      85, 86, 83, 85, 86, 89, 83, 84, 90, 83, 86, 83, &
      85, 86, 83, 85, 86, 87, 90, 89, 89, 83, 86, 83, &
      83, 86, 83, 83, 86, 83, 86, 83, 85, 86, 87, 90, &
      83, 86, 89, 83, 85, 86, 89, 90, 83, 85, 86, 90, &
      90, 82, 83, 84, 85, 86, 87, 90, 90, 90, 83, 84, &
      85, 86, 89, 83, 85, 86, 83, 85, 86, 87, 89, 90, &
      90, 87, 90, 82, 83, 84, 85, 86, 90, 90, 90, 89, &
      90, 83, 85, 86, 85, 85, 83, 85, 86, 83, 85, 86, &
      85, 85, 85, 85, 83, 85, 86, 85, 83, 85, 86, 85, &
      83, 85, 86, 85, 85, 85, 82, 85, 85, 82, 85, 83, &
      84, 87, 88, 89, 90, 85, 85, 87, 86, 87, 88, 89, &
      87, 90, 90, 83, 85, 86, 83, 83, 83, 83, 83, 83, &
      83, 85, 86, 83, 84, 85, 86, 83, 83, 85, 86, 83, &
      83, 83, 83, 87, 90, 83, 83, 87, 90, 85, 86, 83, &
      83, 83, 83, 84, 85, 86, 88, 90, 90, 89, 90, 89, &
      90, 89, 90, 83, 84, 85, 86, 83, 84, 85, 86, 83, &
      84, 85, 86, 84, 86, 84, 86, 83, 84, 85, 86, 90, &
      83, 84, 85, 86, 84, 86, 90, 83, 84, 86, 84, 86, &
      83, 84, 85, 86, 84, 85, 86, 83, 84, 85, 86, 83, &
      84, 85, 86, 87, 90, 83, 84, 85, 86, 90, 83, 84, &
      85, 86, 74, 83, 84, 85, 86, 89, 84, 86, 83, 84, &
      85, 86, 89, 84, 86, 84, 84, 86, 88, 84, 85, 86, &
      87, 88, 89, 90, 86, 88, 86, 88, 89, 90, 90, 85, &
      85, 85, 85, 85, 85, 85, 85, 85, 85, 85, 85, 85, &
      85, 85, 85, 85, 85, 85, 85, 87, 85, 85, 86, 87, &
      88, 89, 90, 90, 87, 90, 89, 83, 86, 83, 86, 83, &
      86, 83, 86, 83, 86, 83, 86, 83, 86, 83, 84, 86 /)
  INTEGER, PARAMETER, DIMENSION(134) :: IHESS_K_2 = (/ &
      83, 84, 86, 83, 86, 83, 86, 83, 86, 83, 86, 83, &
      86, 83, 86, 83, 85, 86, 83, 86, 83, 86, 83, 86, &
      83, 86, 83, 84, 85, 86, 88, 86, 86, 86, 88, 89, &
      87, 87, 87, 87, 87, 90, 87, 87, 87, 87, 87, 87, &
      87, 89, 87, 87, 87, 90, 90, 90, 88, 88, 88, 88, &
      88, 89, 89, 89, 89, 89, 84, 89, 84, 89, 84, 88, &
      89, 89, 89, 90, 90, 90, 90, 90, 90, 90, 90, 90, &
      90, 90, 90, 90, 90, 90, 90, 90, 90, 90, 90, 90, &
      90, 90, 90, 90, 90, 90, 90, 89, 90, 90, 89, 90, &
      90, 90, 90, 89, 90, 90, 90, 90, 90, 90, 90, 90, &
      89, 90, 89, 90, 90, 84, 85, 87, 89, 90, 90, 90, &
      90, 90 /)
  INTEGER, PARAMETER, DIMENSION(854) :: IHESS_K = (/&
    IHESS_K_0, IHESS_K_1, IHESS_K_2 /)


END MODULE gckpp_HessianSP

