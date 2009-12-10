! ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
! 
! The ODE Function of Chemical Model File
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
! File                 : gckpp_Function.f90
! Time                 : Fri May 29 16:36:46 2009
! Working directory    : /home/phs/KPP/v8-02-01_43t
! Equation file        : gckpp.kpp
! Output root filename : gckpp
! 
! ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~



MODULE gckpp_Function

  USE gckpp_Parameters
  IMPLICIT NONE

! A - Rate for each equation
  REAL(kind=dp) :: A(NREACT)

!$OMP THREADPRIVATE( A )
  
CONTAINS


! ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
! 
! Fun - time derivatives of variables - Agregate form
!   Arguments :
!      V         - Concentrations of variable species (local)
!      F         - Concentrations of fixed species (local)
!      RCT       - Rate constants (local)
!      Vdot      - Time derivative of variable species concentrations
! 
! ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

SUBROUTINE Fun ( V, F, RCT, Vdot )

! V - Concentrations of variable species (local)
  REAL(kind=dp) :: V(NVAR)
! F - Concentrations of fixed species (local)
  REAL(kind=dp) :: F(NFIX)
! RCT - Rate constants (local)
  REAL(kind=dp) :: RCT(NREACT)
! Vdot - Time derivative of variable species concentrations
  REAL(kind=dp) :: Vdot(NVAR)


! Computation of equation rates
  A(1) = RCT(1)*V(85)*V(89)
  A(2) = RCT(2)*V(83)*V(89)
  A(3) = RCT(3)*V(84)*V(89)
  A(4) = RCT(4)*V(82)*V(89)
  A(5) = RCT(5)*V(89)*V(90)
  A(6) = RCT(6)*V(83)*V(83)
  A(7) = RCT(7)*V(83)*V(83)
  A(8) = RCT(8)*V(83)*V(84)
  A(9) = RCT(9)*V(17)*V(83)
  A(10) = RCT(10)*V(84)*V(85)
  A(11) = RCT(11)*V(84)*V(84)
  A(12) = RCT(12)*V(83)*F(9)
  A(13) = RCT(13)*V(47)*V(83)
  A(14) = RCT(14)*V(83)*F(2)
  A(15) = RCT(15)*V(85)*V(90)
  A(16) = RCT(16)*V(84)*V(90)
  A(17) = RCT(17)*V(90)*V(90)
  A(18) = RCT(18)*V(90)*V(90)
  A(19) = RCT(19)*V(28)*V(83)
  A(20) = RCT(20)*V(28)*V(83)
  A(21) = RCT(21)*V(69)*V(83)
  A(22) = RCT(22)*V(82)*V(83)
  A(23) = RCT(23)*V(56)*V(83)
  A(24) = RCT(24)*V(83)*V(85)
  A(25) = RCT(25)*V(24)*V(83)
  A(26) = RCT(26)*V(82)*V(84)
  A(27) = RCT(27)*V(29)
  A(28) = RCT(28)*V(29)*V(83)
  A(29) = RCT(29)*V(84)*V(87)
  A(30) = RCT(30)*V(85)*V(87)
  A(31) = RCT(31)*V(83)*V(87)
  A(32) = RCT(32)*V(82)*V(87)
  A(33) = RCT(33)*V(25)
  A(34) = RCT(34)*V(83)*F(11)
  A(35) = RCT(35)*V(83)*F(13)
  A(36) = RCT(36)*V(82)*V(87)
  A(37) = RCT(37)*V(69)*V(87)
  A(38) = RCT(38)*V(71)*V(83)
  A(39) = RCT(39)*V(71)*V(87)
  A(40) = RCT(40)*V(82)*V(86)
  A(41) = RCT(41)*V(21)
  A(42) = RCT(42)*V(85)*V(86)
  A(43) = RCT(43)*V(23)*V(83)
  A(44) = RCT(44)*V(74)*V(85)
  A(45) = RCT(45)*V(16)*V(83)
  A(46) = RCT(46)*V(16)*V(83)
  A(47) = RCT(47)*V(52)*V(85)
  A(48) = RCT(48)*V(70)*V(85)
  A(49) = RCT(49)*V(22)*V(83)
  A(50) = RCT(50)*V(72)*V(85)
  A(51) = RCT(51)*V(72)*V(85)
  A(52) = RCT(52)*V(54)*V(85)
  A(53) = RCT(53)*V(62)*V(85)
  A(54) = RCT(54)*V(60)*V(85)
  A(55) = RCT(55)*V(79)*V(85)
  A(56) = RCT(56)*V(79)*V(85)
  A(57) = RCT(57)*V(57)*V(85)
  A(58) = RCT(58)*V(57)*V(85)
  A(59) = RCT(59)*V(66)*V(85)
  A(60) = RCT(60)*V(65)*V(85)
  A(61) = RCT(61)*V(64)*V(85)
  A(62) = RCT(62)*V(64)*V(85)
  A(63) = RCT(63)*V(59)*V(85)
  A(64) = RCT(64)*V(59)*V(85)
  A(65) = RCT(65)*V(51)*V(85)
  A(66) = RCT(66)*V(55)*V(85)
  A(67) = RCT(67)*V(53)*V(85)
  A(68) = RCT(68)*V(67)*V(85)
  A(69) = RCT(69)*V(63)*V(85)
  A(70) = RCT(70)*V(22)*V(87)
  A(71) = RCT(71)*V(73)*V(83)
  A(72) = RCT(72)*V(83)*F(1)
  A(73) = RCT(73)*V(68)*V(83)
  A(74) = RCT(74)*V(81)*V(82)
  A(75) = RCT(75)*V(18)
  A(76) = RCT(76)*V(82)*V(88)
  A(77) = RCT(77)*V(19)
  A(78) = RCT(78)*V(78)*V(82)
  A(79) = RCT(79)*V(44)
  A(80) = RCT(80)*V(82)*F(5)
  A(81) = RCT(81)*F(7)
  A(82) = RCT(82)*V(81)*V(85)
  A(83) = RCT(83)*V(85)*V(88)
  A(84) = RCT(84)*V(78)*V(85)
  A(85) = RCT(85)*V(85)*F(5)
  A(86) = RCT(86)*V(68)*V(87)
  A(87) = RCT(87)*V(49)*V(83)
  A(88) = RCT(88)*V(49)*V(83)
  A(89) = RCT(89)*V(52)*V(90)
  A(90) = RCT(90)*V(70)*V(90)
  A(91) = RCT(91)*V(72)*V(84)
  A(92) = RCT(92)*V(54)*V(84)
  A(93) = RCT(93)*V(62)*V(84)
  A(94) = RCT(94)*V(60)*V(84)
  A(95) = RCT(95)*V(79)*V(84)
  A(96) = RCT(96)*V(57)*V(84)
  A(97) = RCT(97)*V(66)*V(84)
  A(98) = RCT(98)*V(65)*V(84)
  A(99) = RCT(99)*V(64)*V(84)
  A(100) = RCT(100)*V(59)*V(84)
  A(101) = RCT(101)*V(51)*V(84)
  A(102) = RCT(102)*V(55)*V(84)
  A(103) = RCT(103)*V(53)*V(84)
  A(104) = RCT(104)*V(67)*V(84)
  A(105) = RCT(105)*V(63)*V(84)
  A(106) = RCT(106)*V(76)*V(83)
  A(107) = RCT(107)*V(74)*V(90)
  A(108) = RCT(108)*V(76)*V(87)
  A(109) = RCT(109)*V(72)*V(90)
  A(110) = RCT(110)*V(54)*V(90)
  A(111) = RCT(111)*V(62)*V(90)
  A(112) = RCT(112)*V(60)*V(90)
  A(113) = RCT(113)*V(79)*V(90)
  A(114) = RCT(114)*V(57)*V(90)
  A(115) = RCT(115)*V(66)*V(90)
  A(116) = RCT(116)*V(65)*V(90)
  A(117) = RCT(117)*V(64)*V(90)
  A(118) = RCT(118)*V(59)*V(90)
  A(119) = RCT(119)*V(51)*V(90)
  A(120) = RCT(120)*V(55)*V(90)
  A(121) = RCT(121)*V(53)*V(90)
  A(122) = RCT(122)*V(67)*V(90)
  A(123) = RCT(123)*V(63)*V(90)
  A(124) = RCT(124)*V(83)*F(4)
  A(125) = RCT(125)*V(83)*F(16)
  A(126) = RCT(126)*V(74)*V(74)
  A(127) = RCT(127)*V(74)*V(74)
  A(128) = RCT(128)*V(74)*V(84)
  A(129) = RCT(129)*V(52)*V(84)
  A(130) = RCT(130)*V(70)*V(84)
  A(131) = RCT(131)*V(84)*V(86)
  A(132) = RCT(132)*V(81)*V(84)
  A(133) = RCT(133)*V(84)*V(88)
  A(134) = RCT(134)*V(78)*V(84)
  A(135) = RCT(135)*V(84)*F(5)
  A(136) = RCT(136)*V(48)*V(83)
  A(137) = RCT(137)*V(48)*V(89)
  A(138) = RCT(138)*V(44)*V(83)
  A(139) = RCT(139)*V(44)*V(89)
  A(140) = RCT(140)*V(50)*V(83)
  A(141) = RCT(141)*V(48)*V(87)
  A(142) = RCT(142)*V(83)*F(8)
  A(143) = RCT(143)*V(75)*V(83)
  A(144) = RCT(144)*V(87)*F(8)
  A(145) = RCT(145)*V(75)*V(87)
  A(146) = RCT(146)*V(46)*V(83)
  A(147) = RCT(147)*V(77)*V(83)
  A(148) = RCT(148)*V(80)*V(83)
  A(149) = RCT(149)*V(61)*V(83)
  A(150) = RCT(150)*V(52)*V(86)
  A(151) = RCT(151)*V(70)*V(86)
  A(152) = RCT(152)*V(52)*V(86)
  A(153) = RCT(153)*V(70)*V(86)
  A(154) = RCT(154)*V(46)*V(89)
  A(155) = RCT(155)*V(77)*V(89)
  A(156) = RCT(156)*V(80)*V(89)
  A(157) = RCT(157)*V(46)*V(87)
  A(158) = RCT(158)*V(80)*V(87)
  A(159) = RCT(159)*V(80)*V(87)
  A(160) = RCT(160)*V(81)*V(90)
  A(161) = RCT(161)*V(88)*V(90)
  A(162) = RCT(162)*V(78)*V(90)
  A(163) = RCT(163)*V(90)*F(5)
  A(164) = RCT(164)*V(81)*V(90)
  A(165) = RCT(165)*V(88)*V(90)
  A(166) = RCT(166)*V(78)*V(90)
  A(167) = RCT(167)*V(90)*F(5)
  A(168) = RCT(168)*V(39)*V(83)
  A(169) = RCT(169)*V(38)*V(83)
  A(170) = RCT(170)*V(35)*V(83)
  A(171) = RCT(171)*V(31)*V(83)
  A(172) = RCT(172)*V(32)*V(83)
  A(173) = RCT(173)*V(30)*V(83)
  A(174) = RCT(174)*V(33)*V(83)
  A(175) = RCT(175)*V(37)*V(83)
  A(176) = RCT(176)*V(36)*V(83)
  A(177) = RCT(177)*V(83)*F(6)
  A(178) = RCT(178)*V(45)*V(83)
  A(179) = RCT(179)*V(41)*V(83)
  A(180) = RCT(180)*V(43)*V(83)
  A(181) = RCT(181)*V(42)*V(83)
  A(182) = RCT(182)*V(40)*V(83)
  A(183) = RCT(183)*V(26)*V(83)
  A(184) = RCT(184)*V(27)*V(83)
  A(185) = RCT(185)*V(23)*V(87)
  A(186) = RCT(186)*V(83)*F(12)
  A(187) = RCT(187)*V(58)*V(83)
  A(188) = RCT(188)*V(58)*V(89)
  A(189) = RCT(189)*V(86)*V(86)
  A(190) = RCT(190)*V(86)*V(90)
  A(191) = RCT(191)*V(86)*V(90)
  A(192) = RCT(192)*V(72)*V(86)
  A(193) = RCT(193)*V(62)*V(86)
  A(194) = RCT(194)*V(60)*V(86)
  A(195) = RCT(195)*V(79)*V(86)
  A(196) = RCT(196)*V(57)*V(86)
  A(197) = RCT(197)*V(66)*V(86)
  A(198) = RCT(198)*V(65)*V(86)
  A(199) = RCT(199)*V(64)*V(86)
  A(200) = RCT(200)*V(59)*V(86)
  A(201) = RCT(201)*V(53)*V(86)
  A(202) = RCT(202)*V(54)*V(86)
  A(203) = RCT(203)*V(51)*V(86)
  A(204) = RCT(204)*V(55)*V(86)
  A(205) = RCT(205)*V(67)*V(86)
  A(206) = RCT(206)*V(63)*V(86)
  A(207) = RCT(207)*V(72)*V(86)
  A(208) = RCT(208)*V(62)*V(86)
  A(209) = RCT(209)*V(60)*V(86)
  A(210) = RCT(210)*V(79)*V(86)
  A(211) = RCT(211)*V(57)*V(86)
  A(212) = RCT(212)*V(66)*V(86)
  A(213) = RCT(213)*V(64)*V(86)
  A(214) = RCT(214)*V(59)*V(86)
  A(215) = RCT(215)*V(54)*V(86)
  A(216) = RCT(216)*V(65)*V(86)
  A(217) = RCT(217)*V(51)*V(86)
  A(218) = RCT(218)*V(55)*V(86)
  A(219) = RCT(219)*V(67)*V(86)
  A(220) = RCT(220)*V(63)*V(86)
  A(221) = RCT(221)*V(53)*V(86)
  A(222) = RCT(222)*V(74)*V(86)
  A(223) = RCT(223)*V(74)*V(86)
  A(224) = RCT(224)*V(81)*V(86)
  A(225) = RCT(225)*V(86)*V(88)
  A(226) = RCT(226)*V(78)*V(86)
  A(227) = RCT(227)*V(86)*F(5)
  A(228) = RCT(228)*V(87)*V(87)
  A(229) = RCT(229)*F(3)
  A(230) = RCT(230)*F(3)
  A(231) = RCT(231)*F(3)
  A(232) = RCT(232)*F(3)
  A(233) = RCT(233)*F(3)
  A(234) = RCT(234)*F(3)
  A(235) = RCT(235)*F(3)
  A(236) = RCT(236)*F(3)
  A(237) = RCT(237)*F(3)
  A(238) = RCT(238)*F(3)
  A(239) = RCT(239)*F(3)
  A(240) = RCT(240)*F(3)
  A(241) = RCT(241)*F(3)
  A(242) = RCT(242)*F(3)
  A(243) = RCT(243)*V(82)
  A(244) = RCT(244)*V(89)
  A(245) = RCT(245)*V(21)
  A(246) = RCT(246)*V(56)
  A(247) = RCT(247)*V(69)
  A(248) = RCT(248)*V(25)
  A(249) = RCT(249)*V(17)
  A(250) = RCT(250)*V(44)
  A(251) = RCT(251)*V(18)
  A(252) = RCT(252)*V(73)
  A(253) = RCT(253)*V(84)
  A(254) = RCT(254)*V(82)
  A(255) = RCT(255)*V(87)
  A(256) = RCT(256)*V(25)
  A(257) = RCT(257)*V(34)*V(83)
  A(258) = RCT(258)*V(34)*V(83)
  A(259) = RCT(259)*V(34)*V(87)
  A(260) = RCT(260)*V(20)*V(83)
  A(261) = RCT(261)*V(89)
  A(262) = RCT(262)*V(82)
  A(263) = RCT(263)*V(17)
  A(264) = RCT(264)*V(28)
  A(265) = RCT(265)*V(69)
  A(266) = RCT(266)*V(69)
  A(267) = RCT(267)*V(56)
  A(268) = RCT(268)*V(24)
  A(269) = RCT(269)*V(29)
  A(270) = RCT(270)*V(87)
  A(271) = RCT(271)*V(87)
  A(272) = RCT(272)*V(25)
  A(273) = RCT(273)*V(25)
  A(274) = RCT(274)*V(29)
  A(275) = RCT(275)*V(71)
  A(276) = RCT(276)*V(71)
  A(277) = RCT(277)*V(21)
  A(278) = RCT(278)*V(68)
  A(279) = RCT(279)*V(49)
  A(280) = RCT(280)*V(49)
  A(281) = RCT(281)*V(76)
  A(282) = RCT(282)*F(12)
  A(283) = RCT(283)*V(50)
  A(284) = RCT(284)*F(8)
  A(285) = RCT(285)*F(8)
  A(286) = RCT(286)*V(75)
  A(287) = RCT(287)*V(75)
  A(288) = RCT(288)*V(77)
  A(289) = RCT(289)*V(77)
  A(290) = RCT(290)*V(77)
  A(291) = RCT(291)*V(80)
  A(292) = RCT(292)*V(80)
  A(293) = RCT(293)*V(61)
  A(294) = RCT(294)*V(39)
  A(295) = RCT(295)*V(38)
  A(296) = RCT(296)*V(35)
  A(297) = RCT(297)*V(31)
  A(298) = RCT(298)*V(32)
  A(299) = RCT(299)*V(30)
  A(300) = RCT(300)*V(37)
  A(301) = RCT(301)*V(33)
  A(302) = RCT(302)*V(36)
  A(303) = RCT(303)*F(6)
  A(304) = RCT(304)*V(45)
  A(305) = RCT(305)*V(41)
  A(306) = RCT(306)*V(43)
  A(307) = RCT(307)*V(42)
  A(308) = RCT(308)*V(40)
  A(309) = RCT(309)*V(26)
  A(310) = RCT(310)*V(73)
  A(311) = RCT(311)*V(27)

! Aggregate function
  Vdot(1) = A(247)
  Vdot(2) = A(249)
  Vdot(3) = A(246)
  Vdot(4) = A(248)
  Vdot(5) = A(243)
  Vdot(6) = A(244)
  Vdot(7) = A(245)
  Vdot(8) = A(250)
  Vdot(9) = A(251)
  Vdot(10) = A(252)
  Vdot(11) = A(260)
  Vdot(12) = 0.25*A(258)
  Vdot(13) = A(13)+A(34)+A(42)+A(72)+0.15*A(154)+0.16*A(156)
  Vdot(14) = A(243)+A(244)+A(245)+A(246)+A(247)+A(248)+A(249)+A(250)+A(251)+A(252)
  Vdot(15) = A(146)
  Vdot(16) = -A(45)-A(46)+A(236)
  Vdot(17) = A(7)-A(9)+A(11)-A(249)+0.5*A(253)-A(263)
  Vdot(18) = A(74)-A(75)-A(251)
  Vdot(19) = A(76)-A(77)
  Vdot(20) = A(257)+0.75*A(258)+A(259)-A(260)
  Vdot(21) = A(40)-A(41)-A(245)-A(277)
  Vdot(22) = -A(49)-A(70)+A(232)
  Vdot(23) = -A(43)-A(185)+A(237)
  Vdot(24) = A(24)-A(25)+0.5*A(254)-A(268)
  Vdot(25) = A(32)-A(33)-A(248)-A(256)-A(272)-A(273)
  Vdot(26) = 0.7*A(134)-A(183)-A(309)
  Vdot(27) = 0.41*A(131)-A(184)-A(311)
  Vdot(28) = A(16)-A(19)-A(20)-A(264)
  Vdot(29) = A(26)-A(27)-A(28)-A(269)-A(274)
  Vdot(30) = A(91)-A(173)-A(299)
  Vdot(31) = A(129)-A(171)-A(297)
  Vdot(32) = A(103)-A(172)-A(298)
  Vdot(33) = 0.7*A(132)-A(174)-A(301)
  Vdot(34) = -A(257)-A(258)-A(259)
  Vdot(35) = A(128)-A(170)-A(296)
  Vdot(36) = 0.71*A(133)-A(176)-A(302)
  Vdot(37) = A(130)-A(175)-A(300)
  Vdot(38) = A(105)-A(169)-A(295)
  Vdot(39) = A(104)-A(168)-A(294)
  Vdot(40) = A(100)-A(182)-A(308)
  Vdot(41) = A(97)-A(179)-A(305)
  Vdot(42) = A(99)-A(181)-A(307)
  Vdot(43) = A(98)+A(101)+A(102)-A(180)-A(306)
  Vdot(44) = A(78)-A(79)-A(138)-A(139)-A(250)
  Vdot(45) = A(95)+A(96)-A(178)-A(304)
  Vdot(46) = -A(146)-A(154)-A(157)+A(233)
  Vdot(47) = -A(13)+A(21)+A(37)+0.05*A(38)+0.61*A(59)+A(85)+0.33*A(115)+0.15*A(118)+0.42*A(137)+0.4*A(140)+2*A(142)&
               &+A(143)+2*A(144)+A(145)+0.05*A(154)+0.05*A(155)+0.2*A(156)+A(163)+0.5*A(177)+0.4*A(188)+0.65*A(197)+0.83&
               &*A(200)+A(227)+A(231)+A(265)+A(266)+A(275)+A(276)+A(278)+A(280)+A(283)+1.5*A(284)+2*A(285)+A(286)+A(287)&
               &+A(288)+A(289)+A(292)+A(303)+0.67*A(305)+0.5*A(308)
  Vdot(48) = -A(136)-A(137)-A(141)+0.07*A(154)+A(235)+A(288)
  Vdot(49) = 0.32*A(50)+A(67)-A(87)-A(88)+0.16*A(109)+0.75*A(121)+0.5*A(172)+0.32*A(192)+A(201)+A(221)+A(234)-A(279)&
               &-A(280)+A(298)+0.32*A(310)
  Vdot(50) = 0.24*A(59)+0.95*A(60)+0.72*A(61)+0.6*A(65)+0.13*A(115)+0.5*A(116)+0.36*A(117)-A(140)+0.28*A(188)+0.26&
               &*A(197)+A(198)+0.72*A(199)-A(283)+0.26*A(305)+0.7*A(307)
  Vdot(51) = -A(65)-A(101)-A(119)-A(203)-A(217)
  Vdot(52) = A(46)-A(47)+0.05*A(50)-A(89)+0.03*A(109)-A(129)-A(150)-A(152)+0.5*A(171)+0.05*A(192)+0.05*A(310)
  Vdot(53) = A(45)+0.18*A(50)-A(67)-A(103)+0.09*A(109)-A(121)+0.5*A(172)+0.18*A(192)-A(201)-A(221)+0.18*A(310)
  Vdot(54) = -A(52)+A(71)-A(92)-A(110)-A(202)-A(215)
  Vdot(55) = -A(66)-A(102)-A(120)+A(158)-A(204)-A(218)
  Vdot(56) = A(22)-A(23)+A(37)+A(39)+A(56)+A(58)+0.08*A(59)+0.05*A(60)+A(62)+A(64)+0.1*A(65)+0.85*A(68)+A(70)+A(86)&
               &+A(108)+0.425*A(122)+A(144)+A(145)+A(159)+A(185)+0.85*A(205)+A(242)-A(246)+0.5*A(254)+A(255)+2*A(256)+A(259)&
               &-A(267)
  Vdot(57) = -A(57)-A(58)-A(96)+0.07*A(113)-A(114)+0.136*A(195)-A(196)-A(211)
  Vdot(58) = 0.34*A(55)+A(57)+0.06*A(113)+0.5*A(114)+0.509*A(178)-A(187)-A(188)+0.127*A(195)+A(196)+0.373*A(304)
  Vdot(59) = -A(63)-A(64)-A(100)-A(118)+0.43*A(148)+A(182)-A(200)-A(214)
  Vdot(60) = -A(54)-A(94)+A(106)+A(108)-A(112)-A(194)-A(209)
  Vdot(61) = 0.33*A(59)+0.95*A(60)+A(63)+0.16*A(90)+0.2*A(111)+0.18*A(115)+0.5*A(116)+A(118)+0.59*A(138)-A(149)+0.65&
               &*A(153)+0.2*A(188)+0.36*A(197)+A(198)+0.83*A(200)-A(293)+0.36*A(305)+A(308)
  Vdot(62) = -A(53)+A(87)+A(88)-A(93)-A(111)-A(193)-A(208)
  Vdot(63) = -A(69)-A(105)-A(123)+A(141)+A(169)-A(206)-A(220)
  Vdot(64) = -A(61)-A(62)-A(99)-A(117)+A(147)+0.5*A(181)-A(199)-A(213)
  Vdot(65) = -A(60)-A(98)-A(116)+0.5*A(180)-A(198)-A(216)
  Vdot(66) = -A(59)-A(97)-A(115)+A(179)+0.44*A(187)-A(197)-A(212)
  Vdot(67) = -A(68)-A(104)-A(122)+A(157)+A(168)-A(205)-A(219)
  Vdot(68) = A(47)+0.13*A(50)+0.57*A(52)-A(73)-A(86)+0.75*A(89)+0.09*A(90)+0.07*A(109)+0.54*A(110)+0.25*A(116)+0.25&
               &*A(119)+0.25*A(120)+0.25*A(122)+0.25*A(123)+A(125)+A(150)+A(152)+0.35*A(153)+0.5*A(171)+0.5*A(173)+0.5&
               &*A(180)+0.5*A(181)+0.13*A(192)+0.57*A(202)+A(215)+A(216)+A(217)+A(218)+A(219)+A(220)-A(278)+A(294)+A(295)&
               &+A(297)+A(299)+A(306)+0.13*A(310)
  Vdot(69) = A(5)+A(15)+A(17)+2*A(18)+A(20)-A(21)+A(35)-A(37)+0.05*A(38)+A(48)+0.39*A(52)+0.96*A(53)+0.56*A(55)+0.75&
               &*A(57)+0.35*A(59)+0.28*A(61)+A(63)+0.3*A(65)+A(66)+0.15*A(68)+A(69)+A(83)+A(84)+0.75*A(89)+1.25*A(90)+0.75&
               &*A(107)+0.75*A(109)+0.95*A(110)+0.5*A(111)+0.75*A(112)+1.1*A(113)+1.13*A(114)+0.95*A(115)+0.75*A(116)+0.89&
               &*A(117)+0.85*A(118)+1.25*A(119)+1.25*A(120)+0.75*A(121)+0.83*A(122)+1.25*A(123)+0.29*A(133)+0.535*A(137)&
               &+2.23*A(138)+0.6*A(139)+A(151)+0.9*A(154)+0.8*A(155)+0.7*A(156)+A(160)+2*A(161)+2*A(162)+A(163)+A(164)&
               &+A(165)+A(166)+A(167)+0.5*A(184)+A(186)+0.12*A(188)+A(190)+A(191)+0.2*A(193)+0.69*A(195)+0.75*A(196)+0.4&
               &*A(197)+0.28*A(199)+0.17*A(200)+0.39*A(202)+A(203)+A(204)+0.15*A(205)+A(206)+A(225)+A(226)+A(240)-A(247)&
               &+A(257)+A(259)+A(264)-A(265)-A(266)+A(282)+A(283)+0.5*A(284)+A(289)+A(292)+A(293)+A(300)+A(302)+0.627*A(304)&
               &+0.3*A(307)+0.5*A(308)+A(309)
  Vdot(70) = -A(48)-A(90)-A(130)+A(136)-A(151)-A(153)+A(175)
  Vdot(71) = -A(38)-A(39)+A(44)+A(48)+0.32*A(50)+0.75*A(52)+0.93*A(54)+A(69)+0.5*A(90)+0.75*A(107)+0.16*A(109)+0.38&
               &*A(110)+0.5*A(112)+0.5*A(123)+A(124)+2*A(126)+A(127)+0.5*A(137)+A(151)+0.04*A(155)+0.5*A(170)+0.5*A(174)&
               &+0.32*A(192)+A(194)+0.75*A(202)+A(206)+A(222)+A(223)+A(239)-A(275)-A(276)+A(287)+A(296)+A(300)+A(301)+0.32&
               &*A(310)
  Vdot(72) = A(49)-A(50)-A(51)+0.3*A(52)+A(70)-A(91)-A(109)+0.15*A(110)+0.5*A(173)-A(192)+0.3*A(202)-A(207)
  Vdot(73) = A(51)+0.04*A(53)+0.07*A(54)-A(71)+A(92)-A(252)-A(310)
  Vdot(74) = A(43)-A(44)+0.32*A(50)+A(82)-A(107)+0.16*A(109)-2*A(126)-2*A(127)-A(128)+A(160)+0.5*A(170)+A(185)+0.32&
               &*A(192)-A(222)-A(223)+A(224)+A(278)+0.85*A(281)+0.32*A(310)
  Vdot(75) = 0.53*A(59)+0.28*A(61)+0.3*A(65)+A(66)+A(94)+0.5*A(111)+0.29*A(115)+0.14*A(117)+0.25*A(119)+0.5*A(120)&
               &-A(143)-A(145)+A(149)+0.82*A(155)+0.8*A(156)+0.6*A(188)+0.8*A(193)+0.58*A(197)+0.28*A(199)+0.17*A(200)+0.5&
               &*A(203)+A(204)-A(286)-A(287)+0.58*A(305)+0.3*A(307)
  Vdot(76) = 0.19*A(50)-A(106)-A(108)+0.35*A(109)+0.25*A(112)+0.25*A(113)+0.25*A(114)+0.25*A(115)+0.25*A(117)+0.19&
               &*A(192)+A(207)+A(208)+A(209)+A(210)+A(211)+A(212)+A(213)+A(214)+A(238)-A(281)+0.19*A(310)
  Vdot(77) = 0.34*A(55)+0.05*A(68)+0.2*A(113)+0.03*A(122)-A(147)+0.159*A(154)-A(155)+0.402*A(195)+0.05*A(205)-A(288)&
               &-A(289)-A(290)+0.368*A(304)
  Vdot(78) = -A(78)+A(79)-A(84)-A(134)+0.57*A(148)+A(159)-A(162)-A(166)+A(183)+0.41*A(187)-A(226)+A(290)+A(291)
  Vdot(79) = -A(55)-A(56)-A(95)-A(113)+A(146)+0.491*A(178)-A(195)-A(210)
  Vdot(80) = 0.22*A(55)+0.1*A(68)+0.14*A(113)+0.05*A(122)-A(148)+0.387*A(154)-A(156)-A(158)-A(159)+0.288*A(195)+0.1&
               &*A(205)-A(291)-A(292)+0.259*A(304)
  Vdot(81) = A(73)-A(74)+A(75)-A(82)+A(86)-A(132)-A(160)-A(164)+0.5*A(174)-A(224)+0.15*A(281)
  Vdot(82) = A(1)-A(4)+A(10)+A(15)-A(22)+A(25)-A(26)+A(27)+A(28)+A(29)+2*A(30)+A(31)-A(32)+A(33)-A(40)+A(41)+A(42)+A(44)&
               &+A(47)+A(48)+A(50)+2*A(52)+0.96*A(53)+0.93*A(54)+0.9*A(55)+A(57)+0.92*A(59)+1.95*A(60)+A(61)+A(63)+1.9*A(65)&
               &+2*A(66)+A(67)+1.15*A(68)+2*A(69)-A(74)+A(75)-A(76)+A(77)-A(78)+A(79)-A(80)+A(81)+A(82)+A(83)+A(84)+A(85)&
               &+A(110)+A(116)+A(119)+A(120)+0.575*A(122)+A(123)+A(138)+A(139)+0.5*A(180)+A(186)+A(198)+A(202)+A(203)+A(204)&
               &+0.15*A(205)+A(206)+A(215)+A(216)+A(217)+A(218)+A(219)+A(220)+2*A(228)+A(230)-A(243)-A(254)-A(262)+A(267)&
               &+A(270)+A(272)+A(274)+0.6*A(277)+A(282)+A(294)+A(295)+A(306)+A(310)
  Vdot(83) = -A(2)+A(3)-2*A(6)-2*A(7)-A(8)-A(9)+A(10)-A(12)-A(13)-A(14)-A(19)-A(21)-A(22)-A(23)-A(24)-A(25)-A(28)+A(29)&
               &-A(31)-A(34)-A(35)-A(38)-A(43)-A(45)-A(46)-A(49)-A(71)-A(72)-A(73)-A(87)-A(88)-A(106)-A(124)-A(125)+0.44&
               &*A(131)-A(136)+0.135*A(137)-A(138)-A(140)-A(142)-A(143)-A(146)-A(147)-A(148)-A(149)+0.27*A(154)+0.08*A(155)&
               &+0.215*A(156)-A(168)-A(169)-0.5*A(170)-0.5*A(171)-0.5*A(172)-0.5*A(173)-0.5*A(174)-A(175)-A(176)-0.5*A(177)&
               &-0.491*A(178)-A(179)-0.5*A(180)-0.5*A(181)-A(182)-A(183)-0.5*A(184)-A(186)-A(187)+0.1*A(188)-A(257)-A(258)&
               &-A(260)+2*A(261)+2*A(263)+A(264)+A(267)+A(268)+A(269)+A(294)+A(295)+A(296)+A(297)+A(298)+A(299)+A(300)&
               &+A(301)+A(302)+A(303)+A(304)+A(305)+A(306)+A(307)+A(308)+A(309)+A(311)
  Vdot(84) = A(2)-A(3)+A(5)-A(8)+A(9)-A(10)-2*A(11)+A(12)+A(13)+A(15)-A(16)+2*A(18)+A(21)-A(26)+A(27)-A(29)+A(31)+A(34)&
               &+A(35)+A(37)+0.05*A(38)+A(44)+A(47)+A(48)+0.27*A(50)+0.9*A(55)+A(57)+0.92*A(59)+0.05*A(60)+0.28*A(61)+A(63)&
               &+0.3*A(65)+A(67)+0.8*A(68)+A(83)+A(85)+A(89)+A(90)-A(91)-A(92)-A(93)-A(94)-A(95)-A(96)-A(97)-A(98)-A(99)&
               &-A(100)-A(101)-A(102)-A(103)-A(104)-A(105)+A(107)+0.64*A(109)+0.5*A(110)+0.3*A(111)+0.5*A(112)+0.92*A(113)&
               &+A(114)+A(115)+0.5*A(116)+0.64*A(117)+1.15*A(118)+0.75*A(119)+0.5*A(120)+A(121)+0.45*A(122)+0.5*A(123)&
               &+A(124)+A(125)+2*A(126)-A(128)-A(129)-A(130)-A(131)-A(132)-A(133)-A(134)-A(135)+0.3*A(137)+2*A(138)+A(139)&
               &+0.2*A(140)+A(142)+A(144)+A(149)+A(150)+A(151)+0.06*A(154)+0.06*A(155)+0.275*A(156)+A(160)+2*A(161)+A(162)+2&
               &*A(163)+0.15*A(187)+A(190)+0.27*A(192)+0.8*A(193)+0.864*A(195)+A(196)+A(197)+0.28*A(199)+A(200)+A(201)+0.5&
               &*A(203)+0.8*A(205)+A(222)+A(225)+A(227)-A(253)+A(260)+A(264)+2*A(265)+A(274)+A(275)+A(278)+2*A(283)+2*A(285)&
               &+A(286)+A(289)+A(291)+A(292)+A(293)+A(294)+A(295)+A(296)+A(297)+A(298)+A(299)+A(300)+A(301)+A(302)+A(303)&
               &+A(304)+A(305)+A(306)+0.3*A(307)+A(308)+0.27*A(310)
  Vdot(85) = -A(1)-A(10)-A(15)-A(24)-A(30)+A(36)-A(42)-A(44)-A(47)-A(48)-A(50)-A(51)-A(52)-A(53)-A(54)-A(55)-A(56)-A(57)&
               &-A(58)-A(59)-A(60)-A(61)-A(62)-A(63)-A(64)-A(65)-A(66)-A(67)-A(68)-A(69)-A(82)-A(83)-A(84)-A(85)+A(229)&
               &+A(262)+A(268)+A(271)+A(273)
  Vdot(86) = 0.95*A(38)+A(39)-A(40)+A(41)-A(42)+0.96*A(53)+0.93*A(54)+0.72*A(61)+0.6*A(65)+A(84)+A(93)+0.3*A(111)+0.5&
               &*A(112)+0.36*A(117)+0.25*A(119)-A(131)+A(143)+A(145)-A(150)-A(151)-A(152)-A(153)+A(162)+0.5*A(184)-2*A(189)&
               &-A(190)-A(191)-A(192)-0.8*A(193)-A(195)-A(196)-A(197)-A(198)-0.28*A(199)-A(200)-A(201)-A(202)-0.5*A(203)&
               &-A(204)-A(205)-A(206)-A(207)-A(208)-A(209)-A(210)-A(211)-A(212)-A(213)-A(214)-A(215)-A(216)-A(217)-A(218)&
               &-A(219)-A(220)-A(221)-A(222)-A(223)-A(224)-A(225)-A(227)+0.6*A(277)+A(279)+0.85*A(281)+A(286)+A(289)+A(292)&
               &+A(293)+0.7*A(307)+A(309)
  Vdot(87) = A(4)+A(23)-A(29)-A(30)-A(31)-A(32)+A(33)-A(36)-A(37)-A(39)-A(70)-A(86)-A(108)-A(141)-A(144)-A(145)-A(157)&
               &-A(158)-A(159)-A(185)-2*A(228)-A(255)-A(259)+A(269)-A(270)-A(271)+A(272)+A(273)+0.4*A(277)
  Vdot(88) = -A(76)+A(77)-A(83)-A(133)+0.8*A(140)-A(161)-A(165)+A(176)-A(225)
  Vdot(89) = -A(1)-A(2)-A(3)-A(4)-A(5)+A(6)+0.15*A(131)+0.3*A(132)+0.29*A(133)+0.3*A(134)+0.3*A(135)-A(137)-A(139)-0.9&
               &*A(154)-0.8*A(155)-0.8*A(156)-0.7*A(188)+A(241)-A(244)-A(261)+A(262)+A(270)+A(273)
  Vdot(90) = -A(5)+A(14)-A(15)-A(16)-2*A(17)-2*A(18)+A(19)+A(42)+0.18*A(50)+A(72)-A(89)-A(90)+A(93)+A(94)-A(107)-0.91&
               &*A(109)-A(110)-A(111)-A(112)-A(113)-A(114)-A(115)-A(116)-A(117)-A(118)-A(119)-A(120)-A(121)-A(122)-A(123)&
               &+0.44*A(131)+0.305*A(137)+A(150)+A(151)-A(160)-A(161)-A(162)-A(163)-A(164)-A(165)-A(166)-A(167)+2*A(189)&
               &-A(191)+1.18*A(192)+A(193)+A(194)+A(195)+A(196)+A(197)+A(198)+A(199)+A(200)+A(201)+A(202)+A(203)+A(204)&
               &+A(205)+A(206)+A(222)+A(224)+A(225)+A(226)+A(227)+A(257)+A(258)+A(259)+A(275)+0.4*A(277)+A(279)+2*A(280)&
               &+0.15*A(281)+A(290)+0.18*A(310)+A(311)
      
END SUBROUTINE Fun

! End of Fun function
! ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~



END MODULE gckpp_Function

