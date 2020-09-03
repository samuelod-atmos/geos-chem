#!/bin/bash

# createRunDir.sh: Create GEOS-Chem Classic run directory
#
# Optional argument: run directory name
#
# If optional run directory name argument is not passed then the user
# will be prompted to enter a name interactively, or choose to use the
# default name GC_{res}_{simulation}.
#
# Usage: ./createRunDir.sh [rundirname]
#
# Initial version: M. Sulprizio, 6/24/2020 (based off GCHPctm/createRunDir.sh)

srcrundir=$(pwd -P)
cd ${srcrundir}
cd ../..
gcdir=$(pwd -P)
cd ../../
wrapperdir=$(pwd -P)
cd ${srcrundir}

# Define separator lines
thickline="\n===========================================================\n"
thinline="\n-----------------------------------------------------------\n"

printf "${thickline}GEOS-CHEM RUN DIRECTORY CREATION${thickline}"

#-----------------------------------------------------------------
# Export data root path in ~/.geoschem/config if file exists
#-----------------------------------------------------------------
if [[ -f ${HOME}/.geoschem/config ]]; then
    source ${HOME}/.geoschem/config
    if [[ ! -d ${GC_DATA_ROOT} ]]; then
	printf "\nWarning: Default root data directory does not exist!"
        printf "\nSet new path below or manually edit ${HOME}/.geoschem/config.\n"
    fi
else
    printf "${thinline}Define path to ExtData."
    printf "\nThis will be stored in ${HOME}/.geoschem/config for future automatic use.${thinline}"
    mkdir -p ${HOME}/.geoschem
fi

#-----------------------------------------------------------------
# One-time configuration of data root path in ~/.geoschem/config
#-----------------------------------------------------------------
if [[ -z "${GC_DATA_ROOT}" ]]; then
    printf "${thinline}Enter path for ExtData:${thinline}"
    valid_path=0
    while [ "$valid_path" -eq 0 ]; do
	read extdata
	if [[ ${extdata} = "q" ]]; then
	    printf "\nExiting.\n"
	    exit 1
	elif [[ ! -d ${extdata} ]]; then
            printf "\nERROR: ${extdata} does not exist. Enter a new path or hit q to quit.\n"
	else
	    valid_path=1
	    echo "export GC_DATA_ROOT=${extdata}" >> ${HOME}/.geoschem/config
            source ${HOME}/.geoschem/config
	fi
    done
fi

#-----------------------------------------------------------------
# Ask user to select simulation type
#-----------------------------------------------------------------
printf "${thinline}Choose simulation type:${thinline}"
printf "   1. Full chemistry\n"
printf "   2. Aerosols only\n"
printf "   3. CH4\n"
printf "   4. CO2\n"
printf "   5. Hg\n"
printf "   6. POPs\n"
printf "   7. Tagged CH4\n"
printf "   8. Tagged CO\n"
printf "   9. Tagged O3\n"
printf "  10. TransportTracers\n"

valid_sim=0
while [ "${valid_sim}" -eq 0 ]; do
    read sim_num
    valid_sim=1
    if [[ ${sim_num} = "1" ]]; then
	sim_name=fullchem
    elif [[ ${sim_num} = "2" ]]; then
	sim_name=aerosol
    elif [[ ${sim_num} = "3" ]]; then
	sim_name=CH4
    elif [[ ${sim_num} = "4" ]]; then
	sim_name=CO2
    elif [[ ${sim_num} = "5" ]]; then
	sim_name=Hg
    elif [[ ${sim_num} = "6" ]]; then
	sim_name=POPs
    elif [[ ${sim_num} = "7" ]]; then
	sim_name=tagCH4
    elif [[ ${sim_num} = "8" ]]; then
	sim_name=tagCO
    elif [[ ${sim_num} = "9" ]]; then
	sim_name=tagO3
    elif [[ ${sim_num} = "10" ]]; then
	sim_name=TransportTracers
    else
        valid_sim=0
	printf "Invalid simulation option. Try again.\n"
    fi
done

#-----------------------------------------------------------------
# Ask user to specify full-chemistry simulation options
#-----------------------------------------------------------------
if [[ ${sim_name} = "fullchem" ]]; then
    
    printf "${thinline}Choose chemistry domain:${thinline}"
    printf "  1. Troposphere + stratosphere (Recommended)\n"
    printf "  2. Troposphere only\n"
    valid_chemgrid=0
    while [ "${valid_chemgrid}" -eq 0 ]; do
	read chemgrid_num
	if [[ ${chemgrid_num} = "1" ]]; then
	    chemgrid="trop+strat"
	    valid_chemgrid=1
	elif [[ ${chemgrid_num} = "2" ]]; then
	    chemgrid="trop_only"
	    valid_chemgrid=1
	else
	  printf "Invalid chemistry domain option. Try again.\n"
	fi
    done
    
    printf "${thinline}Choose additional simulation option:${thinline}"
    printf "  1. Standard\n"
    printf "  2. Benchmark\n"
    printf "  3. Complex SOA\n"
    printf "  4. Marine POA\n"
    printf "  5. Acid uptake on dust\n"
    printf "  6. TOMAS\n"
    printf "  7. APM\n"
    printf "  8. RRTMG\n"
    valid_sim_option=0
    sim_extra_option=none
    while [ "${valid_sim_option}" -eq 0 ]; do
	read sim_option
	valid_sim_option=1
	if [[ ${sim_option} = "1" ]]; then
	    sim_extra_option=none
	elif [[ ${sim_option} = "2" ]]; then
	    sim_extra_option="benchmark"
	elif [[ ${sim_option} = "3" ]]; then
	    printf "${thinline}Choose complex SOA option:${thinline}"
	    printf "  1. Complex SOA\n"
	    printf "  2. Complex SOA with semivolatile POA\n"
	    valid_soa=0
	    while [ "${valid_soa}" -eq 0 ]; do
		read soa_option
		valid_soa=1
		if [[ ${soa_option} = "1" ]]; then
		    sim_extra_option="complexSOA"
		elif [[ ${soa_option} = "2" ]]; then
		    sim_extra_option="complexSOA_SVPOA"
		else
		    valid_soa=0
		    printf "Invalid complex SOA option.Try again.\n"
		fi
	    done
	elif [[ ${sim_option} = "4" ]]; then
	   sim_extra_option="marinePOA"
	elif [[ ${sim_option} = "5" ]]; then
	   sim_extra_option="aciduptake"
	elif [[ ${sim_option} = "6" ]]; then
	    printf "${thinline}Choose TOMAS option:${thinline}"
	    printf "  1. TOMAS with 15 bins\n"
	    printf "  1. TOASS with 40 bins\n"
	    valid_tomas=0
	    while [ "${valid_tomas}" -eq 0 ]; do
		read tomas_option
		valid_tomas=1
		if [[ ${tomas_option} = "1" ]]; then
		    sim_extra_option="TOMAS15"
		elif [[ ${tomas_option} = "2" ]]; then
		    sim_extra_option="TOMAS40"
		else
		    valid_tomas=0
		    printf "Invalid TOMAS option. Try again.\n"
		fi
	    done
	elif [[ ${sim_option} = "7" ]]; then
	    sim_extra_option="APM"
	elif [[ ${sim_option} = "8" ]]; then
	    sim_extra_option="RRTMG"
	else
	    valid_sim_option=0
	    printf "Invalid simulation option. Try again.\n"
	fi
    done
    
#-----------------------------------------------------------------
# Ask user to specify POPs simulation options
#-----------------------------------------------------------------
elif [[ ${sim_name} = "POPs" ]]; then
    printf "${thinline}Choose POPs type:${thinline}"
    printf "  1. BaP\n"
    printf "  2. PHE\n"
    printf "  3. PYR\n"
    valid_pops=0
    while [ "${valid_pops}" -eq 0 ]; do
	read pops_num
	valid_pops=1
	if [[ ${pops_num} = "1" ]]; then
	    POP_SPC="BaP"
	    POP_XMW="252.31d-3"
	    POP_KOA="3.02d11"
	    POP_KBC="7.94d13"
	    POP_K_POPG_OH="50d-12"
	    POP_K_POPG_O3A="0d0"
	    POP_K_POPG_O3B="2.8d15"
	    POP_HSTAR="3.10d-5"
	    POP_DEL_H="-110d3"
	    POP_DEL_Hw="43d0"
	elif [[ ${pops_num} = "2" ]]; then
	    POP_SPC="PHE"
	    POP_XMW="178.23d-3"
	    POP_KOA="4.37d7"
	    POP_KBC="1.0d10"
	    POP_K_POPG_OH="2.7d-11"
	    POP_K_POPG_O3A="0d0"
	    POP_K_POPG_O3B="2.15d15"
	    POP_HSTAR="1.74d-3"
	    POP_DEL_H="-74d3"
	    POP_DEL_Hw="47d0"
	elif [[ ${pops_num} = "3" ]]; then
	    POP_SPC="PYR"
	    POP_XMW="202.25d-3"
	    POP_KOA="7.24d8"
	    POP_KBC="1.0d11"
	    POP_K_POPG_OH="50d-12"
	    POP_K_POPG_O3A="0d0"
	    POP_K_POPG_O3B="3.0d15"
	    POP_HSTAR="5.37d-4"
	    POP_DEL_H="-87d3"
	    POP_DEL_Hw="43d0"
	else
	    valid_pops=0
	    printf "Invalid POPs type. Try again.\n"
	fi
	sim_name="${sim_name}_${pops_spc}"
    done

fi

#-----------------------------------------------------------------
# Ask user to select meteorology source
#-----------------------------------------------------------------
printf "${thinline}Choose meteorology source:${thinline}"
printf "  1. MERRA2 (Recommended)\n"
printf "  2. GEOS-FP \n"
valid_met=0
while [ "${valid_met}" -eq 0 ]; do
    read met_num
    valid_met=1
    if [[ ${met_num} = "1" ]]; then
	met_name='MERRA2'
	met_dir='MERRA2'
	met_resolution='05x0625'
	met_native='0.5x0.625'
	met_latres='05'
	met_lonres='0625'
	met_extension='nc4'
	met_cn_year='2015'
	pressure_unit='Pa '
	pressure_scale='0.01'
	dust_sf='3.86e-4'
    elif [[ ${met_num} = "2" ]]; then
	met_name='GEOSFP'
	met_dir='GEOS_FP'
	met_resolution='025x03125'
	met_native='0.25x0.3125'
	met_latres='025'
	met_lonres='03125'
	met_extension='nc'
	met_cn_year='2011'
	pressure_unit='hPa'
	pressure_scale='1.0 '
	dust_sf='6.42e-5'
    else
	valid_met=0
	printf "Invalid meteorology option. Try again.\n"
    fi
done

#-----------------------------------------------------------------
# Ask user to select horizontal resolution
#-----------------------------------------------------------------
printf "${thinline}Choose horizontal resolution:${thinline}"
printf "  1. 4.0  x 5.0\n"
printf "  2. 2.0  x 2.5\n"
printf "  3. 0.5  x 0.625\n"
if [[ ${met_name} = "GEOSFP" ]]; then
    printf "  4. 0.25 x 0.3125\n"
fi

valid_res=0
while [ "${valid_res}" -eq 0 ]; do
    read res_num
    valid_res=1
    if [[ ${res_num} = "1" ]]; then
	grid_res='4x5'
	grid_res_long='4.0x5.0'
	grid_dir=$grid_res
    elif [[ ${res_num} = "2" ]]; then
	grid_res='2x25'
	grid_res_long='2.0x2.5'
	grid_dir='2x2.5'
    elif [[ ${res_num} = "3" ]]; then
	grid_res='05x0625'
	grid_res_long='0.5x0.625'
	grid_dir=$grid_res_long
    elif [[ ${res_num} = "4" ]]; then
	grid_res='025x03125'
	grid_res_long='0.25x0.3125'
	grid_dir=$grid_res_long
    else
	valid_res=0
	printf "Invalid horizontal resolution option. Try again.\n"
    fi
done

if [[ ${grid_res} = "05x0625" ]] || [[ ${grid_res} = "025x03125" ]]; then
    printf "${thinline}Choose horizontal grid domain:${thinline}"
    printf "  1. Global\n"
    printf "  2. Asia\n"
    printf "  3. Europe\n"
    printf "  4. North America\n"
    printf "  5. Custom\n"

    valid_domain=0
    while [ "${valid_domain}" -eq 0 ]; do
	read domain_num
	valid_domain=1
	if [[ ${domain_num} = "1" ]]; then
	    domain_name="global"
	    lon_range="-180.0 180.0"
	    lat_range=" -90.0  90.0"
	    half_polar="T"
	    nested_sim="F"
	    buffer_zone="0  0  0  0"
	else
	    domain_name="AS"
	    half_polar="F"
	    nested_sim="T"
	    buffer_zone="3  3  3  3"
	    if [[ ${domain_num} = "2" ]]; then
	        if [[ ${grid_res} = "05x0625" ]]; then 
	            lon_range=" 60.0 150.0"
		    lat_range="-11.0  55.0"
		elif [[ ${grid_res} = "025x03125" ]]; then 
	            lon_range=" 70.0 140.0"
		    lat_range=" 15.0  55.0"
		fi
	    elif [[ ${domain_num} = "3" ]]; then
		domain_name="EU"
	        if [[ ${grid_res} = "05x0625" ]]; then 
	            lon_range="-30.0 50.0"
		    lat_range=" 30.0 70.0"
		elif [[ ${grid_res} = "025x03125" ]]; then 
	            lon_range="-15.0  40.0"
		    lat_range=" 32.75 61.25"
		fi
	    elif [[ ${domain_num} = "4" ]]; then
		domain_name="NA"
	        if [[ ${grid_res} = "05x0625" ]]; then 
	            lon_range="-140.0 -40.0"
		    lat_range="  10.0  70.0"
		elif [[ ${grid_res} = "025x03125" ]]; then 
	            lon_range="-130.0  -60.0"
		    lat_range="   9.75  60.0"
		fi
	    elif [[ ${domain_num} = "5" ]]; then
		domain_name="custom"
	        lon_range="MinLon MaxLon"
	        lat_range="MinLat MaxLat"
	        printf "\n  -- You will need to manually set longitude and latitude"
		printf "\n     bounds in the Grid Menu of input.geos.\n"
	    else
  		valid_domain=0
		printf "Invalid horizontal grid domain option. Try again.\n"
	    fi
        fi
    done
else
    lon_range="-180.0 180.0"
    lat_range=" -90.0  90.0"
    half_polar="T"
    nested_sim="F"
    buffer_zone="0  0  0  0"
fi

#-----------------------------------------------------------------
# Ask user to select vertical resolution
#-----------------------------------------------------------------
printf "${thinline}Choose number of levels:${thinline}"
printf "  1. 72 (native)\n"
printf "  2. 47 (reduced)\n"

valid_lev=0
while [ "${valid_lev}" -eq 0 ]; do
    read lev_num
    valid_lev=1
    if [[ ${lev_num} = "1" ]]; then
	grid_lev='72'
    elif [[ ${lev_num} = "2" ]]; then
	grid_lev='47'
    else
	valid_lev=0
	printf "Invalid vertical resolution option. Try again.\n"
    fi
done

#-----------------------------------------------------------------
# Ask user to define path where directoy will be created
#-----------------------------------------------------------------
printf "${thinline}Enter path where the run directory will be created:${thinline}"
valid_path=0
while [ "$valid_path" -eq 0 ]; do
    read rundir_path
    if [[ ${rundir_path} = "q" ]]; then
	printf "\nExiting.\n"
	exit 1
    elif [[ ! -d ${rundir_path} ]]; then
        printf "\nERROR: ${rundir_path} does not exist. Enter a new path or hit q to quit.\n"
    else
	valid_path=1
    fi
done

#-----------------------------------------------------------------
# Ask user to define run directoy name if not passed as argument
#-----------------------------------------------------------------
if [ -z "$1" ]; then
    printf "${thinline}Enter run directory name, or press return to use default:${thinline}"
    read rundir_name
    if [[ -z "${rundir_name}" ]]; then
	if [[ "${sim_extra_option}" == "none" ]]; then
	    rundir_name=gc_${grid_res}_${sim_name}
	else
	    rundir_name=gc_${grid_res}_${sim_name}_${sim_extra_option}
	fi
	printf "  -- Using default directory name ${rundir_name}\n"
    fi
else
    rundir_name=$1
fi

#-----------------------------------------------------------------
# Ask user for a new run directory name if specified one exists
#-----------------------------------------------------------------
rundir=${rundir_path}/${rundir_name}
valid_rundir=0
while [ "${valid_rundir}" -eq 0 ]; do
    if [[ -d ${rundir} ]]; then
	printf "\nWARNING: ${rundir} already exists.\n"
        printf "Enter a different run directory name, or q to quit:\n"
	read new_rundir
	if [[ ${new_rundir} = "q" ]]; then
	    printf "Exiting.\n"
	    exit 1
	else
	    rundir=${rundir_path}/${new_rundir}
	fi
    else
        valid_rundir=1
    fi
done

#-----------------------------------------------------------------
# Create run directory
#-----------------------------------------------------------------
mkdir -p ${rundir}

# Copy run directory files and subdirectories
cp ${gcdir}/run/shared/setupConfigFiles.sh  ${rundir}
cp ${gcdir}/run/shared/cleanRunDir.sh       ${rundir}
cp ${gcdir}/run/shared/download_data.py     ${rundir}
cp ./getRunInfo                             ${rundir}
cp ./archiveRun.sh                          ${rundir}
cp ./README                                 ${rundir}
cp ./gitignore                              ${rundir}/.gitignore
cp ./input.geos.templates/input.geos.${sim_name}            ${rundir}/input.geos
cp ./HISTORY.rc.templates/HISTORY.rc.${sim_name}            ${rundir}/HISTORY.rc
cp ./HEMCO_Config.rc.templates/HEMCO_Config.rc.${sim_name}  ${rundir}/HEMCO_Config.rc
cp ./HEMCO_Diagn.rc.templates/HEMCO_Diagn.rc.${sim_name}    ${rundir}/HEMCO_Diagn.rc
if [[ ${sim_name} = "fullchem" ]]; then
    cp -r ${gcdir}/run/shared/metrics_fullchem.py  ${rundir}
    chmod 744 ${rundir}/metrics_fullchem.py
fi
cp -r ./runScriptSamples ${rundir}
mkdir ${rundir}/OutputDir

# Set permissions
chmod 744 ${rundir}/cleanRunDir.sh
chmod 744 ${rundir}/archiveRun.sh
chmod 744 ${rundir}/runScriptSamples/*

# Copy species database; append APM or TOMAS species if needed
cp -r ${gcdir}/run/shared/species_database.yml   ${rundir}
if [[ ${sim_extra_option} =~ "TOMAS" ]]; then
    cat ${gcdir}/run/shared/species_database_tomas.yml >> ${rundir}/species_database.yml
elif [[ ${sim_extra_option} =~ "APM" ]]; then
    cat ${gcdir}/run/shared/species_database_apm.yml >> ${rundir}/species_database.yml
fi

# If benchmark simulation, put run script in directory
if [ ${sim_extra_option} = "benchmark" ]; then
    cp ./runScriptSamples/geoschem.benchmark.run ${rundir}
    chmod 744 ${rundir}/geoschem.benchmark.run
fi

# Create symbolic link to code directory
ln -s ${wrapperdir} ${rundir}/CodeDir

# Create build directory
mkdir ${rundir}/build
printf "To build GEOS-Chem type:\n   cmake ../CodeDir\n   make -j\n   make install\n" >> ${rundir}/build/README

#--------------------------------------------------------------------
# Navigate to run directory and set up input files
#--------------------------------------------------------------------
cd ${rundir}

# Replace token strings in certain files
sed -i -e "s|{DATA_ROOT}|${GC_DATA_ROOT}|"   input.geos
sed -i -e "s|{MET}|${met_name}|"             input.geos
sed -i -e "s|{SIM}|${sim_name}|"             input.geos
sed -i -e "s|{RES}|${grid_res_long}|"        input.geos
sed -i -e "s|{NLEV}|${grid_lev}|"            input.geos
sed -i -e "s|{LON_RANGE}|${lon_range}|"      input.geos
sed -i -e "s|{LAT_RANGE}|${lat_range}|"      input.geos
sed -i -e "s|{HALF_POLAR}|${half_polar}|"    input.geos
sed -i -e "s|{NESTED_SIM}|${nested_sim}|"    input.geos
sed -i -e "s|{BUFFER_ZONE}|${buffer_zone}|"  input.geos
sed -i -e "s|{DATA_ROOT}|${GC_DATA_ROOT}|"   HEMCO_Config.rc
sed -i -e "s|{GRID_DIR}|${grid_dir}|"        HEMCO_Config.rc
sed -i -e "s|{MET_DIR}|${met_dir}|"          HEMCO_Config.rc
sed -i -e "s|{NATIVE_RES}|${met_native}|"    HEMCO_Config.rc
sed -i -e "s|{LATRES}|${met_latres}|"        HEMCO_Config.rc
sed -i -e "s|{LONRES}|${met_lonres}|"        HEMCO_Config.rc
sed -i -e "s|{DUST_SF}|${dust_sf}|"          HEMCO_Config.rc

# Special handling for start/end date based on simulation so that
# start year/month/day matches default initial restart file.
if [[ ${sim_name} = "fullchem" ]]; then
    startdate="20190701"
    enddate="20190801"
else
    startdate="20190101"
    enddate="20190201"
fi
starttime="000000"
endtime="000000"
sed -i -e "s|{DATE1}|${startdate}|"  input.geos
sed -i -e "s|{DATE2}|${enddate}|"    input.geos
sed -i -e "s|{TIME1}|${starttime}|"  input.geos
sed -i -e "s|{TIME2}|${endtime}|"    input.geos

printf "\n  -- This run directory has been set up for $startdate - $enddate."
printf "\n     You may modify these settings in input.geos.\n"

sed -i -e "s|{FREQUENCY}|00000100 000000|"  HISTORY.rc
sed -i -e "s|{DURATION}|00000100 000000|"   HISTORY.rc

printf "\n  -- The default frequency and duration of diagnostics is set to monthly."
printf "\n     You may modify these settings in HISTORY.rc and HEMCO_Config.rc.\n"

# Call script to setup configuration files
if [[ ${sim_name} = "fullchem" ]]; then
    ./setupConfigFiles.sh ${sim_extra_option}
    rm setupConfigFiles.sh
fi

# Modify input files for troposphere-only chemistry grids
if [[ ${chemgrid} = "trop_only" ]]; then
    replace_colon_sep_val "=> Set init. strat. H2O"  F input.geos
    replace_colon_sep_val "Settle strat. aerosols"   F input.geos
    replace_colon_sep_val "Online PSC AEROSOLS"      F input.geos
    replace_colon_sep_val "Perform PSC het. chem.?"  F input.geos
    replace_colon_sep_val "Calc. strat. aero. OD?"   F input.geos
    replace_colon_sep_val "Use UCX strat. chem?"     F input.geos
    replace_colon_sep_val "Active strat. H2O?"       F input.geos
    replace_colon_sep_val "--> STATE_PSC"        false HEMCO_Config.rc
    replace_colon_sep_val "--> GMI_PROD_LOSS"    false HEMCO_Config.rc
    replace_colon_sep_val "--> UCX_PROD_LOSS"     true HEMCO_Config.rc
    sed -i -e "s|'Chem_StatePSC|#'Chem_StatePSC|"      HISTORY.rc
fi

# Modify input files for nested-grid simulations
if [[ ${nested_sim} = "T" ]]; then
    replace_colon_sep_val "--> GC_BCs" true HEMCO_Config.rc
    if [[ ${domain_name} = "NA" ]]; then
	replace_colon_sep_val "--> NEI2011_MONMEAN" false HEMCO_Config.rc
	replace_colon_sep_val "--> NEI2011_HOURLY"  true  HEMCO_Config.rc
    fi
fi

# Modify input files for POPs simulations
if [[ ${sim_name} =~ "POPs" ]]; then
    sed -i -e "s|{POPs_SPC}|${POP_SPC}|"               input.geos
    sed -i -e "s|{POPs_XMW}|${POP_XMW}|"               input.geos
    sed -i -e "s|{POPs_KOA}|${POP_KOA}|"               input.geos
    sed -i -e "s|{POPs_KBC}|${POP_KBC}|"               input.geos
    sed -i -e "s|{POPs_K_POPG_OH}|${POP_K_POPG_OH}|"   input.geos
    sed -i -e "s|{POPs_K_POPG_O3A}|${POP_K_POPG_O3A}|" input.geos
    sed -i -e "s|{POPs_K_POPG_O3B}|${POP_K_POPG_O3B}|" input.geos
    sed -i -e "s|{POPs_HSTAR}|${POP_HSTAR}|"           input.geos
    sed -i -e "s|{POPs_DEL_H}|${POP_DEL_H}|"           input.geos
    sed -i -e "s|{POPs_DEL_Hw}|${POP_DEL_Hw}|"         input.geos
    sed -i -e "s|{POPs_SPC}|${POP_SPC}|"               HEMCO_Config.rc
    sed -i -e "s|{POPs_SPC}|${POP_SPC}|"               HEMCO_Diagn.rc
fi

#--------------------------------------------------------------------
# Copy sample restart file to run directory
#--------------------------------------------------------------------
if [[ ${sim_name} = "fullchem" ]]; then
    # Use restart file saved out from latest 1-year benchmark
    sample_rst=${GC_DATA_ROOT}/GEOSCHEM_RESTARTS/GC_12.9.0/GEOSChem.Restart.fullchem.20160701_0000z.nc4
elif [[ ${sim_name} = "TransportTracers" ]]; then
    # Use restart file saved out from latest 1-year benchmark
    sample_rst=${GC_DATA_ROOT}/GEOSCHEM_RESTARTS/GC_12.8.0/GEOSChem.Restart.TransportTracers.20170101_0000z.nc4
else
    sample_rst=${GC_DATA_ROOT}/GEOSCHEM_RESTARTS/v2018-11/initial_GEOSChem_rst.${grid_res}_${sim_name}.nc
fi
if [[ -f ${sample_rst} ]]; then
    cp ${sample_rst} ${rundir}/GEOSChem.Restart.${startdate}_0000z.nc4
else
    printf "\n  -- No sample restart provided for this simulation."
    printf "\n     You will need to provide an initial restart file or disable"
    printf "\n     GC_RESTARTS in HEMCO_Config.rc to initialize your simulation"
    printf "\n     with default background species concentrations.\n"
fi

#--------------------------------------------------------------------
# Navigate back to source code directory
#--------------------------------------------------------------------
cd ${srcrundir}

#----------------------------------------------------------------------
# Archive repository version in run directory file rundir.version
#----------------------------------------------------------------------
version_log=${rundir}/rundir.version
echo "This run directory was created with ${srcrundir}/createRunDir.sh." > ${version_log}
echo " " >> ${version_log}
echo "GEOS-Chem repository version information:" >> ${version_log}
cd ${gcdir}
remote_url=$(git config --get remote.origin.url)
code_branch=$(git rev-parse --abbrev-ref HEAD)
last_commit=$(git log -n 1 --pretty=format:"%s")
commit_date=$(git log -n 1 --pretty=format:"%cd")
commit_user=$(git log -n 1 --pretty=format:"%cn")
commit_hash=$(git log -n 1 --pretty=format:"%h")
cd ${srcrundir}
printf "\n  Remote URL: ${remote_url}" >> ${version_log}
printf "\n  Branch: ${code_branch}"    >> ${version_log}
printf "\n  Commit: ${last_commit}"    >> ${version_log}
printf "\n  Date: ${commit_date}"      >> ${version_log}
printf "\n  User: ${commit_user}"      >> ${version_log}
printf "\n  Hash: ${commit_hash}"      >> ${version_log}

#-----------------------------------------------------------------
# Ask user whether to track run directory changes with git
#-----------------------------------------------------------------
printf "${thinline}Do you want to track run directory changes with git? (y/n)${thinline}"
valid_response=0
while [ "$valid_response" -eq 0 ]; do
    read enable_git
    if [[ ${enable_git} = "y" ]]; then
	cd ${rundir}
	printf "\n\nChanges to the following run directory files are tracked by git:\n\n" >> ${version_log}
	printf "\n"
	git init
	git add *.rc *.sh *.yml *.run *.py input.geos getRunInfo
	git add runScriptSamples/* README .gitignore
	printf " " >> ${version_log}
	git commit -m "Initial run directory" >> ${version_log}
	cd ${srcrundir}
	valid_response=1
    elif [[ ${enable_git} = "n" ]]; then
	valid_response=1
    else
	printf "Input not recognized. Try again.\n"
    fi
done

#-----------------------------------------------------------------
# Done!
#-----------------------------------------------------------------
printf "\nCreated ${rundir}\n"

exit 0
