Parameter par_vehicles(z) "number of vehicles per zone" /
$include %datafolderpath%/ev_data/vehicles_zones.tsv
/;

Parameter par_ev_charging(h) "demand for EV charging per vehicle" /
$include %datafolderpath%/ev_data/demand_ev_charging_MWh.tsv
/;

par_ev_charging(h) = par_ev_charging(h)/MWtoGW;


$ifThen "%EV_flex%" == ON

Scalar flexible_fraction "fraction of vehicle which are flexible" /0.5/;

Scalars
$include %datafolderpath%/ev_data/ev_scalars.tsv
;

s_store_cap = s_store_cap/MWtoGW;
s_discharge_cap = s_discharge_cap/MWtoGW;
s_charge_cap = s_charge_cap/MWtoGW;

Parameter par_driving_demand(h,z) "electricity used while driving per car [MWh]" /
$include %datafolderpath%/ev_data/demand_driving_MWh.tsv
/;

par_driving_demand(h,z) = par_driving_demand(h,z)/MWtoGW;

Parameter par_connected_vehicles(h) "fraction of cars connected to the grid"  /
$include %datafolderpath%/ev_data\connected_vehicles.tsv
/;

Positive Variables
    var_ev_energy_stored(h,z) "energy stored in electric vehicle batteries"
    var_ev_discharge(h,z) "energy discharged from electric vehicle batteries"
    var_ev_charge(h,z) "energy charged to electric vehicle batteries"
    var_ev_total_demand
;

Equations
    eq_energy_stored
    eq_total_stored_energy_limit
    eq_discharge_limit
    eq_charge_limit
    eq_ev_total_demand
;

eq_energy_stored(h,z).. var_ev_energy_stored(h,z) =E= var_ev_energy_stored(h-1,z) + var_ev_charge(h,z)*s_charge_discharge_eff - var_ev_discharge(h,z)/s_charge_discharge_eff - par_vehicles(z)*flexible_fraction*par_driving_demand(h,z);

eq_total_stored_energy_limit(h,z).. var_ev_energy_stored(h,z) =L= s_store_cap*par_vehicles(z)*flexible_fraction;

eq_discharge_limit(h,z)..  var_ev_discharge(h,z) =L= par_vehicles(z)*flexible_fraction*s_discharge_cap*par_connected_vehicles(h);

eq_charge_limit(h,z)..  var_ev_charge(h,z) =L= par_vehicles(z)*flexible_fraction*s_charge_cap*par_connected_vehicles(h);

eq_ev_total_demand.. var_ev_total_demand =E= sum((h,z), var_ev_charge(h,z) - var_ev_discharge(h,z)/(s_charge_discharge_eff**2) + ((par_ev_charging(h)*par_vehicles(z)*(1-flexible_fraction))/s_charge_discharge_eff));

$else

Scalar s_charge_discharge_eff /0.95/;

Positive Variables
    var_ev_total_demand
;

Equations
    eq_ev_total_demand
;

eq_ev_total_demand.. var_ev_total_demand =E= sum((h,z), (par_ev_charging(h)*par_vehicles(z))/s_charge_discharge_eff);

$endIf