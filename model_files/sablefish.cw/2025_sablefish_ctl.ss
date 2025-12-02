#V3.30.23.1;_safe;_compile_date:_Dec  5 2024;_Stock_Synthesis_by_Richard_Methot_(NOAA)_using_ADMB_13.2
#_Stock_Synthesis_is_a_work_of_the_U.S._Government_and_is_not_subject_to_copyright_protection_in_the_United_States.
#_Foreign_copyrights_may_apply._See_copyright.txt_for_more_information.
#_User_support_available_at:NMFS.Stock.Synthesis@noaa.gov
#_User_info_available_at:https://vlab.noaa.gov/group/stock-synthesis
#_Source_code_at:_https://github.com/nmfs-ost/ss3-source-code

#C file created using an r4ss function
#C file write time: 2025-04-15  08:07:59
#_data_and_control_files: 2025_sablefish_dat.ss // 2025_sablefish_ctl.ss
1  # 0 means do not read wtatage.ss; 1 means read and use wtatage.ss and also read and use growth parameters
1  #_N_Growth_Patterns (Growth Patterns, Morphs, Bio Patterns, GP are terms used interchangeably in SS3)
1 #_N_platoons_Within_GrowthPattern 
#_Cond 1 #_Platoon_within/between_stdev_ratio (no read if N_platoons=1)
#_Cond sd_ratio_rd < 0: platoon_sd_ratio parameter required after movement params.
#_Cond  1 #vector_platoon_dist_(-1_in_first_val_gives_normal_approx)
#
4 # recr_dist_method for parameters:  2=main effects for GP, Area, Settle timing; 3=each Settle entity; 4=none (only when N_GP*Nsettle*pop==1)
1 # not yet implemented; Future usage: Spawner-Recruitment: 1=global; 2=by area
1 #  number of recruitment settlement assignments 
0 # unused option
#GPattern month  area  age (for each settlement assignment)
 1 1 1 0
#
#_Cond 0 # N_movement_definitions goes here if Nareas > 1
#_Cond 1.0 # first age that moves (real age at begin of season, not integer) also cond on do_migration>0
#_Cond 1 1 1 2 4 10 # example move definition for seas=1, morph=1, source=1 dest=2, age1=4, age2=10
#
3 #_Nblock_Patterns
 2 1 1 #_blocks_per_pattern 
# begin and end years of blocks
 1890 2010 2011 2018 # Discard Peak
 1890 2010 # Discard descending
 1890 2001 # Retain Selectivity
#
# controls for all timevary parameters 
1 #_time-vary parm bound check (1=warn relative to base parm bounds; 3=no bound check); Also see env (3) and dev (5) options to constrain with base bounds
#
# AUTOGEN
 1 1 1 1 1 # autogen: 1st element for biology, 2nd for SR, 3rd for Q, 4th reserved, 5th for selex
# where: 0 = autogen time-varying parms of this category; 1 = read each time-varying parm line; 2 = read then autogen if parm min==-12345
#
#_Available timevary codes
#_Block types: 0: P_block=P_base*exp(TVP); 1: P_block=P_base+TVP; 2: P_block=TVP; 3: P_block=P_block(-1) + TVP
#_Block_trends: -1: trend bounded by base parm min-max and parms in transformed units (beware); -2: endtrend and infl_year direct values; -3: end and infl as fraction of base range
#_EnvLinks:  1: P(y)=P_base*exp(TVP*env(y));  2: P(y)=P_base+TVP*env(y);  3: P(y)=f(TVP,env_Zscore) w/ logit to stay in min-max;  4: P(y)=2.0/(1.0+exp(-TVP1*env(y) - TVP2))
#_DevLinks:  1: P(y)*=exp(dev(y)*dev_se;  2: P(y)+=dev(y)*dev_se;  3: random walk;  4: zero-reverting random walk with rho;  5: like 4 with logit transform to stay in base min-max
#_DevLinks(more):  21-25 keep last dev for rest of years
#
#_Prior_codes:  0=none; 6=normal; 1=symmetric beta; 2=CASAL's beta; 3=lognormal; 4=lognormal with biascorr; 5=gamma
#
# setup for M, growth, wt-len, maturity, fecundity, (hermaphro), recr_distr, cohort_grow, (movement), (age error), (catch_mult), sex ratio 
#_NATMORT
0 #_natM_type:_0=1Parm; 1=N_breakpoints;_2=Lorenzen;_3=agespecific;_4=agespec_withseasinterpolate;_5=BETA:_Maunder_link_to_maturity;_6=Lorenzen_range
  #_no additional input for selected M option; read 1P per morph
#
1 # GrowthModel: 1=vonBert with L1&L2; 2=Richards with L1&L2; 3=age_specific_K_incr; 4=age_specific_K_decr; 5=age_specific_K_each; 6=NA; 7=NA; 8=growth cessation
0.5 #_Age(post-settlement) for L1 (aka Amin); first growth parameter is size at this age; linear growth below this
30 #_Age(post-settlement) for L2 (aka Amax); 999 to treat as Linf
-999 #_exponential decay for growth above maxage (value should approx initial Z; -999 replicates 3.24; -998 to not allow growth above maxage)
0  #_placeholder for future growth feature
#
0 #_SD_add_to_LAA (set to 0.1 for SS2 V1.x compatibility)
0 #_CV_Growth_Pattern:  0 CV=f(LAA); 1 CV=F(A); 2 SD=F(LAA); 3 SD=F(A); 4 logSD=F(A)
#
5 #_maturity_option:  1=length logistic; 2=age logistic; 3=read age-maturity matrix by growth_pattern; 4=read age-fecundity; 5=disabled; 6=read length-maturity
#_Age_Maturity by growth pattern
# 0.0104542 0.0224367 0.0474946 0.0977395 0.190508 0.338311 0.526239 0.707016 0.83981 0.919287 0.961156 0.981737 0.99151 0.996074 0.998189 0.999166 0.999616 0.999823 0.999919 0.999963 0.999983 0.999992 0.999996 0.999998 0.999999 0.999999 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1
3 #_First_Mature_Age
1 #_fecundity_at_length option:(1)eggs=Wt*(a+b*Wt);(2)eggs=a*L^b;(3)eggs=a*Wt^b; (4)eggs=a+b*L; (5)eggs=a+b*W
0 #_hermaphroditism option:  0=none; 1=female-to-male age-specific fxn; -1=male-to-female age-specific fxn
1 #_parameter_offset_approach for M, G, CV_G:  1- direct, no offset**; 2- male=fem_parm*exp(male_parm); 3: male=female*exp(parm) then old=young*exp(parm)
#_** in option 1, any male parameter with value = 0.0 and phase <0 is set equal to female parameter
#
#_growth_parms
#_ LO HI INIT PRIOR PR_SD PR_type PHASE env_var&link dev_link dev_minyr dev_maxyr dev_PH Block Block_Fxn
# Sex: 1  BioPattern: 1  NatMort
 0.04 0.13 0.084261 -2.631 0.31 3 2 0 0 0 0 0 0 0 # NatM_uniform_Fem_GP_1
# Sex: 1  BioPattern: 1  Growth
 20 35 25.1822 24.9 99 0 -2 0 0 0 0 0 0 0 # L_at_Amin_Fem_GP_1
 55 70 60.7182 66 99 0 -2 0 0 0 0 0 0 0 # L_at_Amax_Fem_GP_1
 0.15 0.55 0.342744 0.34 99 0 -2 0 0 0 0 0 0 0 # VonBert_K_Fem_GP_1
 0.001 1 0.0972141 0.1 99 0 -2 0 0 0 0 0 0 0 # lnSD_young_Fem_GP_1
 0.01 1 0.0905326 0.15 99 0 -2 0 0 0 0 0 0 0 # LnSD_old_Fem_GP_1
# Sex: 1  BioPattern: 1  WtLen
 0 1 3.41065e-06 3.41e-06 99 6 -50 0 0 0 0 0 0 0 # Wtlen_1_Fem_GP_1
 0 4 3.2667 3.3 99 6 -50 0 0 0 0 0 0 0 # Wtlen_2_Fem_GP_1
# Sex: 1  BioPattern: 1  Maturity&Fecundity
 53 59 55.19 55 99 6 -50 0 0 0 0 0 0 0 # Mat50%_Fem_GP_1
 -3 3 -0.421 -0.25 99 6 -50 0 0 0 0 0 0 0 # Mat_slope_Fem_GP_1
 -3 3 1 1 99 6 -50 0 0 0 0 0 0 0 # Eggs/kg_inter_Fem_GP_1
 -3 3 0 0 99 6 -50 0 0 0 0 0 0 0 # Eggs/kg_slope_wt_Fem_GP_1
# Sex: 2  BioPattern: 1  NatMort
 0 0.13 0 0 0.31 6 -3 0 0 0 0 0 0 0 # NatM_uniform_Mal_GP_1
# Sex: 2  BioPattern: 1  Growth
 15 35 26.6461 25.5 99 0 -2 0 0 0 0 0 0 0 # L_at_Amin_Mal_GP_1
 50 60 56.0591 57 99 0 -2 0 0 0 0 0 0 0 # L_at_Amax_Mal_GP_1
 0.2 0.55 0.351087 0.423 99 0 -2 0 0 0 0 0 0 0 # VonBert_K_Mal_GP_1
 0.001 1 0.0857992 0 99 0 -2 0 0 0 0 0 0 0 # lnSD_young_Mal_GP_1
 0.01 1 0.0733395 0.1 99 0 -2 0 0 0 0 0 0 0 # LnSD_old_Mal_GP_1
# Sex: 2  BioPattern: 1  WtLen
 0 1 3.70085e-06 3.7e-06 99 6 -50 0 0 0 0 0 0 0 # Wtlen_1_Mal_GP_1
 0 4 3.24693 3.2 99 6 -50 0 0 0 0 0 0 0 # Wtlen_2_Mal_GP_1
# Hermaphroditism
#  Recruitment Distribution 
#  Cohort growth dev base
 0.1 10 1 1 1 0 -50 0 0 0 0 0 0 0 # CohortGrowDev
#  Movement
#  Platoon StDev Ratio 
#  Age Error from parameters
#  catch multiplier
#  fraction female, by GP
 1e-06 0.9999 0.5 0.5 0.5 0 -99 0 0 0 0 0 0 0 # FracFemale_GP_1
#  M2 parameter for each predator fleet
#
#_no timevary MG parameters
#
#_seasonal_effects_on_biology_parms
 0 0 0 0 0 0 0 0 0 0 #_femwtlen1,femwtlen2,mat1,mat2,fec1,fec2,Malewtlen1,malewtlen2,L1,K
#_ LO HI INIT PRIOR PR_SD PR_type PHASE
#_Cond -2 2 0 0 -1 99 -2 #_placeholder when no seasonal MG parameters
#
3 #_Spawner-Recruitment; Options: 1=NA; 2=Ricker; 3=std_B-H; 4=SCAA; 5=Hockey; 6=B-H_flattop; 7=survival_3Parm; 8=Shepherd_3Parm; 9=RickerPower_3parm
0  # 0/1 to use steepness in initial equ recruitment calculation
0  #  future feature:  0/1 to make realized sigmaR a function of SR curvature
#_          LO            HI          INIT         PRIOR         PR_SD       PR_type      PHASE    env-var    use_dev   dev_mnyr   dev_mxyr     dev_PH      Block    Blk_Fxn #  parm_name
             8            12         10.40          10.5            99             0          1          0          0          0          0          0          0          0 # SR_LN(R0)
           0.2             1          0.75          0.75          0.15             2         -7          0          0          0          0          0          0          0 # SR_BH_steep
           0.2           1.5           1.4           0.6            99             0        -50          0          0          0          0          0          0          0 # SR_sigmaR
            -1             1             0             0            99             0        -50          0          0          0          0          0          0          0 # SR_regime
            -1             1             0             0            99             0        -50          0          0          0          0          0          0          0 # SR_autocorr
#_no timevary SR parameters
2 #do_recdev:  0=none; 1=devvector (R=F(SSB)+dev); 2=deviations (R=F(SSB)+dev); 3=deviations (R=R0*dev; dev2=R-f(SSB)); 4=like 3 with sum(dev2) adding penalty
1975 # first year of main recr_devs; early devs can precede this era
2023 # last year of main recr_devs; forecast devs start in following year
2 #_recdev phase 
1 # (0/1) to read 13 advanced options
 1890 #_recdev_early_start (0=none; neg value makes relative to recdev_start)
 -3 #_recdev_early_phase
 3 #_forecast_recruitment phase (incl. late recr) (0 value resets to maxphase+1)
 1 #_lambda for Fcast_recr_like occurring before endyr+1
 1974 #_last_yr_nobias_adj_in_MPD; begin of ramp
 1979 #_first_yr_fullbias_adj_in_MPD; begin of plateau
 2023 #_last_yr_fullbias_adj_in_MPD
 2024 #_end_yr_for_ramp_in_MPD (can be in forecast to shape ramp, but SS3 sets bias_adj to 0.0 for fcast yrs)
 0.96 #_max_bias_adj_in_MPD (typical ~0.8; -3 sets all years to 0.0; -2 sets all non-forecast yrs w/ estimated recdevs to 1.0; -1 sets biasadj=1.0 for all yrs w/ recdevs)
 0 #_period of cycles in recruitment (N parms read below)
 -4 #min rec_dev
 4 #max rec_dev
 0 #_read_recdevs
#_end of advanced SR options
#
#_placeholder for full parameter lines for recruitment cycles
# read specified recr devs
#_year Input_value
#
#
#Fishing Mortality info 
0.02 # F ballpark value in units of annual_F
-2000 # F ballpark year (neg value to disable)
3 # F_Method:  1=Pope midseason rate; 2=F as parameter; 3=F as hybrid; 4=fleet-specific parm/hybrid (#4 is superset of #2 and #3 and is recommended)
3 # max F (methods 2-4) or harvest fraction (method 1)
4  # N iterations for tuning in hybrid mode; recommend 3 (faster) to 5 (more precise if many fleets)
#
#_initial_F_parms; for each fleet x season that has init_catch; nest season in fleet; count = 0
#_for unconstrained init_F, use an arbitrary initial catch and set lambda=0 for its logL
#_ LO HI INIT PRIOR PR_SD  PR_type  PHASE
#
#
#_Q_setup for fleets with cpue or survey or deviation data
#_1:  fleet number
#_2:  link type: 1=simple q; 2=mirror; 3=power (+1 parm); 4=mirror with scale (+1p); 5=offset (+1p); 6=offset & power (+2p)
#_     where power is applied as y = q * x ^ (1 + power); so a power value of 0 has null effect
#_     and with the offset included it is y = q * (x + offset) ^ (1 + power)
#_3:  extra input for link, i.e. mirror fleet# or dev index number
#_4:  0/1 to select extra sd parameter
#_5:  0/1 for biasadj or not
#_6:  0/1 to float
#_   fleet      link link_info  extra_se   biasadj     float  #  fleetname
         7         1         0         1         0         1  #  Triennial_Early
         8         1         0         1         0         1  #  Triennial_Late
         9         1         0         1         0         1  #  NWFSC_Slope
        10         1         0         1         0         1  #  WCGBT
        11         5         0         0         0         0  #  ENV
-9999 0 0 0 0 0
#
#_Q_parameters
#_          LO            HI          INIT         PRIOR         PR_SD       PR_type      PHASE    env-var    use_dev   dev_mnyr   dev_mxyr     dev_PH      Block    Blk_Fxn  #  parm_name
           -15            15      0.167784             0            99             0         -1          0          0          0          0          0          0          0  #  LnQ_base_Triennial_Early(7)
         0.001           0.5         0.001             0            99             0         -2          0          0          0          0          0          0          0  #  Q_extraSD_Triennial_Early(7)
           -15            15      0.336667             0            99             0         -1          0          0          0          0          0          0          0  #  LnQ_base_Triennial_Late(8)
         0.001          0.75      0.185526             0            99             0          1          0          0          0          0          0          0          0  #  Q_extraSD_Triennial_Late(8)
           -15            15     -0.644843             0            99             0         -1          0          0          0          0          0          0          0  #  LnQ_base_NWFSC_Slope(9)
         0.001          0.75      0.147979             0            99             0          2          0          0          0          0          0          0          0  #  Q_extraSD_NWFSC_Slope(9)
           -15            15     -0.000012             0            99             0         -1          0          0          0          0          0          0          0  #  LnQ_base_WCGBT(10)
         0.0001          0.3        0.0001             0            99             0         -2          0          0          0          0          0          0          0  #  Q_extraSD_WCGBT(10)
             0            10           0.5             0            99             0          1          0          0          0          0          0          0          0  #  Q_base_ENV(11)
           -15            15             0             0            99             0         -1          0          0          0          0          0          0          0  #  Q_offset_ENV(11)
#_no timevary Q parameters
#
#_size_selex_patterns
#Pattern:_0;  parm=0; selex=1.0 for all sizes
#Pattern:_1;  parm=2; logistic; with 95% width specification
#Pattern:_5;  parm=2; mirror another size selex; PARMS pick the min-max bin to mirror
#Pattern:_11; parm=2; selex=1.0  for specified min-max population length bin range
#Pattern:_15; parm=0; mirror another age or length selex
#Pattern:_6;  parm=2+special; non-parm len selex
#Pattern:_43; parm=2+special+2;  like 6, with 2 additional param for scaling (mean over bin range)
#Pattern:_8;  parm=8; double_logistic with smooth transitions and constant above Linf option
#Pattern:_9;  parm=6; simple 4-parm double logistic with starting length; parm 5 is first length; parm 6=1 does desc as offset
#Pattern:_21; parm=2*special; non-parm len selex, read as N break points, then N selex parameters
#Pattern:_22; parm=4; double_normal as in CASAL
#Pattern:_23; parm=6; double_normal where final value is directly equal to sp(6) so can be >1.0
#Pattern:_24; parm=6; double_normal with sel(minL) and sel(maxL), using joiners
#Pattern:_2;  parm=6; double_normal with sel(minL) and sel(maxL), using joiners, back compatibile version of 24 with 3.30.18 and older
#Pattern:_25; parm=3; exponential-logistic in length
#Pattern:_27; parm=special+3; cubic spline in length; parm1==1 resets knots; parm1==2 resets all 
#Pattern:_42; parm=special+3+2; cubic spline; like 27, with 2 additional param for scaling (mean over bin range)
#_discard_options:_0=none;_1=define_retention;_2=retention&mortality;_3=all_discarded_dead;_4=define_dome-shaped_retention
#_Pattern Discard Male Special
 0 0 0 0 # 1 TWL
 0 0 0 0 # 2 HKL
 0 0 0 0 # 3 Pot
 0 0 0 0 # 4 TWL_Discards
 0 0 0 0 # 5 HKL_Discards
 0 0 0 0 # 6 Pot_Discard
 0 0 0 0 # 7 Triennial_Early
 0 0 0 0 # 8 Triennial_Late
 0 0 0 0 # 9 NWFSC_Slope
 0 0 0 0 # 10 WCGBT
 0 0 0 0 # 11 ENV
#
#_age_selex_patterns
#Pattern:_0; parm=0; selex=1.0 for ages 0 to maxage
#Pattern:_10; parm=0; selex=1.0 for ages 1 to maxage
#Pattern:_11; parm=2; selex=1.0  for specified min-max age
#Pattern:_12; parm=2; age logistic
#Pattern:_13; parm=8; age double logistic. Recommend using pattern 18 instead.
#Pattern:_14; parm=nages+1; age empirical
#Pattern:_15; parm=0; mirror another age or length selex
#Pattern:_16; parm=2; Coleraine - Gaussian
#Pattern:_17; parm=nages+1; empirical as random walk  N parameters to read can be overridden by setting special to non-zero
#Pattern:_41; parm=2+nages+1; // like 17, with 2 additional param for scaling (mean over bin range)
#Pattern:_18; parm=8; double logistic - smooth transition
#Pattern:_19; parm=6; simple 4-parm double logistic with starting age
#Pattern:_20; parm=6; double_normal,using joiners
#Pattern:_26; parm=3; exponential-logistic in age
#Pattern:_27; parm=3+special; cubic spline in age; parm1==1 resets knots; parm1==2 resets all 
#Pattern:_42; parm=2+special+3; // cubic spline; with 2 additional param for scaling (mean over bin range)
#Age patterns entered with value >100 create Min_selage from first digit and pattern from remainder
#_Pattern Discard Male Special
 20 0 0 0 # 1 TWL
 20 0 3 0 # 2 HKL
 15 0 0 2 # 3 Pot
 20 0 0 0 # 4 TWL_Discards
 20 0 0 0 # 5 HKL_Discards
 20 0 0 0 # 6 Pot_Discard
 20 0 0 0 # 7 Triennial_Early
 20 0 0 0 # 8 Triennial_Late
 20 0 0 0 # 9 NWFSC_Slope
 20 0 0 0 # 10 WCGBT
 11 0 0 0 # 11 ENV
#
#_          LO            HI          INIT         PRIOR         PR_SD       PR_type      PHASE    env-var    use_dev   dev_mnyr   dev_mxyr     dev_PH      Block    Blk_Fxn  #  parm_name
# 1   TWL LenSelex
# 2   HKL LenSelex
# 3   Pot LenSelex
# 4   TWL_Discards LenSelex
# 5   HKL_Discards LenSelex
# 6   Pot_Discard LenSelex
# 7   Triennial_Early LenSelex
# 8   Triennial_Late LenSelex
# 9   NWFSC_Slope LenSelex
# 10   WCGBT LenSelex
# 11   ENV LenSelex
# 1   TWL AgeSelex
          0.01            10       3.59766             1            99             0          3          0          0          0          0          0          3          2  #  Age_DblN_peak_TWL(1)
           -10            10      -1.77183           0.3            99             0          5          0          0          0          0          0          0          0  #  Age_DblN_top_logit_TWL(1)
           -10            10      0.899472             5            99             0          4          0          0          0          0          0          3          2  #  Age_DblN_ascend_se_TWL(1)
           -10            10           -10             4            99             0         -5          0          0          0          0          0          0          0  #  Age_DblN_descend_se_TWL(1)
           -10            10      -9.99999             0            99             0         -4          0          0          0          0          0          0          0  #  Age_DblN_start_logit_TWL(1)
           -10            10      0.565923            -5            99             0          5          0          0          0          0          0          0          0  #  Age_DblN_end_logit_TWL(1)
# 2   HKL AgeSelex
          0.01            20       5.32135             1            99             0          3          0          0          0          0          0          3          2  #  Age_DblN_peak_HKL(2)
            -5             5            -4           0.3            99             0         -4          0          0          0          0          0          0          0  #  Age_DblN_top_logit_HKL(2)
           -10            10      0.915386             5            99             0          5          0          0          0          0          0          0          0  #  Age_DblN_ascend_se_HKL(2)
           -10            10       4.06564             4            99             0          5          0          0          0          0          0          0          0  #  Age_DblN_descend_se_HKL(2)
           -10            10            -5             0            99             0         -4          0          0          0          0          0          0          0  #  Age_DblN_start_logit_HKL(2)
           -10            10      -1.35505            -5            99             0          5          0          0          0          0          0          0          0  #  Age_DblN_end_logit_HKL(2)
           -20            20     -0.104302             0            99             0          3          0          0          0          0          0          0          0  #  AgeSel_2Male_Peak_HKL
            -5             5             0             0            99             0         -4          0          0          0          0          0          0          0  #  AgeSel_2Male_Ascend_HKL
           -10            10             0             0            99             0         -4          0          0          0          0          0          0          0  #  AgeSel_2Male_Descend_HKL
           -20            10     -0.636248             0            99             0          4          0          0          0          0          0          0          0  #  AgeSel_2Male_Final_HKL
          0.01             1      0.279859             1            99             0          3          0          0          0          0          0          0          0  #  AgeSel_2Male_Scale_HKL
# 3   Pot AgeSelex
# 4   TWL_Discards AgeSelex
          0.01            20      0.205644             1            99             0         -4          0          0          0          0          0          1          2  #  Age_DblN_peak_TWL_Discards(4)
           -10            10      -3.73792           0.3            99             0         -4          0          0          0          0          0          0          0  #  Age_DblN_top_logit_TWL_Discards(4)
           -10            10       9.99916             5            99             0         -5          0          0          0          0          0          0          0  #  Age_DblN_ascend_se_TWL_Discards(4)
           -10            10      -2.74909             4            99             0          5          0          0          0          0          0          2          2  #  Age_DblN_descend_se_TWL_Discards(4)
           -10            10      -3.30918             0            99             0         -4          0          0          0          0          0          0          0  #  Age_DblN_start_logit_TWL_Discards(4)
           -10            10      -1.90549            -5            99             0          4          0          0          0          0          0          0          0  #  Age_DblN_end_logit_TWL_Discards(4)
# 5   HKL_Discards AgeSelex
          0.01            20       4.47293             1            99             0          3          0          0          0          0          0          1          2  #  Age_DblN_peak_HKL_Discards(5)
           -10            10      -5.95332           0.3            99             0         -4          0          0          0          0          0          0          0  #  Age_DblN_top_logit_HKL_Discards(5)
           -10            10        1.0867             5            99             0          4          0          0          0          0          0          0          0  #  Age_DblN_ascend_se_HKL_Discards(5)
           -10            10      -7.81765             4            99             0         -5          0          0          0          0          0          0          0  #  Age_DblN_descend_se_HKL_Discards(5)
           -10            10            -5             0            99             0         -4          0          0          0          0          0          0          0  #  Age_DblN_start_logit_HKL_Discards(5)
           -10            10      0.565083            -5            99             0          4          0          0          0          0          0          0          0  #  Age_DblN_end_logit_HKL_Discards(5)
# 6   Pot_Discard AgeSelex
          0.01            20       2.94442             1            99             0          3          0          0          0          0          0          2          2  #  Age_DblN_peak_Pot_Discard(6)
           -10            10      -3.23371           0.3            99             0         -4          0          0          0          0          0          0          0  #  Age_DblN_top_logit_Pot_Discard(6)
           -10            10     -0.567118             5            99             0          4          0          0          0          0          0          0          0  #  Age_DblN_ascend_se_Pot_Discard(6)
           -10            10      -5.49683             4            99             0         -5          0          0          0          0          0          0          0  #  Age_DblN_descend_se_Pot_Discard(6)
           -10            10            -5             0            99             0         -4          0          0          0          0          0          0          0  #  Age_DblN_start_logit_Pot_Discard(6)
           -10            10       2.67639            -5            99             0          4          0          0          0          0          0          0          0  #  Age_DblN_end_logit_Pot_Discard(6)
# 7   Triennial_Early AgeSelex
          0.01            12      0.581097             1            99             0         -4          0          0          0          0          0          0          0  #  Age_DblN_peak_Triennial_Early(7)
           -10            10      -3.34652           0.3            99             0          4          0          0          0          0          0          0          0  #  Age_DblN_top_logit_Triennial_Early(7)
           -10            10      -9.72391             5            99             0         -4          0          0          0          0          0          0          0  #  Age_DblN_ascend_se_Triennial_Early(7)
           -10            10      -8.64738             4            99             0         -4          0          0          0          0          0          0          0  #  Age_DblN_descend_se_Triennial_Early(7)
           -10             5            -5            -5            99             0         -4          0          0          0          0          0          0          0  #  Age_DblN_start_logit_Triennial_Early(7)
           -10            10      -5.32407            -5            99             0          4          0          0          0          0          0          0          0  #  Age_DblN_end_logit_Triennial_Early(7)
# 8   Triennial_Late AgeSelex
          0.01            12       1.04968             1            99             0          3          0          0          0          0          0          0          0  #  Age_DblN_peak_Triennial_Late(8)
           -10            10           -10           0.3            99             0         -4          0          0          0          0          0          0          0  #  Age_DblN_top_logit_Triennial_Late(8)
           -10            10      -9.72391             5            99             0         -4          0          0          0          0          0          0          0  #  Age_DblN_ascend_se_Triennial_Late(8)
           -10            10       1.36842             4            99             0          4          0          0          0          0          0          0          0  #  Age_DblN_descend_se_Triennial_Late(8)
           -10             5            -5            -5            99             0         -4          0          0          0          0          0          0          0  #  Age_DblN_start_logit_Triennial_Late(8)
           -10            10      -3.69724            -5            99             0          4          0          0          0          0          0          0          0  #  Age_DblN_end_logit_Triennial_Late(8)
# 9   NWFSC_Slope AgeSelex
          0.01            15       3.73483             1            99             0         -4          0          0          0          0          0          0          0  #  Age_DblN_peak_NWFSC_Slope(9)
           -10            10      -5.67511           0.3            99             0         -4          0          0          0          0          0          0          0  #  Age_DblN_top_logit_NWFSC_Slope(9)
           -10            10       1.54477             5            99             0          4          0          0          0          0          0          0          0  #  Age_DblN_ascend_se_NWFSC_Slope(9)
           -10            10      -6.94214             4            99             0         -4          0          0          0          0          0          0          0  #  Age_DblN_descend_se_NWFSC_Slope(9)
           -10            10      -4.71773            -5            99             0         -4          0          0          0          0          0          0          0  #  Age_DblN_start_logit_NWFSC_Slope(9)
           -10            10       1.28127            -5            99             0          4          0          0          0          0          0          0          0  #  Age_DblN_end_logit_NWFSC_Slope(9)
# 10   WCGBT AgeSelex
          0.01            10          0.25             1            99             0         -4          0          0          0          0          0          0          0  #  Age_DblN_peak_WCGBT(10)
           -10            10      -9.99987           0.3            99             0         -4          0          0          0          0          0          0          0  #  Age_DblN_top_logit_WCGBT(10)
           -10            10       4.34053             5            99             0         -4          0          0          0          0          0          0          0  #  Age_DblN_ascend_se_WCGBT(10)
           -10            10          -9.9          -5.5            99             0         -4          0          0          0          0          0          0          0  #  Age_DblN_descend_se_WCGBT(10)
           -10             5         -2.75            -5            99             0         -4          0          0          0          0          0          0          0  #  Age_DblN_start_logit_WCGBT(10)
           -10            10       1.44385            -5            99             0          4          0          0          0          0          0          0          0  #  Age_DblN_end_logit_WCGBT(10)
# 11   ENV AgeSelex
             0            10             0            -5            99             0        -99          0          0          0          0          0          0          0  #  minage@sel=1_ENV(11)
             0            10             0            -5            99             0        -99          0          0          0          0          0          0          0  #  maxage@sel=1_ENV(11)
#_No_Dirichlet parameters
# timevary selex parameters 
#_          LO            HI          INIT         PRIOR         PR_SD       PR_type    PHASE  #  parm_name
          0.01            20        1.1218             1            99             0      6  # Age_DblN_peak_TWL(1)_BLK3repl_1890
           -10            10      -7.27287             5            99             0     -4  # Age_DblN_ascend_se_TWL(1)_BLK3repl_1890
             1            20       4.63651             1            99             0      6  # Age_DblN_peak_HKL(2)_BLK3repl_1890
#           -3             3     -0.479933             0            99             0      6  # AgeSel_2Male_Peak_HKL_BLK3repl_1890
          0.01            20      0.406885             1            99             0      6  # Age_DblN_peak_TWL_Discards(4)_BLK1repl_1890
          0.01            20     0.0911056             1            99             0     -6  # Age_DblN_peak_TWL_Discards(4)_BLK1repl_2011
           -10            10           -10             4            99             0     -7  # Age_DblN_descend_se_TWL_Discards(4)_BLK2repl_1890
             1            20       2.11471             1            99             0     -6  # Age_DblN_peak_HKL_Discards(5)_BLK1repl_1890
             1            20       3.77859             1            99             0      7  # Age_DblN_peak_HKL_Discards(5)_BLK1repl_2011
             1            20       2.09978             1            99             0      6  # Age_DblN_peak_Pot_Discard(6)_BLK1repl_1890
#             1            20       2.63082             1            99             0      7  # Age_DblN_peak_Pot_Discard(6)_BLK1repl_2011
# info on dev vectors created for selex parms are reported with other devs after tag parameter section 
#
0   #  use 2D_AR1 selectivity? (0/1)
#_no 2D_AR1 selex offset used
#_specs:  fleet, ymin, ymax, amin, amax, sigma_amax, use_rho, len1/age2, devphase, before_range, after_range
#_sigma_amax>amin means create sigma parm for each bin from min to sigma_amax; sigma_amax<0 means just one sigma parm is read and used for all bins
#_needed parameters follow each fleet's specifications
# -9999  0 0 0 0 0 0 0 0 0 0 # terminator
#
# Tag loss and Tag reporting parameters go next
0  # TG_custom:  0=no read and autogen if tag data exist; 1=read
#_Cond -6 6 1 1 2 0.01 -4 0 0 0 0 0 0 0  #_placeholder if no parameters
#
# Input variance adjustments factors: 
 #_1=add_to_survey_CV
 #_2=add_to_discard_stddev
 #_3=add_to_bodywt_CV
 #_4=mult_by_lencomp_N
 #_5=mult_by_agecomp_N
 #_6=mult_by_size-at-age_N
 #_7=mult_by_generalized_sizecomp
#factor fleet New_Var_adj hash Old_Var_adj New_Francis New_MI Francis_mult Francis_lo Francis_hi MI_mult Type Name Note
5	1	0.194052
5	2	0.318849
5	3	0.125632
5	4	0.329077
5	5	0.070836
5	6	0.077003
5	7	1.0
5	8	1.0
5	9	0.123101
5	10	0.053476
 -9999   1    0  # terminator
#
1 #_maxlambdaphase
1 #_sd_offset; must be 1 if any growthCV, sigmaR, or survey extraSD is an estimated parameter
# read 1 changes to default Lambdas (default value is 1.0)
# Like_comp codes:  1=surv; 2=disc; 3=mnwt; 4=length; 5=age; 6=SizeFreq; 7=sizeage; 8=catch; 9=init_equ_catch; 
# 10=recrdev; 11=parm_prior; 12=parm_dev; 13=CrashPen; 14=Morphcomp; 15=Tag-comp; 16=Tag-negbin; 17=F_ballpark; 18=initEQregime
#like_comp fleet  phase  value  sizefreq_method
-9999  1  1  1  1  #  terminator
#
# lambdas (for info only; columns are phases)
#  0 # F_ballpark_lambda
0 # (0/1/2) read specs for more stddev reporting: 0 = skip, 1 = read specs for reporting stdev for selectivity, size, and numbers, 2 = add options for M,Dyn. Bzero, SmryBio
 # 0 2 0 0 # Selectivity: (1) fleet, (2) 1=len/2=age/3=both, (3) year, (4) N selex bins
 # 0 0 # Growth: (1) growth pattern, (2) growth ages
 # 0 0 0 # Numbers-at-age: (1) area(-1 for all), (2) year, (3) N ages
 # -1 # list of bin #'s for selex std (-1 in first bin to self-generate)
 # -1 # list of ages for growth std (-1 in first bin to self-generate)
 # -1 # list of ages for NatAge std (-1 in first bin to self-generate)
999

