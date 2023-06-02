/*
				THANKYOU FOR ALL
				- OpenMP
				- Github
				- SAMP Community
				- AND Others Website

				- CREATOR OF GAMEMODE

			- Scripter -
		  Kazuji Takahashi

			- Mapping -
	  Others Website & Community


	  											DATE MADE GAMEMODE
	  											- 06/01/2022

	  											Finished GM
	  											- 08/12/2022

			GAMEMODE BASIC = Dini 
			THANKYOU FOR ALL AUTHOR GAMEMODE
*/
//==============================================================================
//INCLUDES
#include <a_samp>
#include <a_http>

// INC OTHER
#include <fixes>
#include <zcmd>
#include <sscanf2>
#include <dini>
#include <easyDialog>
#include <yom_buttons>
#include <time>
#include <geo_ip>
#include <attachments>
#include <streamer>
//==============================================================================
//COLOUR DEFINES
#define RED      		0xFF0000FF
#define LRED            0xFF6347FF
#define BLUE            0x3366FFFF
#define SAMP 			0xA9C4E4FF
#define GREY     		0xB9C9BFFF
#define LBLUE			0x00FFFFFF
#define GREEN	     	0x80C837FF
#define LGREEN          0xADFF2FFF
#define ORANGE  		0xFF8000FF
#define YELLOW  		0xFFFF00FF
//==============================================================================
//OTHER DEFINES
#define REGISTER 				1
#define LOGIN 					2
#define MISCEL                  3
#define JOBS 					10
#define BANK    				11
#define WITHDRAW    			12
#define DEPOSIT     			13
#define Bar     				14
#define PASSPORT     			15
#define	AIRPORT					16
#define	PROFIT                  17
#define CITY                    18
#define ORGCP     				19
#define ORGREQUEST     			20
#define CARDEAL     			21
#define SHOP    				22
#define	FIGHT 					24
#define MUSIC                   25
#define	ATM                     26
#define	CAR                     27
#define	FREE					28
#define	DEAL					29
#define QUESTION1 				30
#define QUESTION2 				31
#define QUESTION3 				32
#define QUESTION4 				33
#define QUESTION5               34
#define QUESTION6               35
#define QUESTION7 				36
#define QUESTION8               37
#define FIRSTDIALOG             38
#define TUT1                    40
#define TUT2                    41
#define TUT3                    42
#define TUT4                    43
#define TUT5                    44
#define TUT6                    45
#define TUT7                    46
#define TUT8                    47
#define TUT9                    48
#define TUT10                   49
#define TUT11                   50
#define TUT12                   51
#define TUT13                   52
#define TUT	                    53
#define INSU                    54
#define NUM                     55
#define CARCOLOR                56
#define UPGRADES                57
#define	OFIGHT                  58
#define	SVPASS                  59
#define	ORGMEMBERS              60
#define TEXT		            72
#define WAGE		            73
#define AWARDS		            74
#define AWARDS1		            75
#define LAW                    	76
#define GANG                    77
#define MAFIA                   78
#define OTHER                   79
#define MAX_ATMS 				99
#define MAX_ORGS                11
#define MAX_ORG_VEHICLES 		10
#define MAX_Zone_PER_ORG 		10
#define MAX_ZONE_NAME       	40
//==============================================================================
enum Awards
{
    Cop,
    Bill,
	Buss,
	Jail,
	Admin,
 	House,
    Guide,
	Vomit,
	Abooze,
	Addict,
    Jailer,
    Plates,
	Kainat,
	Shutup,
	School,
	Suicide,
	AirPlane,
    Gangster,
};
enum AInfo
{
    aObject,
	aCreated,
    Float:aX,
    Float:aY,
    Float:aZ,
    Float:arZ,
};
enum Bus
{
	bCost,
	bProfit,
	Float:bX,
	Float:bY,
	Float:bZ,
	bInterior,
	bName[32],
	bOwner[24],
	bProtected,
	bCheckpoint
};
enum Prop
{
	pCost,
	pPickup,
	pMapicon,
	Float:prX,
	Float:prY,
	Float:prZ,
	pOwner[24],
	Text3D:pLabel,
};
enum Orgs
{
	CP,
	Lsk,
	Wage,
	Type,
	OSkin,
	Skin1,
	Color,
	Drugs,
	FStyle,
	Members,
	Ammo[2],
	Name[40],
	Interior,
	Turf[28],
	Money[10],
	Float:OrgX,
	Float:OrgY,
	Float:OrgZ,
	Leader[24],
	Protection,
	Member1[24],
	Member2[24],
	Member3[24],
	Member4[24],
	Member5[24],
	Member6[24],
	Member7[24],
	OWeapons[2],
	ZoneCreated,
	VehiclesCreated,
	OrgZones[MAX_Zone_PER_ORG],
	Vehicles[MAX_ORG_VEHICLES],
	OrgZones2[MAX_Zone_PER_ORG],
	ZoneColor[MAX_Zone_PER_ORG],
	Float:ZoneMinX[MAX_Zone_PER_ORG],
	Float:ZoneMinY[MAX_Zone_PER_ORG],
	Float:ZoneMaxX[MAX_Zone_PER_ORG],
	Float:ZoneMaxY[MAX_Zone_PER_ORG],
};
enum license
{
	CP,
	StepB,
	StepD,
	StepF,
	Vehicle,
}
new randVec[] =
{400,401,402,404,405,410,411,412,413,414,415,418,421,422,426,436,439,440,445,
451,456,458,461,462,466,467,475,479,480,481,482,483,492,496,498,500,507,516,526,
527,529,534,536,540,542,546,547,550,551,554,558,559,560,566,567,585,587,589,603};
enum SAZONE_MAIN
{
	SAZONE_NAME[28],
	Float:SAZONE_AREA[6]
};
static const gSAZones[][SAZONE_MAIN] =
{
	{"The Big Ear",	                {-410.00,1403.30,-3.00,-137.90,1681.20,200.00}},
	{"Aldea Malvada",            {-1372.10,2498.50,0.00,-1277.50,2615.30,200.00}},
	{"Angel Pine",               {-2324.90,-2584.20,-6.10,-1964.20,-2212.10,200.00}},
	{"Arco del Oeste",           {-901.10,2221.80,0.00,-592.00,2571.90,200.00}},
	{"Avispa Country Club",      {-2646.40,-355.40,0.00,-2270.00,-222.50,200.00}},
	{"Avispa Country Club",      {-2831.80,-430.20,-6.10,-2646.40,-222.50,200.00}},
	{"Avispa Country Club",      {-2361.50,-417.10,0.00,-2270.00,-355.40,200.00}},
	{"Avispa Country Club",      {-2667.80,-302.10,-28.80,-2646.40,-262.30,71.10}},
	{"Avispa Country Club",      {-2470.00,-355.40,0.00,-2270.00,-318.40,46.10}},
	{"Avispa Country Club",      {-2550.00,-355.40,0.00,-2470.00,-318.40,39.70}},
	{"Back o Beyond",            {-1166.90,-2641.10,0.00,-321.70,-1856.00,200.00}},
	{"Battery Point",            {-2741.00,1268.40,-4.50,-2533.00,1490.40,200.00}},
	{"Bayside",                  {-2741.00,2175.10,0.00,-2353.10,2722.70,200.00}},
	{"Bayside Marina",           {-2353.10,2275.70,0.00,-2153.10,2475.70,200.00}},
	{"Beacon Hill",              {-399.60,-1075.50,-1.40,-319.00,-977.50,198.50}},
	{"Blackfield",               {964.30,1203.20,-89.00,1197.30,1403.20,110.90}},
	{"Blackfield",               {964.30,1403.20,-89.00,1197.30,1726.20,110.90}},
	{"Blackfield Chapel",        {1375.60,596.30,-89.00,1558.00,823.20,110.90}},
	{"Blackfield Chapel",        {1325.60,596.30,-89.00,1375.60,795.00,110.90}},
	{"Blackfield Intersection",  {1197.30,1044.60,-89.00,1277.00,1163.30,110.90}},
	{"Blackfield Intersection",  {1166.50,795.00,-89.00,1375.60,1044.60,110.90}},
	{"Blackfield Intersection",  {1277.00,1044.60,-89.00,1315.30,1087.60,110.90}},
	{"Blackfield Intersection",  {1375.60,823.20,-89.00,1457.30,919.40,110.90}},
	{"Blueberry",                {104.50,-220.10,2.30,349.60,152.20,200.00}},
	{"Blueberry",                {19.60,-404.10,3.80,349.60,-220.10,200.00}},
	{"Blueberry Acres",          {-319.60,-220.10,0.00,104.50,293.30,200.00}},
	{"Caligula's Palace",        {2087.30,1543.20,-89.00,2437.30,1703.20,110.90}},
	{"Caligula's Palace",        {2137.40,1703.20,-89.00,2437.30,1783.20,110.90}},
	{"Calton Heights",           {-2274.10,744.10,-6.10,-1982.30,1358.90,200.00}},
	{"Chinatown",                {-2274.10,578.30,-7.60,-2078.60,744.10,200.00}},
	{"City Hall",                {-2867.80,277.40,-9.10,-2593.40,458.40,200.00}},
	{"Come-A-Lot",               {2087.30,943.20,-89.00,2623.10,1203.20,110.90}},
	{"Commerce",                 {1323.90,-1842.20,-89.00,1701.90,-1722.20,110.90}},
	{"Commerce",                 {1323.90,-1722.20,-89.00,1440.90,-1577.50,110.90}},
	{"Commerce",                 {1370.80,-1577.50,-89.00,1463.90,-1384.90,110.90}},
	{"Commerce",                 {1463.90,-1577.50,-89.00,1667.90,-1430.80,110.90}},
	{"Commerce",                 {1583.50,-1722.20,-89.00,1758.90,-1577.50,110.90}},
	{"Commerce",                 {1667.90,-1577.50,-89.00,1812.60,-1430.80,110.90}},
	{"Conference Center",        {1046.10,-1804.20,-89.00,1323.90,-1722.20,110.90}},
	{"Conference Center",        {1073.20,-1842.20,-89.00,1323.90,-1804.20,110.90}},
	{"Cranberry Station",        {-2007.80,56.30,0.00,-1922.00,224.70,100.00}},
	{"Creek",                    {2749.90,1937.20,-89.00,2921.60,2669.70,110.90}},
	{"Dillimore",                {580.70,-674.80,-9.50,861.00,-404.70,200.00}},
	{"Doherty",                  {-2270.00,-324.10,-0.00,-1794.90,-222.50,200.00}},
	{"Doherty",                  {-2173.00,-222.50,-0.00,-1794.90,265.20,200.00}},
	{"Downtown",                 {-1982.30,744.10,-6.10,-1871.70,1274.20,200.00}},
	{"Downtown",                 {-1871.70,1176.40,-4.50,-1620.30,1274.20,200.00}},
	{"Downtown",                 {-1700.00,744.20,-6.10,-1580.00,1176.50,200.00}},
	{"Downtown",                 {-1580.00,744.20,-6.10,-1499.80,1025.90,200.00}},
	{"Downtown",                 {-2078.60,578.30,-7.60,-1499.80,744.20,200.00}},
	{"Downtown",                 {-1993.20,265.20,-9.10,-1794.90,578.30,200.00}},
	{"Downtown Los Santos",      {1463.90,-1430.80,-89.00,1724.70,-1290.80,110.90}},
	{"Downtown Los Santos",      {1724.70,-1430.80,-89.00,1812.60,-1250.90,110.90}},
	{"Downtown Los Santos",      {1463.90,-1290.80,-89.00,1724.70,-1150.80,110.90}},
	{"Downtown Los Santos",      {1370.80,-1384.90,-89.00,1463.90,-1170.80,110.90}},
	{"Downtown Los Santos",      {1724.70,-1250.90,-89.00,1812.60,-1150.80,110.90}},
	{"Downtown Los Santos",      {1370.80,-1170.80,-89.00,1463.90,-1130.80,110.90}},
	{"Downtown Los Santos",      {1378.30,-1130.80,-89.00,1463.90,-1026.30,110.90}},
	{"Downtown Los Santos",      {1391.00,-1026.30,-89.00,1463.90,-926.90,110.90}},
	{"Downtown Los Santos",      {1507.50,-1385.20,110.90,1582.50,-1325.30,335.90}},
	{"East Beach",               {2632.80,-1852.80,-89.00,2959.30,-1668.10,110.90}},
	{"East Beach",               {2632.80,-1668.10,-89.00,2747.70,-1393.40,110.90}},
	{"East Beach",               {2747.70,-1668.10,-89.00,2959.30,-1498.60,110.90}},
	{"East Beach",               {2747.70,-1498.60,-89.00,2959.30,-1120.00,110.90}},
	{"East Los Santos",          {2421.00,-1628.50,-89.00,2632.80,-1454.30,110.90}},
	{"East Los Santos",          {2222.50,-1628.50,-89.00,2421.00,-1494.00,110.90}},
	{"East Los Santos",          {2266.20,-1494.00,-89.00,2381.60,-1372.00,110.90}},
	{"East Los Santos",          {2381.60,-1494.00,-89.00,2421.00,-1454.30,110.90}},
	{"East Los Santos",          {2281.40,-1372.00,-89.00,2381.60,-1135.00,110.90}},
	{"East Los Santos",          {2381.60,-1454.30,-89.00,2462.10,-1135.00,110.90}},
	{"East Los Santos",          {2462.10,-1454.30,-89.00,2581.70,-1135.00,110.90}},
	{"Easter Basin",             {-1794.90,249.90,-9.10,-1242.90,578.30,200.00}},
	{"Easter Basin",             {-1794.90,-50.00,-0.00,-1499.80,249.90,200.00}},
	{"Easter Bay Airport",       {-1499.80,-50.00,-0.00,-1242.90,249.90,200.00}},
	{"Easter Bay Airport",       {-1794.90,-730.10,-3.00,-1213.90,-50.00,200.00}},
	{"Easter Bay Airport",       {-1213.90,-730.10,0.00,-1132.80,-50.00,200.00}},
	{"Easter Bay Airport",       {-1242.90,-50.00,0.00,-1213.90,578.30,200.00}},
	{"Easter Bay Airport",       {-1213.90,-50.00,-4.50,-947.90,578.30,200.00}},
	{"Easter Bay Airport",       {-1315.40,-405.30,15.40,-1264.40,-209.50,25.40}},
	{"Easter Bay Airport",       {-1354.30,-287.30,15.40,-1315.40,-209.50,25.40}},
	{"Easter Bay Airport",       {-1490.30,-209.50,15.40,-1264.40,-148.30,25.40}},
	{"Easter Bay Chemicals",     {-1132.80,-768.00,0.00,-956.40,-578.10,200.00}},
	{"Easter Bay Chemicals",     {-1132.80,-787.30,0.00,-956.40,-768.00,200.00}},
	{"El Castillo del Diablo",   {-464.50,2217.60,0.00,-208.50,2580.30,200.00}},
	{"El Castillo del Diablo",   {-208.50,2123.00,-7.60,114.00,2337.10,200.00}},
	{"El Castillo del Diablo",   {-208.50,2337.10,0.00,8.40,2487.10,200.00}},
	{"El Corona",                {1812.60,-2179.20,-89.00,1970.60,-1852.80,110.90}},
	{"El Corona",                {1692.60,-2179.20,-89.00,1812.60,-1842.20,110.90}},
	{"El Quebrados",             {-1645.20,2498.50,0.00,-1372.10,2777.80,200.00}},
	{"Esplanade East",           {-1620.30,1176.50,-4.50,-1580.00,1274.20,200.00}},
	{"Esplanade East",           {-1580.00,1025.90,-6.10,-1499.80,1274.20,200.00}},
	{"Esplanade East",           {-1499.80,578.30,-79.60,-1339.80,1274.20,20.30}},
	{"Esplanade North",          {-2533.00,1358.90,-4.50,-1996.60,1501.20,200.00}},
	{"Esplanade North",          {-1996.60,1358.90,-4.50,-1524.20,1592.50,200.00}},
	{"Esplanade North",          {-1982.30,1274.20,-4.50,-1524.20,1358.90,200.00}},
	{"Fallen Tree",              {-792.20,-698.50,-5.30,-452.40,-380.00,200.00}},
	{"Fallow Bridge",            {434.30,366.50,0.00,603.00,555.60,200.00}},
	{"Fern Ridge",               {508.10,-139.20,0.00,1306.60,119.50,200.00}},
	{"Financial",                {-1871.70,744.10,-6.10,-1701.30,1176.40,300.00}},
	{"Fisher's Lagoon",          {1916.90,-233.30,-100.00,2131.70,13.80,200.00}},
	{"Flint Intersection",       {-187.70,-1596.70,-89.00,17.00,-1276.60,110.90}},
	{"Flint Range",              {-594.10,-1648.50,0.00,-187.70,-1276.60,200.00}},
	{"Fort Carson",              {-376.20,826.30,-3.00,123.70,1220.40,200.00}},
	{"Foster Valley",            {-2270.00,-430.20,-0.00,-2178.60,-324.10,200.00}},
	{"Foster Valley",            {-2178.60,-599.80,-0.00,-1794.90,-324.10,200.00}},
	{"Foster Valley",            {-2178.60,-1115.50,0.00,-1794.90,-599.80,200.00}},
	{"Foster Valley",            {-2178.60,-1250.90,0.00,-1794.90,-1115.50,200.00}},
	{"Frederick Bridge",         {2759.20,296.50,0.00,2774.20,594.70,200.00}},
	{"Gant Bridge",              {-2741.40,1659.60,-6.10,-2616.40,2175.10,200.00}},
	{"Gant Bridge",              {-2741.00,1490.40,-6.10,-2616.40,1659.60,200.00}},
	{"Ganton",                   {2222.50,-1852.80,-89.00,2632.80,-1722.30,110.90}},
	{"Ganton",                   {2222.50,-1722.30,-89.00,2632.80,-1628.50,110.90}},
	{"Garcia",                   {-2411.20,-222.50,-0.00,-2173.00,265.20,200.00}},
	{"Garcia",                   {-2395.10,-222.50,-5.30,-2354.00,-204.70,200.00}},
	{"Garver Bridge",            {-1339.80,828.10,-89.00,-1213.90,1057.00,110.90}},
	{"Garver Bridge",            {-1213.90,950.00,-89.00,-1087.90,1178.90,110.90}},
	{"Garver Bridge",            {-1499.80,696.40,-179.60,-1339.80,925.30,20.30}},
	{"Glen Park",                {1812.60,-1449.60,-89.00,1996.90,-1350.70,110.90}},
	{"Glen Park",                {1812.60,-1100.80,-89.00,1994.30,-973.30,110.90}},
	{"Glen Park",                {1812.60,-1350.70,-89.00,2056.80,-1100.80,110.90}},
	{"Green Palms",              {176.50,1305.40,-3.00,338.60,1520.70,200.00}},
	{"Greenglass College",       {964.30,1044.60,-89.00,1197.30,1203.20,110.90}},
	{"Greenglass College",       {964.30,930.80,-89.00,1166.50,1044.60,110.90}},
	{"Hampton Barns",            {603.00,264.30,0.00,761.90,366.50,200.00}},
	{"Hankypanky Point",         {2576.90,62.10,0.00,2759.20,385.50,200.00}},
	{"Harry Gold Parkway",       {1777.30,863.20,-89.00,1817.30,2342.80,110.90}},
	{"Hashbury",                 {-2593.40,-222.50,-0.00,-2411.20,54.70,200.00}},
	{"Hilltop Farm",             {967.30,-450.30,-3.00,1176.70,-217.90,200.00}},
	{"Hunter Quarry",            {337.20,710.80,-115.20,860.50,1031.70,203.70}},
	{"Idlewood",                 {1812.60,-1852.80,-89.00,1971.60,-1742.30,110.90}},
	{"Idlewood",                 {1812.60,-1742.30,-89.00,1951.60,-1602.30,110.90}},
	{"Idlewood",                 {1951.60,-1742.30,-89.00,2124.60,-1602.30,110.90}},
	{"Idlewood",                 {1812.60,-1602.30,-89.00,2124.60,-1449.60,110.90}},
	{"Idlewood",                 {2124.60,-1742.30,-89.00,2222.50,-1494.00,110.90}},
	{"Idlewood",                 {1971.60,-1852.80,-89.00,2222.50,-1742.30,110.90}},
	{"Jefferson",                {1996.90,-1449.60,-89.00,2056.80,-1350.70,110.90}},
	{"Jefferson",                {2124.60,-1494.00,-89.00,2266.20,-1449.60,110.90}},
	{"Jefferson",                {2056.80,-1372.00,-89.00,2281.40,-1210.70,110.90}},
	{"Jefferson",                {2056.80,-1210.70,-89.00,2185.30,-1126.30,110.90}},
	{"Jefferson",                {2185.30,-1210.70,-89.00,2281.40,-1154.50,110.90}},
	{"Jefferson",                {2056.80,-1449.60,-89.00,2266.20,-1372.00,110.90}},
	{"Julius Thruway East",      {2623.10,943.20,-89.00,2749.90,1055.90,110.90}},
	{"Julius Thruway East",      {2685.10,1055.90,-89.00,2749.90,2626.50,110.90}},
	{"Julius Thruway East",      {2536.40,2442.50,-89.00,2685.10,2542.50,110.90}},
	{"Julius Thruway East",      {2625.10,2202.70,-89.00,2685.10,2442.50,110.90}},
	{"Julius Thruway North",     {2498.20,2542.50,-89.00,2685.10,2626.50,110.90}},
	{"Julius Thruway North",     {2237.40,2542.50,-89.00,2498.20,2663.10,110.90}},
	{"Julius Thruway North",     {2121.40,2508.20,-89.00,2237.40,2663.10,110.90}},
	{"Julius Thruway North",     {1938.80,2508.20,-89.00,2121.40,2624.20,110.90}},
	{"Julius Thruway North",     {1534.50,2433.20,-89.00,1848.40,2583.20,110.90}},
	{"Julius Thruway North",     {1848.40,2478.40,-89.00,1938.80,2553.40,110.90}},
	{"Julius Thruway North",     {1704.50,2342.80,-89.00,1848.40,2433.20,110.90}},
	{"Julius Thruway North",     {1377.30,2433.20,-89.00,1534.50,2507.20,110.90}},
	{"Julius Thruway South",     {1457.30,823.20,-89.00,2377.30,863.20,110.90}},
	{"Julius Thruway South",     {2377.30,788.80,-89.00,2537.30,897.90,110.90}},
	{"Julius Thruway West",      {1197.30,1163.30,-89.00,1236.60,2243.20,110.90}},
	{"Julius Thruway West",      {1236.60,2142.80,-89.00,1297.40,2243.20,110.90}},
	{"Juniper Hill",             {-2533.00,578.30,-7.60,-2274.10,968.30,200.00}},
	{"Juniper Hollow",           {-2533.00,968.30,-6.10,-2274.10,1358.90,200.00}},
	{"K.A.C.C. Military Fuels",  {2498.20,2626.50,-89.00,2749.90,2861.50,110.90}},
	{"Kincaid Bridge",           {-1339.80,599.20,-89.00,-1213.90,828.10,110.90}},
	{"Kincaid Bridge",           {-1213.90,721.10,-89.00,-1087.90,950.00,110.90}},
	{"Kincaid Bridge",           {-1087.90,855.30,-89.00,-961.90,986.20,110.90}},
	{"King's",                   {-2329.30,458.40,-7.60,-1993.20,578.30,200.00}},
	{"King's",                   {-2411.20,265.20,-9.10,-1993.20,373.50,200.00}},
	{"King's",                   {-2253.50,373.50,-9.10,-1993.20,458.40,200.00}},
	{"LVA Freight Depot",        {1457.30,863.20,-89.00,1777.40,1143.20,110.90}},
	{"LVA Freight Depot",        {1375.60,919.40,-89.00,1457.30,1203.20,110.90}},
	{"LVA Freight Depot",        {1277.00,1087.60,-89.00,1375.60,1203.20,110.90}},
	{"LVA Freight Depot",        {1315.30,1044.60,-89.00,1375.60,1087.60,110.90}},
	{"LVA Freight Depot",        {1236.60,1163.40,-89.00,1277.00,1203.20,110.90}},
	{"Las Barrancas",            {-926.10,1398.70,-3.00,-719.20,1634.60,200.00}},
	{"Las Brujas",               {-365.10,2123.00,-3.00,-208.50,2217.60,200.00}},
	{"Las Colinas",              {1994.30,-1100.80,-89.00,2056.80,-920.80,110.90}},
	{"Las Colinas",              {2056.80,-1126.30,-89.00,2126.80,-920.80,110.90}},
	{"Las Colinas",              {2185.30,-1154.50,-89.00,2281.40,-934.40,110.90}},
	{"Las Colinas",              {2126.80,-1126.30,-89.00,2185.30,-934.40,110.90}},
	{"Las Colinas",              {2747.70,-1120.00,-89.00,2959.30,-945.00,110.90}},
	{"Las Colinas",              {2632.70,-1135.00,-89.00,2747.70,-945.00,110.90}},
	{"Las Colinas",              {2281.40,-1135.00,-89.00,2632.70,-945.00,110.90}},
	{"Las Payasadas",            {-354.30,2580.30,2.00,-133.60,2816.80,200.00}},
	{"Las Venturas Airport",     {1236.60,1203.20,-89.00,1457.30,1883.10,110.90}},
	{"Las Venturas Airport",     {1457.30,1203.20,-89.00,1777.30,1883.10,110.90}},
	{"Las Venturas Airport",     {1457.30,1143.20,-89.00,1777.40,1203.20,110.90}},
	{"Las Venturas Airport",     {1515.80,1586.40,-12.50,1729.90,1714.50,87.50}},
	{"Last Dime Motel",          {1823.00,596.30,-89.00,1997.20,823.20,110.90}},
	{"Leafy Hollow",             {-1166.90,-1856.00,0.00,-815.60,-1602.00,200.00}},
	{"Liberty City",             {-1000.00,400.00,1300.00,-700.00,600.00,1400.00}},
	{"Lil' Probe Inn",           {-90.20,1286.80,-3.00,153.80,1554.10,200.00}},
	{"Linden Side",              {2749.90,943.20,-89.00,2923.30,1198.90,110.90}},
	{"Linden Station",           {2749.90,1198.90,-89.00,2923.30,1548.90,110.90}},
	{"Linden Station",           {2811.20,1229.50,-39.50,2861.20,1407.50,60.40}},
	{"Little Mexico",            {1701.90,-1842.20,-89.00,1812.60,-1722.20,110.90}},
	{"Little Mexico",            {1758.90,-1722.20,-89.00,1812.60,-1577.50,110.90}},
	{"Los Flores",               {2581.70,-1454.30,-89.00,2632.80,-1393.40,110.90}},
	{"Los Flores",               {2581.70,-1393.40,-89.00,2747.70,-1135.00,110.90}},
	{"Los Santos International", {1249.60,-2394.30,-89.00,1852.00,-2179.20,110.90}},
	{"Los Santos International", {1852.00,-2394.30,-89.00,2089.00,-2179.20,110.90}},
	{"Los Santos International", {1382.70,-2730.80,-89.00,2201.80,-2394.30,110.90}},
	{"Los Santos International", {1974.60,-2394.30,-39.00,2089.00,-2256.50,60.90}},
	{"Los Santos International", {1400.90,-2669.20,-39.00,2189.80,-2597.20,60.90}},
	{"Los Santos International", {2051.60,-2597.20,-39.00,2152.40,-2394.30,60.90}},
	{"Marina",                   {647.70,-1804.20,-89.00,851.40,-1577.50,110.90}},
	{"Marina",                   {647.70,-1577.50,-89.00,807.90,-1416.20,110.90}},
	{"Marina",                   {807.90,-1577.50,-89.00,926.90,-1416.20,110.90}},
	{"Market",                   {787.40,-1416.20,-89.00,1072.60,-1310.20,110.90}},
	{"Market",                   {952.60,-1310.20,-89.00,1072.60,-1130.80,110.90}},
	{"Market",                   {1072.60,-1416.20,-89.00,1370.80,-1130.80,110.90}},
	{"Market",                   {926.90,-1577.50,-89.00,1370.80,-1416.20,110.90}},
	{"Market Station",           {787.40,-1410.90,-34.10,866.00,-1310.20,65.80}},
	{"Martin Bridge",            {-222.10,293.30,0.00,-122.10,476.40,200.00}},
	{"Missionary Hill",          {-2994.40,-811.20,0.00,-2178.60,-430.20,200.00}},
	{"Montgomery",               {1119.50,119.50,-3.00,1451.40,493.30,200.00}},
	{"Montgomery",               {1451.40,347.40,-6.10,1582.40,420.80,200.00}},
	{"Montgomery Intersection",  {1546.60,208.10,0.00,1745.80,347.40,200.00}},
	{"Montgomery Intersection",  {1582.40,347.40,0.00,1664.60,401.70,200.00}},
	{"Mulholland",               {1414.00,-768.00,-89.00,1667.60,-452.40,110.90}},
	{"Mulholland",               {1281.10,-452.40,-89.00,1641.10,-290.90,110.90}},
	{"Mulholland",               {1269.10,-768.00,-89.00,1414.00,-452.40,110.90}},
	{"Mulholland",               {1357.00,-926.90,-89.00,1463.90,-768.00,110.90}},
	{"Mulholland",               {1318.10,-910.10,-89.00,1357.00,-768.00,110.90}},
	{"Mulholland",               {1169.10,-910.10,-89.00,1318.10,-768.00,110.90}},
	{"Mulholland",               {768.60,-954.60,-89.00,952.60,-860.60,110.90}},
	{"Mulholland",               {687.80,-860.60,-89.00,911.80,-768.00,110.90}},
	{"Mulholland",               {737.50,-768.00,-89.00,1142.20,-674.80,110.90}},
	{"Mulholland",               {1096.40,-910.10,-89.00,1169.10,-768.00,110.90}},
	{"Mulholland",               {952.60,-937.10,-89.00,1096.40,-860.60,110.90}},
	{"Mulholland",               {911.80,-860.60,-89.00,1096.40,-768.00,110.90}},
	{"Mulholland",               {861.00,-674.80,-89.00,1156.50,-600.80,110.90}},
	{"Mulholland Intersection",  {1463.90,-1150.80,-89.00,1812.60,-768.00,110.90}},
	{"North Rock",               {2285.30,-768.00,0.00,2770.50,-269.70,200.00}},
	{"Ocean Docks",              {2373.70,-2697.00,-89.00,2809.20,-2330.40,110.90}},
	{"Ocean Docks",              {2201.80,-2418.30,-89.00,2324.00,-2095.00,110.90}},
	{"Ocean Docks",              {2324.00,-2302.30,-89.00,2703.50,-2145.10,110.90}},
	{"Ocean Docks",              {2089.00,-2394.30,-89.00,2201.80,-2235.80,110.90}},
	{"Ocean Docks",              {2201.80,-2730.80,-89.00,2324.00,-2418.30,110.90}},
	{"Ocean Docks",              {2703.50,-2302.30,-89.00,2959.30,-2126.90,110.90}},
	{"Ocean Docks",              {2324.00,-2145.10,-89.00,2703.50,-2059.20,110.90}},
	{"Ocean Flats",              {-2994.40,277.40,-9.10,-2867.80,458.40,200.00}},
	{"Ocean Flats",              {-2994.40,-222.50,-0.00,-2593.40,277.40,200.00}},
	{"Ocean Flats",              {-2994.40,-430.20,-0.00,-2831.80,-222.50,200.00}},
	{"Octane Springs",           {338.60,1228.50,0.00,664.30,1655.00,200.00}},
	{"Old Venturas Strip",       {2162.30,2012.10,-89.00,2685.10,2202.70,110.90}},
	{"Palisades",                {-2994.40,458.40,-6.10,-2741.00,1339.60,200.00}},
	{"Palomino Creek",           {2160.20,-149.00,0.00,2576.90,228.30,200.00}},
	{"Paradiso",                 {-2741.00,793.40,-6.10,-2533.00,1268.40,200.00}},
	{"Pershing Square",          {1440.90,-1722.20,-89.00,1583.50,-1577.50,110.90}},
	{"Pilgrim",                  {2437.30,1383.20,-89.00,2624.40,1783.20,110.90}},
	{"Pilgrim",                  {2624.40,1383.20,-89.00,2685.10,1783.20,110.90}},
	{"Pilson Intersection",      {1098.30,2243.20,-89.00,1377.30,2507.20,110.90}},
	{"Pirates in Men's Pants",   {1817.30,1469.20,-89.00,2027.40,1703.20,110.90}},
	{"Playa del Seville",        {2703.50,-2126.90,-89.00,2959.30,-1852.80,110.90}},
	{"Prickle Pine",             {1534.50,2583.20,-89.00,1848.40,2863.20,110.90}},
	{"Prickle Pine",             {1117.40,2507.20,-89.00,1534.50,2723.20,110.90}},
	{"Prickle Pine",             {1848.40,2553.40,-89.00,1938.80,2863.20,110.90}},
	{"Prickle Pine",             {1938.80,2624.20,-89.00,2121.40,2861.50,110.90}},
	{"Queens",                   {-2533.00,458.40,0.00,-2329.30,578.30,200.00}},
	{"Queens",                   {-2593.40,54.70,0.00,-2411.20,458.40,200.00}},
	{"Queens",                   {-2411.20,373.50,0.00,-2253.50,458.40,200.00}},
	{"Randolph Industrial",      {1558.00,596.30,-89.00,1823.00,823.20,110.90}},
	{"Redsands East",            {1817.30,2011.80,-89.00,2106.70,2202.70,110.90}},
	{"Redsands East",            {1817.30,2202.70,-89.00,2011.90,2342.80,110.90}},
	{"Redsands East",            {1848.40,2342.80,-89.00,2011.90,2478.40,110.90}},
	{"Redsands West",            {1236.60,1883.10,-89.00,1777.30,2142.80,110.90}},
	{"Redsands West",            {1297.40,2142.80,-89.00,1777.30,2243.20,110.90}},
	{"Redsands West",            {1377.30,2243.20,-89.00,1704.50,2433.20,110.90}},
	{"Redsands West",            {1704.50,2243.20,-89.00,1777.30,2342.80,110.90}},
	{"Regular Tom",              {-405.70,1712.80,-3.00,-276.70,1892.70,200.00}},
	{"Richman",                  {647.50,-1118.20,-89.00,787.40,-954.60,110.90}},
	{"Richman",                  {647.50,-954.60,-89.00,768.60,-860.60,110.90}},
	{"Richman",                  {225.10,-1369.60,-89.00,334.50,-1292.00,110.90}},
	{"Richman",                  {225.10,-1292.00,-89.00,466.20,-1235.00,110.90}},
	{"Richman",                  {72.60,-1404.90,-89.00,225.10,-1235.00,110.90}},
	{"Richman",                  {72.60,-1235.00,-89.00,321.30,-1008.10,110.90}},
	{"Richman",                  {321.30,-1235.00,-89.00,647.50,-1044.00,110.90}},
	{"Richman",                  {321.30,-1044.00,-89.00,647.50,-860.60,110.90}},
	{"Richman",                  {321.30,-860.60,-89.00,687.80,-768.00,110.90}},
	{"Richman",                  {321.30,-768.00,-89.00,700.70,-674.80,110.90}},
	{"Robada Intersection",      {-1119.00,1178.90,-89.00,-862.00,1351.40,110.90}},
	{"Roca Escalante",           {2237.40,2202.70,-89.00,2536.40,2542.50,110.90}},
	{"Roca Escalante",           {2536.40,2202.70,-89.00,2625.10,2442.50,110.90}},
	{"Rockshore East",           {2537.30,676.50,-89.00,2902.30,943.20,110.90}},
	{"Rockshore West",           {1997.20,596.30,-89.00,2377.30,823.20,110.90}},
	{"Rockshore West",           {2377.30,596.30,-89.00,2537.30,788.80,110.90}},
	{"Rodeo",                    {72.60,-1684.60,-89.00,225.10,-1544.10,110.90}},
	{"Rodeo",                    {72.60,-1544.10,-89.00,225.10,-1404.90,110.90}},
	{"Rodeo",                    {225.10,-1684.60,-89.00,312.80,-1501.90,110.90}},
	{"Rodeo",                    {225.10,-1501.90,-89.00,334.50,-1369.60,110.90}},
	{"Rodeo",                    {334.50,-1501.90,-89.00,422.60,-1406.00,110.90}},
	{"Rodeo",                    {312.80,-1684.60,-89.00,422.60,-1501.90,110.90}},
	{"Rodeo",                    {422.60,-1684.60,-89.00,558.00,-1570.20,110.90}},
	{"Rodeo",                    {558.00,-1684.60,-89.00,647.50,-1384.90,110.90}},
	{"Rodeo",                    {466.20,-1570.20,-89.00,558.00,-1385.00,110.90}},
	{"Rodeo",                    {422.60,-1570.20,-89.00,466.20,-1406.00,110.90}},
	{"Rodeo",                    {466.20,-1385.00,-89.00,647.50,-1235.00,110.90}},
	{"Rodeo",                    {334.50,-1406.00,-89.00,466.20,-1292.00,110.90}},
	{"Royal Casino",             {2087.30,1383.20,-89.00,2437.30,1543.20,110.90}},
	{"San Andreas Sound",        {2450.30,385.50,-100.00,2759.20,562.30,200.00}},
	{"Santa Flora",              {-2741.00,458.40,-7.60,-2533.00,793.40,200.00}},
	{"Santa Maria Beach",        {342.60,-2173.20,-89.00,647.70,-1684.60,110.90}},
	{"Santa Maria Beach",        {72.60,-2173.20,-89.00,342.60,-1684.60,110.90}},
	{"Shady Cabin",              {-1632.80,-2263.40,-3.00,-1601.30,-2231.70,200.00}},
	{"Shady Creeks",             {-1820.60,-2643.60,-8.00,-1226.70,-1771.60,200.00}},
	{"Shady Creeks",             {-2030.10,-2174.80,-6.10,-1820.60,-1771.60,200.00}},
	{"Sobell Rail Yards",        {2749.90,1548.90,-89.00,2923.30,1937.20,110.90}},
	{"Spinybed",                 {2121.40,2663.10,-89.00,2498.20,2861.50,110.90}},
	{"Starfish Casino",          {2437.30,1783.20,-89.00,2685.10,2012.10,110.90}},
	{"Starfish Casino",          {2437.30,1858.10,-39.00,2495.00,1970.80,60.90}},
	{"Starfish Casino",          {2162.30,1883.20,-89.00,2437.30,2012.10,110.90}},
	{"Temple",                   {1252.30,-1130.80,-89.00,1378.30,-1026.30,110.90}},
	{"Temple",                   {1252.30,-1026.30,-89.00,1391.00,-926.90,110.90}},
	{"Temple",                   {1252.30,-926.90,-89.00,1357.00,-910.10,110.90}},
	{"Temple",                   {952.60,-1130.80,-89.00,1096.40,-937.10,110.90}},
	{"Temple",                   {1096.40,-1130.80,-89.00,1252.30,-1026.30,110.90}},
	{"Temple",                   {1096.40,-1026.30,-89.00,1252.30,-910.10,110.90}},
	{"The Camel's Toe",          {2087.30,1203.20,-89.00,2640.40,1383.20,110.90}},
	{"The Clown's Pocket",       {2162.30,1783.20,-89.00,2437.30,1883.20,110.90}},
	{"The Emerald Isle",         {2011.90,2202.70,-89.00,2237.40,2508.20,110.90}},
	{"The Farm",                 {-1209.60,-1317.10,114.90,-908.10,-787.30,251.90}},
	{"Four Dragons Casino",      {1817.30,863.20,-89.00,2027.30,1083.20,110.90}},
	{"The High Roller",          {1817.30,1283.20,-89.00,2027.30,1469.20,110.90}},
	{"The Mako Span",            {1664.60,401.70,0.00,1785.10,567.20,200.00}},
	{"The Panopticon",           {-947.90,-304.30,-1.10,-319.60,327.00,200.00}},
	{"The Pink Swan",            {1817.30,1083.20,-89.00,2027.30,1283.20,110.90}},
	{"The Sherman Dam",          {-968.70,1929.40,-3.00,-481.10,2155.20,200.00}},
	{"The Strip",                {2027.40,863.20,-89.00,2087.30,1703.20,110.90}},
	{"The Strip",                {2106.70,1863.20,-89.00,2162.30,2202.70,110.90}},
	{"The Strip",                {2027.40,1783.20,-89.00,2162.30,1863.20,110.90}},
	{"The Strip",                {2027.40,1703.20,-89.00,2137.40,1783.20,110.90}},
	{"The Visage",               {1817.30,1863.20,-89.00,2106.70,2011.80,110.90}},
	{"The Visage",               {1817.30,1703.20,-89.00,2027.40,1863.20,110.90}},
	{"Unity Station",            {1692.60,-1971.80,-20.40,1812.60,-1932.80,79.50}},
	{"Valle Ocultado",           {-936.60,2611.40,2.00,-715.90,2847.90,200.00}},
	{"Verdant Bluffs",           {930.20,-2488.40,-89.00,1249.60,-2006.70,110.90}},
	{"Verdant Bluffs",           {1073.20,-2006.70,-89.00,1249.60,-1842.20,110.90}},
	{"Verdant Bluffs",           {1249.60,-2179.20,-89.00,1692.60,-1842.20,110.90}},
	{"Verdant Meadows",          {37.00,2337.10,-3.00,435.90,2677.90,200.00}},
	{"Verona Beach",             {647.70,-2173.20,-89.00,930.20,-1804.20,110.90}},
	{"Verona Beach",             {930.20,-2006.70,-89.00,1073.20,-1804.20,110.90}},
	{"Verona Beach",             {851.40,-1804.20,-89.00,1046.10,-1577.50,110.90}},
	{"Verona Beach",             {1161.50,-1722.20,-89.00,1323.90,-1577.50,110.90}},
	{"Verona Beach",             {1046.10,-1722.20,-89.00,1161.50,-1577.50,110.90}},
	{"Vinewood",                 {787.40,-1310.20,-89.00,952.60,-1130.80,110.90}},
	{"Vinewood",                 {787.40,-1130.80,-89.00,952.60,-954.60,110.90}},
	{"Vinewood",                 {647.50,-1227.20,-89.00,787.40,-1118.20,110.90}},
	{"Vinewood",                 {647.70,-1416.20,-89.00,787.40,-1227.20,110.90}},
	{"Whitewood Estates",        {883.30,1726.20,-89.00,1098.30,2507.20,110.90}},
	{"Whitewood Estates",        {1098.30,1726.20,-89.00,1197.30,2243.20,110.90}},
	{"Willowfield",              {1970.60,-2179.20,-89.00,2089.00,-1852.80,110.90}},
	{"Willowfield",              {2089.00,-2235.80,-89.00,2201.80,-1989.90,110.90}},
	{"Willowfield",              {2089.00,-1989.90,-89.00,2324.00,-1852.80,110.90}},
	{"Willowfield",              {2201.80,-2095.00,-89.00,2324.00,-1989.90,110.90}},
	{"Willowfield",              {2541.70,-1941.40,-89.00,2703.50,-1852.80,110.90}},
	{"Willowfield",              {2324.00,-2059.20,-89.00,2541.70,-1852.80,110.90}},
	{"Willowfield",              {2541.70,-2059.20,-89.00,2703.50,-1941.40,110.90}},
	{"Yellow Bell Station",      {1377.40,2600.40,-21.90,1492.40,2687.30,78.00}},
	{"Los Santos",               {44.60,-2892.90,-242.90,2997.00,-768.00,900.00}},
	{"Las Venturas",             {869.40,596.30,-242.90,2997.00,2993.80,900.00}},
	{"Bone County",              {-480.50,596.30,-242.90,869.40,2993.80,900.00}},
	{"Tierra Robada",            {-2997.40,1659.60,-242.90,-480.50,2993.80,900.00}},
	{"Tierra Robada",            {-1213.90,596.30,-242.90,-480.50,1659.60,900.00}},
	{"San Fierro",               {-2997.40,-1115.50,-242.90,-1213.90,1659.60,900.00}},
	{"Red County",               {-1213.90,-768.00,-242.90,2997.00,596.30,900.00}},
	{"Flint County",             {-1213.90,-2892.90,-242.90,44.60,-768.00,900.00}},
	{"Whetstone",                {-2997.40,-2892.90,-242.90,-1213.90,-1115.50,900.00}}
};
//==============================================================================
new LS;
new LV;
new SF;
new pd;
new gym;
new Shop;
new Jobs;
new blcp;
new beer;
new dlcp;
new lsap;
new Bank5;
new Bank6;
new Shop1;
new Shop4;
new sk[5];
new Bank7;
new Bank2;
new Bank4;
new Bank8;
new Bank3;
new Shop2;
new Shop3;
new Bank1;
new lsap1;
new lsap2;
new dealer;
new church;
new t1[40];
new t2[40];
new t3[40];
new t4[40];
new t5[40];
new dl[12];
new br[10];
new DL1[6];
new DL2[6];
new DL3[5];
new DL4[5];
new DL5[5];
new DL6[6];
new DL7[6];
new DL8[6];
new DL9[6];
new DL10[6];
new DL11[6];
new DL12[5];
new ssecond;
new sminute;
new blpickup;
new BankExit;
new flpickup;
new GateOpen;
new sandking;
new OrgsCount;
new ZoneCount;
new bloodring;
new sandkinge;
new paintball;
new RPCars[3];
new bloodringe;
new textdraw=0;
new globaltimer;
new PropertyCount;
new BusinessCount;
new Text:Textdraw1;
new Text:Textdraw2;
new Text:Textdraw3;
new Text:Textdraw4;
new Text:Textdraw5;
new PB[MAX_PLAYERS];
new bp[MAX_PLAYERS];
new GL[MAX_PLAYERS];
new RP[MAX_PLAYERS];
new FL[MAX_PLAYERS];
new DL[MAX_PLAYERS];
new BL[MAX_PLAYERS];
new aid[MAX_PLAYERS];
new sa2[MAX_PLAYERS];
new BtL[MAX_PLAYERS];
new Job[MAX_PLAYERS];
new Bag[MAX_PLAYERS];
new VIP[MAX_PLAYERS];
new NZT[MAX_PLAYERS];
new PID[MAX_PLAYERS];
new Car[MAX_PLAYERS];
new BID[MAX_PLAYERS];
new TAFK[MAX_PLAYERS];
new Died[MAX_PLAYERS];
new ACar[MAX_PLAYERS];
new Keys[MAX_PLAYERS];
new Skin[MAX_PLAYERS];
new Drug[MAX_PLAYERS];
new Lock[MAX_PLAYERS];
new Mute[MAX_PLAYERS];
new Cell[MAX_PLAYERS];
new Bank[MAX_PLAYERS];
new Rank[MAX_PLAYERS];
new Time[MAX_PLAYERS];
new Hours[MAX_PLAYERS];
new fuel[MAX_VEHICLES];
new Alarm[MAX_PLAYERS];
new rname[MAX_PLAYERS];
new Business[200][Bus];
new Lotto[MAX_PLAYERS];
new Inter[MAX_PLAYERS];
new rcash[MAX_PLAYERS];
new Tazer[MAX_PLAYERS];
new Tazed[MAX_PLAYERS];
new Property[200][Prop];
new Suited[MAX_PLAYERS];
new called[MAX_PLAYERS];
new Hidden[MAX_PLAYERS];
new Kicked[MAX_PLAYERS];
new Fstyle[MAX_PLAYERS];
new Cigars[MAX_PLAYERS];
new Jailed[MAX_PLAYERS];
new BankID[MAX_PLAYERS];
new Lesson[MAX_PLAYERS];
new Ticket[MAX_PLAYERS];
new Chance[MAX_PLAYERS];
new OrgZone[MAX_PLAYERS];
new Airport[MAX_PLAYERS];
new onphone[MAX_PLAYERS];
new s3[MAX_PLAYERS][128];
new Minutes[MAX_PLAYERS];
new Teacher[MAX_PLAYERS];
new FuelCan[MAX_PLAYERS];
new OrgTime[MAX_PLAYERS];
new CMDUsed[MAX_PLAYERS];
new IsLogged[MAX_PLAYERS];
new Talkanim[MAX_PLAYERS];
new Trucking[MAX_PLAYERS];
new HadDrugs[MAX_PLAYERS];
new Float:pZ[MAX_PLAYERS];
new Passport[MAX_PLAYERS];
new Float:pX[MAX_PLAYERS];
new Password[MAX_PLAYERS];
new Float:pY[MAX_PLAYERS];
new CarPaint[MAX_PLAYERS];
new CarColor1[MAX_PLAYERS];
new CarColor2[MAX_PLAYERS];
new Insurance[MAX_PLAYERS];
new Float:svx[MAX_PLAYERS];
new IsRobbing[MAX_PLAYERS];
new dfbltimer[MAX_PLAYERS];
new PlayerOrg[MAX_PLAYERS];
new Float:svy[MAX_PLAYERS];
new NameLimit[MAX_PLAYERS];
new Reporting[MAX_PLAYERS];
new Float:sa1[MAX_PLAYERS];
new Float:svz[MAX_PLAYERS];
new Questions[MAX_PLAYERS];
new IsSpecing[MAX_PLAYERS];
new VehNum[MAX_PLAYERS][9];
new Refuelling[MAX_PLAYERS];
new AdminLevel[MAX_PLAYERS];
new GamerScore[MAX_PLAYERS];
new DrugAddict[MAX_PLAYERS];
new registered[MAX_PLAYERS];
new Requesting[MAX_PLAYERS];
new Text:Zones[MAX_PLAYERS];
new IsBleeding[MAX_PLAYERS];
new Reason[MAX_PLAYERS][25];
new Float:Armor[MAX_PLAYERS];
new AtmInfo[MAX_ATMS][AInfo];
new spectatorid[MAX_PLAYERS];
new Text:td_fuel[MAX_PLAYERS];
new TheoryPassed[MAX_PLAYERS];
new Cellswitched[MAX_PLAYERS];
new Text3D:Label[MAX_PLAYERS];
new PlayerLeader[MAX_PLAYERS];
new CollectedWage[MAX_PLAYERS];
new IsBeingSpeced[MAX_PLAYERS];
new ChatLine[MAX_PLAYERS][128];
new Text:sdisplay[MAX_PLAYERS];
new SavedWeaps[MAX_PLAYERS][5];
new SavedAmmos[MAX_PLAYERS][5];
new Organization[MAX_ORGS][Orgs];
new bool:Weapons[MAX_PLAYERS][47];
new License[MAX_PLAYERS][license];
new Float:positions[MAX_PLAYERS][6];
new Ignore[MAX_PLAYERS][MAX_PLAYERS];
new PlayerAwards[MAX_PLAYERS][Awards];
new Text3D:vehicle3Dtext[MAX_VEHICLES];
new RPName[MAX_PLAYERS][MAX_PLAYER_NAME];
new MarriedTo[MAX_PLAYERS][MAX_PLAYER_NAME];
//==============================================================================
main(){}
//==============================================================================
public OnGameModeInit()
{
    CreateTextdraws();
    ShowPlayerMarkers(0);
    EnableStuntBonusForAll(0);
   	ManualVehicleEngineAndLights();
	SetGameModeText("RolePlay");
    globaltimer=SetTimer("Global",1300,true);
//==============================================================================
	CreateAtm(414.4580,2533.7800,16.5648,88.798);
	CreateAtm(2159.2224,939.9501,10.8203,2.8198);
	CreateAtm(2173.5415,1407.0386,11.0625,1.9197);
	CreateAtm(2194.7415,1987.0552,12.2969,6.8235);
	CreateAtm(639.9056,1684.7319,7.1875,310.5501);
	CreateAtm(2184.5903,1695.0334,11.0864,62.5508);
	CreateAtm(1595.2738,2218.9077,11.0625,93.4207);
	CreateAtm(1833.1830,-1845.9594,13.5781,7.6307);
	CreateAtm(2105.4314,-1803.7200,13.5547,6.0092);
	CreateAtm(1367.2109,-1282.9178,13.5469,4.3364);
	CreateAtm(1837.1440,-1673.3280,13.3184,4.6444);
	CreateAtm(2023.6367,1017.5326,10.8203,180.0213);
	CreateAtm(2052.8638,-1897.6166,13.5538,91.4941);
	CreateAtm(-1463.1160,1873.3700,32.6328,94.3343);
	CreateAtm(-1967.6462,278.4150,35.1719,358.0296);
	CreateAtm(1601.0364,1815.7365,10.8203,268.0646);
	CreateAtm(-2420.1333,971.2337,45.2969,183.0492);
	CreateAtm(2187.9324,2479.0771,11.2422,182.2900);
	CreateAtm(2253.7019,2396.3792,10.8203,270.4928);
	CreateAtm(1937.4963,2299.9414,10.8130,359.5123);
	CreateAtm(2043.7657,-1410.6008,17.1641,358.2861);
	CreateAtm(1928.6656,-1769.5616,13.5469,185.3688);
	CreateAtm(2115.2664,-1118.1217,25.2982,261.2955);
	CreateAtm(1174.9736,-1317.6941,13.9876,274.6415);
	CreateAtm(-2029.5383,-101.8025,35.1641,266.6968);
	CreateAtm(-1318.7296,2699.3511,50.2663,124.9947);
//==============================================================================
    CreateDynamicPickup(1239,1,-1546,126,2);
    CreateDynamicPickup(1239,1,1727,2309,10);
    CreateDynamicPickup(1239,1,2222,-2682,14);
	CreateDynamicPickup(1239,1,1569.7124,-2263.4231,266.2109,-1);
	gym=CreateDynamicCP(758.0407,5.2203,1000.7024,1.5,0,5,-1,100);
   	Bank4=CreateDynamicPickup(1274,1,-178.1093,1109.9939,19.7422);
   	Bank6=CreateDynamicPickup(1274,1,-1704.3229,785.7140,25.4682);
   	Bank7=CreateDynamicPickup(1274,1,274.1207,-1614.0920,33.2041);
   	Bank8=CreateDynamicPickup(1274,1,2462.8232,2244.1150,10.8203);
	LV=CreateDynamicCP(1674.7411,1450.8416,10.7816,1.5,0,0,-1,50.0);
	Jobs=CreateDynamicCP(362.1016,173.7975,1008.3828,1.0,0,3,-1,50);
   	Bank5=CreateDynamicPickup(1274,1,2862.0969,-1405.7080,11.7344);
	dl[0]=CreateDynamicCP(2126.322,-1128.8271,25.0835,2,0,0,-1,15.0);
	dl[1]=CreateDynamicCP(1736.9126,1869.6564,10.3864,2,0,0,-1,15.0);
	dl[2]=CreateDynamicCP(2166.7205,1402.6173,10.3869,2,0,0,-1,15.0);
	dl[3]=CreateDynamicCP(-1970.7853,289.3765,34.7174,2,0,0,-1,15.0);
	dl[4]=CreateDynamicCP(534.3774,2361.9661,30.11180,2,0,0,-1,15.0);
	dl[5]=CreateDynamicCP(-1655.9498,1212.0081,7.2500,2,0,0,-1,15.0);
	dl[6]=CreateDynamicCP(-1821.1545,-175.6125,8.9563,2,0,0,-1,15.0);
	dl[7]=CreateDynamicCP(1765.7778,-1695.3842,12.983,2,0,0,-1,15.0);
	dl[8]=CreateDynamicCP(1978.1996,2043.6552,10.5437,2,0,0,-1,15.0);
	dl[9]=CreateDynamicCP(550.0584,-1275.5981,16.9753,2,0,0,-1,15.0);
	dl[10]=CreateDynamicCP(-23.7278,-2506.7014,36.386,2,0,0,-1,15.0);
	dl[11]=CreateDynamicCP(-2234.962,2418.6135,-0.304,2,0,0,-1,30.0);
	SF=CreateDynamicCP(-1419.3757,-289.6737,14.1484,1.5,0,0,-1,50.0);
	church=CreateDynamicPickup(1239,1,-1989.0254,1117.9299,54.4717);
   	Bank3=CreateDynamicPickup(1274,1,-2764.9155,375.3531,6.3429,-1);
	blcp=CreateDynamicCP(-2186.9304,2414.8867,5.1563,1.0,0,0,-1,25.0);
	lsap2=CreateDynamicObject(988,1959.052734,-2189,13.5,0.0,0.0,178);
	lsap1=CreateDynamicObject(988,1964.313476,-2189,13.5,0.0,0.0,178);
	Shop4=CreateDynamicCP(-23.2166,-55.6282,1003.5469,1.0,0,6,-1,25.0);
   	Bank2=CreateDynamicPickup(1274,1,2474.4038,1023.0991,10.8203,-1);
   	CreateDynamicObject(987,2268.0320,-2258.8049,12.5,0.0,0.0,135);
	beer=CreateDynamicCP(499.2831,-21.1249,1000.6797,1.5,0,17,-1,100.0);
    pd=CreateDynamicObject(3037,1589.26,-1638,14.3,0.0,0.0,-88.799980);
	sandking=CreateDynamicPickup(1318,1,2695.5005,-1704.6499,11.8438,-1);
	bloodring=CreateDynamicPickup(1318,1,1099.5474,1601.5590,12.5469,-1);
	LS=CreateDynamicCP(1638.9767,-2334.1077,13.5469,1.5,0,0,-1,50.0);
	flpickup=CreateDynamicCP(415.4908,2533.2776,19.1484,1.0,0,0,-1,25.0);
   	Bank1=CreateDynamicPickup(1274,1,1461.8743,-1011.6029,26.8438,-1);
	dlcp=CreateDynamicCP(-2032.8486,-117.3838,1035.1719,1.0,0,3,-1,50.0);
 	paintball=CreateDynamicPickup(1239,1,1310.1403,-1367.4672,13.5349,-1);
	blpickup=CreateDynamicCP(1173.1650,1348.8018,10.9219,1.0,0,0,-1,50.0);
	BankExit=CreateDynamicPickup(1274,1,1563.2772,-2251.8469,266.2109,-1);
	sandkinge=CreateDynamicPickup(1318,1,-1461.4069,-620.7017,1049.8763,-1);
	bloodringe=CreateDynamicPickup(1318,1,-1424.1954,929.6995,1036.4005,-1);
	Shop1=CreateDynamicCP(6.091179,-29.271898,1003.549438,1.0,0,10,-1,25.0);
	Shop=CreateDynamicCP(-25.884498,-185.868988,1003.546875,1.0,0,17,-1,25.0);
	Shop2=CreateDynamicCP(-25.132598,-139.066986,1003.546875,1.0,0,16,-1,25.0);
	Shop3=CreateDynamicCP(-27.946699,-89.609596,1003.5468755,1.0,0,18,-1,25.0);
	CreateDynamic3DTextLabel("Bank",0xFFFFFFFF,569.4249,-2263.4336,166.2109,12);
 	CreateDynamic3DTextLabel("/bank",0xFFFFFFFF,1569.7124,-2263.4231,266.2109,12);
 	CreateDynamic3DTextLabel("State Gym",0xFFFFFFFF,758.0407,5.2203,1000.7024,12);
	CreateDynamic3DTextLabel("City Hall",0xFFFFFFFF,362.1016,173.7975,1008.3828,12);
	CreateDynamic3DTextLabel("24/7 Shop",0xFFFFFFFF,-23.2166,-55.6282,1003.5469,12);
	CreateDynamic3DTextLabel("City Hall",0xFFFFFFFF,362.1016,173.7975,1008.3828,12);
	CreateDynamic3DTextLabel("The Church",0xFFFFFFFF,-1989.0254,1117.9299,54.4717,12);
	CreateDynamic3DTextLabel("The Church",0xFFFFFFFF,-1989.0254,1117.9299,54.4717,12);
	CreateDynamic3DTextLabel("Bike School",0xFFFFFFFF,1173.1650,1348.8018,10.9219,12);
	CreateDynamic3DTextLabel("24/7 Shop",0xFFFFFFFF,6.091179,-29.271898,1003.549438,12);
    CreateDynamic3DTextLabel("/loadpackages to \nload the packages",-1,1727,2309,10,7);
	CreateDynamic3DTextLabel("Alhambra Club",0xFFFFFFFF,499.2831,-21.1249,1000.6797,12);
	CreateDynamic3DTextLabel("Flying School",0xFFFFFFFF,415.4908,2533.2776,19.1484,12);
	CreateDynamic3DTextLabel("Boat License",0xFFFFFFFF,-2186.9304,2414.8867,5.1563,12);
	CreateDynamic3DTextLabel("24/7 Shop",0xFFFFFFFF,-25.884498,-185.868988,1003.546875,12);
 	CreateDynamic3DTextLabel("San Andreas Bank",0xFFFFFFFF,2474.4038,1023.0991,10.8203,12);
 	CreateDynamic3DTextLabel("San Andreas Bank",0xFFFFFFFF,-2764.9155,375.3531,6.3429,12);
 	CreateDynamic3DTextLabel("San Andreas Bank",0xFFFFFFFF,-178.1093,1109.9939,19.7422,12);
 	CreateDynamic3DTextLabel("San Andreas Bank",0xFFFFFFFF,1461.8743,-1011.6029,26.843,12);
 	CreateDynamic3DTextLabel("San Andreas Bank",0xFFFFFFFF,-1704.3229,785.7140,25.4682,12);
	CreateDynamic3DTextLabel("San Andreas Bank",0xFFFFFFFF,274.1207,-1614.0920,33.2041,12);
	CreateDynamic3DTextLabel("San Andreas Bank",0xFFFFFFFF,2462.8232,2244.1150,10.8203,12);
 	CreateDynamic3DTextLabel("San Andreas Bank",0xFFFFFFFF,2862.0969,-1405.7080,11.734,12);
	CreateDynamic3DTextLabel("24/7 Shop",0xFFFFFFFF,-25.132598,-139.066986,1003.546875,12);
	CreateDynamic3DTextLabel("24/7 Shop",0xFFFFFFFF,-27.946699,-89.609596,1003.5468755,12);
	CreateDynamic3DTextLabel("San Andreas Bank",0xFFFFFFFF,1563.2772,-2251.8469,266.2109,12);
	CreateDynamic3DTextLabel("Driving School",0xFFFFFFFF,-2032.8486,-117.3838,1035.1719,12);
    CreateDynamic3DTextLabel("/delieverpackages to\nunload the packages",-1,-1546,126,2,7);
    CreateDynamic3DTextLabel("/delieverpackages to\nunload the packages",-1,2222,-2682,14,7);
	CreateDynamic3DTextLabel("San Fierro Airport",0xFFFFFFFF,-1419.3757,-289.6737,14.1484,12);
	CreateDynamic3DTextLabel("Los Santos Airport",0xFFFFFFFF,1638.9767,-2334.1077,13.5469,12);
	CreateDynamic3DTextLabel("Las Venturas Airport",0xFFFFFFFF,1674.7411,1450.8416,10.7816,12);
	CreateDynamic3DTextLabel("Los Santos Paintball",0xFFFFFFFF,1310.1403,-1367.4672,13.5349,12);
	CreateDynamic3DTextLabel("San Andreas Car Showroom",0xFFFFFFFF,-2234.962,2418.6135,-0.304,12);
	CreateDynamic3DTextLabel("San Andreas Car Showroom",0xFFFFFFFF,-23.7278,-2506.7014,36.386,12);
	CreateDynamic3DTextLabel("San Andreas Car Showroom",0xFFFFFFFF,2126.322,-1128.8271,25.0835,12);
	CreateDynamic3DTextLabel("San Andreas Car Showroom",0xFFFFFFFF,1736.9126,1869.6564,10.3864,12);
	CreateDynamic3DTextLabel("San Andreas Car Showroom",0xFFFFFFFF,2166.7205,1402.6173,10.3869,12);
	CreateDynamic3DTextLabel("San Andreas Car Showroom",0xFFFFFFFF,-1970.7853,289.3765,34.7174,12);
	CreateDynamic3DTextLabel("San Andreas Car Showroom",0xFFFFFFFF,534.3774,2361.9661,30.11180,12);
	CreateDynamic3DTextLabel("San Andreas Car Showroom",0xFFFFFFFF,-1655.9498,1212.0081,7.2500,12);
	CreateDynamic3DTextLabel("San Andreas Car Showroom",0xFFFFFFFF,-1821.1545,-175.6125,8.9563,12);
	CreateDynamic3DTextLabel("San Andreas Car Showroom",0xFFFFFFFF,1765.7778,-1695.3842,12.983,12);
	CreateDynamic3DTextLabel("San Andreas Car Showroom",0xFFFFFFFF,1978.1996,2043.6552,10.5437,12);
	CreateDynamic3DTextLabel("San Andreas Car Showroom",0xFFFFFFFF,550.0584,-1275.5981,16.9753,12);
//==============================================================================
	CreateObject(8406,1584,-1638.6,19.8,0.00,0.00,-2.2);
 	CreateObject(3799,2483.7100,1047,2980,0.00,0.00,0.00);
	CreateObject(3800,2486.5828,1045.1124,2980,0.00,0.00,0.00);
	CreateObject(944,2489.6440,1039.6068,2980,0.00,0.00,0.00);
	CreateObject(3796,2492.0725,1047.2554,2980,0.00,0.00,0.00);
 	CreateObject(3095,268.15,1884.43,16.02,0.00,0.00,0.00);
	CreateObject(3881,2225.23,-2211.68,14.4469,0,0,-225.30);
	CreateObject(13007,1570.50,-2259.50,267.00,0.00,0.00,1.25);
 	CreateObject(2946,1564.80,-2251.30,265.20,0.00,0.00,90.00);
	CreateObject(2946,1561.60,-2251.30,265.20,0.00,0.00,270.00);
	CreateObject(2190,1576.00,-2254.30,265.90,0.00,0.00,182.00);
	CreateObject(14576,1565.40,-2265.80,260.50,0.00,0.00,90.00);
	CreateObject(1616,1588.80,-2266.40,266.50,0.00,0.00,0.00);
	CreateObject(1616,1561.80,-2264.30,268.30,0.00,0.00,266.00);
	CreateObject(1615,1567.60,-2264.50,265.60,0.00,0.00,88.00);
	CreateObject(1671,1564.10,-2265.50,265.50,0.00,0.00,180.00);
	CreateObject(1671,1565.80,-2265.50,265.50,0.00,0.00,179.99);
	CreateObject(1671,1567.50,-2265.50,265.50,0.00,0.00,143.99);
	CreateObject(1671,1570.50,-2265.40,265.50,0.00,0.00,177.99);
	CreateObject(1671,1573.70,-2265.70,265.50,0.00,0.00,191.99);
	CreateObject(1671,1577.30,-2266.00,265.50,0.00,0.00,95.98);
	CreateObject(7930,1584.30,-2259.90,262.00,0.00,0.00,90.00);
	CreateObject(7930,1580.00,-2263.50,262.00,0.00,0.00,180.00);
	CreateObject(2007,1563.50,-2267.30,265.10,0.00,0.00,180.00);
	CreateObject(2000,1564.30,-2267.30,265.10,0.00,0.00,182.00);
	CreateObject(2066,1564.90,-2267.70,265.10,0.00,0.00,0.00);
	CreateObject(2133,1565.80,-2267.50,265.00,0.00,0.00,182.00);
	CreateObject(2161,1566.80,-2267.20,265.00,0.00,0.00,0.00);
	CreateObject(2164,1573.50,-2252.10,265.00,0.00,0.00,0.00);
	CreateObject(2199,1568.70,-2267.50,265.00,0.00,0.00,180.00);
	CreateObject(2200,1571.10,-2267.40,265.00,0.00,0.00,180.00);
	CreateObject(2604,1578.40,-2266.30,266.00,0.00,0.00,272.00);
	CreateObject(2606,1579.10,-2266.40,269.00,0.00,0.00,274.00);
	CreateObject(2202,1574.90,-2267.20,265.20,0.00,0.00,0.00);
	CreateObject(2131,1573.30,-2267.00,265.20,0.00,0.00,182.00);
	CreateObject(2894,1577.80,-2265.20,266.40,0.00,358.00,308);
	CreateObject(3796,1563.82,-2258.71,252.38,0.00,0.00,194.2);
	CreateObject(1685,1569.87,-2261.63,252.30,0.00,0.00,0.00);
	CreateObject(1431,1573.35,-2260.33,252.30,0.00,0.00,0.00);
	CreateObject(3800,1564.79,-2248.75,252.30,0.00,0.00,0.00);
	CreateObject(3800,1562.75,-2250.45,252.30,0.00,0.00,0.00);
	CreateObject(944,1569.04,-2258.48,252.60,0.00,0.00,0.00);
	CreateObject(3796,1569.98,-2276.37,252.38,0.00,0.00,194.2);
	CreateObject(1685,1565.32,-2272.13,252.30,0.00,0.00,0.00);
	CreateObject(1685,1567.52,-2272.00,252.30,0.00,0.00,0.00);
	CreateObject(944,1561.94,-2271.13,252.60,0.00,0.00,0.00);
	CreateObject(944,1562.26,-2269.26,252.60,0.00,0.00,0.00);
	CreateObject(18257,1565.32,-2243.62,252.30,0.00,0.00,-197.40);
	CreateObject(3796,1574.77,-2276.07,252.38,0.00,0.00,297.42);
	CreateObject(9339,3189,173.9676,1008.3828,0.0,0.0,88.3610);
	CreateObject(3279,12.1999998,-261.2000122,4.4000001,0.0000000,0,90);
	CreateObject(3884,12.1999998,-261.3999939,20.5000000,0.0000000,0,270);
	CreateObject(1503,-73.6999969,-329.1000061,4.8000002,0.0000000,0,88);
	CreateObject(1503,-73.6999969,-379.8999939,4.8000002,0.0000000,0,86);
	CreateObject(9241,-9.1999998,-367.6000061,6.0999999,0.0000000,0,270);
 	CreateObject(3399,2493.39,2333.26,12.10,0.00,0.00,0.00);
	CreateObject(19313,121.67,1941.61,21.63,0.00,0.00,0.00);
	CreateObject(19313,286.10,1833.56,19.96,0.00,0.00,90.00);
//==============================================================================
	CreateDynamicMapIcon(1727,2309,11,51,-1,-1,-1,-1,300);
	CreateDynamicMapIcon(1362.7048,1698.0651,10.5474,5,-1,-1,-1,-1,300);
	CreateDynamicMapIcon(1484.1288,-2447.6877,13.2818,5,-1,-1,-1,-1,300);
	CreateDynamicMapIcon(-1350.4796,-229.8320,13.8710,5,-1,-1,-1,-1,300);
	CreateDynamicMapIcon(1835.2781,-1681.3326,12.9782,48,-1,-1,-1,-1,300);
	CreateDynamicMapIcon(2459.8752,2243.2893,10.4453,52,-1,-1,-1,-1,300);
	CreateDynamicMapIcon(2454.3052,2061.5254,10.4461,56,-1,-1,-1,-1,300);
	CreateDynamicMapIcon(2441.8584,2063.4958,10.4450,48,-1,-1,-1,-1,300);
	CreateDynamicMapIcon(2545.0181,1970.1798,10.4453,56,-1,-1,-1,-1,300);
	CreateDynamicMapIcon(2538.2036,2083.0383,10.4457,6,-1,-1,-1,-1,300);
	CreateDynamicMapIcon(2285.1548,2430.8013,10.4451,30,-1,-1,-1,-1,300);
	CreateDynamicMapIcon(2247.7397,2398.2249,10.5955,56,-1,-1,-1,-1,300);
	CreateDynamicMapIcon(2103.7498,2255.4651,10.6515,45,-1,-1,-1,-1,300);
	CreateDynamicMapIcon(1966.5599,2292.0527,10.4455,54,-1,-1,-1,-1,300);
	CreateDynamicMapIcon(1935.9364,2307.3125,10.4453,56,-1,-1,-1,-1,300);
	CreateDynamicMapIcon(2193.0142,1993.7582,12.2969,56,-1,-1,-1,-1,300);
	CreateDynamicMapIcon(2186.0398,1682.6647,10.9715,25,-1,-1,-1,-1,300);
	CreateDynamicMapIcon(2125.0100,1404.2250,10.9150,55,-1,-1,-1,-1,300);
	CreateDynamicMapIcon(2022.3071,1004.1555,10.6933,25,-1,-1,-1,-1,300);
	CreateDynamicMapIcon(2157.4065,944.4659,10.6960,6,-1,-1,-1,-1,300);
	CreateDynamicMapIcon(2384.1519,1040.4169,10.6953,27,-1,-1,-1,-1,300);
	CreateDynamicMapIcon(2473.6755,1021.5497,10.6957,52,-1,-1,-1,-1,300);
	CreateDynamicMapIcon(2542.6436,1020.5229,10.6910,48,-1,-1,-1,-1,300);
	CreateDynamicMapIcon(2415.0249,1122.3872,10.6953,42,-1,-1,-1,-1,300);
	CreateDynamicMapIcon(1659.3862,1720.0867,10.7009,45,-1,-1,-1,-1,300);
	CreateDynamicMapIcon(1580.6824,1769.9729,10.6954,22,-1,-1,-1,-1,300);
	CreateDynamicMapIcon(-1514.4822,2519.8748,55.6443,22,-1,-1,-1,-1,300);
	CreateDynamicMapIcon(-2374.3040,909.8604,45.1082,45,-1,-1,-1,-1,300);
	CreateDynamicMapIcon(-1883.6006,866.1436,34.8411,45,-1,-1,-1,-1,300);
	CreateDynamicMapIcon(-1705.9407,785.9872,24.8906,52,-1,-1,-1,-1,300);
	CreateDynamicMapIcon(-2028.1715,-99.0007,34.8911,36,-1,-1,-1,-1,300);
	CreateDynamicMapIcon(-2268.1316,-153.8661,35.0474,54,-1,-1,-1,-1,300);
	CreateDynamicMapIcon(-2492.7781,-30.8342,25.4879,45,-1,-1,-1,-1,300);
	CreateDynamicMapIcon(-2716.4016,200.8260,4.0588,27,-1,-1,-1,-1,300);
	CreateDynamicMapIcon(-2762.9177,377.1683,5.4939,52,-1,-1,-1,-1,300);
	CreateDynamicMapIcon(-2655.0117,639.2120,14.1802,22,-1,-1,-1,-1,300);
	CreateDynamicMapIcon(494.8578,-1360.0922,16.5918,45,-1,-1,-1,-1,300);
	CreateDynamicMapIcon(457.8503,-1498.0845,30.6711,45,-1,-1,-1,-1,300);
	CreateDynamicMapIcon(275.0454,-1599.3566,32.7402,52,-1,-1,-1,-1,300);
	CreateDynamicMapIcon(1172.8988,-1319.3801,15.3943,22,-1,-1,-1,-1,300);
	CreateDynamicMapIcon(1549.9832,-1674.9602,15.2016,30,-1,-1,-1,-1,300);
	CreateDynamicMapIcon(1831.8083,-1844.4016,13.4097,56,-1,-1,-1,-1,300);
	CreateDynamicMapIcon(2307.8706,-1646.3650,14.8270,49,-1,-1,-1,-1,300);
	CreateDynamicMapIcon(2357.6814,-1366.9982,23.9680,49,-1,-1,-1,-1,300);
	CreateDynamicMapIcon(2421.0940,-1222.1597,25.2772,21,-1,-1,-1,-1,300);
	CreateDynamicMapIcon(2034.5010,-1403.9916,17.1886,22,-1,-1,-1,-1,300);
	CreateDynamicMapIcon(1461.4565,-1016.6689,25.7423,52,-1,-1,-1,-1,300);
	CreateDynamicMapIcon(1460.4380,-1137.9801,23.9864,45,-1,-1,-1,-1,300);
	CreateDynamicMapIcon(2864.9402,-1404.1641,11.2428,52,-1,-1,-1,-1,300);
	CreateDynamicMapIcon(1595.5406,2198.0520,10.3863,51,-1,-1,-1,-1,300);
	CreateDynamicMapIcon(2202.0649,2472.6697,10.5677,51,-1,-1,-1,-1,300);
	CreateDynamicMapIcon(2115.1929,919.9908,10.5266,51,-1,-1,-1,-1,300);
	CreateDynamicMapIcon(2640.7209,1105.9565,10.5274,51,-1,-1,-1,-1,300);
	CreateDynamicMapIcon(608.5971,1699.6238,6.9922,51,-1,-1,-1,-1,300);
	CreateDynamicMapIcon(618.4878,1684.5792,6.9922,51,-1,-1,-1,-1,300);
	CreateDynamicMapIcon(2146.3467,2748.2893,10.5245,51,-1,-1,-1,-1,300);
	CreateDynamicMapIcon(-1327.5607,2677.4316,49.8093,51,-1,-1,-1,-1,300);
	CreateDynamicMapIcon(-2409.2200,976.2798,45.2969,51,-1,-1,-1,-1,300);
	CreateDynamicMapIcon(-1606.0544,-2714.3083,48.5335,51,-1,-1,-1,-1,300);
	CreateDynamicMapIcon(-91.3854,-1169.9175,2.4213,51,-1,-1,-1,-1,300);
	CreateDynamicMapIcon(660.4590,-565.0394,16.3359,51,-1,-1,-1,-1,300);
	CreateDynamicMapIcon(-1605.7156,-2714.4573,48.5335,51,-1,-1,-1,-1,300);
	CreateDynamicMapIcon(-1679.4595,412.5129,6.9973,51,-1,-1,-1,-1,300);
	CreateDynamicMapIcon(-1470.0050,1863.2375,32.3521,51,-1,-1,-1,-1,300);
	CreateDynamicMapIcon(-2244.1396,-2560.5833,31.9219,51,-1,-1,-1,-1,300);
	CreateDynamicMapIcon(1937.4293,-1773.1865,13.3828,51,-1,-1,-1,-1,300);
	CreateDynamicMapIcon(1383.4221,462.5385,20.15063,51,-1,-1,-1,-1,300);
	CreateDynamicMapIcon(1381.7206,459.1907,20.3452,51,-1,-1,-1,-1,300);
	CreateDynamicMapIcon(2244.0481,-1665.0153,15.0329,45,-1,-1,-1,-1,300);
	CreateDynamicMapIcon(2229.4822,-1721.3157,13.1301,54,-1,-1,-1,-1,300);
	CreateDynamicMapIcon(2127.5967,-1126.5481,25.2242,55,-1,-1,-1,-1,300);
 	CreateDynamicMapIcon(-1989.2740,287.7194,33.8505,55,-1,-1,-1,-1,300);
 	CreateDynamicMapIcon(-1639.8102,1215.5056,6.6629,55,-1,-1,-1,-1,300);
 	CreateDynamicMapIcon(-1831.4525,-172.1997,8.9311,55,-1,-1,-1,-1,300);
 	CreateDynamicMapIcon( 499.5259,2362.7202,29.9984,55,-1,-1,-1,-1,300);
 	CreateDynamicMapIcon(1756.0334,-1686.6527,13.1287,55,-1,-1,-1,-1,300);
 	CreateDynamicMapIcon(1732.8749,1863.8625,10.4050,55,-1,-1,-1,-1,300);
 	CreateDynamicMapIcon(407.8688,2528.2463,16.2651,36,-1,-1,-1,-1,300);
 	CreateDynamicMapIcon(1168.6616,1365.8048,10.5385,36,-1,-1,-1,-1,300);
 	CreateDynamicMapIcon(-2186.9304,2414.8867,5.1563,36,-1,-1,-1,-1,300);
 	CreateDynamicMapIcon(1978.1996,2043.6552,10.5437,55,-1,-1,-1,-1,300);
 	CreateDynamicMapIcon(550.0584,-1275.5981,16.0000,55,-1,-1,-1,-1,300);
 	CreateDynamicMapIcon(-23.7278,-2506.7014,36.3826,55,-1,-1,-1,-1,300);
 	CreateDynamicMapIcon(-2234.962,2418.6135,-0.304,55,-1,-1,-1,-1,300);
//==============================================================================
 	CreateDynamicMapIcon(822.6,-1590.3,13.5,7,-1,-1,-1,-1,300);
	CreateDynamicMapIcon(-2570.1,245.4,10.3,7,-1,-1,-1,-1,300);
	CreateDynamicMapIcon(2726.6,-2026.4,17.5,7,-1,-1,-1,-1,300);
	CreateDynamicMapIcon(2080.3,2119.0,10.8,7,-1,-1,-1,-1,300);
	CreateDynamicMapIcon(675.7,-496.6,16.8,7,-1,-1,-1,-1,300);
	CreateDynamicMapIcon(-1805.7,943.2,24.8,29,-1,-1,-1,-1,300);
	CreateDynamicMapIcon(2750.9,2470.9,11.0,29,-1,-1,-1,-1,300);
	CreateDynamicMapIcon(2351.8,2529.0,10.8,29,-1,-1,-1,-1,300);
	CreateDynamicMapIcon(2635.5,1847.4,11.0,29,-1,-1,-1,-1,300);
	CreateDynamicMapIcon(2083.4,2221.0,11.0,29,-1,-1,-1,-1,300);
	CreateDynamicMapIcon(-1719.1,1359.4,8.6,29,-1,-1,-1,-1,300);
	CreateDynamicMapIcon(2330.2,75.2,31.0,29,-1,-1,-1,-1,300);
	CreateDynamicMapIcon(203.2,-200.4,6.5,29,-1,-1,-1,-1,300);
	CreateDynamicMapIcon(812.9,-1616.1,13.6,10,-1,-1,-1,-1,300);
	CreateDynamicMapIcon(1199.1,-924.0,43.3,10,-1,-1,-1,-1,300);
	CreateDynamicMapIcon(2362.2,2069.9,10.8,10,-1,-1,-1,-1,300);
	CreateDynamicMapIcon(2469.5,2033.8,10.8,10,-1,-1,-1,-1,300);
	CreateDynamicMapIcon(2172.9,2795.7,10.8,10,-1,-1,-1,-1,300);
	CreateDynamicMapIcon(1875.3,2072.0,10.8,10,-1,-1,-1,-1,300);
	CreateDynamicMapIcon(1161.5,2072.0,10.8,10,-1,-1,-1,-1,300);
	CreateDynamicMapIcon(-2356.0,1009.0,49.0,10,-1,-1,-1,-1,300);
	CreateDynamicMapIcon(-1913.3,826.2,36.9,10,-1,-1,-1,-1,300);
	CreateDynamicMapIcon(-2335.6,-165.6,39.5,10,-1,-1,-1,-1,300);
	CreateDynamicMapIcon(2397.8,-1895.6,13.7,14,-1,-1,-1,-1,300);
	CreateDynamicMapIcon(2421.6,-1509.6,24.1,14,-1,-1,-1,-1,300);
	CreateDynamicMapIcon(-2671.6,257.4,4.6,14,-1,-1,-1,-1,300);
	CreateDynamicMapIcon(2392.4,2046.5,10.8,14,-1,-1,-1,-1,300);
	CreateDynamicMapIcon(2844.5,2401.1,11.0,14,-1,-1,-1,-1,300);
	CreateDynamicMapIcon(2635.5,1674.3,11.0,14,-1,-1,-1,-1,300);
	CreateDynamicMapIcon(2105.7,2228.7,11.0,14,-1,-1,-1,-1,300);
	CreateDynamicMapIcon(-2154.0,-2461.2,30.8,14,-1,-1,-1,-1,300);
	CreateDynamicMapIcon(-1816.2,620.8,37.5,14,-1,-1,-1,-1,300);
	CreateDynamicMapIcon(-1216.0,1831.4,45.3,14,-1,-1,-1,-1,300);
	CreateDynamicMapIcon(172.73,1176.76,13.7,14,-1,-1,-1,-1,300);
	CreateDynamicMapIcon(932.0,-1353.0,14.0,14,-1,-1,-1,-1,300);
	CreateDynamicMapIcon(1971.7,-2036.6,13.5,39,-1,-1,-1,-1,300);
	CreateDynamicMapIcon(2071.6,-1779.9,13.5,39,-1,-1,-1,-1,300);
	CreateDynamicMapIcon(2094.6,2119.0,10.8,39,-1,-1,-1,-1,300);
	CreateDynamicMapIcon(-2490.5,-40.1,39.3,39,-1,-1,-1,-1,300);
	CreateDynamicMapIcon(1372.9,-1278.8,12.5,6,-1,-1,-1,-1,300);
	CreateDynamicMapIcon(2400.5,-1978.4,13.5,6,-1,-1,-1,-1,300);
	CreateDynamicMapIcon(-2626.6,209.4,4.9,6,-1,-1,-1,-1,300);
	CreateDynamicMapIcon(2535.9,2083.5,10.8,6,-1,-1,-1,-1,300);
	CreateDynamicMapIcon(2156.5,943.2,10.8,6,-1,-1,-1,-1,300);
	CreateDynamicMapIcon(779.7,1874.3,4.9,6,-1,-1,-1,-1,300);
	CreateDynamicMapIcon(-2092.7,-2463.8,30.6,6,-1,-1,-1,-1,300);
	CreateDynamicMapIcon(240.0,-178.2,2.0,6,-1,-1,-1,-1,300);
	CreateDynamicMapIcon(-1509.4,2611.8,58.5,6,-1,-1,-1,-1,300);
	CreateDynamicMapIcon(-315.67,829.87,13.43,6,-1,-1,-1,-1,300);
	CreateDynamicMapIcon(2332.9,63.6,31.0,6,-1,-1,-1,-1,300);
//==============================================================================
	AddPlayerClass(268,1646.6692,-2327.8423,13.5469,352.2056,-1,-1,-1,-1,-1,-1);
	AddPlayerClass(269,1646.6692,-2327.8423,13.5469,352.2056,-1,-1,-1,-1,-1,-1);
	AddPlayerClass(270,1646.6692,-2327.8423,13.5469,352.2056,-1,-1,-1,-1,-1,-1);
	AddPlayerClass(272,1646.6692,-2327.8423,13.5469,352.2056,-1,-1,-1,-1,-1,-1);
	AddPlayerClass(280,1646.6692,-2327.8423,13.5469,352.2056,-1,-1,-1,-1,-1,-1);
	AddPlayerClass(281,1646.6692,-2327.8423,13.5469,352.2056,-1,-1,-1,-1,-1,-1);
	AddPlayerClass(284,1646.6692,-2327.8423,13.5469,352.2056,-1,-1,-1,-1,-1,-1);
	AddPlayerClass(286,1646.6692,-2327.8423,13.5469,352.2056,-1,-1,-1,-1,-1,-1);
	AddPlayerClass(255,1646.6692,-2327.8423,13.5469,352.2056,-1,-1,-1,-1,-1,-1);
	AddPlayerClass(256,1646.6692,-2327.8423,13.5469,352.2056,-1,-1,-1,-1,-1,-1);
	AddPlayerClass(257,1646.6692,-2327.8423,13.5469,352.2056,-1,-1,-1,-1,-1,-1);
	AddPlayerClass(258,1646.6692,-2327.8423,13.5469,352.2056,-1,-1,-1,-1,-1,-1);
	AddPlayerClass(259,1646.6692,-2327.8423,13.5469,352.2056,-1,-1,-1,-1,-1,-1);
	AddPlayerClass(260,1646.6692,-2327.8423,13.5469,352.2056,-1,-1,-1,-1,-1,-1);
	AddPlayerClass(261,1646.6692,-2327.8423,13.5469,352.2056,-1,-1,-1,-1,-1,-1);
	AddPlayerClass(262,1646.6692,-2327.8423,13.5469,352.2056,-1,-1,-1,-1,-1,-1);
	AddPlayerClass(263,1646.6692,-2327.8423,13.5469,352.2056,-1,-1,-1,-1,-1,-1);
	AddPlayerClass(264,1646.6692,-2327.8423,13.5469,352.2056,-1,-1,-1,-1,-1,-1);
	AddPlayerClass(1,1646.6692,-2327.8423,13.5469,352.2056,-1,-1,-1,-1,-1,-1);
	AddPlayerClass(2,1646.6692,-2327.8423,13.5469,352.2056,-1,-1,-1,-1,-1,-1);
	AddPlayerClass(290,1646.6692,-2327.8423,13.5469,352.2056,-1,-1,-1,-1,-1,-1);
	AddPlayerClass(291,1646.6692,-2327.8423,13.5469,352.2056,-1,-1,-1,-1,-1,-1);
	AddPlayerClass(292,1646.6692,-2327.8423,13.5469,352.2056,-1,-1,-1,-1,-1,-1);
	AddPlayerClass(293,1646.6692,-2327.8423,13.5469,352.2056,-1,-1,-1,-1,-1,-1);
	AddPlayerClass(295,1646.6692,-2327.8423,13.5469,352.2056,-1,-1,-1,-1,-1,-1);
	AddPlayerClass(297,1646.6692,-2327.8423,13.5469,352.2056,-1,-1,-1,-1,-1,-1);
	AddPlayerClass(298,1646.6692,-2327.8423,13.5469,352.2056,-1,-1,-1,-1,-1,-1);
    AddPlayerClass(299,1646.6692,-2327.8423,13.5469,352.2056,-1,-1,-1,-1,-1,-1);
	AddPlayerClass(277,1646.6692,-2327.8423,13.5469,352.2056,-1,-1,-1,-1,-1,-1);
	AddPlayerClass(278,1646.6692,-2327.8423,13.5469,352.2056,-1,-1,-1,-1,-1,-1);
	AddPlayerClass(279,1646.6692,-2327.8423,13.5469,352.2056,-1,-1,-1,-1,-1,-1);
	AddPlayerClass(47,1646.6692,-2327.8423,13.5469,352.2056,-1,-1,-1,-1,-1,-1);
	AddPlayerClass(48,1646.6692,-2327.8423,13.5469,352.2056,-1,-1,-1,-1,-1,-1);
	AddPlayerClass(49,1646.6692,-2327.8423,13.5469,352.2056,-1,-1,-1,-1,-1,-1);
	AddPlayerClass(50,1646.6692,-2327.8423,13.5469,352.2056,-1,-1,-1,-1,-1,-1);
	AddPlayerClass(51,1646.6692,-2327.8423,13.5469,352.2056,-1,-1,-1,-1,-1,-1);
	AddPlayerClass(52,1646.6692,-2327.8423,13.5469,352.2056,-1,-1,-1,-1,-1,-1);
	AddPlayerClass(53,1646.6692,-2327.8423,13.5469,352.2056,-1,-1,-1,-1,-1,-1);
	AddPlayerClass(54,1646.6692,-2327.8423,13.5469,352.2056,-1,-1,-1,-1,-1,-1);
	AddPlayerClass(55,1646.6692,-2327.8423,13.5469,352.2056,-1,-1,-1,-1,-1,-1);
	AddPlayerClass(56,1646.6692,-2327.8423,13.5469,352.2056,-1,-1,-1,-1,-1,-1);
	AddPlayerClass(57,1646.6692,-2327.8423,13.5469,352.2056,-1,-1,-1,-1,-1,-1);
	AddPlayerClass(58,1646.6692,-2327.8423,13.5469,352.2056,-1,-1,-1,-1,-1,-1);
	AddPlayerClass(59,1646.6692,-2327.8423,13.5469,352.2056,-1,-1,-1,-1,-1,-1);
	AddPlayerClass(60,1646.6692,-2327.8423,13.5469,352.2056,-1,-1,-1,-1,-1,-1);
	AddPlayerClass(62,1646.6692,-2327.8423,13.5469,352.2056,-1,-1,-1,-1,-1,-1);
	AddPlayerClass(63,1646.6692,-2327.8423,13.5469,352.2056,-1,-1,-1,-1,-1,-1);
	AddPlayerClass(64,1646.6692,-2327.8423,13.5469,352.2056,-1,-1,-1,-1,-1,-1);
	AddPlayerClass(66,1646.6692,-2327.8423,13.5469,352.2056,-1,-1,-1,-1,-1,-1);
	AddPlayerClass(67,1646.6692,-2327.8423,13.5469,352.2056,-1,-1,-1,-1,-1,-1);
	AddPlayerClass(68,1646.6692,-2327.8423,13.5469,352.2056,-1,-1,-1,-1,-1,-1);
	AddPlayerClass(69,1646.6692,-2327.8423,13.5469,352.2056,-1,-1,-1,-1,-1,-1);
	AddPlayerClass(70,1646.6692,-2327.8423,13.5469,352.2056,-1,-1,-1,-1,-1,-1);
	AddPlayerClass(71,1646.6692,-2327.8423,13.5469,352.2056,-1,-1,-1,-1,-1,-1);
	AddPlayerClass(72,1646.6692,-2327.8423,13.5469,352.2056,-1,-1,-1,-1,-1,-1);
	AddPlayerClass(73,1646.6692,-2327.8423,13.5469,352.2056,-1,-1,-1,-1,-1,-1);
	AddPlayerClass(75,1646.6692,-2327.8423,13.5469,352.2056,-1,-1,-1,-1,-1,-1);
	AddPlayerClass(76,1646.6692,-2327.8423,13.5469,352.2056,-1,-1,-1,-1,-1,-1);
	AddPlayerClass(78,1646.6692,-2327.8423,13.5469,352.2056,-1,-1,-1,-1,-1,-1);
	AddPlayerClass(79,1646.6692,-2327.8423,13.5469,352.2056,-1,-1,-1,-1,-1,-1);
	AddPlayerClass(80,1646.6692,-2327.8423,13.5469,352.2056,-1,-1,-1,-1,-1,-1);
	AddPlayerClass(81,1646.6692,-2327.8423,13.5469,352.2056,-1,-1,-1,-1,-1,-1);
	AddPlayerClass(82,1646.6692,-2327.8423,13.5469,352.2056,-1,-1,-1,-1,-1,-1);
	AddPlayerClass(83,1646.6692,-2327.8423,13.5469,352.2056,-1,-1,-1,-1,-1,-1);
	AddPlayerClass(84,1646.6692,-2327.8423,13.5469,352.2056,-1,-1,-1,-1,-1,-1);
	AddPlayerClass(85,1646.6692,-2327.8423,13.5469,352.2056,-1,-1,-1,-1,-1,-1);
	AddPlayerClass(87,1646.6692,-2327.8423,13.5469,352.2056,-1,-1,-1,-1,-1,-1);
	AddPlayerClass(88,1646.6692,-2327.8423,13.5469,352.2056,-1,-1,-1,-1,-1,-1);
	AddPlayerClass(89,1646.6692,-2327.8423,13.5469,352.2056,-1,-1,-1,-1,-1,-1);
	AddPlayerClass(91,1646.6692,-2327.8423,13.5469,352.2056,-1,-1,-1,-1,-1,-1);
	AddPlayerClass(92,1646.6692,-2327.8423,13.5469,352.2056,-1,-1,-1,-1,-1,-1);
	AddPlayerClass(93,1646.6692,-2327.8423,13.5469,352.2056,-1,-1,-1,-1,-1,-1);
	AddPlayerClass(95,1646.6692,-2327.8423,13.5469,352.2056,-1,-1,-1,-1,-1,-1);
	AddPlayerClass(96,1646.6692,-2327.8423,13.5469,352.2056,-1,-1,-1,-1,-1,-1);
	AddPlayerClass(97,1646.6692,-2327.8423,13.5469,352.2056,-1,-1,-1,-1,-1,-1);
	AddPlayerClass(98,1646.6692,-2327.8423,13.5469,352.2056,-1,-1,-1,-1,-1,-1);
	AddPlayerClass(99,1646.6692,-2327.8423,13.5469,352.2056,-1,-1,-1,-1,-1,-1);
	AddPlayerClass(100,1646.6692,-2327.8423,13.5469,352.2056,-1,-1,-1,-1,-1,-1);
	AddPlayerClass(101,1646.6692,-2327.8423,13.5469,352.2056,-1,-1,-1,-1,-1,-1);
	AddPlayerClass(104,1646.6692,-2327.8423,13.5469,352.2056,-1,-1,-1,-1,-1,-1);
	AddPlayerClass(107,1646.6692,-2327.8423,13.5469,352.2056,-1,-1,-1,-1,-1,-1);
	AddPlayerClass(108,1646.6692,-2327.8423,13.5469,352.2056,-1,-1,-1,-1,-1,-1);
	AddPlayerClass(109,1646.6692,-2327.8423,13.5469,352.2056,-1,-1,-1,-1,-1,-1);
	AddPlayerClass(110,1646.6692,-2327.8423,13.5469,352.2056,-1,-1,-1,-1,-1,-1);
	AddPlayerClass(111,1646.6692,-2327.8423,13.5469,352.2056,-1,-1,-1,-1,-1,-1);
	AddPlayerClass(112,1646.6692,-2327.8423,13.5469,352.2056,-1,-1,-1,-1,-1,-1);
	AddPlayerClass(113,1646.6692,-2327.8423,13.5469,352.2056,-1,-1,-1,-1,-1,-1);
	AddPlayerClass(117,1646.6692,-2327.8423,13.5469,352.2056,-1,-1,-1,-1,-1,-1);
	AddPlayerClass(118,1646.6692,-2327.8423,13.5469,352.2056,-1,-1,-1,-1,-1,-1);
	AddPlayerClass(121,1646.6692,-2327.8423,13.5469,352.2056,-1,-1,-1,-1,-1,-1);
	AddPlayerClass(122,1646.6692,-2327.8423,13.5469,352.2056,-1,-1,-1,-1,-1,-1);
	AddPlayerClass(123,1646.6692,-2327.8423,13.5469,352.2056,-1,-1,-1,-1,-1,-1);
	AddPlayerClass(127,1646.6692,-2327.8423,13.5469,352.2056,-1,-1,-1,-1,-1,-1);
	AddPlayerClass(128,1646.6692,-2327.8423,13.5469,352.2056,-1,-1,-1,-1,-1,-1);
	AddPlayerClass(129,1646.6692,-2327.8423,13.5469,352.2056,-1,-1,-1,-1,-1,-1);
	AddPlayerClass(131,1646.6692,-2327.8423,13.5469,352.2056,-1,-1,-1,-1,-1,-1);
	AddPlayerClass(133,1646.6692,-2327.8423,13.5469,352.2056,-1,-1,-1,-1,-1,-1);
	AddPlayerClass(134,1646.6692,-2327.8423,13.5469,352.2056,-1,-1,-1,-1,-1,-1);
	AddPlayerClass(135,1646.6692,-2327.8423,13.5469,352.2056,-1,-1,-1,-1,-1,-1);
	AddPlayerClass(136,1646.6692,-2327.8423,13.5469,352.2056,-1,-1,-1,-1,-1,-1);
	AddPlayerClass(137,1646.6692,-2327.8423,13.5469,352.2056,-1,-1,-1,-1,-1,-1);
	AddPlayerClass(138,1646.6692,-2327.8423,13.5469,352.2056,-1,-1,-1,-1,-1,-1);
	AddPlayerClass(139,1646.6692,-2327.8423,13.5469,352.2056,-1,-1,-1,-1,-1,-1);
	AddPlayerClass(140,1646.6692,-2327.8423,13.5469,352.2056,-1,-1,-1,-1,-1,-1);
	AddPlayerClass(141,1646.6692,-2327.8423,13.5469,352.2056,-1,-1,-1,-1,-1,-1);
	AddPlayerClass(142,1646.6692,-2327.8423,13.5469,352.2056,-1,-1,-1,-1,-1,-1);
	AddPlayerClass(143,1646.6692,-2327.8423,13.5469,352.2056,-1,-1,-1,-1,-1,-1);
	AddPlayerClass(144,1646.6692,-2327.8423,13.5469,352.2056,-1,-1,-1,-1,-1,-1);
	AddPlayerClass(145,1646.6692,-2327.8423,13.5469,352.2056,-1,-1,-1,-1,-1,-1);
	AddPlayerClass(146,1646.6692,-2327.8423,13.5469,352.2056,-1,-1,-1,-1,-1,-1);
	AddPlayerClass(147,1646.6692,-2327.8423,13.5469,352.2056,-1,-1,-1,-1,-1,-1);
	AddPlayerClass(148,1646.6692,-2327.8423,13.5469,352.2056,-1,-1,-1,-1,-1,-1);
	AddPlayerClass(150,1646.6692,-2327.8423,13.5469,352.2056,-1,-1,-1,-1,-1,-1);
	AddPlayerClass(151,1646.6692,-2327.8423,13.5469,352.2056,-1,-1,-1,-1,-1,-1);
	AddPlayerClass(152,1646.6692,-2327.8423,13.5469,352.2056,-1,-1,-1,-1,-1,-1);
	AddPlayerClass(153,1646.6692,-2327.8423,13.5469,352.2056,-1,-1,-1,-1,-1,-1);
	AddPlayerClass(154,1646.6692,-2327.8423,13.5469,352.2056,-1,-1,-1,-1,-1,-1);
	AddPlayerClass(155,1646.6692,-2327.8423,13.5469,352.2056,-1,-1,-1,-1,-1,-1);
	AddPlayerClass(156,1646.6692,-2327.8423,13.5469,352.2056,-1,-1,-1,-1,-1,-1);
	AddPlayerClass(157,1646.6692,-2327.8423,13.5469,352.2056,-1,-1,-1,-1,-1,-1);
	AddPlayerClass(158,1646.6692,-2327.8423,13.5469,352.2056,-1,-1,-1,-1,-1,-1);
	AddPlayerClass(159,1646.6692,-2327.8423,13.5469,352.2056,-1,-1,-1,-1,-1,-1);
	AddPlayerClass(160,1646.6692,-2327.8423,13.5469,352.2056,-1,-1,-1,-1,-1,-1);
	AddPlayerClass(161,1646.6692,-2327.8423,13.5469,352.2056,-1,-1,-1,-1,-1,-1);
	AddPlayerClass(162,1646.6692,-2327.8423,13.5469,352.2056,-1,-1,-1,-1,-1,-1);
	AddPlayerClass(166,1646.6692,-2327.8423,13.5469,352.2056,-1,-1,-1,-1,-1,-1);
	AddPlayerClass(167,1646.6692,-2327.8423,13.5469,352.2056,-1,-1,-1,-1,-1,-1);
	AddPlayerClass(168,1646.6692,-2327.8423,13.5469,352.2056,-1,-1,-1,-1,-1,-1);
	AddPlayerClass(169,1646.6692,-2327.8423,13.5469,352.2056,-1,-1,-1,-1,-1,-1);
	AddPlayerClass(170,1646.6692,-2327.8423,13.5469,352.2056,-1,-1,-1,-1,-1,-1);
	AddPlayerClass(171,1646.6692,-2327.8423,13.5469,352.2056,-1,-1,-1,-1,-1,-1);
	AddPlayerClass(172,1646.6692,-2327.8423,13.5469,352.2056,-1,-1,-1,-1,-1,-1);
	AddPlayerClass(173,1646.6692,-2327.8423,13.5469,352.2056,-1,-1,-1,-1,-1,-1);
	AddPlayerClass(174,1646.6692,-2327.8423,13.5469,352.2056,-1,-1,-1,-1,-1,-1);
	AddPlayerClass(175,1646.6692,-2327.8423,13.5469,352.2056,-1,-1,-1,-1,-1,-1);
	AddPlayerClass(176,1646.6692,-2327.8423,13.5469,352.2056,-1,-1,-1,-1,-1,-1);
	AddPlayerClass(177,1646.6692,-2327.8423,13.5469,352.2056,-1,-1,-1,-1,-1,-1);
	AddPlayerClass(178,1646.6692,-2327.8423,13.5469,352.2056,-1,-1,-1,-1,-1,-1);
	AddPlayerClass(179,1646.6692,-2327.8423,13.5469,352.2056,-1,-1,-1,-1,-1,-1);
	AddPlayerClass(180,1646.6692,-2327.8423,13.5469,352.2056,-1,-1,-1,-1,-1,-1);
	AddPlayerClass(181,1646.6692,-2327.8423,13.5469,352.2056,-1,-1,-1,-1,-1,-1);
	AddPlayerClass(182,1646.6692,-2327.8423,13.5469,352.2056,-1,-1,-1,-1,-1,-1);
	AddPlayerClass(183,1646.6692,-2327.8423,13.5469,352.2056,-1,-1,-1,-1,-1,-1);
	AddPlayerClass(184,1646.6692,-2327.8423,13.5469,352.2056,-1,-1,-1,-1,-1,-1);
	AddPlayerClass(185,1646.6692,-2327.8423,13.5469,352.2056,-1,-1,-1,-1,-1,-1);
	AddPlayerClass(186,1646.6692,-2327.8423,13.5469,352.2056,-1,-1,-1,-1,-1,-1);
	AddPlayerClass(187,1646.6692,-2327.8423,13.5469,352.2056,-1,-1,-1,-1,-1,-1);
	AddPlayerClass(188,1646.6692,-2327.8423,13.5469,352.2056,-1,-1,-1,-1,-1,-1);
	AddPlayerClass(189,1646.6692,-2327.8423,13.5469,352.2056,-1,-1,-1,-1,-1,-1);
	AddPlayerClass(190,1646.6692,-2327.8423,13.5469,352.2056,-1,-1,-1,-1,-1,-1);
	AddPlayerClass(191,1646.6692,-2327.8423,13.5469,352.2056,-1,-1,-1,-1,-1,-1);
	AddPlayerClass(192,1646.6692,-2327.8423,13.5469,352.2056,-1,-1,-1,-1,-1,-1);
	AddPlayerClass(193,1646.6692,-2327.8423,13.5469,352.2056,-1,-1,-1,-1,-1,-1);
	AddPlayerClass(194,1646.6692,-2327.8423,13.5469,352.2056,-1,-1,-1,-1,-1,-1);
	AddPlayerClass(195,1646.6692,-2327.8423,13.5469,352.2056,-1,-1,-1,-1,-1,-1);
	AddPlayerClass(196,1646.6692,-2327.8423,13.5469,352.2056,-1,-1,-1,-1,-1,-1);
	AddPlayerClass(197,1646.6692,-2327.8423,13.5469,352.2056,-1,-1,-1,-1,-1,-1);
	AddPlayerClass(198,1646.6692,-2327.8423,13.5469,352.2056,-1,-1,-1,-1,-1,-1);
	AddPlayerClass(199,1646.6692,-2327.8423,13.5469,352.2056,-1,-1,-1,-1,-1,-1);
	AddPlayerClass(200,1646.6692,-2327.8423,13.5469,352.2056,-1,-1,-1,-1,-1,-1);
	AddPlayerClass(201,1646.6692,-2327.8423,13.5469,352.2056,-1,-1,-1,-1,-1,-1);
	AddPlayerClass(202,1646.6692,-2327.8423,13.5469,352.2056,-1,-1,-1,-1,-1,-1);
	AddPlayerClass(203,1646.6692,-2327.8423,13.5469,352.2056,-1,-1,-1,-1,-1,-1);
	AddPlayerClass(204,1646.6692,-2327.8423,13.5469,352.2056,-1,-1,-1,-1,-1,-1);
	AddPlayerClass(205,1646.6692,-2327.8423,13.5469,352.2056,-1,-1,-1,-1,-1,-1);
	AddPlayerClass(206,1646.6692,-2327.8423,13.5469,352.2056,-1,-1,-1,-1,-1,-1);
	AddPlayerClass(207,1646.6692,-2327.8423,13.5469,352.2056,-1,-1,-1,-1,-1,-1);
	AddPlayerClass(209,1646.6692,-2327.8423,13.5469,352.2056,-1,-1,-1,-1,-1,-1);
	AddPlayerClass(210,1646.6692,-2327.8423,13.5469,352.2056,-1,-1,-1,-1,-1,-1);
	AddPlayerClass(211,1646.6692,-2327.8423,13.5469,352.2056,-1,-1,-1,-1,-1,-1);
	AddPlayerClass(212,1646.6692,-2327.8423,13.5469,352.2056,-1,-1,-1,-1,-1,-1);
	AddPlayerClass(213,1646.6692,-2327.8423,13.5469,352.2056,-1,-1,-1,-1,-1,-1);
	AddPlayerClass(214,1646.6692,-2327.8423,13.5469,352.2056,-1,-1,-1,-1,-1,-1);
	AddPlayerClass(215,1646.6692,-2327.8423,13.5469,352.2056,-1,-1,-1,-1,-1,-1);
	AddPlayerClass(216,1646.6692,-2327.8423,13.5469,352.2056,-1,-1,-1,-1,-1,-1);
	AddPlayerClass(217,1646.6692,-2327.8423,13.5469,352.2056,-1,-1,-1,-1,-1,-1);
	AddPlayerClass(218,1646.6692,-2327.8423,13.5469,352.2056,-1,-1,-1,-1,-1,-1);
	AddPlayerClass(219,1646.6692,-2327.8423,13.5469,352.2056,-1,-1,-1,-1,-1,-1);
	AddPlayerClass(220,1646.6692,-2327.8423,13.5469,352.2056,-1,-1,-1,-1,-1,-1);
	AddPlayerClass(221,1646.6692,-2327.8423,13.5469,352.2056,-1,-1,-1,-1,-1,-1);
	AddPlayerClass(222,1646.6692,-2327.8423,13.5469,352.2056,-1,-1,-1,-1,-1,-1);
	AddPlayerClass(223,1646.6692,-2327.8423,13.5469,352.2056,-1,-1,-1,-1,-1,-1);
	AddPlayerClass(224,1646.6692,-2327.8423,13.5469,352.2056,-1,-1,-1,-1,-1,-1);
	AddPlayerClass(225,1646.6692,-2327.8423,13.5469,352.2056,-1,-1,-1,-1,-1,-1);
	AddPlayerClass(226,1646.6692,-2327.8423,13.5469,352.2056,-1,-1,-1,-1,-1,-1);
	AddPlayerClass(227,1646.6692,-2327.8423,13.5469,352.2056,-1,-1,-1,-1,-1,-1);
	AddPlayerClass(229,1646.6692,-2327.8423,13.5469,352.2056,-1,-1,-1,-1,-1,-1);
	AddPlayerClass(230,1646.6692,-2327.8423,13.5469,352.2056,-1,-1,-1,-1,-1,-1);
	AddPlayerClass(231,1646.6692,-2327.8423,13.5469,352.2056,-1,-1,-1,-1,-1,-1);
	AddPlayerClass(232,1646.6692,-2327.8423,13.5469,352.2056,-1,-1,-1,-1,-1,-1);
	AddPlayerClass(233,1646.6692,-2327.8423,13.5469,352.2056,-1,-1,-1,-1,-1,-1);
	AddPlayerClass(234,1646.6692,-2327.8423,13.5469,352.2056,-1,-1,-1,-1,-1,-1);
	AddPlayerClass(235,1646.6692,-2327.8423,13.5469,352.2056,-1,-1,-1,-1,-1,-1);
	AddPlayerClass(236,1646.6692,-2327.8423,13.5469,352.2056,-1,-1,-1,-1,-1,-1);
	AddPlayerClass(237,1646.6692,-2327.8423,13.5469,352.2056,-1,-1,-1,-1,-1,-1);
	AddPlayerClass(238,1646.6692,-2327.8423,13.5469,352.2056,-1,-1,-1,-1,-1,-1);
	AddPlayerClass(239,1646.6692,-2327.8423,13.5469,352.2056,-1,-1,-1,-1,-1,-1);
	AddPlayerClass(240,1646.6692,-2327.8423,13.5469,352.2056,-1,-1,-1,-1,-1,-1);
	AddPlayerClass(241,1646.6692,-2327.8423,13.5469,352.2056,-1,-1,-1,-1,-1,-1);
	AddPlayerClass(242,1646.6692,-2327.8423,13.5469,352.2056,-1,-1,-1,-1,-1,-1);
	AddPlayerClass(243,1646.6692,-2327.8423,13.5469,352.2056,-1,-1,-1,-1,-1,-1);
	AddPlayerClass(244,1646.6692,-2327.8423,13.5469,352.2056,-1,-1,-1,-1,-1,-1);
	AddPlayerClass(245,1646.6692,-2327.8423,13.5469,352.2056,-1,-1,-1,-1,-1,-1);
	AddPlayerClass(246,1646.6692,-2327.8423,13.5469,352.2056,-1,-1,-1,-1,-1,-1);
	AddPlayerClass(249,1646.6692,-2327.8423,13.5469,352.2056,-1,-1,-1,-1,-1,-1);
	AddPlayerClass(250,1646.6692,-2327.8423,13.5469,352.2056,-1,-1,-1,-1,-1,-1);
	AddPlayerClass(251,1646.6692,-2327.8423,13.5469,352.2056,-1,-1,-1,-1,-1,-1);
	AddPlayerClass(253,1646.6692,-2327.8423,13.5469,352.2056,-1,-1,-1,-1,-1,-1);
//==============================================================================
	AddStaticVehicleEx(randVec[random(sizeof( randVec))],1933.7473,949.2192,10.3950,271.0862,13,13,7000);
	AddStaticVehicleEx(randVec[random(sizeof( randVec))],1879.6400,1179.8530,10.4849,180.5099,41,29,7000);
	AddStaticVehicleEx(randVec[random(sizeof( randVec))],1844.1685,1199.9709,10.9949,271.3335,41,41,7000);
	AddStaticVehicleEx(randVec[random(sizeof( randVec))],1665.2125,988.3992,10.8221,359.4476,113,36,7000);
	AddStaticVehicleEx(randVec[random(sizeof( randVec))],1633.8776,982.7350,10.8083,269.5782,37,107,7000);
	AddStaticVehicleEx(randVec[random(sizeof( randVec))],1668.1410,1039.4226,10.7314,178.2749,4,1,7000);
	AddStaticVehicleEx(randVec[random(sizeof( randVec))],1554.4259,1019.3704,10.5911,4.1406,36,1,7000);
	AddStaticVehicleEx(randVec[random(sizeof( randVec))],1425.0068,1048.2004,11.3934,90.1014,1,1,7000);
	AddStaticVehicleEx(randVec[random(sizeof( randVec))],1381.2629,969.6309,10.8961,275.4272,123,1,7000);
	AddStaticVehicleEx(randVec[random(sizeof( randVec))],1618.1036,583.1451,0.0027,181.9702,112,20,7000);
	AddStaticVehicleEx(randVec[random(sizeof( randVec))],1637.6469,583.0063,0.2442,178.7530,112,20,7000);
	AddStaticVehicleEx(randVec[random(sizeof( randVec))],1912.2084,698.6523,10.6865,91.0300,1,1,7000);
	AddStaticVehicleEx(randVec[random(sizeof( randVec))],1941.7010,708.3120,10.4758,179.4741,17,1,7000);
	AddStaticVehicleEx(randVec[random(sizeof( randVec))],2049.8433,734.6339,11.2017,358.1067,7,7,7000);
	AddStaticVehicleEx(randVec[random(sizeof( randVec))],2361.5261,726.0615,11.1392,358.6479,11,11,7000);
	AddStaticVehicleEx(randVec[random(sizeof( randVec))],2573.8772,746.0350,10.9863,182.2076,64,64,7000);
	AddStaticVehicleEx(randVec[random(sizeof( randVec))],2572.2505,720.6636,10.4160,0.9026,2,1,7000);
	AddStaticVehicleEx(randVec[random(sizeof( randVec))],2633.1143,728.4107,10.6075,270.4173,28,1,7000);
	AddStaticVehicleEx(randVec[random(sizeof( randVec))],2707.1887,835.9462,10.6369,359.9156,1,1,7000);
	AddStaticVehicleEx(randVec[random(sizeof( randVec))],2827.2024,1277.9709,10.5083,91.5705,12,1,7000);
	AddStaticVehicleEx(randVec[random(sizeof( randVec))],2805.2136,1354.9484,10.8260,272.3326,75,1,7000);
	AddStaticVehicleEx(randVec[random(sizeof( randVec))],2781.2798,1980.1521,10.8174,272.0248,15,15,7000);
	AddStaticVehicleEx(randVec[random(sizeof( randVec))],2868.6846,2424.0757,10.8221,226.5174,37,37,7000);
	AddStaticVehicleEx(randVec[random(sizeof( randVec))],2878.8928,2360.5830,10.4760,269.3630,21,1,7000);
	AddStaticVehicleEx(randVec[random(sizeof( randVec))],2827.5525,2368.3738,10.6412,89.8135,37,37,7000);
	AddStaticVehicleEx(randVec[random(sizeof( randVec))],2754.4534,2489.3059,10.6555,346.5354,3,6,7000);
	AddStaticVehicleEx(randVec[random(sizeof( randVec))],2593.0061,2275.4080,10.4581,270.7476,60,1,7000);
	AddStaticVehicleEx(randVec[random(sizeof( randVec))],2103.9006,2075.7358,10.6953,90.8892,40,1,7000);
	AddStaticVehicleEx(randVec[random(sizeof( randVec))],2070.2986,2040.1598,10.5857,183.0444,37,37,7000);
	AddStaticVehicleEx(randVec[random(sizeof( randVec))],2185.9387,2000.3730,10.4032,91.8105,116,1,7000);
	AddStaticVehicleEx(randVec[random(sizeof( randVec))],2088.0959,2206.6272,10.5810,174.9848,110,110,7000);
	AddStaticVehicleEx(randVec[random(sizeof( randVec))],2283.1360,2397.9351,10.6055,177.3161,36,1,7000);
	AddStaticVehicleEx(randVec[random(sizeof( randVec))],2401.5381,2310.2683,7.9570,359.6457,34,34,7000);
	AddStaticVehicleEx(randVec[random(sizeof( randVec))],2511.1343,2374.4714,10.5875,268.5397,92,1,7000);
	AddStaticVehicleEx(randVec[random(sizeof( randVec))],2487.6179,2551.7463,21.5128,347.5952,22,1,7000);
	AddStaticVehicleEx(randVec[random(sizeof( randVec))],2406.2834,2543.8398,21.4736,91.0200,3,1,7000);
	AddStaticVehicleEx(randVec[random(sizeof( randVec))],2406.6172,2540.9854,21.4717,84.3399,10,10,7000);
	AddStaticVehicleEx(randVec[random(sizeof( randVec))],2406.4841,2538.1829,21.4711,95.5858,12,12,7000);
	AddStaticVehicleEx(randVec[random(sizeof( randVec))],2359.9573,2567.6929,10.4161,272.5682,3,6,7000);
	AddStaticVehicleEx(randVec[random(sizeof( randVec))],2104.3684,2413.6033,10.7145,268.0009,4,1,7000);
	AddStaticVehicleEx(randVec[random(sizeof( randVec))],2068.5532,2407.7920,14.8727,90.7560,15,15,7000);
	AddStaticVehicleEx(randVec[random(sizeof( randVec))],2086.8467,2398.6973,14.8829,87.5306,10,10,7000);
	AddStaticVehicleEx(randVec[random(sizeof( randVec))],2078.7744,2401.8579,32.0624,90.3872,11,11,7000);
	AddStaticVehicleEx(randVec[random(sizeof( randVec))],1902.0305,2340.2280,10.9376,272.0597,119,119,7000);
	AddStaticVehicleEx(randVec[random(sizeof( randVec))],1964.6104,2263.3984,21.6058,358.8971,46,46,7000);
	AddStaticVehicleEx(randVec[random(sizeof( randVec))],1913.1425,2159.3816,10.4544,88.5365,24,1,7000);
	AddStaticVehicleEx(randVec[random(sizeof( randVec))],2155.1472,1867.9774,10.3070,359.6697,30,1,7000);
	AddStaticVehicleEx(randVec[random(sizeof( randVec))],2209.9329,1878.8024,10.7284,359.1025,97,96,7000);
	AddStaticVehicleEx(randVec[random(sizeof( randVec))],2191.2114,1800.1472,10.8692,181.1709,16,0,7000);
	AddStaticVehicleEx(randVec[random(sizeof( randVec))],2222.4583,1952.0540,31.4973,89.6415,46,46,7000);
	AddStaticVehicleEx(randVec[random(sizeof( randVec))],2449.3967,1991.3334,10.9044,178.6346,101,1,7000);
	AddStaticVehicleEx(randVec[random(sizeof( randVec))],2578.4866,1977.0854,10.6166,268.6755,41,29,7000);
	AddStaticVehicleEx(randVec[random(sizeof( randVec))],1512.2699,2258.1401,10.8672,359.3095,1,31,7000);
	AddStaticVehicleEx(randVec[random(sizeof( randVec))],1385.6652,2252.8999,10.4034,268.0454,53,1,7000);
	AddStaticVehicleEx(randVec[random(sizeof( randVec))],1298.0107,2085.4412,10.5653,269.6215,42,42,7000);
	AddStaticVehicleEx(randVec[random(sizeof( randVec))],1652.9469,2124.2402,10.6803,218.5212,3,3,7000);
	AddStaticVehicleEx(randVec[random(sizeof( randVec))],1613.4615,2220.6357,10.5699,89.6341,53,53,7000);
	AddStaticVehicleEx(randVec[random(sizeof( randVec))],1604.1533,2130.9858,11.1580,270.1462,53,53,7000);
	AddStaticVehicleEx(randVec[random(sizeof( randVec))],1509.6985,2084.8362,10.8936,90.2385,123,1,7000);
	AddStaticVehicleEx(randVec[random(sizeof( randVec))],1372.9529,1968.0880,11.3794,268.8760,61,61,7000);
	AddStaticVehicleEx(randVec[random(sizeof( randVec))],1859.7639,2031.5673,7.3262,86.7889,116,1,7000);
	AddStaticVehicleEx(randVec[random(sizeof( randVec))],1889.5774,1933.5256,7.3105,1.6931,125,125,7000);
	AddStaticVehicleEx(randVec[random(sizeof( randVec))],1931.8080,1761.4613,18.6231,0.4794,61,61,7000);
	AddStaticVehicleEx(randVec[random(sizeof( randVec))],1987.3032,1750.8423,18.6667,358.9502,112,1,7000);
	AddStaticVehicleEx(randVec[random(sizeof( randVec))],1568.5989,1894.0583,10.5981,359.4499,24,118,7000);
	AddStaticVehicleEx(randVec[random(sizeof( randVec))],1583.1244,1963.5934,10.6095,178.4924,28,1,7000);
	AddStaticVehicleEx(randVec[random(sizeof( randVec))],1687.0884,1915.9934,10.3973,262.6798,43,1,7000);
	AddStaticVehicleEx(randVec[random(sizeof( randVec))],1598.0459,1838.6763,10.9045,181.4901,123,1,7000);
	AddStaticVehicleEx(randVec[random(sizeof( randVec))],1605.3131,1851.4323,10.6808,181.6195,13,1,7000);
	AddStaticVehicleEx(randVec[random(sizeof( randVec))],1665.8552,1154.6335,10.6649,272.0782,53,53,7000);
	AddStaticVehicleEx(randVec[random(sizeof( randVec))],1692.1569,1316.5089,10.6132,181.0338,12,12,7000);
	AddStaticVehicleEx(randVec[random(sizeof( randVec))],1682.6193,1286.8591,10.6120,359.5006,2,2,7000);
	AddStaticVehicleEx(randVec[random(sizeof( randVec))],1672.9663,1287.1198,10.6762,178.5262,42,42,7000);
	AddStaticVehicleEx(randVec[random(sizeof( randVec))],1672.9675,1316.6228,10.4607,359.3459,17,1,7000);
	AddStaticVehicleEx(randVec[random(sizeof( randVec))],1641.4597,1299.0786,10.5878,88.7653,13,13,7000);
	AddStaticVehicleEx(randVec[random(sizeof( randVec))],2135.1169,987.5624,10.6119,180.7656,12,12,7000);
	AddStaticVehicleEx(randVec[random(sizeof( randVec))],2162.7100,1022.8547,10.9478,96.0288,119,119,7000);
	AddStaticVehicleEx(randVec[random(sizeof( randVec))],2200.9917,937.7636,10.8078,269.0280,24,112,7000);
	AddStaticVehicleEx(randVec[random(sizeof( randVec))],2393.9250,987.0667,10.4168,358.7879,42,42,7000);
	AddStaticVehicleEx(randVec[random(sizeof( randVec))],2491.9773,991.1074,10.5661,4.6930,90,90,7000);
	AddStaticVehicleEx(randVec[random(sizeof( randVec))],2460.8201,925.0990,10.7289,270.2138,93,64,7000);
	AddStaticVehicleEx(randVec[random(sizeof( randVec))],2491.8096,936.7916,10.4220,179.1399,53,53,7000);
	AddStaticVehicleEx(randVec[random(sizeof( randVec))],2636.6533,1076.1158,10.6643,86.7663,41,29,7000);
	AddStaticVehicleEx(randVec[random(sizeof( randVec))],2040.0554,1309.8300,10.5773,181.7683,113,1,7000);
	AddStaticVehicleEx(randVec[random(sizeof( randVec))],2039.3184,1488.7177,10.4202,180.4359,13,1,7000);
	AddStaticVehicleEx(randVec[random(sizeof( randVec))],2076.0657,1669.3798,10.2969,0.2352,58,8,7000);
	AddStaticVehicleEx(randVec[random(sizeof( randVec))],2040.0372,1664.9554,10.5288,179.9844,7,7,7000);
	AddStaticVehicleEx(randVec[random(sizeof( randVec))],2351.3953,1415.8734,35.3331,269.0942,112,1,7000);
	AddStaticVehicleEx(randVec[random(sizeof( randVec))],2302.8748,1455.1986,42.5878,268.8100,13,13,7000);
	AddStaticVehicleEx(randVec[random(sizeof( randVec))],2341.8777,1518.4885,42.3996,342.6307,37,1,7000);
	AddStaticVehicleEx(randVec[random(sizeof( randVec))],1942.8247,1361.0007,9.0324,179.3419,42,42,7000);
	AddStaticVehicleEx(randVec[random(sizeof( randVec))],1063.7784,1003.3749,10.5840,345.8102,7,7,7000);
	AddStaticVehicleEx(randVec[random(sizeof( randVec))],215.4972,2542.8821,17.9296,178.7355,3,90,7000);
	AddStaticVehicleEx(randVec[random(sizeof( randVec))],190.8062,2543.5435,17.9169,176.9427,4,90,7000);
	AddStaticVehicleEx(randVec[random(sizeof( randVec))],-290.1986,1317.2966,54.2817,82.9668,37,37,7000);
	AddStaticVehicleEx(randVec[random(sizeof( randVec))],-177.5699,1219.7926,19.7902,88.6779,1,31,7000);
	AddStaticVehicleEx(randVec[random(sizeof( randVec))],-84.4204,1221.9553,19.5197,0.3241,122,113,7000);
	AddStaticVehicleEx(randVec[random(sizeof( randVec))],45.7590,1178.0515,18.2478,93.8978,15,15,7000);
	AddStaticVehicleEx(randVec[random(sizeof( randVec))],-1.0860,1116.7876,19.6353,181.8415,90,96,7000);
	AddStaticVehicleEx(randVec[random(sizeof( randVec))],-83.7541,1077.5983,19.4084,170.8568,46,46,7000);
	AddStaticVehicleEx(randVec[random(sizeof( randVec))],-166.3417,1093.4547,19.6453,269.4803,53,53,7000);
	AddStaticVehicleEx(randVec[random(sizeof( randVec))],-247.8100,1058.7548,19.5176,270.0869,0,1,7000);
	AddStaticVehicleEx(randVec[random(sizeof( randVec))],-315.3624,1165.4788,19.6485,180.6319,93,64,7000);
	AddStaticVehicleEx(randVec[random(sizeof( randVec))],1972.0596,-1710.1375,15.8796,89.5876,24,1,7000);
	AddStaticVehicleEx(randVec[random(sizeof( randVec))],1837.6171,-1831.8480,13.7471,90.7201,48,48,7000);
	AddStaticVehicleEx(randVec[random(sizeof( randVec))],2807.0916,-2455.6167,13.6111,0.2423,0,0,7000);
	AddStaticVehicleEx(randVec[random(sizeof( randVec))],1938.1008,-2141.9185,13.5647,180.6419,96,25,7000);
	AddStaticVehicleEx(randVec[random(sizeof( randVec))],2150.3347,-1700.5493,15.0903,89.5363,101,25,7000);
	AddStaticVehicleEx(randVec[random(sizeof( randVec))],2297.3115,-1641.6460,14.7661,87.6743,15,15,7000);
	AddStaticVehicleEx(randVec[random(sizeof( randVec))],2478.9543,-1748.0833,13.4550,0.9652,99,81,7000);
	AddStaticVehicleEx(randVec[random(sizeof( randVec))],2657.8115,-1701.7416,9.3153,92.5552,37,37,7000);
	AddStaticVehicleEx(randVec[random(sizeof( randVec))],2692.1069,-1672.6614,9.1215,181.6508,9,39,7000);
	AddStaticVehicleEx(randVec[random(sizeof( randVec))],2796.4978,-1571.7622,10.5697,269.3196,74,8,7000);
	AddStaticVehicleEx(randVec[random(sizeof( randVec))],2809.2361,-1832.1379,9.5523,86.4388,117,1,7000);
	AddStaticVehicleEx(randVec[random(sizeof( randVec))],2863.5798,-1954.6375,10.7677,0.1072,53,53,7000);
	AddStaticVehicleEx(randVec[random(sizeof( randVec))],2789.4736,-1994.5270,13.1613,0.6415,24,118,7000);
	AddStaticVehicleEx(randVec[random(sizeof( randVec))],2684.7383,-1982.9592,13.4041,180.2627,93,64,7000);
	AddStaticVehicleEx(randVec[random(sizeof( randVec))],2802.7634,-1428.5120,20.3433,358.3627,108,108,7000);
	AddStaticVehicleEx(randVec[random(sizeof( randVec))],2664.0659,-1091.2067,69.2301,268.8888,99,81,7000);
	AddStaticVehicleEx(randVec[random(sizeof( randVec))],2659.7534,-1131.4335,65.4865,272.6761,1,5,7000);
	AddStaticVehicleEx(randVec[random(sizeof( randVec))],2678.8064,-1237.5902,55.5410,96.8868,6,6,7000);
	AddStaticVehicleEx(randVec[random(sizeof( randVec))],2757.9592,-1177.3027,69.2073,266.7634,15,15,7000);
	AddStaticVehicleEx(randVec[random(sizeof( randVec))],2505.5156,-1239.2402,36.3916,180.1342,45,92,7000);
	AddStaticVehicleEx(randVec[random(sizeof( randVec))],2357.8059,-1361.8973,23.8694,180.2655,17,1,7000);
	AddStaticVehicleEx(randVec[random(sizeof( randVec))],2390.6462,-1487.5004,23.3918,270.6916,35,1,7000);
	AddStaticVehicleEx(randVec[random(sizeof( randVec))],2196.2783,-1276.0974,24.3842,180.3141,9,39,7000);
	AddStaticVehicleEx(randVec[random(sizeof( randVec))],2216.6941,-1366.1135,23.8964,179.7005,97,96,7000);
	AddStaticVehicleEx(randVec[random(sizeof( randVec))],2148.4424,-1203.3536,23.4904,88.3811,40,1,7000);
	AddStaticVehicleEx(randVec[random(sizeof( randVec))],2148.1526,-1170.8549,23.5917,271.7717,122,113,7000);
	AddStaticVehicleEx(randVec[random(sizeof( randVec))],2228.1511,-1166.2961,25.7993,88.9630,16,0,7000);
	AddStaticVehicleEx(randVec[random(sizeof( randVec))],2327.0063,-1050.9269,52.1042,187.0041,75,1,7000);
	AddStaticVehicleEx(randVec[random(sizeof( randVec))],2270.8647,-1034.3649,51.5499,123.3642,97,96,7000);
	AddStaticVehicleEx(randVec[random(sizeof( randVec))],1997.8322,-1090.3406,24.1466,266.2220,1,1,7000);
	AddStaticVehicleEx(randVec[random(sizeof( randVec))],2062.1792,-1192.9938,23.5216,180.7986,7,7,7000);
	AddStaticVehicleEx(randVec[random(sizeof( randVec))],1910.5818,-1116.8087,25.5020,180.5684,39,39,7000);
	AddStaticVehicleEx(randVec[random(sizeof( randVec))],1996.2916,-1470.8112,13.0693,273.6034,62,62,7000);
	AddStaticVehicleEx(randVec[random(sizeof( randVec))],1922.9071,-1414.1719,13.0679,7.1217,6,6,7000);
	AddStaticVehicleEx(randVec[random(sizeof( randVec))],1572.9414,-1308.6868,17.1111,269.9504,53,53,7000);
	AddStaticVehicleEx(randVec[random(sizeof( randVec))],1499.7058,-1246.9164,14.1679,268.4184,13,13,7000);
	AddStaticVehicleEx(randVec[random(sizeof( randVec))],1473.9648,-1501.0992,13.5686,90.4675,11,11,7000);
	AddStaticVehicleEx(randVec[random(sizeof( randVec))],1503.2621,-1737.4407,13.2815,270.8260,90,90,7000);
	AddStaticVehicleEx(randVec[random(sizeof( randVec))],1361.3685,-1650.9573,13.2188,90.1711,47,47,7000);
	AddStaticVehicleEx(randVec[random(sizeof( randVec))],1191.4658,-1531.1211,13.2961,177.8073,41,29,7000);
	AddStaticVehicleEx(randVec[random(sizeof( randVec))],1145.9196,-1247.1692,14.9111,179.2147,122,113,7000);
	AddStaticVehicleEx(randVec[random(sizeof( randVec))],1246.2566,-1108.0243,25.0760,267.7855,42,42,7000);
	AddStaticVehicleEx(randVec[random(sizeof( randVec))],1247.4598,-1067.8854,28.9902,90.0537,25,1,7000);
	AddStaticVehicleEx(randVec[random(sizeof( randVec))],1191.6299,-1007.4591,32.2194,97.5065,46,46,7000);
	AddStaticVehicleEx(randVec[random(sizeof( randVec))],1190.6952,-1084.8616,28.8056,89.0331,14,14,7000);
	AddStaticVehicleEx(randVec[random(sizeof( randVec))],1146.7253,-1078.9056,28.1430,269.5490,13,118,7000);
	AddStaticVehicleEx(randVec[random(sizeof( randVec))],894.0931,-1518.4951,12.7089,179.4033,62,62,7000);
	AddStaticVehicleEx(randVec[random(sizeof( randVec))],782.1780,-1601.7968,13.0243,269.8525,35,1,7000);
	AddStaticVehicleEx(randVec[random(sizeof( randVec))],545.1813,-1509.9197,14.3235,1.1945,53,53,7000);
	AddStaticVehicleEx(randVec[random(sizeof( randVec))],439.5918,-1294.2716,15.2937,213.4597,62,62,7000);
	AddStaticVehicleEx(randVec[random(sizeof( randVec))],621.4239,-1255.6221,17.7834,186.6033,75,1,7000);
	AddStaticVehicleEx(randVec[random(sizeof( randVec))],440.7443,-1354.8929,14.5967,32.9557,25,1,7000);
	AddStaticVehicleEx(randVec[random(sizeof( randVec))],200.3813,-1444.6251,12.8306,139.3589,11,11,7000);
	AddStaticVehicleEx(randVec[random(sizeof( randVec))],423.2578,-1802.2577,5.1902,90.1100,84,96,7000);
	AddStaticVehicleEx(randVec[random(sizeof( randVec))],334.3509,-1789.1488,4.8617,359.2522,3,6,7000);
	AddStaticVehicleEx(randVec[random(sizeof( randVec))],324.5078,-1808.7347,4.3989,179.9792,99,81,7000);
	AddStaticVehicleEx(randVec[random(sizeof( randVec))],-92.8506,-1559.3331,2.2084,314.4424,3,1,7000);
	AddStaticVehicleEx(randVec[random(sizeof( randVec))],182.7401,-1291.2057,69.7113,359.4011,37,37,7000);
	AddStaticVehicleEx(randVec[random(sizeof( randVec))],249.2259,-1355.5809,52.7708,304.7867,112,1,7000);
	AddStaticVehicleEx(randVec[random(sizeof( randVec))],279.3775,-1265.2927,73.7339,305.2403,12,12,7000);
	AddStaticVehicleEx(randVec[random(sizeof( randVec))],251.2775,-1228.7406,74.2286,218.8206,3,1,7000);
	AddStaticVehicleEx(randVec[random(sizeof( randVec))],1362.4254,-1266.4696,13.3116,0.7702,62,62,7000);
	AddStaticVehicleEx(randVec[random(sizeof( randVec))],1476.9373,-1102.0942,23.3992,180.0034,52,39,7000);
	AddStaticVehicleEx(randVec[random(sizeof( randVec))],1590.3651,-1009.9333,23.7648,184.6722,62,62,7000);
	AddStaticVehicleEx(randVec[random(sizeof( randVec))],1662.0386,-1136.0973,23.6791,179.4146,110,110,7000);
	AddStaticVehicleEx(randVec[random(sizeof( randVec))],1712.3287,-1036.0176,24.0729,359.7810,41,41,7000);
	AddStaticVehicleEx(randVec[random(sizeof( randVec))],1173.2889,-914.4623,43.2030,184.5989,53,53,7000);
	AddStaticVehicleEx(randVec[random(sizeof( randVec))],1464.4934,-894.7592,55.2469,4.6464,119,119,7000);
	AddStaticVehicleEx(randVec[random(sizeof( randVec))],1028.6193,-810.1218,101.8433,21.1050,37,37,7000);
	AddStaticVehicleEx(randVec[random(sizeof( randVec))],858.0665,-825.6636,89.2454,204.7440,75,1,7000);
	AddStaticVehicleEx(randVec[random(sizeof( randVec))],273.5647,-1148.7874,80.5073,134.8065,37,37,7000);
	AddStaticVehicleEx(randVec[random(sizeof( randVec))],1438.0616,-2347.5278,13.1225,180.1092,101,1,7000);
	AddStaticVehicleEx(randVec[random(sizeof( randVec))],1560.3424,-2308.9202,13.6658,269.5758,108,108,7000);
	AddStaticVehicleEx(randVec[random(sizeof( randVec))],1549.5864,-2211.7385,13.6037,0.4468,1,31,7000);
	AddStaticVehicleEx(randVec[random(sizeof( randVec))],1745.0253,-2127.1816,13.4540,359.8481,93,64,7000);
	AddStaticVehicleEx(randVec[random(sizeof( randVec))],1724.8407,-2097.5671,13.4021,180.0313,15,15,7000);
	AddStaticVehicleEx(randVec[random(sizeof( randVec))],1549.5575,-2361.2617,13.4614,0.9716,36,1,7000);
	AddStaticVehicleEx(randVec[random(sizeof( randVec))],2112.2893,-2429.0752,14.9514,179.6798,27,97,7000);
	AddStaticVehicleEx(randVec[random(sizeof( randVec))],2015.8528,-2630.6826,14.7430,64.7717,1,1,7000);
	AddStaticVehicleEx(randVec[random(sizeof( randVec))],1823.0800,-2628.3459,14.9538,1.1075,3,90,7000);
	AddStaticVehicleEx(randVec[random(sizeof( randVec))],1365.3988,-2214.3618,13.6141,89.6270,75,1,7000);
	AddStaticVehicleEx(randVec[random(sizeof( randVec))],1238.6937,211.0751,19.1404,157.4593,7,7,7000);
	AddStaticVehicleEx(randVec[random(sizeof( randVec))],1228.3247,291.4643,19.5566,63.3223,97,25,7000);
	AddStaticVehicleEx(randVec[random(sizeof( randVec))],1332.6859,291.7187,19.2215,249.1730,46,46,7000);
	AddStaticVehicleEx(randVec[random(sizeof( randVec))],1389.4755,264.8127,19.3082,337.8669,24,118,7000);
	AddStaticVehicleEx(randVec[random(sizeof( randVec))],1399.6265,402.0626,19.5040,66.7561,0,1,7000);
	AddStaticVehicleEx(randVec[random(sizeof( randVec))],2469.3860,127.4987,26.1388,179.8219,21,1,7000);
	AddStaticVehicleEx(randVec[random(sizeof( randVec))],2497.4688,46.6235,26.2703,91.0502,75,1,7000);
	AddStaticVehicleEx(randVec[random(sizeof( randVec))],2567.3760,-6.9261,26.5530,4.9689,1,2,7000);
	AddStaticVehicleEx(randVec[random(sizeof( randVec))],2397.5437,-45.2744,26.6879,359.2568,33,0,7000);
	AddStaticVehicleEx(randVec[random(sizeof( randVec))],2380.9392,26.1394,27.0694,88.3819,40,1,7000);
	AddStaticVehicleEx(randVec[random(sizeof( randVec))],2409.4795,55.5849,26.8472,178.5209,20,1,7000);
	AddStaticVehicleEx(randVec[random(sizeof( randVec))],2339.5007,27.9453,26.3120,181.3531,53,53,7000);
	AddStaticVehicleEx(randVec[random(sizeof( randVec))],2290.4150,155.8123,27.0336,182.5226,114,1,7000);
	AddStaticVehicleEx(randVec[random(sizeof( randVec))],2210.1899,113.6663,26.9650,271.1395,45,45,7000);
	AddStaticVehicleEx(randVec[random(sizeof( randVec))],167.3658,-44.8291,1.5598,270.4458,37,107,7000);
	AddStaticVehicleEx(randVec[random(sizeof( randVec))],182.6690,-111.1162,1.0182,279.6544,26,1,7000);
	AddStaticVehicleEx(randVec[random(sizeof( randVec))],115.0002,-149.8465,1.6263,272.3596,1,31,7000);
	AddStaticVehicleEx(randVec[random(sizeof( randVec))],126.9119,-240.4353,1.5843,359.5949,96,25,7000);
	AddStaticVehicleEx(randVec[random(sizeof( randVec))],51.9982,-285.0762,2.2785,0.1043,1,1,7000);
	AddStaticVehicleEx(randVec[random(sizeof( randVec))],65.1134,-285.1273,2.1518,0.1696,1,1,7000);
	AddStaticVehicleEx(randVec[random(sizeof( randVec))],203.2595,-182.5264,1.1739,33.2222,3,6,7000);
	AddStaticVehicleEx(randVec[random(sizeof( randVec))],316.3455,-195.5372,1.4523,91.9877,13,1,7000);
	AddStaticVehicleEx(randVec[random(sizeof( randVec))],349.6386,-85.3251,1.0368,86.7004,46,46,7000);
	AddStaticVehicleEx(randVec[random(sizeof( randVec))],319.4078,-84.4339,1.9719,91.9459,37,0,7000);
	AddStaticVehicleEx(randVec[random(sizeof( randVec))],278.3414,-56.5755,1.5701,179.8493,10,10,7000);
	AddStaticVehicleEx(randVec[random(sizeof( randVec))],752.9799,277.7843,27.1707,188.0042,15,15,7000);
	AddStaticVehicleEx(randVec[random(sizeof( randVec))],2002.3630,-1275.3885,23.5713,0.1793,37,37,7000);
	AddStaticVehicleEx(randVec[random(sizeof( randVec))],2184.8931,-1258.8341,23.7640,79.2201,41,29,7000);
	AddStaticVehicleEx(randVec[random(sizeof( randVec))],2148.7693,-1189.7415,23.6926,270.1913,97,96,7000);
	AddStaticVehicleEx(randVec[random(sizeof( randVec))],2148.4668,-1143.3317,24.7419,269.0538,77,26,7000);
	AddStaticVehicleEx(randVec[random(sizeof( randVec))],1936.2124,-1596.9961,13.3193,177.8309,25,1,7000);
	AddStaticVehicleEx(randVec[random(sizeof( randVec))],1835.0287,-1832.4965,13.6759,91.5650,88,1,7000);
	AddStaticVehicleEx(randVec[random(sizeof( randVec))],1838.1370,-1871.0452,13.1270,0.0116,12,1,7000);
	AddStaticVehicleEx(randVec[random(sizeof( randVec))],1778.3640,-1903.7675,13.1629,273.6829,12,12,7000);
	AddStaticVehicleEx(randVec[random(sizeof( randVec))],2052.6128,-1904.4019,13.2722,178.8128,42,42,7000);
	AddStaticVehicleEx(randVec[random(sizeof( randVec))],2272.8032,-1906.8878,13.1979,0.3544,9,1,7000);
	AddStaticVehicleEx(randVec[random(sizeof( randVec))],2326.8401,-1948.1578,13.2498,90.9849,46,46,7000);
	AddStaticVehicleEx(randVec[random(sizeof( randVec))],2497.8315,-2022.8759,13.3580,358.8246,44,96,7000);
	AddStaticVehicleEx(randVec[random(sizeof( randVec))],1941.3153,-2142.5486,13.5408,179.6801,97,25,7000);
	AddStaticVehicleEx(randVec[random(sizeof( randVec))],1172.5,-1795.5,13.1,0.0,-1,-1,7000);
	AddStaticVehicleEx(randVec[random(sizeof( randVec))],1182.1,-1795.9,13.1,0.0,-1,-1,7000);
	AddStaticVehicleEx(randVec[random(sizeof( randVec))],-2102.5684,62.0034,35.3397,0.6222,113,1,7000);
    AddStaticVehicleEx(randVec[random(sizeof( randVec))],-2089.8113,-83.9018,34.8821,0.4661,125,125,7000);
    AddStaticVehicleEx(randVec[random(sizeof( randVec))],-2076.9238,-84.1402,35.0221,0.9090,42,42,7000);
    AddStaticVehicleEx(randVec[random(sizeof( randVec))],-2200.6074,75.3185,35.4458,89.0617,117,227,7000);
    AddStaticVehicleEx(randVec[random(sizeof( randVec))],-2265.5288,125.0820,35.2476,88.9068,123,1,7000);
    AddStaticVehicleEx(randVec[random(sizeof( randVec))],-2264.9924,204.4487,34.8351,90.1961,76,76,7000);
    AddStaticVehicleEx(randVec[random(sizeof( randVec))],-2265.4917,196.5683,34.9199,269.9381,53,53,7000);
    AddStaticVehicleEx(randVec[random(sizeof( randVec))],-2214.0950,306.3920,34.6872,180.1591,53,53,7000);
    AddStaticVehicleEx(randVec[random(sizeof( randVec))],-2515.8459,355.8087,34.8624,245.1416,66,1,7000);
    AddStaticVehicleEx(randVec[random(sizeof( randVec))],-2476.9080,413.2953,27.5472,318.5872,22,22,7000);
    AddStaticVehicleEx(randVec[random(sizeof( randVec))],-2585.9924,328.8984,4.8528,90.6867,101,25,7000);
    AddStaticVehicleEx(randVec[random(sizeof( randVec))],-2685.0078,267.8158,3.9414,0.2605,101,1,7000);
    AddStaticVehicleEx(randVec[random(sizeof( randVec))],-2691.7698,205.1006,4.1161,359.8282,31,1,7000);
    AddStaticVehicleEx(randVec[random(sizeof( randVec))],-2796.4805,196.8990,6.9761,88.1638,9,39,7000);
    AddStaticVehicleEx(randVec[random(sizeof( randVec))],-2754.4792,76.3173,6.9417,269.7805,92,1,7000);
    AddStaticVehicleEx(randVec[random(sizeof( randVec))],-2789.1880,-6.7858,6.7778,89.2736,31,93,7000);
    AddStaticVehicleEx(randVec[random(sizeof( randVec))],-2796.3660,-149.1670,7.0645,97.5699,13,1,7000);
    AddStaticVehicleEx(randVec[random(sizeof( randVec))],-2774.9185,-295.4905,6.8985,359.5875,62,62,7000);
    AddStaticVehicleEx(randVec[random(sizeof( randVec))],-2763.1572,-312.3184,6.7556,2.6547,36,36,7000);
    AddStaticVehicleEx(randVec[random(sizeof( randVec))],-2736.9114,-281.5465,6.6949,179.5579,41,29,7000);
    AddStaticVehicleEx(randVec[random(sizeof( randVec))],-2640.1516,-55.4312,4.0667,359.6426,80,1,7000);
    AddStaticVehicleEx(randVec[random(sizeof( randVec))],-2616.4072,-131.3259,4.1599,270.8042,41,41,7000);
    AddStaticVehicleEx(randVec[random(sizeof( randVec))],-2478.4260,-177.2738,25.2518,90.6125,36,8,7000);
    AddStaticVehicleEx(randVec[random(sizeof( randVec))],-2355.8210,-125.4361,35.3120,179.8700,111,31,7000);
    AddStaticVehicleEx(randVec[random(sizeof( randVec))],-2341.1118,-125.3512,35.1301,178.6833,45,45,7000);
    AddStaticVehicleEx(randVec[random(sizeof( randVec))],-2306.7358,-49.3554,34.8892,358.9100,79,1,7000);
    AddStaticVehicleEx(randVec[random(sizeof( randVec))],-2434.5730,93.7720,35.0355,359.2002,62,62,7000);
    AddStaticVehicleEx(randVec[random(sizeof( randVec))],-2399.5676,-589.5268,132.2912,124.3248,17,1,7000);
    AddStaticVehicleEx(randVec[random(sizeof( randVec))],-2124.9314,-775.5569,32.0217,270.1837,16,0,7000);
    AddStaticVehicleEx(randVec[random(sizeof( randVec))],-2148.8789,-814.9279,31.9333,270.3014,24,1,7000);
    AddStaticVehicleEx(randVec[random(sizeof( randVec))],-2133.7773,-866.1979,32.0087,89.1160,24,112,7000);
    AddStaticVehicleEx(randVec[random(sizeof( randVec))],-2125.1660,-950.2552,31.9769,273.3919,10,10,7000);
    AddStaticVehicleEx(randVec[random(sizeof( randVec))],-1872.2690,-900.1074,31.6625,269.8726,9,39,7000);
    AddStaticVehicleEx(randVec[random(sizeof( randVec))],-1886.7418,-954.5665,31.6179,90.4934,11,1,7000);
    AddStaticVehicleEx(randVec[random(sizeof( randVec))],-2193.9485,-419.9153,35.1106,312.3228,4,4,7000);
    AddStaticVehicleEx(randVec[random(sizeof( randVec))],-2157.8008,-455.6239,34.8814,277.7245,19,19,7000);
    AddStaticVehicleEx(randVec[random(sizeof( randVec))],-1834.2732,-16.6847,15.2773,265.5591,85,85,7000);
    AddStaticVehicleEx(randVec[random(sizeof( randVec))],-1649.4747,448.6677,7.2767,134.2515,40,1,7000);
    AddStaticVehicleEx(randVec[random(sizeof( randVec))],-1775.4452,762.8129,24.5993,82.2385,21,1,7000);
    AddStaticVehicleEx(randVec[random(sizeof( randVec))],-1706.7520,894.2825,24.9346,44.0204,10,10,7000);
    AddStaticVehicleEx(randVec[random(sizeof( randVec))],-1759.2092,955.8120,24.6410,86.6330,21,1,7000);
    AddStaticVehicleEx(randVec[random(sizeof( randVec))],-1761.6964,1095.8527,45.0166,270.9578,33,0,7000);
    AddStaticVehicleEx(randVec[random(sizeof( randVec))],-1786.7789,1206.0625,25.0074,169.9724,90,96,7000);
    AddStaticVehicleEx(randVec[random(sizeof( randVec))],-1877.1298,1070.0017,45.2184,359.0956,15,15,7000);
    AddStaticVehicleEx(randVec[random(sizeof( randVec))],-1964.9657,1185.7441,45.1415,95.8886,46,46,7000);
    AddStaticVehicleEx(randVec[random(sizeof( randVec))],-2085.6672,1139.6288,50.1221,179.8084,53,1,7000);
    AddStaticVehicleEx(randVec[random(sizeof( randVec))],-2114.6865,1246.5107,18.9960,26.4211,92,1,7000);
    AddStaticVehicleEx(randVec[random(sizeof( randVec))],-2371.7859,1295.2126,19.8453,181.0045,62,62,7000);
    AddStaticVehicleEx(randVec[random(sizeof( randVec))],-2401.0066,1131.1270,55.5005,164.2580,42,42,7000);
    AddStaticVehicleEx(randVec[random(sizeof( randVec))],-2567.8545,1147.6683,55.5109,159.0775,37,0,7000);
    AddStaticVehicleEx(randVec[random(sizeof( randVec))],-2626.8005,1377.7942,6.7728,178.7154,13,8,7000);
    AddStaticVehicleEx(randVec[random(sizeof( randVec))],-2645.1526,1344.7423,7.2899,269.2026,108,108,7000);
    AddStaticVehicleEx(randVec[random(sizeof( randVec))],-2877.6914,782.7867,34.7541,258.3813,62,62,7000);
    AddStaticVehicleEx(randVec[random(sizeof( randVec))],-2859.9917,680.3394,22.8922,294.4129,56,29,7000);
    AddStaticVehicleEx(randVec[random(sizeof( randVec))],-2545.6633,627.4894,14.2693,269.4256,39,39,7000);
    AddStaticVehicleEx(randVec[random(sizeof( randVec))],-2572.5474,647.6614,14.3608,270.3624,101,1,7000);
    AddStaticVehicleEx(randVec[random(sizeof( randVec))],-2670.9983,713.3991,27.6665,90.7792,13,118,7000);
    AddStaticVehicleEx(randVec[random(sizeof( randVec))],-2664.8000,913.3209,79.7970,181.3638,41,41,7000);
    AddStaticVehicleEx(randVec[random(sizeof( randVec))],-2586.0308,979.7228,77.8695,178.1336,10,10,7000);
    AddStaticVehicleEx(randVec[random(sizeof( randVec))],-2539.9355,938.8276,64.4205,269.7780,17,0,7000);
    AddStaticVehicleEx(randVec[random(sizeof( randVec))],-2408.3845,944.6786,45.0014,268.7538,7,7,7000);
    AddStaticVehicleEx(randVec[random(sizeof( randVec))],-2319.9839,991.0798,50.6874,90.7149,1,31,7000);
    AddStaticVehicleEx(randVec[random(sizeof( randVec))],-2248.5437,777.9184,49.2362,1.2035,95,1,7000);
    AddStaticVehicleEx(randVec[random(sizeof( randVec))],-2296.3301,723.3162,49.0909,270.1208,46,46,7000);
    AddStaticVehicleEx(randVec[random(sizeof( randVec))],-2134.6909,837.1762,69.5836,358.6565,101,1,7000);
    AddStaticVehicleEx(randVec[random(sizeof( randVec))],-2047.9559,771.6667,60.3879,93.7836,40,1,7000);
    AddStaticVehicleEx(randVec[random(sizeof( randVec))],-2107.9087,1013.6323,71.6341,358.1461,95,95,7000);
    AddStaticVehicleEx(randVec[random(sizeof( randVec))],-1799.1256,1293.1399,31.4422,357.0734,15,15,7000);
    AddStaticVehicleEx(randVec[random(sizeof( randVec))],-1829.4512,1289.4866,40.9989,19.5562,75,77,7000);
    AddStaticVehicleEx(randVec[random(sizeof( randVec))],-1822.3140,1311.1034,59.5926,186.3249,7,7,7000);
    AddStaticVehicleEx(randVec[random(sizeof( randVec))],-1557.9880,1261.5369,0.2798,267.2076,26,26,7000);
    AddStaticVehicleEx(randVec[random(sizeof( randVec))],-1490.1447,1001.6636,6.9577,89.9216,90,90,7000);
    AddStaticVehicleEx(randVec[random(sizeof( randVec))],-1463.0747,1023.2205,-0.3480,269.5969,1,22,7000);
    AddStaticVehicleEx(randVec[random(sizeof( randVec))],-1474.2643,1090.6489,-0.4221,89.5647,56,56,7000);
    AddStaticVehicleEx(randVec[random(sizeof( randVec))],-1904.4089,299.3538,40.8083,274.0902,92,1,7000);
    AddStaticVehicleEx(randVec[random(sizeof( randVec))],-1379.3826,-211.2748,15.5524,306.5851,7,68,7000);
    AddStaticVehicleEx(randVec[random(sizeof( randVec))],-1369.9886,-220.5197,5.8621,90.6711,37,37,7000);
    AddStaticVehicleEx(randVec[random(sizeof( randVec))],-1474.3687,-183.3825,5.8770,271.0188,30,1,7000);
    AddStaticVehicleEx(randVec[random(sizeof( randVec))],-1353.5331,-13.0777,6.1238,269.5897,119,119,7000);
    AddStaticVehicleEx(randVec[random(sizeof( randVec))],-1431.9883,41.9968,5.6360,0.5938,9,39,7000);
    AddStaticVehicleEx(randVec[random(sizeof( randVec))],-1184.7396,25.8315,14.3216,228.3719,-1,-1,7000);
    AddStaticVehicleEx(randVec[random(sizeof( randVec))],-1287.8268,5.7044,15.3619,136.7590,-1,-1,7000);
//==============================================================================
    AddStaticVehicleEx(403,1689.8835,2317.8638,11.4135,269.8633,0,0,1200);
 	AddStaticVehicleEx(403,1689.9127,2329.4316,11.4422,269.8634,0,0,1200);
	AddStaticVehicleEx(403,1689.9513,2345.5820,11.4135,269.8634,0,0,1200);
	AddStaticVehicleEx(403,1689.9780,2356.7107,11.3938,269.8634,0,0,1200);
 	AddStaticVehicleEx(403,1690.0057,2368.3911,11.3730,269.8634,0,0,1200);
	AddStaticVehicleEx(591,1681.1849,2317.3940,11.4272,270.1179,0,0,1200);
	AddStaticVehicleEx(591,1681.1609,2329.4038,11.4273,270.1179,0,0,1200);
	AddStaticVehicleEx(591,1681.1273,2345.6333,11.4274,270.1179,0,0,1200);
	AddStaticVehicleEx(591,1681.1041,2356.6460,11.4275,270.1179,0,0,1200);
	AddStaticVehicleEx(591,1681.0798,2368.3921,11.4276,270.1179,0,0,1200);
//==============================================================================
    DL1[0]=AddStaticVehicleEx(402,2126.3000,1409.3000,10.5280,2.5000,-1,-1,7000);
	DL1[1]=AddStaticVehicleEx(496,2123.0999,1398.3997,10.5229,359.7002,-1,-1,7000);
	DL1[2]=AddStaticVehicleEx(603,2129.5984,1397.5035,10.6662,180.3020,-1,-1,7000);
	DL1[3]=AddStaticVehicleEx(480,2136.0000,1398.5000,10.6000,0.1000,-1,-1,7000);
	DL1[4]=AddStaticVehicleEx(587,2142.1001,1397.5000,10.4741,180.3000,-1,-1,7000);
	DL1[5]=AddStaticVehicleEx(421,2135.8003,1408.0051,10.7356,179.1111,-1,-1,7000);
	DL2[0]=AddStaticVehicleEx(475,2135.5796,-1138.0618,25.3601,89.4336,-1,-1,7000);
	DL2[1]=AddStaticVehicleEx(567,2135.3000,-1145.5000,24.6000,89.0000,-1,-1,7000);
	DL2[2]=AddStaticVehicleEx(535,2118.8523,-1145.0802,24.3838,268.4513,-1,-1,7000);
	DL2[3]=AddStaticVehicleEx(542,2119.9922,-1137.9222,24.8618,266.6711,-1,-1,7000);
	DL2[4]=AddStaticVehicleEx(439,2120.5798,-1127.0013,25.3031,254.3232,-1,-1,7000);
	DL2[5]=AddStaticVehicleEx(422,2135.5000,-1130.5000,25.6000,80.5000,-1,-1,7000);
	DL3[0]=AddStaticVehicleEx(411,-1988.9985,248.1000,34.8254,89.0000,-1,-1,7000);
	DL3[1]=AddStaticVehicleEx(429,-1988.4021,256.7447,34.8759,88.5362,-1,-1,7000);
	DL3[2]=AddStaticVehicleEx(562,-1986.0251,273.0963,34.8517,92.4527,-1,-1,7000);
	DL3[3]=AddStaticVehicleEx(560,-1953.9008,295.1998,35.1634,111.5000,9,39,7000);
	DL3[4]=AddStaticVehicleEx(541,-1987.0933,264.3595,34.8140,87.4178,-1,-1,7000);
	DL4[0]=AddStaticVehicleEx(411,-1659.8215,1208.2151,20.8683,309.8704,-1,-1,7000);
	DL4[1]=AddStaticVehicleEx(477,-1664.7980,1222.7976,20.9119,224.8007,-1,-1,7000);
	DL4[2]=AddStaticVehicleEx(506,-1649.0021,1207.5004,20.8575,55.3994,-1,-1,7000);
	DL4[3]=AddStaticVehicleEx(451,-1653.0452,1212.0088,13.3764,359.6208,-1,-1,7000);
	DL4[4]=AddStaticVehicleEx(541,-1661.3716,1213.5186,13.3054,346.1439,-1,-1,7000);
	DL5[0]=AddStaticVehicleEx(510,-1817.0054,-161.6000,8.9923,90.0000,-1,-1,7000);
	DL5[1]=AddStaticVehicleEx(461,-1817.5000,-158.6000,8.7653,91.0000,-1,-1,7000);
	DL5[2]=AddStaticVehicleEx(481,-1817.4165,-166.3014,8.9098,95.0000,-1,-1,7000);
	DL5[3]=AddStaticVehicleEx(463,-1822.4000,-150.4947,8.9635,180.0000,-1,-1,7000);
	DL5[4]=AddStaticVehicleEx(586,-1818.5000,-184.5993,8.9117,358.6000,-1,-1,7000);
	DL6[0]=AddStaticVehicleEx(566,1785.8000,-1690.8000,13.1000,185.5000,-1,-1,7000);
	DL6[1]=AddStaticVehicleEx(534,1780.5000,-1690.5000,13.0280,183.8000,-1,-1,7000);
	DL6[2]=AddStaticVehicleEx(536,1774.0000,-1691.0000,13.1000,181.3000,-1,-1,7000);
	DL6[3]=AddStaticVehicleEx(576,1781.3000,-1702.9005,13.0219,2.7000,-1,-1,7000);
	DL6[4]=AddStaticVehicleEx(567,1774.5000,-1702.0000,13.3000,0.6000,-1,-1,7000);
	DL6[5]=AddStaticVehicleEx(575,1789.8972,-1690.4012,13.0769,183.8013,-1,-1,7000);
	DL7[0]=AddStaticVehicleEx(579,503.4403,2383.6304,29.8991,135.3581,-1,-1,7000);
	DL7[1]=AddStaticVehicleEx(505,509.6976,2379.7998,30.1247,135.5040,-1,-1,7000);
	DL7[2]=AddStaticVehicleEx(483,517.7013,2375.3062,30.1969,137.2996,-1,-1,7000);
	DL7[3]=AddStaticVehicleEx(586,524.7000,2370.6001,29.6280,132.5000,-1,-1,7000);
	DL7[4]=AddStaticVehicleEx(508,529.7150,2365.5566,30.8935,138.5450,-1,-1,7000);
	DL7[5]=AddStaticVehicleEx(424,497.7000,2388.5000,29.2000,133.5000,-1,-1,7000);
	DL8[0]=AddStaticVehicleEx(419,1730.9000,1926.0000,10.5280,90.5000,-1,-1,7000);
	DL8[1]=AddStaticVehicleEx(545,1731.6000,1919.8000,10.5280,89.3000,-1,-1,7000);
	DL8[2]=AddStaticVehicleEx(475,1731.4000,1913.1000,10.5280,89.8000,-1,-1,7000);
	DL8[3]=AddStaticVehicleEx(551,1730.9000,1906.4000,10.5280,89.9000,-1,-1,7000);
	DL8[4]=AddStaticVehicleEx(565,1731.4908,1899.4000,10.5070,90.6000,-1,-1,7000);
	DL8[5]=AddStaticVehicleEx(492,1730.8002,1932.0009,10.6137,88.8000,-1,-1,7000);
	DL9[0]=AddStaticVehicleEx(580,1993.3000,2042.6000,10.6000,90.8000,67,67,7000);
	DL9[1]=AddStaticVehicleEx(405,1993.0000,2049.3000,10.6000,90.5000,36,1,7000);
	DL9[2]=AddStaticVehicleEx(471,1993.2577,2057.3511,10.2960,143.5192,103,111,7000);
	DL9[3]=AddStaticVehicleEx(533,1987.9000,2058.8000,10.4875,178.6000,74,1,7000);
	DL9[4]=AddStaticVehicleEx(589,1982.0000,2058.6001,10.4089,181.3000,31,31,7000);
	DL9[5]=AddStaticVehicleEx(559,1993.5992,2035.5970,10.3544,89.2965,58,8,7000);
	DL10[0]=AddStaticVehicleEx(445,552.5000,-1290.0000,17.1000,359.5988,35,35,7000);
	DL10[1]=AddStaticVehicleEx(415,542.7000,-1291.0000,16.9653,359.6933,40,1,7000);
	DL10[2]=AddStaticVehicleEx(491,533.7029,-1290.5002,16.9965,1.6925,71,72,7000);
	DL10[3]=AddStaticVehicleEx(555,524.7000,-1291.1000,16.7577,1.9938,58,1,7000);
	DL10[4]=AddStaticVehicleEx(482,535.5000,-1274.8000,17.2000,307.8173,71,71,7000);
	DL10[5]=AddStaticVehicleEx(561,562.2000,-1290.5000,16.9595,359.7000,8,17,7000);
	DL11[0]=AddStaticVehicleEx(579,-33.6822,-2495.0906,36.6158,214.3033,11,11,7000);
	DL11[1]=AddStaticVehicleEx(458,-22.2000,-2495.1001,36.5000,122.4015,25,1,7000);
	DL11[2]=AddStaticVehicleEx(426,-18.5012,-2500.8008,36.3778,122.0000,7,7,7000);
	DL11[3]=AddStaticVehicleEx(475,-13.1007,-2509.3027,36.4097,121.9973,17,1,7000);
	DL11[4]=AddStaticVehicleEx(558,-16.6956,-2521.0957,36.2917,29.2039,24,1,7000);
	DL11[5]=AddStaticVehicleEx(483,-39.2000,-2498.8000,36.4795,214.6000,0,6,7000);
	DL12[0]=AddStaticVehicle(452,-2237.6497,2406.7654,-0.4221,322.7038,1,5);
	DL12[1]=AddStaticVehicle(453,-2219.3940,2425.6021,-0.3008,319.4943,56,56);
	DL12[2]=AddStaticVehicle(454,-2224.4961,2436.4277,0.0603,325.1469,26,26);
	DL12[3]=AddStaticVehicle(472,-2246.2864,2417.1292,-0.1454,310.6385,56,15);
	DL12[4]=AddStaticVehicle(493,-2199.8054,2420.6067,0.0387,37.5209,36,13);
	sk[0]=AddStaticVehicleEx(495,-1475.6338,-609.8226,1057.3993,108.8411,101,106,7000);
	sk[1]=AddStaticVehicleEx(495,-1482.9836,-613.0592,1057.1184,121.1785,88,99,7000);
	sk[2]=AddStaticVehicleEx(495,-1490.0323,-616.9849,1057.5839,134.3937,123,124,7000);
	sk[3]=AddStaticVehicleEx(495,-1493.5482,-624.6669,1057.2692,167.6800,5,6,7000);
	br[0]=AddStaticVehicleEx(504,-1362.4677,931.9797,1036.1553,5.2547,57,38,7000);
	br[1]=AddStaticVehicleEx(504,-1355.7494,932.7526,1036.1659,7.9765,45,29,7000);
	br[2]=AddStaticVehicleEx(504,-1347.9845,933.2904,1036.1665,9.7506,34,9,7000);
	br[3]=AddStaticVehicleEx(504,-1340.5938,935.0083,1036.1803,14.4369,65,9,7000);
	br[4]=AddStaticVehicleEx(504,-1333.3375,937.0743,1036.2063,15.9782,14,1,7000);
	br[5]=AddStaticVehicleEx(504,-1489.6584,949.4990,1036.6302,329.6139,12,9,7000);
	br[6]=AddStaticVehicleEx(504,-1493.9797,952.7529,1036.6815,327.0351,26,1,7000);
	br[7]=AddStaticVehicleEx(504,-1497.7964,955.5482,1036.7438,320.8500,51,39,7000);
	br[8]=AddStaticVehicleEx(504,-1501.4036,958.0691,1036.7959,320.5081,57,38,7000);
	br[9]=AddStaticVehicleEx(504,-1505.0313,960.9451,1036.8516,311.6219,45,29,7000);
    RPCars[0]=AddStaticVehicleEx(507,2422.4243,1110.9246,10.5693,179.5205,-1,-1,7000);
	RPCars[1]=AddStaticVehicleEx(400,2422.5022,1105.1083,10.8342,179.5020,-1,-1,7000);
	RPCars[2]=AddStaticVehicleEx(405,2422.5417,1116.9604,10.5706,179.8426,-1,-1,7000);
//==============================================================================
	/*
	Syntax for CreateProperty:CreateProperty(Float:x,Float:y,Float:z,Cost);
	Syntax for CreateBusiness:CreateBusiness(name[32],Float:x,Float:y,Float:z,interior,Cost,Profit);
 	Syntax for CreateOrganization: CreateOrganization(name[40],skin,skin1,lsk,Float:x,Float:y,Float:z,interior,wp1=0,a1=0,wp2=0,a2=0,color,Type)
  	Syntax for CreateOrgVehicle: CreateOrgVehicle(orgname[40],modelid,Float:x,Float:y,Float:z,Float:rotation,color1,color2)
   	Syntax for CreateOrganizationZone: CreateOrganizationZone(orgname[40],Float:minx,Float:miny,Float:maxx,Float:maxy,color)
    */
//==============================================================================
	CreateBusiness("The Pig Pen",2424.531982,-1220.734619,25.456348,0,420000,180);
	CreateBusiness("Liquor",2353.027343,-1371.973754,24.398437,0,120000,190);
	CreateBusiness("Cluckin' Bell",2420.292968,-1506.180908,24.000000,0,590000,250);
	CreateBusiness("Ten Green Bottles",508.182434,-79.591735,998.960937,11,760000,290);
	CreateBusiness("Los Santos Binco",2241.514404,-1664.240844,15.476562,0,250000,310);
	CreateBusiness("Los Santos Gym",770.643310,9.568116,1000.706726,5,800000,320);
	CreateBusiness("LS Tatto Shop",2069.955810,-1777.891845,13.558954,0,90000,120);
	CreateBusiness("Reeces",2072.311035,-1796.527099,13.546875,0,90000,120);
	CreateBusiness("The Well Stacked Pizza",2103.484130,-1810.370727,13.554687,0,320000,220);
	CreateBusiness("LS Tatto Shop",1975.313598,-2039.772094,13.546875,0,90000,120);
	CreateBusiness("Alhambra Night Club",1834.820800,-1689.137084,13.415534,0,1200000,350);
	CreateBusiness("Los Santos Binco",1459.217163,-1137.085205,24.015441,0,250000,310);
	CreateBusiness("Burger Shot",812.471679,-1625.189331,13.546875,0,320000,220);
	CreateBusiness("LS Barber Salon",826.897155,-1593.380249,13.554450,0,90000,120);
	CreateBusiness("Los Santos Binco",497.547149,-1358.888183,16.576969,0,250000,310);
	CreateBusiness("Los Santos Victim",458.605468,-1504.178344,31.018217,0,250000,310);
	CreateBusiness("LS Barber Shop",2721.609863,-2029.845947,13.547199,0,90000,120);
	CreateBusiness("Cluckin' Bell",2399.157714,-1897.863769,13.546875,0,320000,220);
	CreateBusiness("The Well Stacked Pizza",2335.609863,78.330337,26.482410,0,320000,220);
	CreateBusiness("Inside Track",1289.275634,267.011047,19.554687,0,800000,350);
	CreateBusiness("LS Barber Shop",673.951293,-500.438751,16.335937,0,90000,120);
	CreateBusiness("The Well Stacked Pizza",205.355575,-203.410049,1.578125,0,320000,220);
	CreateBusiness("Burger Shot",1208.414062,-919.424865,43.051540,0,390000,240);
	CreateBusiness("Cluckin' Bell",925.872558,-1354.145019,13.377613,0,390000,240);
	CreateBusiness("Jim's Sticky Ring",1036.844970,-1338.054687,13.726562,0,600000,300);
	CreateBusiness("The Four Dragon's Casino",1994.626342,1018.057495,994.890625,10,2600000,490);
	CreateBusiness("Come-A-Lot",2184.162597,1116.525634,12.648437,0,1500000,270);
	CreateBusiness("The Royal Casino",2088.726562,1451.923828,10.820312,0,900000,350);
	CreateBusiness("Sex Shop",-104.918121,-8.145134,1000.718750,3,500000,350);
	CreateBusiness("LV Tatto Shop",2093.411865,2120.928222,10.820312,0,190000,250);
	CreateBusiness("LV Boutique",2075.298339,2120.731445,10.812517,0,290000,260);
	CreateBusiness("The Well Stacked Pizza",2081.346923,2222.993652,10.820312,0,620000,280);
	CreateBusiness("LV Binco",2103.096435,2259.786376,11.023437,0,260000,190);
	CreateBusiness("Las Venturas Gym",1964.094970,2294.764404,16.455863,0,706000,220);
	CreateBusiness("Las Venturas Gym",1877.709472,2073.282714,11.062500,0,706000,220);
	CreateBusiness("LV Burger Shot",1878.315185,2074.061035,11.062500,0,706000,220);
	CreateBusiness("LV Burger Shot",1162.201171,2071.968750,11.062500,0,706000,220);
	CreateBusiness("San Andreas Oil Factory",238.442474,1423.024047,10.585937,0,3100000,550);
	CreateBusiness("Cluckin' Bell",175.784866,1173.064331,14.757812,0,706000,220);
	CreateBusiness("Nude Strippers Daily",2544.825683,1023.210876,10.820312,0,706000,220);
	CreateBusiness("Cluckin' Bell",2636.466308,1669.101806,11.023437,0,706000,220);
	CreateBusiness("The Well Stacked Pizza",2635.994873,1849.276733,11.023437,0,706000,290);
	CreateBusiness("Burger Shot",2467.393066,2032.935668,11.062500,0,706000,220);
	CreateBusiness("The Craw Bar",2438.484130,2063.623779,10.820312,0,706000,220);
	CreateBusiness("Cluckin' Bell",2391.375244,2042.667236,10.820312,0,706000,220);
	CreateBusiness("Burger Shot",2366.322509,2072.795410,10.820312,0,706000,220);
	CreateBusiness("Cobra Gym",-2268.105957,-154.151657,35.320312,0,900000,350);
	CreateBusiness("Burger Shot",-2329.723144,-165.664108,35.554687,0,650000,250);
	CreateBusiness("SF Tattoo Shop",-2492.838867,-42.196594,25.749746,0,150000,120);
	CreateBusiness("Urban Clothes",-2493.373779,-25.927684,25.765625,0,350000,220);
	CreateBusiness("Barber Pole",-2569.656250,246.785186,10.290096,0,150000,120);
	CreateBusiness("Cluckin' Bell",-2674.651367,262.927673,4.632812,0,650000,250);
	CreateBusiness("Supa Save",-2444.153320,752.562255,35.178627,0,390000,320);
	CreateBusiness("SF Binco",-2376.242919,912.653015,45.445312,0,350000,220);
	CreateBusiness("Cluckin' Bell",-2355.145263,1003.017150,50.898437,0,650000,250);
	CreateBusiness("Burger Shot",-1908.131225,826.347839,35.171875,0,650000,290);
	CreateBusiness("SF ZIP",-1882.318969,863.333435,35.171875,0,350000,220);
	CreateBusiness("The Well Stacked Pizza",-1805.530761,946.118225,24.890625,0,650000,290);
	CreateBusiness("The Well Stacked Pizza",-1721.931396,1361.942871,7.187500,0,650000,290);
//==============================================================================
	CreateProperty(-2027.731201,-42.946727,38.804687,80000);
	CreateProperty(-2424.633789,337.134277,37.001972,100000);
	CreateProperty(-2620.750732,121.075111,7.203125,50000);
	CreateProperty(-2623.049316,131.621276,7.203125,50000);
	CreateProperty(-2620.650634,96.782325,5.000000,60000);
	CreateProperty(-2667.933349,-5.402149,6.132812,100000);
	CreateProperty(-2620.711914,-134.667068,5.000000,50000);
	CreateProperty(-2456.222900,-133.541152,26.087228,500000);
	CreateProperty(-2720.034667,-318.294311,7.843750,100000);
	CreateProperty(-2792.006835,-145.994262,7.859375,50000);
	CreateProperty(-2787.108642,-175.389694,10.062500,60000);
	CreateProperty(-2786.758789,-89.759346,10.062500,70000);
	CreateProperty(-2793.313476,21.335821,7.187500,70000);
	CreateProperty(-2790.473144,7.266133,7.195312,70000);
	CreateProperty(-2791.893066,77.595657,10.054687,80000);
	CreateProperty(-2791.897460,103.594848,10.054687,80000);
	CreateProperty(-2789.221679,183.789184,10.062500,80000);
	CreateProperty(-2791.876953,212.073104,10.054687,80000);
	CreateProperty(-2099.491943,900.729003,76.710937,200000);
	CreateProperty(-2462.788574,132.439102,35.171875,150000);
	CreateProperty(-2701.450927,818.854248,49.984375,180000);
	CreateProperty(-2583.778808,896.475891,64.984375,50000);
	CreateProperty(-2511.144042,967.630249,73.535873,70000);
	CreateProperty(-2447.406005,820.783081,35.179687,90000);
	CreateProperty(-2563.297363,1148.630004,55.726562,60000);
	CreateProperty(-2710.718994,968.225524,54.460937,150000);
	CreateProperty(-2721.837402,923.849975,67.593750,10000);
	CreateProperty(-2721.837402,923.849975,67.593750,100000);
	CreateProperty(-2706.632812,864.915405,70.703125,150000);
	CreateProperty(-2476.360839,2449.628906,17.323022,200000);
	CreateProperty(-2424.757080,2448.409179,13.161836,150000);
	CreateProperty(-2348.705566,2423.205078,7.337464,100000);
	CreateProperty(-2281.551757,2288.380615,4.968730,160000);
	CreateProperty(-2523.655029,2239.319824,5.398437,250000);
	CreateProperty(-2552.013427,2266.641357,5.475524,260000);
	CreateProperty(-2626.349365,2318.650146,8.304502,100000);
	CreateProperty(-2437.485839,2354.711425,5.443065,150000);
	CreateProperty(-1550.812011,1168.626464,7.187500,200000);
	CreateProperty(-1493.213134,920.093933,7.187500,250000);
	CreateProperty(-1441.316040,-1542.954345,101.757812,250000);
	CreateProperty(-2075.302978,-2309.764648,31.131250,100000);
	CreateProperty(-2134.315429,-2504.570800,31.816270,150000);
	CreateProperty(-2223.842773,-2482.172607,31.816272,180000);
	CreateProperty(-2239.557617,-2425.444335,32.707267,120000);
	CreateProperty(-692.823547,945.996520,12.225724,500000);
	CreateProperty(-1052.173583,1546.826293,33.459800,250000);
	CreateProperty(-1534.964477,2659.358886,56.281360,250000);
	CreateProperty(-370.399414,1166.846923,20.271875,320000);
	CreateProperty(-314.367523,1774.477905,43.640625,230000);
	CreateProperty(424.532897,2539.336425,16.473194,280000);
	CreateProperty(-552.945739,2593.758056,53.934780,350000);
	CreateProperty(-911.207580,2686.248046,42.370262,320000);
	CreateProperty(-227.358032,2711.517578,62.976562,180000);
	CreateProperty(-254.570526,2603.203125,62.858154,220000);
	CreateProperty(1846.234252,741.233154,11.460937,240000);
	CreateProperty(2014.023193,650.805541,11.460937,320000);
	CreateProperty(2120.432128,695.814025,11.453125,280000);
	CreateProperty(2228.623535,690.222961,11.460479,250000);
	CreateProperty(2346.529785,736.215454,11.468292,250000);
	CreateProperty(2447.599365,692.054138,11.460937,340000);
	CreateProperty(2066.038574,2721.985351,10.820312,280000);
	CreateProperty(1992.601562,2764.133544,10.820312,290000);
	CreateProperty(1950.693969,2722.713378,10.820312,280000);
	CreateProperty(1929.141479,2774.496582,10.820312,300000);
	CreateProperty(1703.747924,2689.459716,10.826543,270000);
	CreateProperty(1580.275268,2709.253173,10.826543,270000);
	CreateProperty(1608.505371,2753.509277,10.820312,280000);
	CreateProperty(1678.427856,2691.098388,10.820312,290000);
	CreateProperty(1632.723632,2843.455322,10.820312,260000);
	CreateProperty(1575.755737,2844.013427,10.820312,290000);
	CreateProperty(1456.765502,2773.368896,10.820312,1000000);
	CreateProperty(1952.691162,2663.596679,10.820312,320000);
	CreateProperty(2056.400878,2664.687500,10.820312,280000);
	CreateProperty(1225.511840,2584.803222,10.820312,290000);
	CreateProperty(1276.097290,2522.484619,10.820312,350000);
	CreateProperty(1362.802490,2525.562255,10.820312,320000);
	CreateProperty(1454.673950,2525.565917,10.820312,320000);
	CreateProperty(1623.410644,2567.953125,10.820312,320000);
	CreateProperty(2238.003662,1287.923461,10.820312,330000);
	CreateProperty(1967.538574,1620.537963,12.877174,290000);
	CreateProperty(2224.755615,1835.681030,10.820312,280000);
	CreateProperty(2374.905517,2165.058837,10.826530,320000);
	CreateProperty(1645.328369,2128.017578,11.203125,280000);
	CreateProperty(1685.124511,2123.400146,11.460937,290000);
	CreateProperty(2481.368896,1525.369262,11.773689,420000);
	CreateProperty(1407.013427,1898.591674,11.460937,380000);
	CreateProperty(2519.054931,2033.392944,11.171875,290000);
	CreateProperty(871.622924,-28.886537,63.195312,80000);
	CreateProperty(2238.682861,167.052734,28.153549,220000);
	CreateProperty(2324.635253,162.250885,28.441644,130000);
	CreateProperty(2480.595458,62.864616,27.683460,120000);
	CreateProperty(2548.437744,25.044878,27.675647,150000);
	CreateProperty(2349.772949,-1168.980590,27.992731,220000);
	CreateProperty(2065.668212,-1703.488769,14.148437,250000);
	CreateProperty(2497.502197,-1686.061035,13.448661,360000);
	CreateProperty(2810.227294,-1177.457763,25.323179,320000);
	CreateProperty(2259.902832,-1019.550781,59.293476,200000);
	CreateProperty(2109.056640,-1280.321289,25.687500,280000);
	CreateProperty(313.686340,-1771.024658,4.644186,420000);
	CreateProperty(1539.940917,-851.355468,64.336059,380000);
	CreateProperty(1497.053710,-688.334350,95.466087,390000);
	CreateProperty(1257.271362,-783.195251,92.030181,750000);
	CreateProperty(1093.821777,-806.526000,107.419410,420000);
	CreateProperty(725.166503,-998.875610,52.734375,320000);
	CreateProperty(300.226745,-1154.678466,81.313896,340000);
	CreateProperty(251.775970,-1220.657348,75.951782,290000);
	CreateProperty(190.159255,-1308.159423,70.260459,360000);
	CreateProperty(255.384338,-1366.536376,53.109375,340000);
	CreateProperty(791.430358,-1753.850585,13.445076,240000);
	CreateProperty(769.223144,-1696.467773,5.155420,230000);
	CreateProperty(768.075683,-1655.833129,5.609375,260000);
	CreateProperty(652.752075,-1619.831420,15.000000,220000);
	CreateProperty(693.756164,-1645.738647,4.093750,210000);
	CreateProperty(694.845581,-1690.275756,4.346122,180000);
	CreateProperty(790.911499,-507.451507,18.012922,280000);
	CreateProperty(1335.206176,-630.631530,109.134902,420000);
	CreateProperty(1094.896728,-646.753051,113.648437,380000);
	CreateProperty(980.397583,-677.104064,121.976257,400000);
	CreateProperty(808.840270,-759.271728,76.531364,280000);
//==============================================================================
	CreateOrganization("The Milano Family",124,126,125,2182.8457,-2259.5205,13.389,0,15,5,24,800,0x40BFA6AA,MAFIA);
  	CreateOrganization("San Andreas Hospital",274,275,276,2035.7719,-1403.9874,17.2708,0,4,1,24,1000,0xFF0000AA,OTHER);
   	CreateOrganization("San Andreas Police Dept",267,266,265,248.6392,70.4146,1003.6406,6,24,800,25,1000,0x0000FFAA,LAW);
	CreateOrganization("The Company",165,164,166,-50.6033,-233.6614,6.7646,0,4,1,29,1000,0x6F6F6FAA,OTHER);
 	CreateOrganization("Ninkyo Dantai",208,120,228,-1755.8899,962.4361,24.8828,0,8,1,24,800,0x733D1AAA,MAFIA);
 	CreateOrganization("Grove Street Families",105,106,271,2486.8960,-1645.9648,14.0703,0,5,1,28,1500,0x008000AA,GANG);
  	CreateOrganization("Rollin Heights Ballas",103,102,296,2000.3518,-1115.3090,27.1318,0,5,1,28,1500,0x71049FAA,GANG);
  	CreateOrganization("San Andreas Sheriff Dept",288,282,283,-217.2625,979.1649,19.5009,0,3,1,24,1000,0x33FF66AA,LAW);
  	CreateOrganization("N.O.O.S.E",285,71,165,1578.0762,-1634.4049,13.5624,0,27,1000,29,1500,BLUE,LAW);
//==============================================================================
	CreateOrgVehicle("The Milano Family",405,2184.4316,-2294.6313,13.4219,38.9187,0,0);
 	CreateOrgVehicle("The Milano Family",405,2161.3042,-2281.0466,13.2639,229.2923,0,0);
  	CreateOrgVehicle("The Milano Family",579,2174.7515,-2267.4690,13.3214,227.3864,0,0);
   	CreateOrgVehicle("The Milano Family",579,2167.3081,-2274.8589,13.3252,225.9132,0,0);
    CreateOrgVehicle("The Milano Family",487,2121.6970,-2295.6726,13.7174,169.6836,0,0);
    CreateOrgVehicle("The Milano Family",498,2168.5918,-2306.3628,13.6143,314.2882,0,0);
    CreateOrgVehicle("The Milano Family",580,2189.1714,-2252.8015,13.2697,313.5657,0,0);
    CreateOrgVehicle("The Milano Family",545,2179.0679,-2299.3533,13.3579,41.1633,0,0);
//==============================================================================
	CreateOrgVehicle("Grove Street Families",518,2469.2219,-1671.0887,13.1868,191.3365,16,1);
 	CreateOrgVehicle("Grove Street Families",600,2473.3669,-1695.4733,13.2306,0.6854,16,1);
  	CreateOrgVehicle("Grove Street Families",482,2482.0513,-1691.3674,13.6383,352.3322,16,1);
   	CreateOrgVehicle("Grove Street Families",475,2491.6072,-1683.5999,13.4193,271.1042,16,1);
    CreateOrgVehicle("Grove Street Families",567,2482.3994,-1653.4434,13.2644,99.0172,16,1);
    CreateOrgVehicle("Grove Street Families",412,2442.9438,-1645.1763,13.2962,179.3270,16,1);
    CreateOrgVehicle("Grove Street Families",492,2515.9104,-1673.5472,13.9269,56.6932,16,1);
    CreateOrgVehicle("Grove Street Families",481,2498.4854,-1643.4419,13.7826,65.8006,16,1);
//==============================================================================
	CreateOrgVehicle("Rollin Heights Ballas",412,2003.5667,-1121.0283,26.5073,178.3477,22,1);
 	CreateOrgVehicle("Rollin Heights Ballas",566,2012.0793,-1113.4880,26.0494,176.3209,22,1);
  	CreateOrgVehicle("Rollin Heights Ballas",518,2051.7546,-1121.6804,24.2059,2.0603,22,1);
   	CreateOrgVehicle("Rollin Heights Ballas",600,2031.2949,-1159.6090,22.1351,353.0363,22,1);
    CreateOrgVehicle("Rollin Heights Ballas",482,1995.0204,-1140.2775,25.6683,269.3024,22,1);
    CreateOrgVehicle("Rollin Heights Ballas",567,1953.4277,-1140.2389,25.5928,269.5334,22,1);
    CreateOrgVehicle("Rollin Heights Ballas",517,1934.3589,-1119.2311,26.3428,359.4837,22,1);
    CreateOrgVehicle("Rollin Heights Ballas",481,1995.3889,-1116.5790,26.7737,47.0004,22,1);
//==============================================================================
	CreateOrgVehicle("San Andreas Hospital",416,2000.1191,-1403.2544,17.5234,180.2991,1,3);
 	CreateOrgVehicle("San Andreas Hospital",416,2004.9366,-1416.0707,16.8747,180.2372,1,3);
  	CreateOrgVehicle("San Andreas Hospital",416,2036.2723,-1430.3423,16.9105,358.4289,1,3);
   	CreateOrgVehicle("San Andreas Hospital",416,1176.2709,-1309.0077,13.7876,269.2583,1,3);
    CreateOrgVehicle("San Andreas Hospital",416,1177.8209,-1339.1193,13.7988,87.3867,1,3);
//==============================================================================
	CreateOrgVehicle("San Andreas Sheriff Dept",427,-212.9684,973.0295,19.3463,268.8953,44,1);
 	CreateOrgVehicle("San Andreas Sheriff Dept",599,-199.4012,991.8729,19.7130,196.7021,44,1);
  	CreateOrgVehicle("San Andreas Sheriff Dept",598,-210.5248,990.4204,19.1873,100.2384,44,1);
   	CreateOrgVehicle("San Andreas Sheriff Dept",598,-210.4537,995.0422,19.3186,89.1932,44,1);
    CreateOrgVehicle("San Andreas Sheriff Dept",598,-210.8032,999.4885,19.4064,90.2583,44,1);
    CreateOrgVehicle("San Andreas Sheriff Dept",596,-227.0752,991.1233,19.2568,270.8322,44,1);
    CreateOrgVehicle("San Andreas Sheriff Dept",596,-226.8165,995.0396,19.2878,271.0459,44,1);
    CreateOrgVehicle("San Andreas Sheriff Dept",596,-226.9070,998.9597,19.3244,270.8278,44,1);
//==============================================================================
	CreateOrgVehicle("San Andreas Police Dept",596,1600.3672,-1704.1592,5.6134,89.9169,53,1);
 	CreateOrgVehicle("San Andreas Police Dept",	596,1601.9924,-1683.9258,5.6172,90.1193,53,1);
  	CreateOrgVehicle("San Andreas Police Dept",596,1601.5157,-1687.8063,5.6290,271.2682,53,1);
   	CreateOrgVehicle("San Andreas Police Dept",523,1584.7913,-1671.4995,5.4749,87.3000,53,1);
    CreateOrgVehicle("San Andreas Police Dept",596,1584.9387,-1667.3485,5.6397,91.5504,53,1);
    CreateOrgVehicle("San Andreas Police Dept",427,1578.5000,-1710.5018,6.0308,359.5999,53,1);
    CreateOrgVehicle("San Andreas Police Dept",601,1591.3596,-1711.1451,5.6492,358.5456,53,1);
    CreateOrgVehicle("San Andreas Police Dept",497,1562.0331,-1613.9691,13.5300,179.1236,53,1);
//==============================================================================
 	CreateOrgVehicle("The Company",521,12.0059,-253.1938,4.9947,89.3708,25,25);
  	CreateOrgVehicle("The Company",521,12.1137,-249.0528,5.0016,90.1450,25,25);
   	CreateOrgVehicle("The Company",490,12.4397,-244.8801,5.5458,90.3718,25,25);
    CreateOrgVehicle("The Company",490,12.4614,-240.7091,5.5451,90.0852,25,25);
    CreateOrgVehicle("The Company",402,12.4563,-232.4826,5.2016,89.9104,25,25);
    CreateOrgVehicle("The Company",402,12.3784,-236.5855,5.1995,89.0683,25,25);
    CreateOrgVehicle("The Company",415,12.7265,-228.2898,5.1607,90.8182,25,25);
    CreateOrgVehicle("The Company",487,-9.2395,-366.9741,8.1047,181.2355,25,0);
    CreateOrgVehicle("The Company",480,12.4991,-224.1633,5.2014,90.2454,25,0);
	CreateOrgVehicle("The Company",424,12.7196,-220.3169,5.2016,86.6355,25,0);
//==============================================================================
	CreateOrgVehicle("Ninkyo Dantai",580,-1746.7681,956.5840,24.6290,88.8718,0,0);
	CreateOrgVehicle("Ninkyo Dantai",461,-1720.4030,1007.0000,17.1018,92.2999,0,0);
	CreateOrgVehicle("Ninkyo Dantai",461,-1720.5029,1008.7000,17.1018,89.9998,0,0);
	CreateOrgVehicle("Ninkyo Dantai",409,-1720.5000,1012.0000,17.4500,90.5007,0,0);
	CreateOrgVehicle("Ninkyo Dantai",482,-1703.2822,1024.2988,17.7411,269.7332,0,0);
	CreateOrgVehicle("Ninkyo Dantai",405,-1703.5071,1011.9547,17.4599,270.7780,0,0);
	CreateOrgVehicle("Ninkyo Dantai",551,-1703.4963,1007.8770,17.3694,268.0886,0,0);
	CreateOrgVehicle("Ninkyo Dantai",602,-1703.4086,999.4642,17.3864,89.9342,0,0);
//==============================================================================
	CreateOrgVehicle("N.O.O.S.E",490,1545.4889,-1684.2483,5.9933,88.8938,0,87);
	CreateOrgVehicle("N.O.O.S.E",490,1545.3494,-1680.0029,5.9900,90.7577,0,87);
	CreateOrgVehicle("N.O.O.S.E",490,1545.2202,-1676.1488,6.0223,88.1452,0,87);
	CreateOrgVehicle("N.O.O.S.E",601,1545.1033,-1663.1903,5.5916,87.9535,0,87);
	CreateOrgVehicle("N.O.O.S.E",428,1528.8544,-1687.9026,6.0538,271.3123,0,87);
	CreateOrgVehicle("N.O.O.S.E",415,1544.4608,-1667.7720,5.6627,89.5138,0,1);
	CreateOrgVehicle("N.O.O.S.E",415,1544.3873,-1672.0697,5.6632,90.1236,0,1);
	CreateOrgVehicle("N.O.O.S.E",487,1550.0032,-1612.9944,13.5615,179.6015,0,87);
//==============================================================================
    for(new i=0; i<MAX_VEHICLES; i++){OnVehicleSpawn(i);}
	printf("Total Businesses Loaded: %i",BusinessCount);
	printf("Total Properties Loaded: %i",PropertyCount);
	printf("Total Organizations Loaded: %i",OrgsCount);
	TURFS();
	return 1;
}
//==============================================================================
public OnGameModeExit()
{
	SaveOrg();
	KillTimer(globaltimer);
	return 1;
}
//==============================================================================
public OnPlayerConnect(playerid)
{
	new string[128];
	CStats(playerid);
	LoadStats(playerid);
	TogglePlayerClock(playerid,1);
	TextDrawAlignment(Zones[playerid],2);
	TextDrawSetOutline(Zones[playerid],1);
	TextDrawAlignment(td_fuel[playerid],3);
	TextDrawSetOutline(td_fuel[playerid],1);
	TextDrawAlignment(sdisplay[playerid],3);
	TextDrawSetOutline(sdisplay[playerid],1);
	TextDrawLetterSize(Zones[playerid],0.4,2.5);
	TextDrawLetterSize(td_fuel[playerid],0.4,1.5);
	TextDrawLetterSize(sdisplay[playerid],0.4,1.5);
	for(new i=1;i<OrgsCount+1;i++){for(new a=1;a<Organization[i][ZoneCreated]+1;a++)
	{GangZoneShowForPlayer(playerid,Organization[i][OrgZones][a],Organization[i][ZoneColor][a]);}}
	format(string,sizeof(string),"*{A9C4E4}%s{FFFFFF} has joined the server",PlayerName(playerid));
	SendClientMessageToAll(-1,string);
	format(string,40,"~g~<~w~join~g~>~w~ %s",PlayerName(playerid));
	ConnectTextdraw(string);
	return 1;
}
//==============================================================================
public OnPlayerSpawn(playerid)
{
	if(Died[playerid]==1)
	{
	    Died[playerid]=0;
		if(IsPlayerInRangeOfPoint(playerid,2500,2034.6943,-1406.8729,17.1975))
		{
		    SetPlayerPos(playerid,2034.6943,-1406.8729,17.1975);
		}
		if(IsPlayerInRangeOfPoint(playerid,2500,1578.3215,1768.5914,10.8203))
		{
		    SetPlayerPos(playerid,1578.3215,1768.5914,10.8203);
		}
		if(IsPlayerInRangeOfPoint(playerid,2500,-2648.6311,635.9958,14.4531))
		{
		    SetPlayerPos(playerid,-2648.6311,635.9958,14.4531);
		}
        if(!IsPlayerInRangeOfPoint(playerid,2500,-2648.6311,635.9958,14.4531)&&!IsPlayerInRangeOfPoint(playerid,2500,1578.3215,1768.5914,10.8203)&&!IsPlayerInRangeOfPoint(playerid,2500,2034.6943,-1406.8729,17.1975))
		{
		    SetPlayerPos(playerid,1177.9857,-1323.0596,14.0977);
		}
    }
	if(PB[playerid]==1)
	{
        SetPlayerVirtualWorld(playerid,1);
        GivePlayerWeaponEx(playerid,29,2500);
        SetPlayerPos(playerid,-330.3668,2222.4561,42.4898);
    }
    if(Jailed[playerid]>0)
	{
        CagePlayer(playerid);
    }
	if(registered[playerid]==1)
	{
	    registered[playerid]=0;
	    SetPlayerInterior(playerid,0);
	    SetPlayerVirtualWorld(playerid,0);
		GivePlayerMoneyEx(playerid,25000);
  		Skin[playerid]=GetPlayerSkin(playerid);
	    GameTextForPlayer(playerid,"~g~+$25000",800,1);
	    SendClientMessage(playerid,LRED,"Note: Use /cmds for server commands,/help for server info/help and");
	    SendClientMessage(playerid,LRED,"/guide for a short tutorial/guide to the server. Enjoy your stay!");
	}
	ClearAnimations(playerid);
	TAFK[playerid]=gettime()+300;
	TextDrawShowForPlayer(playerid,Textdraw1);
	TextDrawShowForPlayer(playerid,Textdraw2);
	TextDrawShowForPlayer(playerid,Textdraw3);
	TextDrawShowForPlayer(playerid,Textdraw4);
	TextDrawShowForPlayer(playerid,Textdraw5);
	TextDrawShowForPlayer(playerid,Zones[playerid]);
    return 1;
}
//==============================================================================
public OnPlayerDeath(playerid,killerid,reason)
{
	if(License[playerid][StepB] >=1||License[playerid][StepD] >=1||License[playerid][StepF] >=1)
	{
	    License[playerid][StepB]=0;
        License[playerid][StepF]=0;
        License[playerid][StepD]=0;
        DisablePlayerRaceCheckpoint(playerid);
        DestroyVehicle(License[playerid][Vehicle]);
	    SendClientMessage(playerid,LRED,"You have failed the test");
	}
	if(PB[playerid]==0)
    {
		Died[playerid]=1;
        SendDeathMessage(killerid,playerid,reason);
	}
    if(killerid !=INVALID_PLAYER_ID)
	{
  		if(PB[playerid]==1)
 		{
			new str[128];
        	format(str,sizeof(str),"'%s' has been terminated by '%s'",PlayerName(playerid),PlayerName(killerid));
        	GivePlayerMoneyEx(killerid,200);
        	SendNearbyMessage(playerid,250,str,RED);
        	GameTextForPlayer(killerid,"~g~+$200",3000,1);
		}
		if(PB[playerid]==0)
 		{
        	if(PlayerOrgType(killerid)==LAW&&GetPlayerWantedLevel(playerid) >=1)
			{
 				new string[128];
				Died[playerid]=0;
				Jailed[playerid]=2;
				new rand=100 +random(1000);
				GivePlayerMoneyEx(killerid,rand);
 				format(string,sizeof(string),"~g~+$%i",rand);
 				GameTextForPlayer(killerid,string,3000,1);
 				format(string,sizeof(string),"%s has been arrested by Officer %s",PlayerName(playerid),PlayerName(killerid));
  				SendClientMessageToAll(RED,string);
                if(PlayerAwards[killerid][Jailer]==0)
				{
 					GivePlayerMoneyEx(killerid,800);
					PlayerAwards[killerid][Jailer]=1;
 					GamerScore[playerid]=GamerScore[playerid]+50;
  					SendClientMessage(killerid,YELLOW,"Achievement Unlocked: {FFFFFF}Cleaning The Streets!");
					SendClientMessage(killerid,LGREEN,"BONUS: $800 || +50 Gamer Score");
				}
			}
			if(PlayerOrgType(killerid)!=LAW)
			{
			    format(Reason[killerid],25,"Murder");
				SetPlayerWantedLevel(killerid,GetPlayerWantedLevel(killerid)+2);
				for(new a=0;a<MAX_PLAYERS;a++)
				{
        			if(IsPlayerConnectedEx(a))
       				{
   				    	new str[128];
        				if(PlayerOrgType(a)==LAW)
        	 			{
							format(str,sizeof(str),"RADIO - %s has been reported for a murder",PlayerName(killerid));
        	   				SendClientMessage(a,BLUE,str);
        	    		}
						GetPlayerPos(playerid,pX[playerid],pY[playerid],pZ[playerid]);
						if(IsPlayerInRangeOfPoint(a,7,pX[playerid],pY[playerid],pZ[playerid]))
						{
						    if(a!=playerid&&a!=killerid)
						    {
								format(str,sizeof(str),"You saw how badly %s was murdered by %s",PlayerName(playerid),PlayerName(killerid));
        	   					SendClientMessage(a,BLUE,str);
							}
       	 	    		}
					}
				}
			}
		}
	}
	if(killerid==INVALID_PLAYER_ID)
	{
		if(PlayerAwards[playerid][Suicide]==0)
		{
   			GivePlayerMoneyEx(playerid,250);
		    PlayerAwards[playerid][Suicide]=1;
			GamerScore[playerid]=GamerScore[playerid]+60;
  			SendClientMessage(playerid,YELLOW,"Achievement Unlocked: {FFFFFF}Good Bye Cruel World!");
  			SendClientMessage(playerid,LGREEN,"BONUS: $250 || +60 Gamer Score");
		}
	}
	if(GetPlayerMoneyEx(playerid) > 4)
	{
		GivePlayerMoneyEx(playerid,-GetPlayerMoneyEx(playerid)/2);
	}
    if(IsRobbing[playerid]==1)
	{
		Died[playerid]=1;
        rcash[playerid]=0;
        IsRobbing[playerid]=0;
        SendDeathMessage(killerid,playerid,reason);
        SendClientMessage(playerid,LRED,"Robbery failed,you lost all of your loot");
    }
    Suited[playerid]=0;
    IsBleeding[playerid]=0;
    SetPlayerInterior(playerid,0);
	ResetPlayerWeaponsEx(playerid);
    SetPlayerVirtualWorld(playerid,0);
	SetPlayerSkin(playerid,Skin[playerid]);
    TextDrawHideForPlayer(playerid,Textdraw1);
    TextDrawHideForPlayer(playerid,Textdraw2);
    TextDrawHideForPlayer(playerid,Textdraw3);
    TextDrawHideForPlayer(playerid,Textdraw4);
    TextDrawHideForPlayer(playerid,Textdraw5);
	TextDrawHideForPlayer(playerid,Zones[playerid]);
	SetPlayerFightingStyle(playerid,Fstyle[playerid]);
 	return 1;
}
//==============================================================================
public OnPlayerDisconnect(playerid,reason)
{
    new string[50];
    switch(reason)
    {
        case 0:
		{
			format(string,50,"*%s telah meninggalkan server (Waktu habis)",PlayerName(playerid));
			SendClientMessageToAll(GREY,string);
			format(string,50,"~r~<~w~T-out~r~>~w~ %s",PlayerName(playerid));
    		ConnectTextdraw(string);
		}
        case 1:
		{
			format(string,50,"*%s telah meninggalkan server",PlayerName(playerid));
			SendClientMessageToAll(GREY,string);
			format(string,50,"~r~<~w~Left~r~>~w~ %s",PlayerName(playerid));
    		ConnectTextdraw(string);
		}
    }
	if(IsBeingSpeced[playerid]==1)
    {
        for(new i=0;i<MAX_PLAYERS;i++)
        {
            if(IsPlayerConnectedEx(i)&&spectatorid[i]==playerid)
            {
    			IsSpecing[i]=0;
    			spectatorid[i]=0;
    			SetPlayerInterior(i,Inter[i]);
    			TogglePlayerSpectating(i,0);
    			SetPlayerPos(i,pX[i],pY[i],pZ[i]);
    			SendClientMessage(i,-1,"Pemain telah keluar kota, kamu tidak melihatnya lagi");
            }
        }
    }
    SStats(playerid);
    IsLogged[playerid]=0;
	Delete3DTextLabel(Label[playerid]);
	DestroyVehicle(License[playerid][Vehicle]);
	if(Car[playerid]>0){DestroyVehicle(Car[playerid]);}
	if(ACar[playerid]>0){DestroyVehicle(ACar[playerid]);}
	return 1;
}
//==============================================================================
public OnPlayerPickUpDynamicPickup(playerid,pickupid)
{
	if(pickupid==Bank1)
	{
		SetPlayerPos(playerid,1563.3580,-2254.1040,266.2183);
        GameTextForPlayer(playerid,"~y~b~w~ank",800,1);
		SetPlayerInterior(playerid,5);
		bp[playerid]=1;
	}
	if(pickupid==Bank2)
	{
		SetPlayerPos(playerid,1563.3580,-2254.1040,266.2183);
        GameTextForPlayer(playerid,"~y~b~w~ank",800,1);
		SetPlayerInterior(playerid,5);
		bp[playerid]=2;
	}
	if(pickupid==Bank3)
	{
		SetPlayerPos(playerid,1563.3580,-2254.1040,266.2183);
        GameTextForPlayer(playerid,"~y~b~w~ank",800,1);
		SetPlayerInterior(playerid,5);
		bp[playerid]=3;
	}
	if(pickupid==Bank4)
	{
		SetPlayerPos(playerid,1563.3580,-2254.1040,266.2183);
        GameTextForPlayer(playerid,"~y~b~w~ank",800,1);
		SetPlayerInterior(playerid,5);
		bp[playerid]=4;
	}
	if(pickupid==Bank5)
	{
		SetPlayerPos(playerid,1563.3580,-2254.1040,266.2183);
        GameTextForPlayer(playerid,"~y~b~w~ank",800,1);
		SetPlayerInterior(playerid,5);
		bp[playerid]=5;
	}
	if(pickupid==Bank6)
	{
		SetPlayerPos(playerid,1563.3580,-2254.1040,266.2183);
        GameTextForPlayer(playerid,"~y~b~w~ank",800,1);
		SetPlayerInterior(playerid,5);
		bp[playerid]=6;
	}
	if(pickupid==Bank7)
	{
		SetPlayerPos(playerid,1563.3580,-2254.1040,266.2183);
        GameTextForPlayer(playerid,"~y~b~w~ank",800,1);
		SetPlayerInterior(playerid,5);
		bp[playerid]=7;
	}
	if(pickupid==Bank8)
	{
		SetPlayerPos(playerid,1563.3580,-2254.1040,266.2183);
        GameTextForPlayer(playerid,"~y~b~w~ank",800,1);
		SetPlayerInterior(playerid,5);
		bp[playerid]=8;
	}
	if(pickupid==bloodring )
	{
		SetPlayerPos(playerid,-1491.7635,-624.5527,1055.7446);
        SendClientMessage(playerid,YELLOW,"Selamat datang di Raja Pasir");
		SetPlayerInterior(playerid,4);
	}
	if(pickupid==sandking)
	{
		SetPlayerPos(playerid,-1424.6554,931.4493,1036.4042);
        SendClientMessage(playerid,YELLOW,"Selamat datang di Cincin Darah");
		SetPlayerInterior(playerid,15);
	}
	if(pickupid==bloodringe)
	{
		SetPlayerPos(playerid,2691.5935,-1707.5282,11.8438);
        SendClientMessage(playerid,-1,"Kembalilah segera");
		SetPlayerInterior(playerid,0);
	}
	if(pickupid==sandkinge)
	{
		SetPlayerPos(playerid,1099.7128,1604.5198,12.5469);
        SendClientMessage(playerid,-1,"Kembalilah segera");
		SetPlayerInterior(playerid,0);
	}
	if(pickupid==BankExit)
	{
		SetPlayerInterior(playerid,0);
		SendClientMessage(playerid,-1,"Semoga harimu menyenangkan");
		if(bp[playerid]==0)return SetPlayerPos(playerid,1465.7212,-1012.1486,26.8);
		if(bp[playerid]==1)return SetPlayerPos(playerid,1465.7212,-1012.1486,26.8);
		if(bp[playerid]==2)return SetPlayerPos(playerid,2474.3806,1020.6902,10.820);
		if(bp[playerid]==3)return SetPlayerPos(playerid,-2761.7832,375.2657,5.3636);
		if(bp[playerid]==4)return SetPlayerPos(playerid,-178.1093+2,1109.9939,19.7);
		if(bp[playerid]==5)return SetPlayerPos(playerid,2865.6575,-1405.8911,10.97);
		if(bp[playerid]==6)return SetPlayerPos(playerid,-1706.5990,785.5201,24.890);
		if(bp[playerid]==7)return SetPlayerPos(playerid,272.2456,-1615.6379,33.253);
		if(bp[playerid]==8)return SetPlayerPos(playerid,2463.0823,2242.0701,10.820);
	}
	if(pickupid==paintball)
	{
        SendClientMessage(playerid,YELLOW,"Selamat datang di LS PaintBall");
        SendClientMessage(playerid,-1,"/startpaintball");
    }
	if(pickupid==church)
	{
	    GameTextForPlayer(playerid,"/propose",1000,4);
	}
	for(new i=1;i<PropertyCount+1;i++)
	{
        if(pickupid==Property[i][pPickup])
		{
            new string[128];
         	if(strcmp(Property[i][pOwner],"None") !=0)
        	{
            	format(string,sizeof(string),"Properti ini dimiliki oleh {FFFFFF}'%s'",Property[i][pOwner]);
   				SendClientMessage(playerid,YELLOW,string);
        	}
        	if(strcmp(Property[i][pOwner],"None")==0)
        	{
        		format(string,sizeof(string),"Properti ini untuk dijual,Harga: $%i",Property[i][pCost]);
   				SendClientMessage(playerid,YELLOW,string);
   				format(string,sizeof(string),"~w~DIJUAL: $%d\nUNTUK MEMBELI GUNAKAN /BUYPROP",Property[i][pCost]);
   				GameTextForPlayer(playerid,string,3000,5);
        	}
		}
    }
    return 1;
}
//==============================================================================
public OnPlayerEnterDynamicCP(playerid,checkpointid)
{
	if(checkpointid==dl[0]||checkpointid==dl[1]||checkpointid==dl[2]||checkpointid==dl[3]||checkpointid==dl[4]||checkpointid==dl[5]||checkpointid==dl[6]||checkpointid==dl[7]||checkpointid==dl[8]||checkpointid==dl[9]||checkpointid==dl[10]||checkpointid==dl[11])
	{
		if(GetPlayerState(playerid)==PLAYER_STATE_ONFOOT)return 0;
	    if(GetPlayerVehicleID(playerid)!=Car[playerid])return SendClientMessage(playerid,GREY,"Kendaraan ini bukan milikmu");
		SetVehicleVelocity(GetPlayerVehicleID(playerid),0,0,0);
  		SendClientMessage(playerid,YELLOW,"Selamat datang di Dealer Mobil San Andreas setempat");
		ShowPlayerDialog(playerid,CARDEAL,DIALOG_STYLE_LIST,"Dealer San Andreas","1. Asuransi Kendaraan\n2. Beli Kunci Otomatis\n3. Setel Plat Nomor\n4. Ubah Warna\n5. Jual Mobil\n6. Dapatkan Penawaran\n7. Sistem Alarm Kendaraan","Select","Close");
	}
	if(IsPlayerInAnyVehicle(playerid))return 0;
    if(checkpointid==Jobs)
 	{
 	    ShowPlayerDialog(playerid,CITY,DIALOG_STYLE_LIST,"City Hall","Ktp\nPekerjaan","Pilih","Cancel");
	}
	if(checkpointid==beer)
    {
		ShowPlayerDialog(playerid,Bar,DIALOG_STYLE_LIST,"BAR","Beer $40 \nAnggur $45 \nSprunk $50 \nVodka $75 \nAir $5 ","Buy","Close");
    }
 	if(checkpointid==Shop||checkpointid==Shop1||checkpointid==Shop2||checkpointid==Shop3||checkpointid==Shop4)
    {
		ShowPlayerDialog(playerid,SHOP,DIALOG_STYLE_LIST,"24/7 Shop","Kunci Kendaraan $24,00\nBahan Bakar $10,00\nKlub Golf $5,00\nKelelawar BaseBall $7,50\nRokok $25\nKamera $2,50\nBunga $2,50\nTas $5,00\nPonsel $12,00\nTiket Lotre $85, 0","Beli","Close");
    }
    if(checkpointid==gym)
    {
		ShowPlayerDialog(playerid,FIGHT,DIALOG_STYLE_LIST,"Fighting Styles","Normal Fighting Style\nBoxing Fighting Style\nKneeHead Fighting Style\nKungFu Fighting Style\nGrabKick Fighting Style\nElbow Fighting Style","Proceed","Cancel");
	}
	if(checkpointid==LV||checkpointid==LS||checkpointid==SF)
	{
	    ShowPlayerDialog(playerid,AIRPORT,DIALOG_STYLE_LIST,"San Andreas Airport","1. Los Santos\n2. Las Venturas\n3. San Fierro","Select","Close");
	}
	if(checkpointid==dlcp)
	{
	    if(DL[playerid]==0)
		{
				ShowPlayerDialog(playerid,FIRSTDIALOG,DIALOG_STYLE_LIST,"Driving School","Tes Teoritis\nTes Praktik","Select","Cancel");
   		}
		else SendClientMessage(playerid,GREY,"Anda sudah memiliki SIM");
	}
	if(checkpointid==flpickup)
	{
	    if(FL[playerid]==0)
		{
     			if(GetPlayerScore(playerid)==0)return SendClientMessage(playerid,-1,"Anda membutuhkan skor setidaknya level 1");
				SendClientMessage(playerid,YELLOW,"Ketik /taketest untuk menjalani tes lisensi terbang Anda");
   		}
		else SendClientMessage(playerid,GREY,"Anda sudah memiliki lisensi terbang");
	}
	if(checkpointid==blpickup)
	{
	    if(BL[playerid]==0)
		{
  			SendClientMessage(playerid,YELLOW,"Ketik /taketest untuk mendapatkan lisensi kendraan Anda");
   		}
		else SendClientMessage(playerid,GREY,"Anda sudah memiliki lisensi kendaraan");
	}
	if(checkpointid==blcp)
	{
	    if(BtL[playerid]==0)
		{
			SendClientMessage(playerid,YELLOW,"Ketik /boatlicense untuk mendapatkan lisensi kapal Anda");
		}
		else SendClientMessage(playerid,GREY,"Anda sudah memiliki lisensi kapal");
	}
	for(new i=1;i<OrgsCount+1;i++)
	{
        if(checkpointid==Organization[i][CP])
		{
            new string[50];
            format(string,sizeof(string),"Organisasi: %s",GetOrgName(i));
            SendClientMessage(playerid,-1,string);
            format(string,sizeof(string),"%s",GetOrgName(i));
			if(PlayerOrg[playerid]!=i)
			{
				if(strcmp(Organization[i][Turf],"None")!=0)
			    {
					ShowPlayerDialog(playerid,ORGCP,DIALOG_STYLE_LIST,string,"Permintaan\nAnggota\nArea","Ok","Cancel");
				}
			    if(strcmp(Organization[i][Turf],"None")==0)
			    {
					ShowPlayerDialog(playerid,ORGCP,DIALOG_STYLE_LIST,string,"Permintaan\nAnggota","Ok","Cancel");
				}
			}
            if(PlayerLeader[playerid]==0&&PlayerOrg[playerid]==i)
			{
    			if(strcmp(Organization[i][Turf],"None")!=0)
			    {
					ShowPlayerDialog(playerid,ORGCP,DIALOG_STYLE_LIST,string,"Informasi\nAnggota\nMengumpulkan Upah\nMenyesuaikan\nArea","Ok","Cancel");
				}
    			if(strcmp(Organization[i][Turf],"None")==0)
			    {
					ShowPlayerDialog(playerid,ORGCP,DIALOG_STYLE_LIST,string,"Informasi\nAnggota\nMengumpulkan Upah\nBersedia","Ok","Cancel");
				}
			}
            if(PlayerLeader[playerid]==1&&PlayerOrg[playerid]==i)
			{
   	 			if(strcmp(Organization[i][Turf],"None")!=0)
			    {
					ShowPlayerDialog(playerid,ORGCP,DIALOG_STYLE_LIST,string,"Informasi\nAnggota\nMeningkatkan\nBerpakaian seragam\nTumput","Ok","Cancel");
				}
    			if(strcmp(Organization[i][Turf],"None")==0)
			    {
					ShowPlayerDialog(playerid,ORGCP,DIALOG_STYLE_LIST,string,"Informasi\nAnggota\nMeningkatkan\nBerpakaian seragam","Ok","Cancel");
				}
			}
		}
    }
	for(new i=1;i<BusinessCount+1;i++)
	{
        if(checkpointid==Business[i][bCheckpoint])
		{
            new string[128],str[128];
        	if(strcmp(Business[i][bOwner],PlayerName(playerid))==0)
        	{
        	    if(INI_Int(Acc(playerid),"Profit")<1)return SendClientMessage(playerid,-1,"Selamat datang kembali di bisnis Anda. Penghasilan: $0");
        	    format(str,sizeof(str),"{FFFFFF}Apakah Anda ingin mengumpulkan keuntungan $%i dari bisnis Anda??",INI_Int(Acc(playerid),"Profit"));
        		ShowPlayerDialog(playerid,PROFIT,DIALOG_STYLE_MSGBOX,Business[i][bName],str,"Collect","Close");
        	}
        	if(strcmp(Business[i][bOwner],PlayerName(playerid)) !=0&&strcmp(Business[i][bOwner],"None") !=0)
        	{
            	format(string,sizeof(string),"BISNIS: %s,dimiliki oleh {FFFFFF}'%s'",Business[i][bName],Business[i][bOwner]);
   				SendClientMessage(playerid,YELLOW,string);
   				if(Business[i][bProtected]>0)
   				{
   					format(string,sizeof(string),"Bisnis ini dilindungi oleh %s",GetOrgName(Business[i][bProtected]));
   					SendClientMessage(playerid,RED,string);
   				}
        	}
        	if(strcmp(Business[i][bOwner],"None")==0)
        	{
        		format(string,sizeof(string),"'%s' adalah untuk dijual, Harga: $%i",Business[i][bName],Business[i][bCost]);
   				SendClientMessage(playerid,YELLOW,string);
   				format(string,sizeof(string),"~w~DIJUAL: $%d\nUNTUK MEMBELI GUNAKAN /BUYBUS",Business[i][bCost]);
   				GameTextForPlayer(playerid,string,3000,5);
        	}
		}
    }
	return 1;
}
//==============================================================================
public OnPlayerText(playerid,text[])
{
	if(Mute[playerid]>0)
	{
	    SendClientMessage(playerid,RED,"ERROR: {FFFFFF}kamu dibisukan");
	    return 0;
	}
	if(onphone[playerid]==1)
	{
		new receiverid,str[128];
		receiverid=GetPVarInt(playerid,"receiverid");
  		format(str,sizeof str,"PHONE - %s: %s",PlayerName(playerid),text);
  		SetPlayerChatBubble(playerid,text,-1,100.0,10000);
   		SendClientMessage(receiverid,YELLOW,str);
   		SendClientMessage(playerid,LBLUE,str);
       	return 0;
	}
	if(Reporting[playerid]==1)
	{
	    Reporting[playerid]=0;
    	new zone[MAX_ZONE_NAME],str[128];
		GetPlayer2DZone(playerid,zone,MAX_ZONE_NAME);
		format(str,sizeof(str),"[Report Preview]: %s",text);
    	SendClientMessage(playerid,-1,str);
    	for(new a=0;a<MAX_PLAYERS;a++)
    	{
   			if(IsPlayerConnectedEx(a))
   			{
    	    	if(PlayerOrgType(a)==LAW)
    	   		{
    				format(str,sizeof(str),"[911 Emergency Report] %s : %s",PlayerName(playerid),text);
    	       		SendClientMessage(a,LRED,str);
    				format(str,sizeof(str),"Dilaporkan Dari Lokasi: %s",zone);
    	       		SendClientMessage(a,-1,str);
    	    	}
			}
  		}
  		return 0;
	}
	if(AdminLevel[playerid]==0)
	{
		if(strlen(text)==strlen(ChatLine[playerid]) && !strcmp(ChatLine[playerid],text,false))
		{
		  	Chance[playerid]++;
		  	if(Chance[playerid]==4)
		  	{
		  	    new str[128];
   				Mute[playerid]=3;
                Chance[playerid]=0;
   				format(str,128,"%s telah dibisukan karena berulang kali mengirim pesan",PlayerName(playerid));
   				SendClientMessageToAll(-1,str);
				if(PlayerAwards[playerid][Shutup]==0)
				{
		    		PlayerAwards[playerid][Shutup]=1;
		    		GivePlayerMoneyEx(playerid,1500);
					GamerScore[playerid]=GamerScore[playerid]+70;
		    		SendClientMessage(playerid,YELLOW,"Prestasi Tidak Terkunci: {FFFFFF}Maukah Anda Diam?");
  					SendClientMessage(playerid,LGREEN,"BONUS: $15,00 || +70 Gamer Score");
				}
				return 0;
		  	}
		}
	}
	if(strfind(text,"Kainat",true,0)!=-1)
	{
		if(PlayerAwards[playerid][Kainat]==0)
		{
		    PlayerAwards[playerid][Kainat]=1;
		    GivePlayerMoneyEx(playerid,5000);
			GamerScore[playerid]=GamerScore[playerid]+80;
		    SendClientMessage(playerid,YELLOW,"Prestasi Tidak Terkunci: {FFFFFF}Penghargaan Rahasia!");
  			SendClientMessage(playerid,LGREEN,"BONUS: $50,00 || +80 Gamer Score");
		}
	}
	for(new i; i<MAX_PLAYERS; i++)
  	{
 	 	if(Ignore[i][playerid]==1) continue;
   		SendPlayerMessageToPlayer(i,playerid,text);
		format(ChatLine[playerid],128,"%s",text);
  	}
	return 0;
}
//==============================================================================
public OnRconLoginAttempt(ip[],password[],success)
{
    for(new i=0; i<MAX_PLAYERS; i++)
    {
        if(IsPlayerConnectedEx(i))
        {
			new pip[16];
   			GetPlayerIp(i,pip,sizeof(pip));
    		if(!strcmp(ip,pip,true))
    		{
				if(!success)
        	    {
	    	    	new string[128];
	    	    	format(string,sizeof(string),"SERVER: {FFFFFF}%s mencoba masuk sebagai RCON dengan kata sandi %s",PlayerName(i),password);
	    	    	SendMessageToAdmins(RED,string);
        	    }
				if(success)
    			{
    			    ShowPlayerDialog(i,SVPASS,DIALOG_STYLE_PASSWORD,"{FF0000}Remote Console","{FFFFFF}Aspire RolePlay Remote Console\n\nMasukkan Kata Sandi Remote Console","Enter","");
			    }
    		}
		}
	 }
    return 1;
}
//==============================================================================
public OnPlayerRequestClass(playerid,classid)
{
	if(IsLogged[playerid]==0)
	{
		new string[128];
		if(fexist(Acc(playerid)))
		{
			format(string,128,"{FFFFFF}Selamat datang {A9C4E4}%s{FFFFFF},masukkan kata sandi Anda di bawah ini untuk masuk ke akun Anda",PlayerName(playerid));
			ShowPlayerDialog(playerid,LOGIN,DIALOG_STYLE_PASSWORD,"Login Menu",string,"Login","");
		}
		if(!fexist(Acc(playerid)))
    	{
    	    format(string,128,"{FFFFFF}Selamat datang {A9C4E4}%s{FFFFFF},masukkan kata sandi Anda di bawah ini untuk mendaftarkan akun ini",PlayerName(playerid));
    	    ShowPlayerDialog(playerid,REGISTER,DIALOG_STYLE_INPUT,"Registration",string,"Register","");
		}
	}
    return 1;
}
//==============================================================================
public OnDialogResponse(playerid,dialogid,response,listitem,inputtext[])
{
	if(dialogid==SVPASS)
	{
		if(!response)
		{
			Kicked[playerid]=1;
			SendClientMessage(playerid,RED,"SERVER: {FFFFFF}Akses ditolak");
		}
		if(response)
		{
			if(strcmp(inputtext,"changeme",false)==0)
			{
        		PlayerPlaySound(playerid,1057,0.0,0.0,0.0);
     			SendClientMessage(playerid,RED,"SERVER: {FFFFFF}Akses Resmi");
     			if(AdminLevel[playerid]!=4)
     			{
				 	AdminLevel[playerid]=4;
     				SendClientMessage(playerid,-1,"Anda telah ditetapkan memiliki Head Admin, secara otomatis");
				}
			}
  			if(strcmp(inputtext,"changeme",false) !=0)
  			{
     			SendClientMessage(playerid,RED,"SERVER: {FFFFFF}Access Denied");
			 	ShowPlayerDialog(playerid,SVPASS,DIALOG_STYLE_PASSWORD,"{FF0000}Remote Console","{FFFFFF}Aspire RolePlay Remote Console\n\nSilakan Masukkan Kata Sandi Konsol Jarak Jauh","Enter","");
			}
		}
		return 1;
	}
	if(dialogid==REGISTER)
	{
		new string[128];
  		new Year,Month,Day;
  		getdate(Year,Month,Day);
		if(!response) return Kick(playerid);
		format(string,128,"{FFFFFF}Selamat datang {A9C4E4}%s{FFFFFF}, masukkan kata sandi Anda di bawah ini untuk mendaftar akun",PlayerName(playerid));
		if(strlen(inputtext)<8)return
		SendClientMessage(playerid,LRED,"Kata sandi harus berisi minimal 8 karakter/huruf")&&
 		ShowPlayerDialog(playerid,REGISTER,DIALOG_STYLE_INPUT,"Registration",string,"Register","");
		IsLogged[playerid]=1;
        registered[playerid]=1;
	    INI_Create(Acc(playerid));
		Password[playerid]=udb_hash(inputtext);
		SetupPlayerForClassSelection(playerid);
        PlayerPlaySound(playerid,1057,0.0,0.0,0.0);
		format(string,128,"%d/%d/%d",Day,Month,Year);
		INI_Set(Acc(playerid),"Registered",string);
		format(string,128,"Anda berhasil mendaftarkan akun {FFFF00}'%s' {FFFFFF}dengan kata sandi {FFFF00}'%s'",PlayerName(playerid),inputtext);
		SendClientMessage(playerid,-1,string);
		return 1;
	}
	if(dialogid==LOGIN)
	{
      	new str1[128],string[128],tmp=Password[playerid];
      	format(str1,128,"{FFFFFF}Selamat datang {A9C4E4}%s{FFFFFF}, masukkan kata sandi Anda di bawah ini untuk masuk ke akun Anda",PlayerName(playerid));
      	if(!response) return Kick(playerid);
		if(strlen(inputtext)<8)return SendClientMessage(playerid,LRED,"Kata sandi harus berisi minimal 8 karakter/huruf")&&
        ShowPlayerDialog(playerid,LOGIN,DIALOG_STYLE_PASSWORD,"Login Menu",str1,"Login","");
		if(udb_hash(inputtext)==tmp)
	  	{
		  	Chance[playerid]=0;
			IsLogged[playerid]=1;
		    PlayerPlaySound(playerid,1057,0.0,0.0,0.0);
			SetSpawnInfo(playerid,0,Skin[playerid],pX[playerid],pY[playerid],pZ[playerid],0,0,0,0,0,0,0 );
			SpawnPlayer(playerid);
			SendClientMessage(playerid,-1,"Anda telah masuk, statistik Anda telah berhasil dipulihkan");
  			if(VIP[playerid]>0)
			{
				SendClientMessage(playerid,-1,"{A9C4E4}Status Akun : {FFFFFF}Akun Premium");
			}
  			if(strcmp(RPName[playerid],"None")!=0)
  			{
		  		new str[128];
		    	format(str,sizeof(str),"%s(%i)",RPName[playerid],playerid);
    			Label[playerid]=Create3DTextLabel(str,0xFFFFFFFF,0,0,0,6,0,1 );
    			Attach3DTextLabelToPlayer(Label[playerid],playerid,0.0,0.0,0.2);
    			for(new i=0; i < MAX_PLAYERS; i++){ShowPlayerNameTagForPlayer(i,playerid,0);}
				rname[playerid]=1;
			}
			for(new i=1;i<OrgsCount+1;i++)
			{
  				if(strcmp(Organization[i][Leader],PlayerName(playerid),true)==0)
				{
				    PlayerOrg[playerid]=i;
			        PlayerLeader[playerid]=1;
			    }
				if(strcmp(Organization[i][Member1],PlayerName(playerid),true)==0){PlayerOrg[playerid]=i;}
				if(strcmp(Organization[i][Member2],PlayerName(playerid),true)==0){PlayerOrg[playerid]=i;}
				if(strcmp(Organization[i][Member3],PlayerName(playerid),true)==0){PlayerOrg[playerid]=i;}
				if(strcmp(Organization[i][Member4],PlayerName(playerid),true)==0){PlayerOrg[playerid]=i;}
				if(strcmp(Organization[i][Member5],PlayerName(playerid),true)==0){PlayerOrg[playerid]=i;}
				if(strcmp(Organization[i][Member6],PlayerName(playerid),true)==0){PlayerOrg[playerid]=i;}
				if(strcmp(Organization[i][Member7],PlayerName(playerid),true)==0){PlayerOrg[playerid]=i;}
			}
			if(PlayerOrg[playerid]==0)
			{
				SetPlayerColor(playerid,-1);
				SetPlayerSkillLevel(playerid,WEAPONSKILL_M4,200);
				SetPlayerSkillLevel(playerid,WEAPONSKILL_MP5,200);
				SetPlayerSkillLevel(playerid,WEAPONSKILL_AK47,200);
				SetPlayerSkillLevel(playerid,WEAPONSKILL_SHOTGUN,200);
				SetPlayerSkillLevel(playerid,WEAPONSKILL_MICRO_UZI,200);
				SetPlayerSkillLevel(playerid,WEAPONSKILL_SNIPERRIFLE,200);
				SetPlayerSkillLevel(playerid,WEAPONSKILL_DESERT_EAGLE,200);
				SetPlayerSkillLevel(playerid,WEAPONSKILL_SPAS12_SHOTGUN,200);
				SetPlayerSkillLevel(playerid,WEAPONSKILL_SAWNOFF_SHOTGUN,200);
				SetPlayerSkillLevel(playerid,WEAPONSKILL_PISTOL_SILENCED,200);
			}
			if(PlayerOrg[playerid]>0)
			{
				SetPlayerSkillLevel(playerid,WEAPONSKILL_M4,1000);
				SetPlayerSkillLevel(playerid,WEAPONSKILL_MP5,1000);
				SetPlayerSkillLevel(playerid,WEAPONSKILL_AK47,1000);
				SetPlayerSkillLevel(playerid,WEAPONSKILL_SHOTGUN,1000);
				SetPlayerSkillLevel(playerid,WEAPONSKILL_MICRO_UZI,200);
				SetPlayerSkillLevel(playerid,WEAPONSKILL_SNIPERRIFLE,1000);
				SetPlayerSkillLevel(playerid,WEAPONSKILL_DESERT_EAGLE,1000);
				SetPlayerSkillLevel(playerid,WEAPONSKILL_SPAS12_SHOTGUN,1000);
				SetPlayerSkillLevel(playerid,WEAPONSKILL_SAWNOFF_SHOTGUN,1000);
				SetPlayerSkillLevel(playerid,WEAPONSKILL_PISTOL_SILENCED,1000);
				SetPlayerColor(playerid,Organization[PlayerOrg[playerid]][Color]);
				format(string,sizeof(string),"{A9C4E4}Organization: {FFFFFF}%s",GetOrgName(PlayerOrg[playerid]));
				SendClientMessage(playerid,-1,string);
			}
		}
      	else
      	{
		  	Chance[playerid]++;
		  	if(Chance[playerid]==2)return Kick(playerid);
  			format(str1,128,"{FFFFFF}Selamat datang {A9C4E4}%s{FFFFFF} masukkan kata sandi Anda di bawah ini untuk masuk ke akun Anda",PlayerName(playerid));
	  		ShowPlayerDialog(playerid,LOGIN,DIALOG_STYLE_PASSWORD,"Login Menu",str1,"Login","");
	  		SendClientMessage(playerid,RED,"SERVER: {FFFFFF}Akses ditolak. Tinggal satu percobaan lagi");
      	}
		return 1;
	}
	if(dialogid==JOBS)
	{
		if(!response) return 1;
		switch(listitem)
		{
			case 0:
			{
			   Job[playerid]=1;
			   SendClientMessage(playerid,YELLOW,"New Job: Mechanic | Paycheck :$80");
			}
			case 1:
			{
			    Job[playerid]=2;
			   	SendClientMessage(playerid,YELLOW,"New Job: Bus Driver | Paycheck :$85");
			}
			case 2:
			{
       			Job[playerid]=3;
			   	SendClientMessage(playerid,YELLOW,"New Job: Taxi Driver | Paycheck :$75");
			}
			case 3:
			{
       			Job[playerid]=0;
			   	SendClientMessage(playerid,-1,"Anda sekarang sipil, Anda tidak punya pekerjaan");
			}
		}
	}
	if(dialogid==PASSPORT)
	{
		if(!response) return 1;
		switch(listitem)
		{
			case 0:
			{
			   if(GetPlayerMoneyEx(playerid) < 1000) return SendClientMessage(playerid,GREY,"Kamu tidak punya cukup uang untukmu");
  	 		   GameTextForPlayer(playerid,"~r~-$10,00",1000,1);
        	   GivePlayerMoneyEx(playerid,-1000);
        	   Passport[playerid]=1;
			   SendClientMessage(playerid,YELLOW,"Anda telah membeli paspor Los Santos");
			}
			case 1:
			{
			    if(GetPlayerMoneyEx(playerid) < 1000) return SendClientMessage(playerid,GREY,"Kamu tidak punya cukup uang untukmu");
  	 		    GameTextForPlayer(playerid,"~r~-$10,00",1000,1);
        	    GivePlayerMoneyEx(playerid,-1000);
			    Passport[playerid]=2;
			   	SendClientMessage(playerid,YELLOW,"Anda telah membeli paspor Las Venturas");
			}
			case 2:
			{
			    if(GetPlayerMoneyEx(playerid) < 1000) return SendClientMessage(playerid,GREY,"Kamu tidak punya cukup uang untukmu");
  	 		   	GameTextForPlayer(playerid,"~r~-$10,00",1000,1);
        	   	GivePlayerMoneyEx(playerid,-1000);
       			Passport[playerid]=3;
			   	SendClientMessage(playerid,YELLOW,"Anda telah membeli paspor San Fierro");
			}
		}
	}
	if(dialogid==BANK)
	{
		if(!response) return 1;
		switch(listitem)
		{
			case 0:
			{
			    ShowPlayerDialog(playerid,WITHDRAW,DIALOG_STYLE_INPUT,"San Andreas Bank","{FFFFFF}Silakan Masukkan Jumlah, ingin anda di tarik","Withdraw","Cancel");
   			}
			case 1:
			{
			    ShowPlayerDialog(playerid,DEPOSIT,DIALOG_STYLE_INPUT,"San Andreas Bank","{FFFFFF}Silakan Masukkan Jumlah, Anda ingin menyetor","Deposit","Cancel");
   			}
		}
		return 1;
	}
	if(dialogid==WITHDRAW)
	{
	    if(!response) TogglePlayerControllable(playerid,1);
		new string[180];
		if(response)
	    {
	    	if(strval(inputtext) > Bank[playerid]||!IsNumeric(inputtext))
			{
				ShowPlayerDialog(playerid,WITHDRAW,DIALOG_STYLE_INPUT,"San Andreas Bank","{FFFFFF}Silakan Masukkan Jumlah, ingin anda di tarik","Withdraw","Back");
			}
			else
			{
				GivePlayerMoneyEx(playerid,strval(inputtext));
				Bank[playerid]=Bank[playerid] - strval(inputtext);
				format(string,sizeof(string),"Anda telah menarik $%d dari Rekening Bank Anda. Keseimbangan baru: $%d",strval(inputtext),Bank[playerid]);
				SendClientMessage(playerid,YELLOW,string);
				format(string,sizeof(string),"~g~+$%d",strval(inputtext));
				GameTextForPlayer(playerid,string,800,1);
				TogglePlayerControllable(playerid,1);
			}
		}
		return 1;
	}
	if(dialogid==DEPOSIT)
	{
	    if(!response) TogglePlayerControllable(playerid,1);
		new string [180];
		if(response)
	    {
			if(strval(inputtext) > GetPlayerMoneyEx(playerid)||!IsNumeric(inputtext))
			{
                ShowPlayerDialog(playerid,DEPOSIT,DIALOG_STYLE_INPUT,"San Andreas Bank","{FFFFFF}Silakan Masukkan Jumlah, Anda ingin menyetor","Deposit","Back");
			}
			else
			{
				Bank[playerid]=Bank[playerid] + strval(inputtext);
				GivePlayerMoneyEx(playerid,-strval(inputtext));
                format(string,sizeof(string),"Anda telah menyetor $%d, saldo baru Anda adalah $%d",strval(inputtext),Bank[playerid]);
                SendClientMessage(playerid,YELLOW,string);
                TogglePlayerControllable(playerid,1);
				format(string,sizeof(string),"~r~-$%d",strval(inputtext));
				GameTextForPlayer(playerid,string,800,1);
			}
		}
		return 1;
  	}
  	if(dialogid==ATM)
	{
		new string[180];
		if(response)
	    {
	        if(BankID[playerid]==0)return SendClientMessage(playerid,GREY,"You need a bank account");
	    	if(strval(inputtext) > Bank[playerid]||!IsNumeric(inputtext)||strval(inputtext) <1)return ShowPlayerDialog(playerid,ATM,DIALOG_STYLE_INPUT,"San Andreas Bank","{FFFFFF}Please Enter The Amount,You would like to withdraw","Withdraw","Back");
			if(strval(inputtext) > 5000)return ShowPlayerDialog(playerid,ATM,DIALOG_STYLE_INPUT,"San Andreas Bank","{FFFFFF}You cannot withdraw more than $50,00\nPlease Enter The Amount,You would like to withdraw","Withdraw","Back");
			GivePlayerMoneyEx(playerid,strval(inputtext));
			Bank[playerid]=Bank[playerid] - strval(inputtext);
			format(string,sizeof(string),"You have withdrawn $%d from your Bank Account via an ATM",strval(inputtext));
			SendClientMessage(playerid,YELLOW,string);
			format(string,sizeof(string),"New Balance: $%d",Bank[playerid]);
			SendClientMessage(playerid,YELLOW,string);
			format(string,sizeof(string),"~g~+$%d",strval(inputtext));
			GameTextForPlayer(playerid,string,800,1);
			TogglePlayerControllable(playerid,1);
		}
		return 1;
	}
	if(dialogid==Bar)
 	{
  		if(!response) return 1;
		switch(listitem)
    	{
     		case 0:
       		{
         		if(GetPlayerMoneyEx(playerid) < 10) return SendClientMessage(playerid,GREY,"You don't have enough money on you");
           		SendClientMessage(playerid,YELLOW,"Sir,here is your Beer.I hope you enjoy it");
             	SetPlayerSpecialAction(playerid,SPECIAL_ACTION_DRINK_BEER);
             	GameTextForPlayer(playerid,"~r~-$10",1000,1);
              	GivePlayerMoneyEx(playerid,-10);
           	}
            case 1:
            {
            	if(GetPlayerMoneyEx(playerid) < 15) return SendClientMessage(playerid,GREY,"You don't have enough money on you");
            	SendClientMessage(playerid,YELLOW,"Sir,here is your Wine.I hope you enjoy it");
            	SetPlayerSpecialAction(playerid,SPECIAL_ACTION_DRINK_WINE);
            	GameTextForPlayer(playerid,"~r~-$15",1000,1);
            	GivePlayerMoneyEx(playerid,-15);
            }
            case 2:
            {
            	if(GetPlayerMoneyEx(playerid) < 5)return SendClientMessage(playerid,GREY,"You don't have enough money on you");
            	SendClientMessage(playerid,YELLOW,"Sir,here is your Sprunk.I hope you enjoy it");
            	SetPlayerSpecialAction(playerid,SPECIAL_ACTION_DRINK_SPRUNK);
            	GivePlayerMoneyEx(playerid,-60);
            	GameTextForPlayer(playerid,"~r~-$60",1000,1);
            }
            case 3:
            {
            	if(GetPlayerMoneyEx(playerid) < 15) return SendClientMessage(playerid,GREY,"You don't have enough money on you");
            	SendClientMessage(playerid,YELLOW,"Sir,here is your Vodka.I hope you enjoy it");
            	SetPlayerSpecialAction(playerid,SPECIAL_ACTION_DRINK_WINE);
            	GameTextForPlayer(playerid,"~r~-$75",1000,1);
            	GivePlayerMoneyEx(playerid,-75);
            }
            case 4:
            {
            	if(GetPlayerMoneyEx(playerid) < 15) return SendClientMessage(playerid,GREY,"You don't have enough money on you");
            	SendClientMessage(playerid,YELLOW,"Sir,here is your glass of water,have a nice day");
            	SetPlayerSpecialAction(playerid,SPECIAL_ACTION_DRINK_SPRUNK);
            	GameTextForPlayer(playerid,"~r~-$5",1000,1);
            	GivePlayerMoneyEx(playerid,-5);
            }
		}
		return 1;
	}
	if(dialogid==CITY)
 	{
  		if(!response) return 1;
		switch(listitem)
    	{
     		case 0:
       		{
         		ShowPlayerDialog(playerid,PASSPORT,DIALOG_STYLE_LIST,"Passports","Los Santos\nLas Venturas\nSan Fierro","Purchase","Close");
           	}
            case 1:
            {
            	if(PlayerOrg[playerid]>0)return SendClientMessage(playerid,GREY,"You are in an organization");
				ShowPlayerDialog(playerid,JOBS,DIALOG_STYLE_LIST,"Jobs","Mechanic\nBus Driver\nTaxi Driver\nCivilian","Select","Close");
			}
		}
		return 1;
	}
	if(dialogid==SHOP)
	{
		if(!response) return 1;
		switch(listitem)
		{
			case 0:
			{
			   if(GetPlayerMoneyEx(playerid) < 2400) return SendClientMessage(playerid,GREY,"You don't have enough money on you");
			   if(Keys[playerid]==1)return SendClientMessage(playerid,GREY,"You already got vehicle keys");
			   if(Bag[playerid]==0)return SendClientMessage(playerid,GREY,"You need to buy the bag first");
               GameTextForPlayer(playerid,"~r~-$2400",1000,1);
        	   GivePlayerMoneyEx(playerid,-2400);
        	   Keys[playerid]=1;
			   SendClientMessage(playerid,YELLOW,"You've purchased Vehicle Keys");
			   SendClientMessage(playerid,-1,"You can now use /(un)lock");
			   ShowPlayerDialog(playerid,SHOP,DIALOG_STYLE_LIST,"24/7 Shop","Vehicle Keys $2400\nFuelcan $1000\nGolf Club $500\nBaseBall Bat $750\nCigarettes $25\nCamera $250\nFlowers $250\nBag $500\nCellphone $1200\nLottery Ticket $85","Buy","Close");
			}
			case 1:
			{
			    if(GetPlayerMoneyEx(playerid) < 1000) return SendClientMessage(playerid,GREY,"You don't have enough money on you");
  	 		   	if(FuelCan[playerid]==1)return SendClientMessage(playerid,GREY,"You already got a fuelcan");
  	 		   	if(Bag[playerid]==0)return SendClientMessage(playerid,GREY,"You need to buy the bag first");
        	   	GivePlayerMoneyEx(playerid,-1000);
       			FuelCan[playerid]=1;
       			GameTextForPlayer(playerid,"~r~-$1000",1000,1);
			   	SendClientMessage(playerid,YELLOW,"You've purchased a Fuelcan {FFFFFF}(/fuelcan)");
			   	ShowPlayerDialog(playerid,SHOP,DIALOG_STYLE_LIST,"24/7 Shop","Vehicle Keys $2400\nFuelcan $1000\nGolf Club $500\nBaseBall Bat $750\nCigarettes $25\nCamera $250\nFlowers $250\nBag $500\nCellphone $1200\nLottery Ticket $85","Buy","Close");
			}
			case 2:
			{
				if(GetPlayerMoneyEx(playerid) < 500) return SendClientMessage(playerid,GREY,"You don't have enough money on you");
  	 		   	GameTextForPlayer(playerid,"~r~-$500",1000,1);
        	   	GivePlayerMoneyEx(playerid,-500);
       			GivePlayerWeaponEx(playerid,2,1);
			   	SendClientMessage(playerid,YELLOW,"You've purchased a Golf Bat");
			   	ShowPlayerDialog(playerid,SHOP,DIALOG_STYLE_LIST,"24/7 Shop","Vehicle Keys $2400\nFuelcan $1000\nGolf Club $500\nBaseBall Bat $750\nCigarettes $25\nCamera $250\nFlowers $250\nBag $500\nCellphone $1200\nLottery Ticket $850","Buy","Close");
			}
			case 3:
			{

		   	 	if(GetPlayerMoneyEx(playerid) < 750) return SendClientMessage(playerid,GREY,"You don't have enough money on you");
  	 		   	GameTextForPlayer(playerid,"~r~-$750",1000,1);
        	   	GivePlayerMoneyEx(playerid,-750);
       			GivePlayerWeaponEx(playerid,5,1);
			   	SendClientMessage(playerid,YELLOW,"You've purchased a BaseBall Bat");
				ShowPlayerDialog(playerid,SHOP,DIALOG_STYLE_LIST,"24/7 Shop","Vehicle Keys $2400\nFuelcan $1000\nGolf Club $500\nBaseBall Bat $750\nCigarettes $25\nCamera $250\nFlowers $250\nBag $500\nCellphone $1200\nLottery Ticket $85","Buy","Close");
			}
			case 4:
			{

		   	 	if(GetPlayerMoneyEx(playerid) < 25) return SendClientMessage(playerid,GREY,"You don't have enough money on you");
		   	 	if(Bag[playerid]==0)return SendClientMessage(playerid,GREY,"You need to buy the bag first");
  	 		   	GameTextForPlayer(playerid,"~r~-$25",1000,1);
        	   	GivePlayerMoneyEx(playerid,-25);
       			Cigars[playerid]=Cigars[playerid]+5;
			   	SendClientMessage(playerid,YELLOW,"You've purchased a Packet of Cigars");
				ShowPlayerDialog(playerid,SHOP,DIALOG_STYLE_LIST,"24/7 Shop","Vehicle Keys $2400\nFuelcan $1000\nGolf Club $500\nBaseBall Bat $750\nCigarettes $25\nCamera $250\nFlowers $250\nBag $500\nCellphone $1200\nLottery Ticket $85","Buy","Close");
			}
			case 5:
			{

		   	 	if(GetPlayerMoneyEx(playerid) < 250) return SendClientMessage(playerid,GREY,"You don't have enough money on you");
		   	 	if(Bag[playerid]==0)return SendClientMessage(playerid,GREY,"You need to buy the bag first");
  	 		   	GameTextForPlayer(playerid,"~r~-$250",1000,1);
        	   	GivePlayerMoneyEx(playerid,-250);
       			GivePlayerWeaponEx(playerid,43,50);
			   	SendClientMessage(playerid,YELLOW,"You've purchased a Camera");
				ShowPlayerDialog(playerid,SHOP,DIALOG_STYLE_LIST,"24/7 Shop","Vehicle Keys $2400\nFuelcan $1000\nGolf Club $500\nBaseBall Bat $750\nCigarettes $25\nCamera $250\nFlowers $250\nBag $500\nCellphone $1200\nLottery Ticket $85","Buy","Close");
			}
			case 6:
			{

		   	 	if(GetPlayerMoneyEx(playerid) < 250) return SendClientMessage(playerid,GREY,"You don't have enough money on you");
  	 		   	GameTextForPlayer(playerid,"~r~-$250",1000,1);
        	   	GivePlayerMoneyEx(playerid,-250);
       			GivePlayerWeaponEx(playerid,14,1);
			   	SendClientMessage(playerid,YELLOW,"You've purchased Flowers");
				ShowPlayerDialog(playerid,SHOP,DIALOG_STYLE_LIST,"24/7 Shop","Vehicle Keys $2400\nFuelcan $1000\nGolf Club $500\nBaseBall Bat $750\nCigarettes $25\nCamera $250\nFlowers $250\nBag $500\nCellphone $1200\nLottery Ticket $85","Buy","Close");
			}
			case 7:
			{
				if(GetPlayerMoneyEx(playerid) < 500) return SendClientMessage(playerid,GREY,"You don't have enough money on you");
                if(Bag[playerid]==1)return SendClientMessage(playerid,GREY,"You already got a Bag");
		      	GameTextForPlayer(playerid,"~r~-$500",1000,1);
        	   	GivePlayerMoneyEx(playerid,-500);
       			Bag[playerid]=1;
			   	SendClientMessage(playerid,YELLOW,"You've purchased a Bag");
				ShowPlayerDialog(playerid,SHOP,DIALOG_STYLE_LIST,"24/7 Shop","Vehicle Keys $2400\nFuelcan $1000\nGolf Club $500\nBaseBall Bat $750\nCigarettes $25\nCamera $250\nFlowers $250\nBag $500\nCellphone $1200\nLottery Ticket $85","Buy","Close");
			}
			case 8:
			{
				if(Cell[playerid]>0)return SendClientMessage(playerid,GREY,"You cannot buy more than 1 cell phone");
		   	 	if(GetPlayerMoneyEx(playerid) < 1200) return SendClientMessage(playerid,GREY,"You don't have enough money on you");
                if(Bag[playerid]==0)return SendClientMessage(playerid,GREY,"You need to buy the bag first");
				new randphone=100000 + random(899999),string[128];
				GameTextForPlayer(playerid,"~r~-$1200",1000,1);
       			Cell[playerid]=randphone;
        	   	GivePlayerMoneyEx(playerid,-1200);
       			format(string,sizeof(string),"You've purchased a CellPhone,your cell number is {FFFF00}%d",randphone);
				SendClientMessage(playerid,YELLOW,string);
			}
			case 9:
			{
				if(Lotto[playerid]>0)return SendClientMessage(playerid,GREY,"You cannot buy more than 1 Lottery Ticket");
		   	 	if(GetPlayerMoneyEx(playerid) < 85) return SendClientMessage(playerid,GREY,"You don't have enough money on you");
                if(Bag[playerid]==0)return SendClientMessage(playerid,GREY,"You need to buy the bag first");
				GameTextForPlayer(playerid,"~r~-$85",1000,1);
        	   	GivePlayerMoneyEx(playerid,-85);
	   			new randlotto=70 + random(11),string[128];
       			Lotto[playerid]=randlotto;
        	   	format(string,sizeof(string),"You've purchased a Lottery Ticket,your number is {FFFF00}%d",randlotto);
				SendClientMessage(playerid,YELLOW,string);
			}
		}
	}
	if(dialogid==FIGHT)
    {
        if(response)
        {
    		if(listitem==0)
		    {
		        if(GetPlayerScore(playerid) < 4) return SendClientMessage(playerid,GREY,"You need a score more than 4 to learn a fighting style");
		        if(GetPlayerMoneyEx(playerid) < 1000) return SendClientMessage(playerid,GREY,"You don't have enough money on you");
      			SetPlayerFightingStyle(playerid,FIGHT_STYLE_NORMAL);
		  		GivePlayerMoneyEx(playerid,-1000);
  				Fstyle[playerid]=4;
       			GameTextForPlayer(playerid,"~r~-$1000",1000,1);
				SendClientMessage(playerid,YELLOW,"You have changed your fighting style to a Normal Fighting Style");
			}
			if(listitem==1)
			{
		        if(GetPlayerScore(playerid) < 4) return SendClientMessage(playerid,GREY,"You need a score more than 4 to learn a fighting style");
		        if(GetPlayerMoneyEx(playerid) < 1000) return SendClientMessage(playerid,GREY,"You don't have enough money on you");
				GivePlayerMoneyEx(playerid,-1000);
  				Fstyle[playerid]=5;
       			GameTextForPlayer(playerid,"~r~-$1000",1000,1);
				SetPlayerFightingStyle(playerid,FIGHT_STYLE_BOXING);
				SendClientMessage(playerid,YELLOW,"You have changed your fighting style to a Boxing Fighting Style");
			}
			if(listitem==2)
			{
		        if(GetPlayerScore(playerid) < 4) return SendClientMessage(playerid,GREY,"You need a score more than 4 to learn a fighting style");
		        if(GetPlayerMoneyEx(playerid) < 1000) return SendClientMessage(playerid,GREY,"You don't have enough money on you");
			    GivePlayerMoneyEx(playerid,-1000);
  				Fstyle[playerid]=7;
       			GameTextForPlayer(playerid,"~r~-$1000",1000,1);
				SetPlayerFightingStyle(playerid,FIGHT_STYLE_KNEEHEAD);
				SendClientMessage(playerid,YELLOW,"You have changed your fighting style to a KneeHead Fighting Style");
			}
			if(listitem==3)
			{
		        if(GetPlayerScore(playerid) < 4) return SendClientMessage(playerid,GREY,"You need a score more than 4 to learn a fighting style");
		        if(GetPlayerMoneyEx(playerid) < 1000) return SendClientMessage(playerid,GREY,"You don't have enough money on you");
			    GivePlayerMoneyEx(playerid,-1000);
  				Fstyle[playerid]=6;
       			GameTextForPlayer(playerid,"~r~-$1000",1000,1);
				SetPlayerFightingStyle(playerid,FIGHT_STYLE_KUNGFU);
				SendClientMessage(playerid,YELLOW,"You have changed your fighting style to a Kung Fu Fighting Style");
			}
			if(listitem==4)
			{
		        if(GetPlayerScore(playerid) < 4) return SendClientMessage(playerid,GREY,"You need a score more than 4 to learn a fighting style");
		        if(GetPlayerMoneyEx(playerid) < 1000) return SendClientMessage(playerid,GREY,"You don't have enough money on you");
			    GivePlayerMoneyEx(playerid,-1000);
  				Fstyle[playerid]=15;
       			GameTextForPlayer(playerid,"~r~-$1000",1000,1);
				SetPlayerFightingStyle(playerid,FIGHT_STYLE_GRABKICK);
				SendClientMessage(playerid,YELLOW,"You have changed your fighting style to a GrabKick Fighting Style");
			}
			if(listitem==5)
			{
		        if(GetPlayerScore(playerid) < 4) return SendClientMessage(playerid,GREY,"You need a score more than 4 to learn a fighting style");
		        if(GetPlayerMoneyEx(playerid) < 1000) return SendClientMessage(playerid,GREY,"You don't have enough money on you");
			    GivePlayerMoneyEx(playerid,-1000);
  				Fstyle[playerid]=16;
       			GameTextForPlayer(playerid,"~r~-$1000",1000,1);
				SetPlayerFightingStyle(playerid,FIGHT_STYLE_ELBOW);
				SendClientMessage(playerid,YELLOW,"You have changed your fighting style to a Elbow Fighting Style");
			}
        }
        return 1;
    }
	if(dialogid==CAR)
	{
		if(!response) return 1;
		switch(listitem)
		{
			case 0:
			{
			   	new vehicleid=GetPlayerVehicleID(playerid);
				new engine,lights,alarm,doors,bonnet,boot,objective;
				GetVehicleParamsEx(vehicleid,engine,lights,alarm,doors,bonnet,boot,objective);
				if(engine==1)
				{
		    		SetVehicleParamsEx(vehicleid,0,lights,alarm,doors,bonnet,boot,objective);
					ShowPlayerDialog(playerid,CAR,DIALOG_STYLE_LIST,"Vehicle Control","Engine\nLights\nHood\nTrunk\nDoors\nAlarm","Choose","");
				}
				else
				{
		    		SetVehicleParamsEx(vehicleid,1,lights,alarm,doors,bonnet,boot,objective);
					ShowPlayerDialog(playerid,CAR,DIALOG_STYLE_LIST,"Vehicle Control","Engine\nLights\nHood\nTrunk\nDoors\nAlarm","Choose","");
				}
			}
			case 1:
			{
			    new vehicleid=GetPlayerVehicleID(playerid);
				new engine,lights,alarm,doors,bonnet,boot,objective;
				GetVehicleParamsEx(vehicleid,engine,lights,alarm,doors,bonnet,boot,objective);
				if(lights==1)
				{
		    		SetVehicleParamsEx(vehicleid,engine,0,alarm,doors,bonnet,boot,objective);
					ShowPlayerDialog(playerid,CAR,DIALOG_STYLE_LIST,"Vehicle Control","Engine\nLights\nHood\nTrunk\nDoors\nAlarm","Choose","");
				}
				else
				{
		    		SetVehicleParamsEx(vehicleid,engine,1,alarm,doors,bonnet,boot,objective);
					ShowPlayerDialog(playerid,CAR,DIALOG_STYLE_LIST,"Vehicle Control","Engine\nLights\nHood\nTrunk\nDoors\nAlarm","Choose","");
				}
			}
			case 2:
			{
       			new vehicleid=GetPlayerVehicleID(playerid);
				new engine,lights,alarm,doors,bonnet,boot,objective;
				GetVehicleParamsEx(vehicleid,engine,lights,alarm,doors,bonnet,boot,objective);
				if(bonnet==1)
				{
		    		SetVehicleParamsEx(vehicleid,engine,lights,alarm,doors,0,boot,objective);
					ShowPlayerDialog(playerid,CAR,DIALOG_STYLE_LIST,"Vehicle Control","Engine\nLights\nHood\nTrunk\nDoors\nAlarm","Choose","");
				}
				else
				{
		    		SetVehicleParamsEx(vehicleid,engine,lights,alarm,doors,1,boot,objective);
					ShowPlayerDialog(playerid,CAR,DIALOG_STYLE_LIST,"Vehicle Control","Engine\nLights\nHood\nTrunk\nDoors\nAlarm","Choose","");
				}
			}
			case 3:
			{
       			new vehicleid=GetPlayerVehicleID(playerid);
				new engine,lights,alarm,doors,bonnet,boot,objective;
				GetVehicleParamsEx(vehicleid,engine,lights,alarm,doors,bonnet,boot,objective);
				if(boot==1)
				{
		    		SetVehicleParamsEx(vehicleid,engine,lights,alarm,doors,bonnet,0,objective);
					ShowPlayerDialog(playerid,CAR,DIALOG_STYLE_LIST,"Vehicle Control","Engine\nLights\nHood\nTrunk\nDoors\nAlarm","Choose","");
				}
				else
				{
 					SetVehicleParamsEx(vehicleid,engine,lights,alarm,doors,bonnet,1,objective);
					ShowPlayerDialog(playerid,CAR,DIALOG_STYLE_LIST,"Vehicle Control","Engine\nLights\nHood\nTrunk\nDoors\nAlarm","Choose","");
				}
			}
			case 4:
			{
       			new vehicleid=GetPlayerVehicleID(playerid);
				new engine,lights,alarm,doors,bonnet,boot,objective;
				GetVehicleParamsEx(vehicleid,engine,lights,alarm,doors,bonnet,boot,objective);
				if(doors==1)
				{
		    		SetVehicleParamsEx(vehicleid,engine,lights,alarm,0,bonnet,boot,objective);
					ShowPlayerDialog(playerid,CAR,DIALOG_STYLE_LIST,"Vehicle Control","Engine\nLights\nHood\nTrunk\nDoors\nAlarm","Choose","");
				}
				else
				{
 					SetVehicleParamsEx(vehicleid,engine,lights,alarm,1,bonnet,boot,objective);
					ShowPlayerDialog(playerid,CAR,DIALOG_STYLE_LIST,"Vehicle Control","Engine\nLights\nHood\nTrunk\nDoors\nAlarm","Choose","");
				}
			}
			case 5:
			{
       			new vehicleid=GetPlayerVehicleID(playerid);
				new engine,lights,alarm,doors,bonnet,boot,objective;
				GetVehicleParamsEx(vehicleid,engine,lights,alarm,doors,bonnet,boot,objective);
				if(alarm==1)
				{
		    		SetVehicleParamsEx(vehicleid,engine,lights,0,doors,bonnet,boot,objective);
					ShowPlayerDialog(playerid,CAR,DIALOG_STYLE_LIST,"Vehicle Control","Engine\nLights\nHood\nTrunk\nDoors\nAlarm","Choose","");
				}
				else
				{
 					SetVehicleParamsEx(vehicleid,engine,lights,1,doors,bonnet,boot,objective);
					ShowPlayerDialog(playerid,CAR,DIALOG_STYLE_LIST,"Vehicle Control","Engine\nLights\nHood\nTrunk\nDoors\nAlarm","Choose","");
				}
			}
		}
	}
	if(dialogid==PROFIT)
	{
	    new str[128];
	    if(!response)return 0;
	    format(str,sizeof(str),"You have collected the profit of $%i from your business",INI_Int(Acc(playerid),"Profit"));
		SendClientMessage(playerid,YELLOW,str);
		GivePlayerMoneyEx(playerid,INI_Int(Acc(playerid),"Profit"));
		format(str,sizeof(str),"~g~+$%i",INI_Int(Acc(playerid),"Profit"));
		GameTextForPlayer(playerid,str,800,1);
		INI_IntSet(Acc(playerid),"Profit",0);
		return 1;
	}
	if(dialogid==AIRPORT)
 	{
  		if(!response) return 1;
		switch(listitem)
    	{
     		case 0:
       		{
       		    if(GetPlayerWantedLevel(playerid)>0)return SendClientMessage(playerid,GREY,"You are wanted");
         		if(GetPlayerMoneyEx(playerid)<1500)return SendClientMessage(playerid,GREY,"You don't have enough money on you");
         		if(Airport[playerid]>0)return SendClientMessage(playerid,GREY,"Your flight is already booked");
				if(IsPlayerInRangeOfPoint(playerid,5,1638.9767,-2334.1077,13.5469))return SendClientMessage(playerid,GREY,"You are already in Los Santos Airport");
				SendClientMessage(playerid,-1,"Please be seated and wait till we land");
				SetPlayerPos(playerid,1.808619,32.384357,1199.593750);
				GameTextForPlayer(playerid,"~r~-$1500",1000,1);
				GivePlayerMoneyEx(playerid,-1500);
				SetPlayerInterior(playerid,1);
				Airport[playerid]=1;
           	}
            case 1:
            {
                if(GetPlayerWantedLevel(playerid)>0)return SendClientMessage(playerid,GREY,"You are wanted");
            	if(GetPlayerMoneyEx(playerid)<1500)return SendClientMessage(playerid,GREY,"You don't have enough money on you");
         		if(Airport[playerid]>0)return SendClientMessage(playerid,GREY,"Your flight is already booked");
                if(IsPlayerInRangeOfPoint(playerid,5,1674.7411,1450.8416,10.7816))return SendClientMessage(playerid,GREY,"You are already in Las Venturas Airport");
				SendClientMessage(playerid,-1,"Please be seated and wait till we land");
				SetPlayerPos(playerid,1.808619,32.384357,1199.593750);
				GameTextForPlayer(playerid,"~r~-$1500",1000,1);
				GivePlayerMoneyEx(playerid,-1500);
				SetPlayerInterior(playerid,1);
				Airport[playerid]=2;
            }
            case 2:
            {
                if(GetPlayerWantedLevel(playerid)>0)return SendClientMessage(playerid,GREY,"You are wanted");
            	if(GetPlayerMoneyEx(playerid)<1500)return SendClientMessage(playerid,GREY,"You don't have enough money on you");
         		if(Airport[playerid]>0)return SendClientMessage(playerid,GREY,"Your flight is already booked");
         		if(IsPlayerInRangeOfPoint(playerid,5,-1419.3757,-289.6737,14.1484))return SendClientMessage(playerid,GREY,"You are already in San Fierro Airport");
				SendClientMessage(playerid,-1,"Please be seated and wait till we land");
				SetPlayerPos(playerid,1.808619,32.384357,1199.593750);
				GameTextForPlayer(playerid,"~r~-$1500",1000,1);
				GivePlayerMoneyEx(playerid,-1500);
				SetPlayerInterior(playerid,1);
				Airport[playerid]=3;
            }
		}
		return 1;
	}
    if(dialogid==FIRSTDIALOG)
	{
		if(!response) return 1;
		switch(listitem)
		{
			case 0:
			{
   				if(TheoryPassed[playerid]==1)return SendClientMessage(playerid,GREY,"You have already passed your theory test");
				ShowPlayerDialog(playerid,QUESTION1,DIALOG_STYLE_LIST,"Can Drugs affect your driving?","No,unless they've been prescribed by a Doctor\nYes\nNo","Select","");
			}
			case 1:
			{
			    if(TheoryPassed[playerid]==1)
				{
	        		Time[playerid]=gettime()+60*3;
	        		GivePlayerMoneyEx(playerid,-500);
					License[playerid][StepD]=1;
					License[playerid][Vehicle]=AddStaticVehicleEx(496,-2025.3169,-96.5181,34.9307,90.1800,-1,-1,-1);
					SetVehicleParamsEx(License[playerid][Vehicle],1,0,0,0,0,0,0);
					PutPlayerInVehicle(playerid,License[playerid][Vehicle],0);
					SetPlayerInterior(playerid,0);
	        		GameTextForPlayer(playerid,"~r~-$500",1000,1);
				}else return SendClientMessage(playerid,GREY,"You need to pass your theory tests first");

			}
		}
	}
	if(dialogid==QUESTION1)
	{
		if(!response) return 1;
		switch(listitem)
		{
			case 0:
			{
				ShowPlayerDialog(playerid,QUESTION2,DIALOG_STYLE_LIST,"On which lane should a driver drive?","Left Lane\nRight Lane\nDepends on his wish","Select","");
				Questions[playerid]=Questions[playerid]+1;
			}
			case 1:
			{
			    ShowPlayerDialog(playerid,QUESTION2,DIALOG_STYLE_LIST,"On which lane should a driver drive?","Left Lane\nRight Lane\nDepends on his wish","Select","");
			}
			case 2:
			{
			    ShowPlayerDialog(playerid,QUESTION2,DIALOG_STYLE_LIST,"On which lane should a driver drive?","Left Lane\nRight Lane\nDepends on his wish","Select","");
			}
		}
	}
	if(dialogid==QUESTION2)
	{
		if(!response) return 1;
		switch(listitem)
		{
			case 0:
			{
				ShowPlayerDialog(playerid,QUESTION3,DIALOG_STYLE_LIST,"What if you hit a car with no driver in it?","We silently run away\nSteal his car\nWe leave our cell number to his car","Select","");
			}
			case 1:
			{
			    ShowPlayerDialog(playerid,QUESTION3,DIALOG_STYLE_LIST,"What if you hit a car with no driver in it?","We silently run away\nSteal his car\nWe leave our cell number to his car","Select","");
				Questions[playerid]=Questions[playerid]+1;
			}
			case 2:
			{
			    ShowPlayerDialog(playerid,QUESTION3,DIALOG_STYLE_LIST,"What if you hit a car with no driver in it?","We silently run away\nSteal his car\nWe leave our cell number to his car","Select","");
			}
		}
	}
	if(dialogid==QUESTION3)
	{
		if(!response) return 1;
		switch(listitem)
		{
			case 0:
			{
				ShowPlayerDialog(playerid,QUESTION4,DIALOG_STYLE_LIST,"Before Changing lane,you need to:","Give a signal\nSpeed Up\nSwitch off the engine","Select","");
			}
			case 1:
			{
			    ShowPlayerDialog(playerid,QUESTION4,DIALOG_STYLE_LIST,"Before Changing lane,you need to:","Give a signal\nSpeed Up\nSwitch off the engine","Select","");
			}
			case 2:
			{
			    ShowPlayerDialog(playerid,QUESTION4,DIALOG_STYLE_LIST,"Before Changing lane,you need to:","Give a signal\nSpeed Up\nSwitch off the engine","Select","");
			    Questions[playerid]=Questions[playerid]+1;
			}
		}
	}
	if(dialogid==QUESTION4)
	{
		if(!response) return 1;
		switch(listitem)
		{
			case 0:
			{
				ShowPlayerDialog(playerid,QUESTION5,DIALOG_STYLE_LIST,"When are you allowed to use cellphone while driving?","Park the car in mid of the road and use it\nAt the red signal\nWhile no cops are near","Select","");
			    Questions[playerid]=Questions[playerid]+1;
			}
			case 1:
			{
			   ShowPlayerDialog(playerid,QUESTION5,DIALOG_STYLE_LIST,"When are you allowed to use cellphone while driving?","Park the car in mid of the road and use it\nAt the red signal\nWhile no cops are near","Select","");
			}
			case 2:
			{
			    ShowPlayerDialog(playerid,QUESTION5,DIALOG_STYLE_LIST,"When are you allowed to use cellphone while driving?","Park the car in mid of the road and use it\nAt the red signal\nWhile no cops are near","Select","");
			}
		}
	}
	if(dialogid==QUESTION5)
	{
		if(!response) return 1;
		switch(listitem)
		{
			case 0:
			{
				ShowPlayerDialog(playerid,QUESTION6,DIALOG_STYLE_LIST,"What you do when you hear a cop siren?","Make a run\nPull the handbrake and park the car\nPull over the vehicle","Select","");
			}
			case 1:
			{
   				ShowPlayerDialog(playerid,QUESTION6,DIALOG_STYLE_LIST,"What you do when you hear a cop siren?","Make a run\nPull the handbrake and park the car\nPull over the vehicle","Select","");
		    	Questions[playerid]=Questions[playerid]+1;
			}
			case 2:
			{
			    ShowPlayerDialog(playerid,QUESTION6,DIALOG_STYLE_LIST,"What you do when you hear a cop siren?","Make a run\nPull the handbrake and park the car\nPull over the vehicle","Select","");
			}
		}
	}
	if(dialogid==QUESTION6)
	{
		if(!response) return 1;
		switch(listitem)
		{
			case 0:
			{
				ShowPlayerDialog(playerid,QUESTION7,DIALOG_STYLE_LIST,"What you do when a car accident takes place","Kill the other guy\nCall the emergency line","Select","");
			}
			case 1:
			{
   				ShowPlayerDialog(playerid,QUESTION7,DIALOG_STYLE_LIST,"What you do when a car accident takes place","Kill the other guy\nCall the emergency line","Select","");
			}
			case 2:
			{
			    ShowPlayerDialog(playerid,QUESTION7,DIALOG_STYLE_LIST,"What you do when a car accident takes place","Kill the other guy\nCall the emergency line","Select","");
		    	Questions[playerid]=Questions[playerid]+1;
			}
		}
	}
	if(dialogid==QUESTION7)
	{
		if(!response) return 1;
		switch(listitem)
		{
			case 0:
			{
				ShowPlayerDialog(playerid,QUESTION8,DIALOG_STYLE_LIST,"When are you permitted to pass a vehicle,on the right?","When the vehicle is stopped.\nWhen the vehicle is driving slowly.\nWhen the vehicle has it's left signals on. ","Select","");
			}
			case 1:
			{
   				ShowPlayerDialog(playerid,QUESTION8,DIALOG_STYLE_LIST,"When are you permitted to pass a vehicle,on the right?","When the vehicle is stopped.\nWhen the vehicle is driving slowly.\nWhen the vehicle has it's left signals on. ","Select","");
   				Questions[playerid]=Questions[playerid]+1;
			}
		}
	}
	if(dialogid==QUESTION8)
	{
		if(!response) return 1;
		switch(listitem)
		{
			case 0:
			{
			    if(Questions[playerid]>6){
				SendClientMessage(playerid,YELLOW,"You have passed your theory test,you may proceed to the practical one now");
   				TheoryPassed[playerid]=1;}
			    else if(Questions[playerid]<6){
				SendClientMessage(playerid,LRED,"You have failed your theory test");
   				TheoryPassed[playerid]=0;}
			}
			case 1:
			{
   				if(Questions[playerid]>=6){
				SendClientMessage(playerid,YELLOW,"You have passed your theory test,you may proceed to the Practical one now");
   				TheoryPassed[playerid]=1;}
			    else if(Questions[playerid]<6){
				SendClientMessage(playerid,LRED,"You have failed your theory test");
   				TheoryPassed[playerid]=0;}
			}
			case 2:
			{
   				Questions[playerid]=Questions[playerid]+1;
				if(Questions[playerid]>=6){
				SendClientMessage(playerid,YELLOW,"You have passed your theory test,you may proceed to the Practical one now");
   				TheoryPassed[playerid]=1;}
			    else if(Questions[playerid]<6){
				SendClientMessage(playerid,LRED,"You have failed your theory test");
   				TheoryPassed[playerid]=0;}
			}
		}
	}
	if(dialogid==ORGCP && response)
	{
        switch(listitem)
		{
            case 0:
            {
                for(new i=1;i<OrgsCount+1;i++)
				{
                    if(IsPlayerInRangeOfPoint(playerid,3.0,Organization[i][OrgX],Organization[i][OrgY],Organization[i][OrgZ]))
					{
					    if(PlayerOrg[playerid]!=i)
					    {
							new string[120];
							if(PlayerOrg[playerid] > 0) return SendClientMessage(playerid,GREY,"You already belong to an organization");
							if(Requesting[playerid] > 0) return SendClientMessage(playerid,GREY,"You are already requesting to join an organization");
							if(!IsLeaderOnline(i)) return SendClientMessage(playerid,GREY,"The leader of this organization is currently offline");
							format(string,sizeof(string),"%s is requesting to join the %s",PlayerName(playerid),GetOrgName(i));
   							GameTextForPlayer(playerid,"Request Sent",1000,4);
   							SendClientMessageToAll(YELLOW,string);
							Requesting[playerid]=i;
					    }
						if(PlayerOrg[playerid]==i)
					    {
					        if(response)
					        {
                        		new string[256];
                        		if(Organization[i][Drugs]>0)
                        		{
                        		    format(string,256,"{A9C4E4}Organization: {FFFFFF}%s\n{A9C4E4}Current Leader: {FFFFFF}%s\n{A9C4E4}Organization Balance: {FFFFFF}$%d\n{A9C4E4}Organization Members: {FFFFFF}%d\n{A9C4E4}Drug Packs: {FFFFFF}%d",GetOrgName(i),Organization[i][Leader],Organization[i][Money],Organization[i][Members],Organization[i][Drugs]);
								}
								else
								{
                        			format(string,256,"{A9C4E4}Organization: {FFFFFF}%s\n{A9C4E4}Current Leader: {FFFFFF}%s\n{A9C4E4}Organization Balance: {FFFFFF}$%d\n{A9C4E4}Organization Members: {FFFFFF}%d",GetOrgName(i),Organization[i][Leader],Organization[i][Money],Organization[i][Members]);
								}
								ShowPlayerDialog(playerid,MISCEL,DIALOG_STYLE_MSGBOX,"Organization",string,"Close","");
                        		return 1;
							}
						}
					}
                }
            }
            case 1:
            {
                for(new i=1;i<OrgsCount+1;i++)
				{
                    if(IsPlayerInRangeOfPoint(playerid,3.0,Organization[i][OrgX],Organization[i][OrgY],Organization[i][OrgZ]))
					{
   						if(Organization[i][Members]>0)
		   				{
		   					new string[256],member1[25],member2[25],member3[25],member4[25],member5[25],member6[25],member7[25];
		   					if(strcmp(Organization[i][Member1],"None") !=0){format(member1,25,Organization[i][Member1]);}
		   					if(strcmp(Organization[i][Member2],"None") !=0){format(member2,25,Organization[i][Member2]);}
		   					if(strcmp(Organization[i][Member3],"None") !=0){format(member3,25,Organization[i][Member3]);}
		   					if(strcmp(Organization[i][Member4],"None") !=0){format(member4,25,Organization[i][Member4]);}
		   					if(strcmp(Organization[i][Member5],"None") !=0){format(member5,25,Organization[i][Member5]);}
		   					if(strcmp(Organization[i][Member6],"None") !=0){format(member6,25,Organization[i][Member6]);}
		   					if(strcmp(Organization[i][Member7],"None") !=0){format(member7,25,Organization[i][Member7]);}
       						format(string,sizeof(string),"%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s",Organization[i][Leader],member1,member2,member3,member4,member5,member6,member7);
    						ShowPlayerDialog(playerid,ORGMEMBERS,DIALOG_STYLE_LIST,"Organization Members",string,"Close","");
                    		return 1;
						}else SendClientMessage(playerid,GREY,"There are no members in this organization");
					}
				}
            }
            case 2:
            {
				for(new i=1;i<OrgsCount+1;i++)
				{
                    if(IsPlayerInRangeOfPoint(playerid,3.0,Organization[i][OrgX],Organization[i][OrgY],Organization[i][OrgZ]))
					{
						if(PlayerOrg[playerid]!=i)
    					{
							ShowPlayerDialog(playerid,MISCEL,DIALOG_STYLE_LIST,"Organization Turfs",Organization[i][Turf],"Close","");
							return 1;
						}
					}
				}
                if(PlayerLeader[playerid]==0)
                {
                	if(CollectedWage[playerid] <=0) return SendClientMessage(playerid,GREY,"You didn't earn anything yet");
                	new string[80];
                	format(string,sizeof(string),"You have collected $%d of wage",CollectedWage[playerid]);
                	SendClientMessage(playerid,YELLOW,string);
                	GivePlayerMoneyEx(playerid,CollectedWage[playerid]);
                	CollectedWage[playerid]=0;
				}
				if(PlayerLeader[playerid]==1)
                {
					ShowPlayerDialog(playerid,UPGRADES,DIALOG_STYLE_LIST,"Organization Upgrages","Select Fighting Style\nSet Wage","Select","Close");
				}
				return 1;
            }
            case 3:
            {
                if(PlayerOrg[playerid] !=0)
				{
				    GiveOrgFeatures(playerid);
                }
            }
            case 4:
            {
                for(new i=1;i<OrgsCount+1;i++)
				{
                    if(IsPlayerInRangeOfPoint(playerid,3.0,Organization[i][OrgX],Organization[i][OrgY],Organization[i][OrgZ]))
					{
      					if(PlayerOrg[playerid]==i)
    					{
							ShowPlayerDialog(playerid,MISCEL,DIALOG_STYLE_LIST,"Organization Turfs",Organization[i][Turf],"Close","");
							return 1;
		   				}
					}
				}
            }

        }
        return 1;
    }
	if(dialogid==UPGRADES)
	{
		if(!response) return 1;
		switch(listitem)
		{
			case 0:
			{
                ShowPlayerDialog(playerid,OFIGHT,DIALOG_STYLE_LIST,"Organization Fighting Style","Normal Fighting Style\nBoxing Fighting Style\nKneeHead Fighting Style\nKungFu Fighting Style\nGrabKick Fighting Style\nElbow Fighting Style","Select","Close");
			}
			case 1:
			{
				ShowPlayerDialog(playerid,WAGE,DIALOG_STYLE_INPUT,"Organization Wage","{FFFFFF}Set the wage for your organization members\n Note: Wage cannot be lower than 200 or higher than 2000","Proceed","Close");
			}
		}
		return 1;
	}
	if(dialogid==OFIGHT)
    {
        if(response)
        {
    		if(listitem==0)
		    {
		        if(Organization[PlayerOrg[playerid]][Money]<150000) return SendClientMessage(playerid,GREY,"Your organization balance should be atleast $150000 to purchase this");
      			Organization[PlayerOrg[playerid]][FStyle]=4;
      			Organization[PlayerOrg[playerid]][Money]=Organization[PlayerOrg[playerid]][Money]-150000;
				SendClientMessage(playerid,YELLOW,"You have changed the fighting style of your organization members to Normal Fighting Style");
			}
			if(listitem==1)
			{
		        if(Organization[PlayerOrg[playerid]][Money]<150000) return SendClientMessage(playerid,GREY,"Your organization balance should be atleast $150000 to purchase this");
      			Organization[PlayerOrg[playerid]][FStyle]=5;
      			Organization[PlayerOrg[playerid]][Money]=Organization[PlayerOrg[playerid]][Money]-150000;
				SendClientMessage(playerid,YELLOW,"You have changed the fighting style of your organization members to Boxing Fighting Style");
			}
			if(listitem==2)
			{
		        if(Organization[PlayerOrg[playerid]][Money]<150000) return SendClientMessage(playerid,GREY,"Your organization balance should be atleast $150000 to purchase this");
      			Organization[PlayerOrg[playerid]][FStyle]=7;
      			Organization[PlayerOrg[playerid]][Money]=Organization[PlayerOrg[playerid]][Money]-150000;
				SendClientMessage(playerid,YELLOW,"You have changed the fighting style of your organization members to KneeHead Fighting Style");
			}
			if(listitem==3)
			{
		        if(Organization[PlayerOrg[playerid]][Money]<150000) return SendClientMessage(playerid,GREY,"Your organization balance should be atleast $150000 to purchase this");
      			Organization[PlayerOrg[playerid]][FStyle]=6;
      			Organization[PlayerOrg[playerid]][Money]=Organization[PlayerOrg[playerid]][Money]-150000;
				SendClientMessage(playerid,YELLOW,"You have changed the fighting style of your organization members to Kung Fu Fighting Style");
			}
			if(listitem==4)
			{
		        if(Organization[PlayerOrg[playerid]][Money]<150000) return SendClientMessage(playerid,GREY,"Your organization balance should be atleast $150000 to purchase this");
      			Organization[PlayerOrg[playerid]][FStyle]=15;
      			Organization[PlayerOrg[playerid]][Money]=Organization[PlayerOrg[playerid]][Money]-150000;
				SendClientMessage(playerid,YELLOW,"You have changed the fighting style of your organization members to GrabKick Fighting Style");
			}
			if(listitem==5)
			{
		        if(Organization[PlayerOrg[playerid]][Money]<150000) return SendClientMessage(playerid,GREY,"Your organization balance should be atleast $150000 to purchase this");
      			Organization[PlayerOrg[playerid]][FStyle]=16;
      			Organization[PlayerOrg[playerid]][Money]=Organization[PlayerOrg[playerid]][Money]-150000;
				SendClientMessage(playerid,YELLOW,"You have changed the fighting style of your organization members to Elbow Fighting Style");
			}
        }
        return 1;
    }
    if(dialogid==ORGREQUEST && response)
	{
		new string[120];
        if(PlayerOrg[playerid] > 0) return SendClientMessage(playerid,GREY,"You already belong to an organization");
		if(Requesting[playerid] > 0) return SendClientMessage(playerid,GREY,"You are already requesting to join an organization");
		if(!IsLeaderOnline(listitem+1)) return SendClientMessage(playerid,GREY,"The leader of this organization is currently offline");
		format(string,sizeof(string),"%s is requesting to join the %s",PlayerName(playerid),GetOrgName(listitem+1));
		SendClientMessageToAll(-1,string);
   		GameTextForPlayer(playerid,"Request Sent",1000,4);
		Requesting[playerid]=listitem+1;
		return 1;
	}
	if(dialogid==DEAL)
	{
		if(!response)return RemovePlayerFromVehicle(playerid);
		if(GetPlayerMoneyEx(playerid) < GetVehiclePrice(GetPlayerVehicleID(playerid)))return RemovePlayerFromVehicle(playerid)&&
		SendClientMessage(playerid,GREY,"You donot have enough money on you to buy this vehicle");
		if(BankID[playerid]==0)return RemovePlayerFromVehicle(playerid)&&
		SendClientMessage(playerid,GREY,"You donot have a bank account");
		if(Car[playerid]!=0)return RemovePlayerFromVehicle(playerid)&&
		SendClientMessage(playerid,GREY,"You already own a vehicle");
		new str[128],vehicle[24];
		GetVehicleName(GetPlayerVehicleID(playerid),vehicle,sizeof(vehicle));
		GivePlayerMoneyEx(playerid,-GetVehiclePrice(GetPlayerVehicleID(playerid)));
		if(dealer==1)
		{
			Car[playerid]=AddStaticVehicleEx(GetVehicleModel(GetPlayerVehicleID(playerid)),2107.4619,1382.9857,10.6841,177.0584,-1,-1,-1);
		}
		if(dealer==2)
		{
			Car[playerid]=AddStaticVehicleEx(GetVehicleModel(GetPlayerVehicleID(playerid)),2142.7175,-1121.6375,25.2600,262.7143,-1,-1,-1);
		}
		if(dealer==3)
		{
			Car[playerid]=AddStaticVehicleEx(GetVehicleModel(GetPlayerVehicleID(playerid)),-1989.2740,287.7194,33.8505,90.6863,-1,-1,-1);
		}
		if(dealer==4)
		{
			Car[playerid]=AddStaticVehicleEx(GetVehicleModel(GetPlayerVehicleID(playerid)),-1639.8102,1215.5056,6.6629,229.2032,-1,-1,-1);
		}
		if(dealer==5)
		{
			Car[playerid]=AddStaticVehicleEx(GetVehicleModel(GetPlayerVehicleID(playerid)),-1831.4525,-172.1997,8.9311,4.8678,-1,-1,-1);
		}
		if(dealer==6)
		{
			Car[playerid]=AddStaticVehicleEx(GetVehicleModel(GetPlayerVehicleID(playerid)),1756.0334,-1686.6527,13.1287,351.1371,-1,-1,-1);
		}
		if(dealer==7)
		{
			Car[playerid]=AddStaticVehicleEx(GetVehicleModel(GetPlayerVehicleID(playerid)),499.5259,2362.7202,29.9984,47.3147,-1,-1,-1);
		}
		if(dealer==8)
		{
			Car[playerid]=AddStaticVehicleEx(GetVehicleModel(GetPlayerVehicleID(playerid)),1732.8749,1863.8625,10.4050,99.4247,-1,-1,-1);
		}
		if(dealer==9)
		{
			Car[playerid]=AddStaticVehicleEx(GetVehicleModel(GetPlayerVehicleID(playerid)),1943.6582,2035.5415,10.5401,174.2254,-1,-1,-1);
		}
		if(dealer==10)
		{
			Car[playerid]=AddStaticVehicleEx(GetVehicleModel(GetPlayerVehicleID(playerid)),558.0236,-1262.0970,16.9693,18.9618,-1,-1,-1);
		}
		if(dealer==11)
		{
			Car[playerid]=AddStaticVehicleEx(GetVehicleModel(GetPlayerVehicleID(playerid)),-26.0381,-2522.2466,36.3153,116.8957,-1,-1,-1);
		}
		if(dealer==12)
		{
			Car[playerid]=AddStaticVehicleEx(GetVehicleModel(GetPlayerVehicleID(playerid)),-2206.5332,2440.4475,0.1451,319.3806,-1,-1,-1);
		}
		PutPlayerInVehicle(playerid,Car[playerid],0);
		format(str,sizeof(str),"You have purchased %s for $%d",vehicle,GetVehiclePrice(GetPlayerVehicleID(playerid)));
		SendClientMessage(playerid,YELLOW,str);
		ShowPlayerDialog(playerid,CARCOLOR,DIALOG_STYLE_LIST,"CAR COLOR","1.Black\n2.White\n3.Blue\n4.Red\n5.Pink\n6.Yellow\n7.Green","Select","");
		format(str,sizeof(str),"~r~-$%d",GetVehiclePrice(GetPlayerVehicleID(playerid)));
		GameTextForPlayer(playerid,str,1000,1);
		SetVehicleParamsEx(GetPlayerVehicleID(playerid),0,0,0,1,0,0,0);
	}
	if(dialogid==CARDEAL)
	{
		if(!response) return 1;
		switch(listitem)
		{
			case 0:
			{
			    ShowPlayerDialog(playerid,INSU,DIALOG_STYLE_LIST,"San Andreas Dealership","Purchase Insurance\nTerminate Insurance","Select","Close");
   			}
			case 1:
			{
				if(Lock[playerid]==1)return SendClientMessage(playerid,GREY,"You already have a Car Auto Lock");
				if(GetPlayerMoneyEx(playerid)<2400)return SendClientMessage(playerid,GREY,"You don't have enough money on you");
				Lock[playerid]=1;
				GivePlayerMoneyEx(playerid,-2400);
				GameTextForPlayer(playerid,"~r~-$2400",1000,1);
				SendClientMessage(playerid,YELLOW,"You have purchased a car lock system");
			}
			case 2:
			{
			    ShowPlayerDialog(playerid,NUM,DIALOG_STYLE_INPUT,"San Andreas Dealership","{FFFFFF}Enter the number plate text below\nNote: The number plate text should not contain more than 8 characters","Order","Close");
   			}
			case 3:
			{
			    ShowPlayerDialog(playerid,CARCOLOR,DIALOG_STYLE_LIST,"CAR COLOR","1.Black\n2.White\n3.Blue\n4.Red\n5.Pink\n6.Yellow\n7.Green","Select","");
			}
			case 4:
			{
			    new rand=(GetVehiclePrice(GetPlayerVehicleID(playerid))/100)*40,name[32],string[128];
			    GetVehicleName(Car[playerid],name,32);
				format(string,sizeof(string),"You sold your %s for $%i. The money has been sent to your bank account",name,rand);
				SendClientMessage(playerid,YELLOW,string);
				Bank[playerid]=Bank[playerid]+rand;
				format(string,sizeof(string),"~g~+$%i",rand);
				GameTextForPlayer(playerid,string,800,1);
				DestroyVehicle(Car[playerid]);
				Car[playerid]=0;
				Lock[playerid]=0;
				Alarm[playerid]=0;
				Insurance[playerid]=0;
   			}
			case 5:
			{
			    new rand=(GetVehiclePrice(GetPlayerVehicleID(playerid))/100)*40,name[32],string[128];
			    GetVehicleName(Car[playerid],name,32);
				format(string,sizeof(string),"You will get $%i for your %s",rand,name);
				SendClientMessage(playerid,ORANGE,string);
			}
			case 6:
			{
				if(Alarm[playerid]==1)return SendClientMessage(playerid,GREY,"You already have a Car Alarm System");
				if(GetPlayerMoneyEx(playerid)<1400)return SendClientMessage(playerid,GREY,"You don't have enough money on you");
				Alarm[playerid]=1;
				GivePlayerMoneyEx(playerid,-1400);
				GameTextForPlayer(playerid,"~r~-$1400",1000,1);
				SendClientMessage(playerid,YELLOW,"You have purchased a car alarm system");
			}
		}
		return 1;
	}
	if(dialogid==INSU)
	{
		if(!response) return 1;
		switch(listitem)
		{
			case 0:
			{
			    if(Insurance[playerid]==1)return SendClientMessage(playerid,GREY,"You already have a insurance for this vehicle");
				Insurance[playerid]=1;
				SendClientMessage(playerid,YELLOW,"You have issued a insurance for this vehicle");
   			}
			case 1:
			{
		 		if(Insurance[playerid]==0)return SendClientMessage(playerid,GREY,"You have no insurance for this vehicle already");
				Insurance[playerid]=0;
				SendClientMessage(playerid,-1,"You have terminated the insurance for this vehicle");
   			}
		}
		return 1;
	}
	if(dialogid==NUM)
	{
		if(!response) return 1;
		if(strlen(inputtext)>8)return ShowPlayerDialog(playerid,NUM,DIALOG_STYLE_INPUT,"San Andreas Dealership","{FFFFFF}Enter the number plate text below\nNote: The number plate text should not contain more than 8 characters","Order","Close");
		if(GetPlayerMoneyEx(playerid)<400)return SendClientMessage(playerid,GREY,"Number plate costs $400");
		GivePlayerMoneyEx(playerid,-200);
		format(VehNum[playerid],9,inputtext);
		GameTextForPlayer(playerid,"~r~-$400",1000,1);
		SendClientMessage(playerid,YELLOW,"Your desired number plate has been ordered");
        if(PlayerAwards[playerid][Plates]==0)
		{
			PlayerAwards[playerid][Plates]=1;
 			GivePlayerMoneyEx(playerid,100);
			GamerScore[playerid]=GamerScore[playerid]+50;
  			SendClientMessage(playerid,YELLOW,"Achievement Unlocked: {FFFFFF}Ma Platez!");
			SendClientMessage(playerid,LGREEN,"BONUS: $100 || +50 Gamer Score");
		}
		return 1;
	}
    if(dialogid==TUT)
	{
		if(response)
		{
			TogglePlayerControllable(playerid,0);
   			SetPlayerPos(playerid,2079.6685,971.9166,37.8261);
			SetPlayerCameraPos(playerid,2079.6685,971.9166,37.8261);
			SetPlayerCameraLookAt(playerid,2031.3771,1004.4495,22.0540);
			SendClientMessage(playerid,YELLOW,"We will go through a short and quick server tutorial/guide. Click 'Next' to continue or 'Close' to finish");
			ShowPlayerDialog(playerid,TUT1,DIALOG_STYLE_MSGBOX,"Server Guide - The 4D Casino","{FFFFFF}One of the most famous and interesting place in San Andreas\n where many players are found roaming","Next","Close");
		}
		else
		{
			TogglePlayerControllable(playerid,1);
   			SetPlayerPos(playerid,pX[playerid],pY[playerid],pZ[playerid]);
		}
		return 1;
	}
    if(dialogid==TUT1)
	{
		if(response)
		{
		 	SetPlayerPos(playerid,2160.5510,2013.9879,34.3836);
			SetPlayerCameraPos(playerid,2160.5510,2013.9879,34.3836);
			SetPlayerCameraLookAt(playerid,2190.2861,1993.9847,17.0470);
			ShowPlayerDialog(playerid,TUT2,DIALOG_STYLE_MSGBOX,"Server Guide - 24/7 Shop","{FFFFFF}A market where every useful stuff can be purchased.\nYou can buy stocks like Cellphones and Fuelcan","Next","Close");
		}
		else
		{
		    SpawnPlayer(playerid);
			TogglePlayerControllable(playerid,1);
   			SetPlayerPos(playerid,pX[playerid],pY[playerid],pZ[playerid]);
		}
		return 1;
	}
    if(dialogid==TUT2)
	{
		if(response)
		{
			SetPlayerPos(playerid,1327.2228,-1280,36.2890);
			SetPlayerCameraPos(playerid,1327.2228,-1280,36.2890);
			SetPlayerCameraLookAt(playerid,1362.6744,-1279.7654,17.1699);
			ShowPlayerDialog(playerid,TUT3,DIALOG_STYLE_MSGBOX,"Server Guide - AmmuNation","{FFFFFF}A shop where guns can be purchased.\nNote: You must have Gun License to keep guns legally or cops will\n arrest you","Next","Close");
		}
		else
		{
		    SpawnPlayer(playerid);
			TogglePlayerControllable(playerid,1);
			SetPlayerPos(playerid,pX[playerid],pY[playerid],pZ[playerid]);
		}
		return 1;
	}
    if(dialogid==TUT3)
	{
		if(response)
		{
			SetPlayerPos(playerid,2470.6982,1000.7332,20);
			SetPlayerCameraPos(playerid,2470.6982,1000.7332,20);
			SetPlayerCameraLookAt(playerid,2474.8789,1022.6317,13.5437);
			ShowPlayerDialog(playerid,TUT4,DIALOG_STYLE_MSGBOX,"Server Guide - Bank","{FFFFFF}This is one of the Banks In San Andreas\nBanks allow you to withdraw or deposit your money\n and provides many other facilities","Next","Close");
		}
		else
		{
		    SpawnPlayer(playerid);
			TogglePlayerControllable(playerid,1);
			SetPlayerPos(playerid,pX[playerid],pY[playerid],pZ[playerid]);
		}
		return 1;
	}
    if(dialogid==TUT4)
	{
		if(response)
		{
			SetPlayerPos(playerid,2450,1121.0461,28.1907);
			SetPlayerCameraPos(playerid,2450,1121.0461,28.1907);
			SetPlayerCameraLookAt(playerid,2419.2202,1123.6049,18.4028);
			ShowPlayerDialog(playerid,TUT5,DIALOG_STYLE_MSGBOX,"Server Guide - City Department","{FFFFFF}This is LV RP School/planning department\nHere you can get RolePlay marks by taking part in a RP lesson\nYou are also able to get many of the jobs from here","Next","Close");
		}
		else
		{
		    SpawnPlayer(playerid);
			TogglePlayerControllable(playerid,1);
			SetPlayerPos(playerid,pX[playerid],pY[playerid],pZ[playerid]);
		}
		return 1;
	}
    if(dialogid==TUT5)
	{
		if(response)
		{
			SetPlayerPos(playerid,384.2922,2535,28.6537);
			SetPlayerCameraPos(playerid,384.2922,2535,28.6537);
			SetPlayerCameraLookAt(playerid,409.3525,2534.5334,21.9862);
			ShowPlayerDialog(playerid,TUT6,DIALOG_STYLE_MSGBOX,"Server Guide - Flying School","{FFFFFF}This is the place where you have to pass practical test to get a Flying License","Next","Close");
		}
		else
		{
		    SpawnPlayer(playerid);
			TogglePlayerControllable(playerid,1);
			SetPlayerPos(playerid,pX[playerid],pY[playerid],pZ[playerid]);
		}
		return 1;
	}
    if(dialogid==TUT6)
	{
		if(response)
		{
			SetPlayerPos(playerid,-2012.3108,-78.4816,48);
			SetPlayerCameraPos(playerid,-2012.3108,-78.4816,48);
			SetPlayerCameraLookAt(playerid,-2027.4343,-100.0997,39.7279);
			ShowPlayerDialog(playerid,TUT7,DIALOG_STYLE_MSGBOX,"Server Guide - Driving School","{FFFFFF}You already know that driving vehicles without valid license is illegal\nTherefore this is the place where you can obtain your license","Next","Close");
		}
		else
		{
		    SpawnPlayer(playerid);
			TogglePlayerControllable(playerid,1);
			SetPlayerPos(playerid,pX[playerid],pY[playerid],pZ[playerid]);
		}
		return 1;
	}
    if(dialogid==TUT7)
	{
		if(response)
		{
			SetPlayerPos(playerid,1223.2250,-1289,31.9257);
			SetPlayerCameraPos(playerid,1223.2250,-1289,31.9257);
			SetPlayerCameraLookAt(playerid,1177.5485,-1323.5773,14.0761);
			ShowPlayerDialog(playerid,TUT8,DIALOG_STYLE_MSGBOX,"Server Guide - Hospital","{FFFFFF}One of the hospitals in San Andreas where you spawn after death\n Medics will charge you and confiscate your weapons","Next","Close");
		}
		else
		{
		    SpawnPlayer(playerid);
			TogglePlayerControllable(playerid,1);
			SetPlayerPos(playerid,pX[playerid],pY[playerid],pZ[playerid]);
		}
		return 1;
	}
    if(dialogid==TUT8)
	{
		if(response)
		{
			SetPlayerPos(playerid,1173.3220,1383.7501,12.3802);
			SetPlayerCameraPos(playerid,1173.3220,1383.7501,12.5802);
			SetPlayerCameraLookAt(playerid,1168.9822,1363.7888,13.3900);
			ShowPlayerDialog(playerid,TUT9,DIALOG_STYLE_MSGBOX,"Server Guide - Bike School","{FFFFFF}This is the bike school,where you will have to pass a practical test and get yourself bike license","Next","Close");
		}
		else
		{
		    SpawnPlayer(playerid);
			TogglePlayerControllable(playerid,1);
			SetPlayerPos(playerid,pX[playerid],pY[playerid],pZ[playerid]);
		}
		return 1;
	}
    if(dialogid==TUT9)
	{
		if(response)
		{
			SetPlayerPos(playerid,-1959.9182,1099.2802,56.9948);
			SetPlayerCameraPos(playerid,-1959.9182,1099.2802,56.5948);
			SetPlayerCameraLookAt(playerid,-1989.0254,1117.9299,54.4717);
			ShowPlayerDialog(playerid,TUT10,DIALOG_STYLE_MSGBOX,"Server Guide - The Church","{FFFFFF}This is the Church at San Fierro,Marriages are held here with the commands /propose and /acceptproposal\nNote: You need atleast 3 witnesses to witness your marriage","Next","Close");
		}
		else
		{
		    SpawnPlayer(playerid);
			TogglePlayerControllable(playerid,1);
			SetPlayerPos(playerid,pX[playerid],pY[playerid],pZ[playerid]);
		}
		return 1;
	}
    if(dialogid==TUT10)
	{
		if(response)
		{
			SetPlayerPos(playerid,1506.3059,-1675.0323,19.2422);
			SetPlayerCameraPos(playerid,1506.3059,-1675.0323,19.5422);
			SetPlayerCameraLookAt(playerid,1551.1582,-1676.1315,15.7291);
			ShowPlayerDialog(playerid,TUT11,DIALOG_STYLE_MSGBOX,"Server Guide - Police Department","{FFFFFF}This is one of the Police Departments in San Andreas,where the cops are found\nNote: You can use /call 911 for an emergency call to either call cops or medics","Next","Close");
		}
		else
		{
		    SpawnPlayer(playerid);
			TogglePlayerControllable(playerid,1);
			SetPlayerPos(playerid,pX[playerid],pY[playerid],pZ[playerid]);
		}
		return 1;
	}
    if(dialogid==TUT11)
	{
		if(response)
		{
			SetPlayerPos(playerid,1811.0945,-1688.3301,17.3354);
			SetPlayerCameraPos(playerid,1811.0945,-1688.3301,17.5354);
			SetPlayerCameraLookAt(playerid,1833.8680,-1682.8680,13.4553);
			ShowPlayerDialog(playerid,TUT12,DIALOG_STYLE_MSGBOX,"Server Guide - Clubs and Bars","{FFFFFF}Alhambra Night Clubs and other pubs offer you drinks for fun\nYou have the ability to purchase some of the pubs and have them as your business","Next","Close");
		}
		else
		{
		    SpawnPlayer(playerid);
			TogglePlayerControllable(playerid,1);
			SetPlayerPos(playerid,pX[playerid],pY[playerid],pZ[playerid]);
		}
		return 1;
	}
    if(dialogid==TUT12)
	{
		if(response)
		{
			SetPlayerPos(playerid,-1995.4313,239.9191,38.1719);
			SetPlayerCameraPos(playerid,-1995.4313,239.9191,38.5719);
			SetPlayerCameraLookAt(playerid,-1982.3243,265.0338,35.1719);
			ShowPlayerDialog(playerid,TUT13,DIALOG_STYLE_MSGBOX,"Server Guide - Car Dealers","{FFFFFF}Want to purchase a personal car? San Andreas Car Delears provide you the best cars with an insurance\nYou can buy auto-locks and desired number plates for your car from here","Finish","");
		}
		else
		{
		    SpawnPlayer(playerid);
			TogglePlayerControllable(playerid,1);
			SetPlayerPos(playerid,pX[playerid],pY[playerid],pZ[playerid]);
		}
		return 1;
	}
    if(dialogid==TUT13)
	{
		if(response)
		{
			SpawnPlayer(playerid);
			TogglePlayerControllable(playerid,1);
   			SetPlayerPos(playerid,pX[playerid],pY[playerid],pZ[playerid]);
			SendClientMessage(playerid,-1,"Thank you for your patience,enjoy your stay");
			if(PlayerAwards[playerid][Guide]==0)
			{
				PlayerAwards[playerid][Guide]=1;
 				GivePlayerMoneyEx(playerid,1000);
				GamerScore[playerid]=GamerScore[playerid]+60;
  				SendClientMessage(playerid,YELLOW,"Achievement Unlocked: {FFFFFF}City Guide!");
				SendClientMessage(playerid,LGREEN,"BONUS: $1000 || +60 Gamer Score");
			}
		}
		return 1;
	}
	if(dialogid==MUSIC)
	{
		if(!response) StopAudioStreamForPlayer(playerid);
		switch(listitem)
		{
			case 0:
			{
			    PlayAudioStreamForPlayer(playerid,"http://k006.kiwi6.com/hotlink/lo1u75sz1z/1jhak_maar_ke.mp3");
   			}
			case 1:
			{
		 		PlayAudioStreamForPlayer(playerid,"http://k006.kiwi6.com/hotlink/o4gvweyhss/18_linkin_park_papercut.mp3");
   			}
			case 2:
			{
		 		PlayAudioStreamForPlayer(playerid,"http://k006.kiwi6.com/hotlink/kpn0nfspe6/04._points_of_authority.mp3");
   			}
		}
		return 1;
	}
	if(dialogid==CARCOLOR)
	{
		if(!response) return 1;
		switch(listitem)
		{
			case 0:
			{
			   	CarColor1[playerid]=0;
   				CarColor2[playerid]=0;
				ChangeVehicleColor(GetPlayerVehicleID(playerid),0,0);
			}
			case 1:
			{
			   	CarColor1[playerid]=1;
   				CarColor2[playerid]=1;
				ChangeVehicleColor(GetPlayerVehicleID(playerid),1,1);
			}
			case 2:
			{
			   	CarColor1[playerid]=2;
   				CarColor2[playerid]=2;
				ChangeVehicleColor(GetPlayerVehicleID(playerid),2,2);
			}
			case 3:
			{
			   	CarColor1[playerid]=3;
   				CarColor2[playerid]=3;
				ChangeVehicleColor(GetPlayerVehicleID(playerid),3,3);
			}
			case 4:
			{
			   	CarColor1[playerid]=5;
   				CarColor2[playerid]=5;
				ChangeVehicleColor(GetPlayerVehicleID(playerid),5,5);
			}
			case 5:
			{
			   	CarColor1[playerid]=6;
   				CarColor2[playerid]=6;
				ChangeVehicleColor(GetPlayerVehicleID(playerid),6,6);
			}

			case 6:
			{
			   	CarColor1[playerid]=7;
   				CarColor2[playerid]=7;
				ChangeVehicleColor(GetPlayerVehicleID(playerid),7,7);
			}
			case 7:
			{
			   	CarColor1[playerid]=16;
   				CarColor2[playerid]=16;
				ChangeVehicleColor(GetPlayerVehicleID(playerid),16,16);
			}
		}
		return 1;
	}
	if(dialogid==WAGE)
	{
		new string[180];
		if(response)
	    {
	    	if(strval(inputtext) > 2000||strval(inputtext) < 200||!IsNumeric(inputtext))
			{
				ShowPlayerDialog(playerid,WAGE,DIALOG_STYLE_INPUT,"Organization Wage","{FFFFFF}Set the wage for your organization members\nNote: Wage cannot be lower than 200 or higher than 2000","Proceed","Close");
			}
			else
			{
				Organization[PlayerOrg[playerid]][Wage]=strval(inputtext);
				format(string,sizeof(string),"The wage of your organization members has been updated to $%d",strval(inputtext));
				SendClientMessage(playerid,YELLOW,string);
			}
		}
		return 1;
	}
	if(dialogid==AWARDS1)
	{
		if(response)return OnPlayerClickPlayer(playerid,aid[playerid],1);
		return 1;
	}
	if(dialogid==AWARDS)
	{
		if(response)
		{
  			switch(listitem)
			{
				case 0:
				{
				    ShowPlayerDialog(playerid,AWARDS1,DIALOG_STYLE_MSGBOX,"I Like Donuts!","{ADFF2F}Get involved in one of the law orgs","Back","Close");
				}
				case 1:
				{
				    ShowPlayerDialog(playerid,AWARDS1,DIALOG_STYLE_MSGBOX,"I am Involved In One","{ADFF2F}Start Running one of the busineses in San Andreas","Back","Close");
				}
				case 2:
				{
				    ShowPlayerDialog(playerid,AWARDS1,DIALOG_STYLE_MSGBOX,"NOT That Phone Bill","{ADFF2F}Hmmm...Why not find out yourself?","Back","Close");
				}
				case 3:
				{
				    ShowPlayerDialog(playerid,AWARDS1,DIALOG_STYLE_MSGBOX,"City Guide","{ADFF2F}Checkout the server tutorial to unlock this award","Back","Close");
				}
				case 4:
				{
				    ShowPlayerDialog(playerid,AWARDS1,DIALOG_STYLE_MSGBOX,"That was too much!","{ADFF2F}Start vomitting after getting high","Back","Close");
				}
				case 5:
				{
				    ShowPlayerDialog(playerid,AWARDS1,DIALOG_STYLE_MSGBOX,"I Made It!","{ADFF2F}Become Staff member","Back","Close");
				}
				case 6:
				{
				    ShowPlayerDialog(playerid,AWARDS1,DIALOG_STYLE_MSGBOX,"Home Sweet Home","{ADFF2F}Become an owner of one of the properties in San Andreas","Back","Close");
				}
				case 7:
				{
				    ShowPlayerDialog(playerid,AWARDS1,DIALOG_STYLE_MSGBOX,"Public Enemy","{ADFF2F}Get jailed for 20 times","Back","Close");
				}
				case 8:
				{
				    ShowPlayerDialog(playerid,AWARDS1,DIALOG_STYLE_MSGBOX,"BLOW!","{ADFF2F}Non drug addicts will never get this!","Back","Close");
				}
				case 9:
				{
				    ShowPlayerDialog(playerid,AWARDS1,DIALOG_STYLE_MSGBOX,"Cleaning The Streets","{ADFF2F}Become a kickass and start jailing the assholes","Back","Close");
				}
				case 10:
				{
				    ShowPlayerDialog(playerid,AWARDS1,DIALOG_STYLE_MSGBOX,"Ab00ze!","{ADFF2F}Hmmm...lets checkout new porn videos","Back","Close");
				}
				case 11:
				{
				    ShowPlayerDialog(playerid,AWARDS1,DIALOG_STYLE_MSGBOX,"Ma Platez","{ADFF2F}Get some new plates for your personal vehicle","Back","Close");
				}
				case 12:
				{
				    ShowPlayerDialog(playerid,AWARDS1,DIALOG_STYLE_MSGBOX,"Back To School","{ADFF2F}Get roleplay marks to unlock this","Back","Close");
				}
				case 13:
				{
				    ShowPlayerDialog(playerid,AWARDS1,DIALOG_STYLE_MSGBOX,"Secret Award!","{ADFF2F}Try your luck by typing your girlfriend's name on mainchat","Back","Close");
				}
				case 14:
				{
				    ShowPlayerDialog(playerid,AWARDS1,DIALOG_STYLE_MSGBOX,"Will You Shut Up?","{ADFF2F}Keep spamming the mainchat like a moron","Back","Close");
				}
				case 15:
				{
				    ShowPlayerDialog(playerid,AWARDS1,DIALOG_STYLE_MSGBOX,"Good Bye Cruel World","{ADFF2F}Too easy...isn't it?","Back","Close");
				}
				case 16:
				{
				    ShowPlayerDialog(playerid,AWARDS1,DIALOG_STYLE_MSGBOX,"Dark Side","{ADFF2F}How about becoming a gangster and unlock this award?","Back","Close");
				}
				case 17:
				{
				    ShowPlayerDialog(playerid,AWARDS1,DIALOG_STYLE_MSGBOX,"Free Roaming","{ADFF2F}Airport ftw!","Back","Close");
				}
			}
		}
		return 1;
	}
	return 0;
}
//==============================================================================
public OnPlayerClickPlayer(playerid,clickedplayerid,source)
{
	aid[playerid]=clickedplayerid;
	if(!IsPlayerConnectedEx(playerid))return 1;
	if(source==0)
	{if(clickedplayerid==playerid)return SendClientMessage(playerid,GREY,"Why not try /awards instead?");}
 	new string[410],color1[9],color2[9],color3[9],color4[9],color5[9],color6[9],color7[9],color8[9];
	new color9[9],color10[9],color11[9],color12[9],color13[9],color14[9],color15[9],color16[9],color17[9],color18[9];
	if(PlayerAwards[clickedplayerid][Cop]==0){color1="{FFFFFF}";}
	if(PlayerAwards[clickedplayerid][Cop]==1){color1="{ADFF2F}";}
	if(PlayerAwards[clickedplayerid][Buss]==0){color2="{FFFFFF}";}
	if(PlayerAwards[clickedplayerid][Buss]==1){color2="{ADFF2F}";}
	if(PlayerAwards[clickedplayerid][Bill]==0){color3="{FFFFFF}";}
	if(PlayerAwards[clickedplayerid][Bill]==1){color3="{ADFF2F}";}
	if(PlayerAwards[clickedplayerid][Guide]==0){color4="{FFFFFF}";}
	if(PlayerAwards[clickedplayerid][Guide]==1){color4="{ADFF2F}";}
	if(PlayerAwards[clickedplayerid][Vomit]==0){color5="{FFFFFF}";}
	if(PlayerAwards[clickedplayerid][Vomit]==1){color5="{ADFF2F}";}
	if(PlayerAwards[clickedplayerid][Admin]==0){color6="{FFFFFF}";}
	if(PlayerAwards[clickedplayerid][Admin]==1){color6="{ADFF2F}";}
	if(PlayerAwards[clickedplayerid][House]==0){color7="{FFFFFF}";}
	if(PlayerAwards[clickedplayerid][House]==1){color7="{ADFF2F}";}
	if(PlayerAwards[clickedplayerid][Jail]==0){color8="{FFFFFF}";}
	if(PlayerAwards[clickedplayerid][Jail]==1){color8="{ADFF2F}";}
	if(PlayerAwards[clickedplayerid][Addict]==0){color9="{FFFFFF}";}
	if(PlayerAwards[clickedplayerid][Addict]==1){color9="{ADFF2F}";}
	if(PlayerAwards[clickedplayerid][Jailer]==0){color10="{FFFFFF}";}
	if(PlayerAwards[clickedplayerid][Jailer]==1){color10="{ADFF2F}";}
	if(PlayerAwards[clickedplayerid][Abooze]==0){color11="{FFFFFF}";}
	if(PlayerAwards[clickedplayerid][Abooze]==1){color11="{ADFF2F}";}
	if(PlayerAwards[clickedplayerid][Plates]==0){color12="{FFFFFF}";}
	if(PlayerAwards[clickedplayerid][Plates]==1){color12="{ADFF2F}";}
	if(PlayerAwards[clickedplayerid][School]==0){color13="{FFFFFF}";}
	if(PlayerAwards[clickedplayerid][School]==1){color13="{ADFF2F}";}
	if(PlayerAwards[clickedplayerid][Kainat]==0){color14="{FFFFFF}";}
	if(PlayerAwards[clickedplayerid][Kainat]==1){color14="{ADFF2F}";}
	if(PlayerAwards[clickedplayerid][Shutup]==0){color15="{FFFFFF}";}
	if(PlayerAwards[clickedplayerid][Shutup]==1){color15="{ADFF2F}";}
	if(PlayerAwards[clickedplayerid][Suicide]==0){color16="{FFFFFF}";}
	if(PlayerAwards[clickedplayerid][Suicide]==1){color16="{ADFF2F}";}
	if(PlayerAwards[clickedplayerid][Gangster]==0){color17="{FFFFFF}";}
	if(PlayerAwards[clickedplayerid][Gangster]==1){color17="{ADFF2F}";}
	if(PlayerAwards[clickedplayerid][AirPlane]==0){color18="{FFFFFF}";}
	if(PlayerAwards[clickedplayerid][AirPlane]==1){color18="{ADFF2F}";}
	format(string,410,"%sI like donuts!\n%sI am involved in one!\n%sNOT that phone bill\n%sCity guide\n%sThat was too much\n%sI made it!\n%sHome sweet home\n%sPublic enemy\n%sBLOW!\n%sCleaning the streets\n%sAb00ze\n%sMa platez\n%sBack to school\n%sSecret award\n%sWill you shut up?\n%sGood bye cruel world\n%sDark side\n%sFree roaming!",
	color1,color2,color3,color4,color5,color6,color7,color8,color9,color10,color11,color12,color13,color14,color15,color16,color17,color18);
	ShowPlayerDialog(playerid,AWARDS,DIALOG_STYLE_LIST,"Achievements",string,"Select","Close");
	return 1;
}
//==============================================================================
public OnPlayerKeyStateChange(playerid,newkeys,oldkeys)
{
	if(newkeys==KEY_ACTION)
	{
		if(GetPlayerState(playerid)==PLAYER_STATE_DRIVER)
		{
			new vehicleid=GetPlayerVehicleID(playerid);
			new engine,lights,alarm,doors,bonnet,boot,objective;
			GetVehicleParamsEx(vehicleid,engine,lights,alarm,doors,bonnet,boot,objective);
			if(lights==1) lights=0; else lights=1;
			SetVehicleParamsEx(vehicleid,engine,lights,alarm,doors,bonnet,boot,objective);
			if(IsATowTruck(GetPlayerVehicleID(playerid)))
			{
    			if(IsTrailerAttachedToVehicle(GetPlayerVehicleID(playerid)))return DetachTrailerFromVehicle(GetPlayerVehicleID(playerid));
    			new Float:PPPX,Float:PPPY,Float:PPPZ;
    			GetPlayerPos(playerid,PPPX,PPPY,PPPZ);
    			new Float:VVVX,Float:VVVY,Float:VVVZ;
    			new Found=0;
    			new vid=0;
    			while((vid<MAX_VEHICLES)&&(!Found))
    			{
    				vid++;
        			GetVehiclePos(vid,VVVX,VVVY,VVVZ);
        			if((floatabs(PPPX-VVVX)<7.0)&&(floatabs(PPPY-VVVY)<7.0)&&(floatabs(PPPZ-VVVZ)<7.0)&&(vid!=GetPlayerVehicleID(playerid)))
        			{
        				Found=1;
        	    		AttachTrailerToVehicle(vid,GetPlayerVehicleID(playerid));
        	    		SetPlayerChatBubble(playerid,"*towing a vehicle",LBLUE,30.0,2000);
        			}
    			}
			}
		}
	}
	if(newkeys==KEY_YES)
	{
	    ClearAnimations(playerid);
	}
  	if(newkeys==KEY_SECONDARY_ATTACK)
 	{
  		for(new i=0; i < sizeof(AtmInfo); i++)
 		{
  			if(IsPlayerInRangeOfPoint(playerid,1.5,AtmInfo[i][aX],AtmInfo[i][aY],AtmInfo[i][aZ]))
    		{
     			if(AtmInfo[i][aCreated]==1)
       			{
	        		if(BankID[playerid]==0)return SendClientMessage(playerid,GREY,"You need a bank account");
                    ShowPlayerDialog(playerid,ATM,DIALOG_STYLE_INPUT,"San Andreas Bank","{FFFFFF}Please Enter The Amount,You would like to withdraw","Withdraw","Back");
           		}
         	}
		}
  	}
	if(newkeys & KEY_FIRE)
    {
    	if(IsPlayerConnectedEx(playerid))
     	{
      		new weapon=GetPlayerWeapon(playerid),wname[40],string[128];
        	if(weapon !=0 && !Weapons[playerid][weapon])
        	{
        	    if(weapon!=40&&weapon!=46&&weapon!=2)
        	    {
					if(weapon==35||weapon==37||weapon==38)
					{
						GetWeaponName(GetPlayerWeapon(playerid),wname,sizeof(wname));
						format(string,sizeof(string),"SERVER: {FFFFFF}%s has spawned a %s by hacks and has been kicked from the server",PlayerName(playerid),wname);
 	    				ResetPlayerWeaponsEx(playerid);
					 	SendMessageToAdmins(RED,string);
						Kicked[playerid]=1;
					}
					else
					{
						GetWeaponName(GetPlayerWeapon(playerid),wname,sizeof(wname));
						format(string,sizeof(string),"SERVER: {FFFFFF}%s has spawned a %s by hacks",PlayerName(playerid),wname);
   						SendMessageToAdmins(RED,string);
						SendMessageToAdmins(-1,"NOTE: /spec them,and if they are in ammunation or near org hq,it can possibly be a bug");
 	    				Weapons[playerid][weapon]=true;
					}
				}
			}
		 }
	}
	return 1;
}
//==============================================================================
public OnPlayerRequestSpawn(playerid)
{
    if(IsLogged[playerid]==0)return 0;
	return 1;
}
//==============================================================================
public OnVehicleSpawn(vehicleid)
{
    fuel[vehicleid]=10+random(30);
	SetVehicleParamsEx(vehicleid,0,0,0,0,0,0,0);
	if(IsBicycle(vehicleid))
	{
	 	SetVehicleParamsEx(vehicleid,1,0,0,0,0,0,0);
	}
	if(BRVehicle(vehicleid))
	{
 	   LinkVehicleToInterior(vehicleid,15);
	}
	if(SKVehicle(vehicleid))
	{
    	LinkVehicleToInterior(vehicleid,4);
	}
	if(RPVehicle(vehicleid))
	{
		vehicle3Dtext[vehicleid]=Create3DTextLabel( "RolePlay School",0xFFFFFFFF,0.0,0.0,0.0,15.0,0,1 );
    	Attach3DTextLabelToVehicle(vehicle3Dtext[vehicleid],vehicleid,0.0,0.0,0.0);
 	}
	if(IsDL(vehicleid))
	{
		new str[128],vehicle[24];
    	GetVehicleName(vehicleid,vehicle,24);
	   	SetVehicleNumberPlate(vehicleid,"DEALERS");
    	format(str,sizeof(str),"%s\n{FFFF00}Price:{FFFFFF} $%d",vehicle,GetVehiclePrice(vehicleid));
    	vehicle3Dtext[vehicleid]=Create3DTextLabel( str,0xFFFFFFFF,0.0,0.0,0.0,20.0,0,1 );
    	Attach3DTextLabelToVehicle( vehicle3Dtext[vehicleid],vehicleid,0.0,0.0,0.0);
	}
	return 1;
}
//==============================================================================
public OnPlayerStateChange(playerid,newstate,oldstate)
{
	if(newstate==PLAYER_STATE_DRIVER)
	{
		if(IsDL(GetPlayerVehicleID(playerid)))
		{
     		new vehicle[24],str[128];
			GetVehicleName(GetPlayerVehicleID(playerid),vehicle,sizeof(vehicle));
			format(str,sizeof(str),"%s - $%d",vehicle,GetVehiclePrice(GetPlayerVehicleID(playerid)));
			SendClientMessage(playerid,YELLOW,str);
			format(str,sizeof(str),"{FFFFFF}Do you want to purchase {FFFF00}%s {FFFFFF}in $%d?",vehicle,GetVehiclePrice(GetPlayerVehicleID(playerid)));
			ShowPlayerDialog(playerid,DEAL,DIALOG_STYLE_MSGBOX,"San Andreas Car Dealers",str,"Select","");
		}
		if(IsBeingSpeced[playerid]==1)
        {
            for(new i=0;i<MAX_PLAYERS;i++)
            {
                if(spectatorid[i]==playerid)
                {
                    PlayerSpectateVehicle(i,GetPlayerVehicleID(playerid));
                }
            }
        }
	    if(!IsBicycle(GetPlayerVehicleID(playerid)))
	    {
			SetPlayerArmedWeapon(playerid,0);
     		new vehicleid=GetPlayerVehicleID(playerid);
			new engine,lights,alarm,doors,bonnet,boot,objective;
			GetVehicleParamsEx(vehicleid,engine,lights,alarm,doors,bonnet,boot,objective);
			if(engine !=1) {SendClientMessage(playerid,-1,"To switch on the vehicle's engine type {FF8000}/engine");}
			if(engine==1)
  			{
			  	TextDrawShowForPlayer(playerid,sdisplay[playerid]);
        		TextDrawShowForPlayer(playerid,td_fuel[playerid]);
			}
       		if(GetVehicleModel(vehicleid)==420 || GetVehicleModel(vehicleid)==438 && Job[playerid] !=3) return RemovePlayerFromVehicle(playerid);
			if(GetVehicleModel(vehicleid)==437 && Job[playerid] !=2) return RemovePlayerFromVehicle(playerid);
			if(RPVehicle(GetPlayerVehicleID(playerid)))
			{
    			if(Teacher[playerid]==0||Lesson[playerid]==-1)
    			{
     				RemovePlayerFromVehicle(playerid);
				}
			}
			if(GetPlayerVehicleID(playerid)==Car[playerid])
			{
			    SendClientMessage(playerid,YELLOW,"Welcome back to your vehicle");
			}
			if(License[playerid][StepD] >=1)
	    	{
	    	    SendClientMessage(playerid,ORANGE,"Drive to the first checkpoint and follow the other ones");
	    	    License[playerid][StepD]=2;
	    	    SetPlayerRaceCheckpoint(playerid,0,-1612.5419,1195.4073,6.7575,-2036.5591,-69.9707,34.8866,3.00);
	    	    License[playerid][CP]=0;
				dfbltimer[playerid]=0;
			}
			if(License[playerid][StepD]==0)
			{
			    if(IsCar(GetPlayerVehicleID(playerid))||IsTruck(GetPlayerVehicleID(playerid)))
			    {
					if(DL[playerid]==0)
					{
					    SendClientMessage(playerid,LRED,"You need a car license in order to drive cars legally(/drivingschool)");
					}
				}
			}
			if(License[playerid][StepF] >=1)
	    	{
	    	    SendClientMessage(playerid,ORANGE,"Fly to the first checkpoint and follow the other ones");
	    	    License[playerid][StepF]=2;
	    	    SetPlayerRaceCheckpoint(playerid,3,-1519.3550,2527.1025,159.3644,378.9980,2513.1108,17.9407,8.00);
	    	    License[playerid][CP]=0;
				dfbltimer[playerid]=0;
			}
			if(License[playerid][StepF]==0)
			{
			    if(IsPlane(GetPlayerVehicleID(playerid)))
			    {
					if(FL[playerid]==0)
					{
					    RemovePlayerFromVehicle(playerid);
					}
				}
			}
			if(License[playerid][StepB] >=1)
	    	{
	    	    SendClientMessage(playerid,ORANGE,"Ride to the first checkpoint and follow the other ones");
	    	    License[playerid][StepB]=2;
	    	    SetPlayerRaceCheckpoint(playerid,0,1548,2054,10,1157,1371,10,3.00);
	    	    License[playerid][CP]=0;
				dfbltimer[playerid]=0;
			}
			if(License[playerid][StepB]==0)
			{
			    if(IsBike(GetPlayerVehicleID(playerid)))
			    {
					if(BL[playerid]==0)
					{
					    RemovePlayerFromVehicle(playerid);
					}
				}
			}
		}
	}
	if(newstate==PLAYER_STATE_ONFOOT)
	{
		RemovePlayerAttachedObject(playerid,4);
	    TextDrawHideForPlayer(playerid,sdisplay[playerid]);
	    TextDrawHideForPlayer(playerid,td_fuel[playerid]);
    	if(Trucking[playerid]>0)
    	{
			Trucking[playerid]=0;
			DisablePlayerCheckpoint(playerid);
			SetVehicleToRespawn(GetPlayerVehicleID(playerid));
			SendClientMessage(playerid,LRED,"You have quit the trucking mission");
		}
		if(IsDL(GetPlayerVehicleID(playerid)))
		{
			SetVehicleToRespawn(GetPlayerVehicleID(playerid));
		}
    	if(IsBeingSpeced[playerid]==1)
        {
            for(new i=0;i<MAX_PLAYERS;i++)
            {
                if(spectatorid[i]==playerid)
                {
                    PlayerSpectatePlayer(i,playerid);
                }
            }
        }
	}
	return 1;
}
//==============================================================================
public OnPlayerExitVehicle(playerid,vehicleid)
{
	if(License[playerid][StepB] >=1||License[playerid][StepD] >=1||License[playerid][StepF] >=1)
	{
        License[playerid][StepB]=0;
        License[playerid][StepF]=0;
        License[playerid][StepD]=0;
        RemovePlayerFromVehicle(playerid);
        DisablePlayerRaceCheckpoint(playerid);
        DestroyVehicle(License[playerid][Vehicle]);
	    GameTextForPlayer(playerid,"~r~Failed",3000,0);
    }
	new engine,lights,alarm,bonnet,boot,objective,doors;
	GetVehicleParamsEx(vehicleid,engine,lights,alarm,doors,bonnet,boot,objective);
	if(vehicleid==Car[playerid]&&Lock[playerid]==1)
	{
		if(engine==0&&GetPlayerState(playerid)==PLAYER_STATE_DRIVER)
		{
		    SetVehicleParamsEx(vehicleid,engine,lights,alarm,1,bonnet,boot,objective);
		    SendClientMessage(playerid,YELLOW,"Your vehicle has been automatically locked");
		}
	}
	if(vehicleid!=Car[playerid]&&doors==1)
	{
	 	SetVehicleParamsEx(vehicleid,engine,lights,alarm,0,bonnet,boot,objective);
	}
	return 1;
}
//==============================================================================
public OnPlayerEnterVehicle(playerid,vehicleid,ispassenger)
{
	if(!ispassenger)
	{
		for(new i=1;i<OrgsCount+1;i++)
		{
			for(new a=0;a<MAX_ORG_VEHICLES;a++)
		 	{
    			if(vehicleid==Organization[i][Vehicles][a] && PlayerOrg[playerid] !=i)
			 	{
     				if(DoesOrgExist(GetOrgName(i)))
					{
	    				ClearAnimations(playerid);
                    }
                }
            }
        }
		for(new i=0;i<MAX_PLAYERS;i++)
 		{
			if(vehicleid !=Car[playerid]&& vehicleid==Car[i])
			{
			    if(Alarm[i]==1)
			    {
					new engine,lights,alarm,bonnet,boot,objective,doors,str[128];
					GetVehicleParamsEx(vehicleid,engine,lights,alarm,doors,bonnet,boot,objective);
			        SetVehicleParamsEx(vehicleid,engine,lights,1,doors,bonnet,boot,objective);
			        format(str,128,"%s has entered your vehicle as driver",PlayerName(playerid));
			        SendClientMessage(i,LRED,str);
			    }
			}
    	}
	}
	if(ispassenger)
	{
	    if(vehicleid==Car[playerid])
	    {
			new engine,lights,alarm,bonnet,boot,objective,doors;
			GetVehicleParamsEx(Car[playerid],engine,lights,alarm,doors,bonnet,boot,objective);
			if(doors==1)
			{
				SetVehicleParamsEx(Car[playerid],engine,lights,alarm,0,bonnet,boot,objective);
				SendClientMessage(playerid,-1,"You have unlocked your vehicle");
			}
		}
	}
	return 1;
}
//==============================================================================
public OnPlayerStreamIn(playerid,forplayerid)
{
	if(rname[playerid]==1)
  	{
  	    new str[128];
  	    Delete3DTextLabel(Label[playerid]);
  	    format(str,sizeof(str),"%s(%i)",RPName[playerid],playerid);
 	 	Label[playerid]=Create3DTextLabel(str,0xFFFFFFFF,0,0,0,6,0,1 );
		Attach3DTextLabelToPlayer(Label[playerid],playerid,0.0,0.0,0.2);
    	for(new i=0; i < MAX_PLAYERS; i++){ShowPlayerNameTagForPlayer(i,playerid,0);}
    	ShowPlayerNameTagForPlayer(forplayerid,playerid,0);
	}
	return 1;
}
//==============================================================================
public OnVehiclePaintjob(playerid,vehicleid,paintjobid)
{
	if(vehicleid==Car[playerid]){CarPaint[playerid]=paintjobid;}
	return 1;
}
//==============================================================================
public OnVehicleRespray(playerid,vehicleid,color1,color2)
{
    if(vehicleid==Car[playerid])
	{
		CarColor1[playerid]=color1;
		CarColor2[playerid]=color2;
	}
	return 1;
}
//==============================================================================
public OnPlayerEnterRaceCheckpoint(playerid)
{
	if(IsPlayerInAnyVehicle(playerid) && GetPlayerVehicleID(playerid)==License[playerid][Vehicle] && License[playerid][StepD] >=2)
	{
	    if(License[playerid][CP]==0)
	    {
			SetPlayerRaceCheckpoint(playerid,0,-2036.5591,-69.9707,34.8866,-2036.5591,-69.9707,34.8866,3.00);
			SendClientMessage(playerid,ORANGE,"Now make your way back to the school");
			License[playerid][CP]++;
		}
  		else if(License[playerid][CP]==1)
		{
		    DisablePlayerRaceCheckpoint(playerid);
		    new v=GetPlayerVehicleID(playerid);
		    new Float:vhp;
		    GetVehicleHealth(v,vhp);
		    License[playerid][CP]=-1;
		    if(gettime() <=Time[playerid]&&vhp >500)
		    {
				DL[playerid]=1;
				License[playerid][StepD]=0;
				RemovePlayerFromVehicle(playerid);
        		DisablePlayerRaceCheckpoint(playerid);
				DestroyVehicle(License[playerid][Vehicle]);
	    		SendClientMessage(playerid,YELLOW,"You have passed the test,and got your license");
			}
			else
			{
				DL[playerid]=0;
				License[playerid][StepD]=0;
			    RemovePlayerFromVehicle(playerid);
        		DisablePlayerRaceCheckpoint(playerid);
				DestroyVehicle(License[playerid][Vehicle]);
	    		SendClientMessage(playerid,LRED,"You have failed the test, bring the car in one piece and reach earlier (within 3 mins)");
			}
		}
	}if(IsPlayerInAnyVehicle(playerid) && GetPlayerVehicleID(playerid)==License[playerid][Vehicle] && License[playerid][StepB] >=2)
	{
	    if(License[playerid][CP]==0)
	    {
			SendClientMessage(playerid,ORANGE,"Now make your way back to the school");
			SetPlayerRaceCheckpoint(playerid,0,1157,1371,10,1157,1371,10,2.00);
			License[playerid][CP]++;
		}
		else if(License[playerid][CP]==1)
		{
		    DisablePlayerRaceCheckpoint(playerid);
		    new v=GetPlayerVehicleID(playerid);
		    License[playerid][CP]=-1;
		    new Float:vhp;
		    GetVehicleHealth(v,vhp);
		    if(gettime() <=Time[playerid]&&vhp > 500)
		    {
				BL[playerid]=1;
				License[playerid][StepB]=0;
				RemovePlayerFromVehicle(playerid);
        		DisablePlayerRaceCheckpoint(playerid);
				DestroyVehicle(License[playerid][Vehicle]);
	    		SendClientMessage(playerid,YELLOW,"You have passed the test and got your license");
			}
			else
			{
				License[playerid][StepB]=0;
			    RemovePlayerFromVehicle(playerid);
        		DisablePlayerRaceCheckpoint(playerid);
				DestroyVehicle(License[playerid][Vehicle]);
	    		SendClientMessage(playerid,LRED,"You have failed the test, bring the bike in one piece and try to reach earlier (within 2 mins)");
			}
		}
	}
	if(IsPlayerInAnyVehicle(playerid) && GetPlayerVehicleID(playerid)==License[playerid][Vehicle] && License[playerid][StepF] >=2)
	{
	    if(License[playerid][CP]==0)
	    {
			SendClientMessage(playerid,ORANGE,"Now make your way back to the school");
			SetPlayerRaceCheckpoint(playerid,0,378.9980,2513.1108,17.9407,378.9980,2513.1108,17.9407,8.00);
			License[playerid][CP]++;
		}
		else if(License[playerid][CP]==1)
		{
		    DisablePlayerRaceCheckpoint(playerid);
		    new v=GetPlayerVehicleID(playerid);
		    License[playerid][CP]=-1;
		    new Float:vhp;
		    GetVehicleHealth(v,vhp);
		    if(gettime() <=Time[playerid]&&vhp > 500)
		    {
				FL[playerid]=1;
				License[playerid][StepF]=0;
				RemovePlayerFromVehicle(playerid);
        		DisablePlayerRaceCheckpoint(playerid);
				DestroyVehicle(License[playerid][Vehicle]);
	    		SendClientMessage(playerid,YELLOW,"You have passed the test and got your license");
			}
			else
			{
				License[playerid][StepF]=0;
			    RemovePlayerFromVehicle(playerid);
        		DisablePlayerRaceCheckpoint(playerid);
				DestroyVehicle(License[playerid][Vehicle]);
	    		SendClientMessage(playerid,LRED,"You have failed the test, bring the plane in one piece and try to reach earlier (within 2 mins)");
			}
		}
	}
	return 1;
}
//==============================================================================
public OnVehicleDeath(vehicleid,killerid)
{
    for(new i=0; i< MAX_PLAYERS; i++)
    {
    	if(vehicleid==Car[i]&&VIP[i]==0)
		{
			if(Insurance[i]==1)
			{
			    new string[50];
				SendClientMessage(i,YELLOW,"The insurance amount of your car has been sent to your bank account");
				Bank[i]=Bank[i]+GetVehiclePrice(Car[i]);
				format(string,sizeof(string),"~g~+$%i",GetVehiclePrice(Car[i]));
				GameTextForPlayer(i,string,800,1);
			}
			Car[i]=0;
			Lock[i]=0;
			Alarm[i]=0;
			Insurance[i]=0;
			DestroyVehicle(vehicleid);
			SendClientMessage(i,LRED,"Your personal vehicle is now a history");
		}
		if(vehicleid==ACar[i])
		{
			DestroyVehicle(vehicleid);
		}
	}
	if(vehicleid==License[killerid][Vehicle])
	{
 	   DestroyVehicle(License[killerid][Vehicle]);
	}
	return 1;
}
//==============================================================================
public OnPlayerTakeDamage(playerid,issuerid,Float:amount,weaponid)
{
	if(weaponid==34||weaponid==4||weaponid==4||weaponid==9||weaponid==25||weaponid==26||weaponid==27)
	{
	    if(IsBleeding[playerid]==0)
	    {
			IsBleeding[playerid]=1;
			SendClientMessage(playerid,LRED,"You have started to bleed,get medical assistance as soon as possible");
		}
	}
	if(Tazed[playerid]==0&&Tazer[issuerid]==1)
	{
	    Tazed[playerid]=1;
	    Tazer[issuerid]=0;
	    ClearAnimations(playerid);
	    TogglePlayerControllable(playerid,0);
	    RemovePlayerAttachedObject(issuerid,6);
   		GameTextForPlayer(playerid,"~g~BU~r~ZZZZZZZZZZZZ",1000,4);
 		ApplyPlayerAnimation(playerid,"CRACK","crckdeth2",4.0,1,0,0,0,0);
   		SendClientMessage(playerid,BLUE,"You have been tazed,and you fell to the ground");
   		SendClientMessage(issuerid,BLUE,"You have tazed that player,and he fell to the ground");
	}
	return 1;
}
//==============================================================================
public OnPlayerClickMap(playerid,Float:fX,Float:fY,Float:fZ)
{
	if(AdminLevel[playerid]>1)
	{
	    if(IsPlayerInAnyVehicle(playerid)){SetVehiclePos(GetPlayerVehicleID(playerid),fX,fY,fZ+5);}
		else{SetPlayerPosFindZ(playerid,fX,fY,fZ+5);}
	}
	return 1;
}
//==============================================================================
public OnPlayerInteriorChange(playerid,newinteriorid,oldinteriorid)
{
	if(newinteriorid !=0)
	{
		TextDrawHideForPlayer(playerid,Zones[playerid]);
	}
	if(newinteriorid==0)
	{
		TextDrawShowForPlayer(playerid,Zones[playerid]);
	}
    if(IsBeingSpeced[playerid]==1)
    {
        for(new i=0; i< MAX_PLAYERS; i++)
    	{
         	if(IsPlayerConnectedEx(i))
			{
				if(spectatorid[i]==playerid)
            	{
            	    SetPlayerInterior(i,GetPlayerInterior(playerid));
            	}
			}
        }
    }
    return 1;
}
//==============================================================================
forward Global();
public Global()
{
	Second();
	ssecond++;
	if(ssecond==60)
	{
 		Minute();
        sminute++;
   		ssecond=0;
	}
	if(sminute==24)
	{
  		Hour();
        sminute=0;
       	ssecond=0;
	}
	return 1;
}
//==============================================================================
CMD:rules(playerid,params[])
{
	if(IsJailedOrMuted(playerid))return 1;
    SendClientMessage(playerid,YELLOW,"-Server Rules-");
    SendClientMessage(playerid,-1,"1. The main chat is supposed to be complete OOC chat.");
    SendClientMessage(playerid,-1,"2. If you own a property or a business or both,and go inactive");
    SendClientMessage(playerid,-1,"for a time period of more than 7 days,your business and property");
    SendClientMessage(playerid,-1,"will be resetted as a result.");
    SendClientMessage(playerid,-1,"3. No admin is supposed to use any admin command while roleplaying");
    SendClientMessage(playerid,-1,"for self benefits.");
    SendClientMessage(playerid,-1,"4. The /rpname tag means that you are in character,and any non-rpish");
    SendClientMessage(playerid,-1,"act will either get you banned or kicked from server or an organization.");
    SendClientMessage(playerid,-1,"5. Any usage of third party tools for self-benefit will get you banned.");
	return 1;
}
//==============================================================================
CMD:help(playerid,params[])
{
	if(IsJailedOrMuted(playerid))return 1;
    SendClientMessage(playerid,YELLOW,"Bikini Bottom Roleplay Server Help");
    SendClientMessage(playerid,-1,"The main objective of the server is to RolePlay");
    SendClientMessage(playerid,-1,"RolePlay is quite similiar to acting,you act and");
    SendClientMessage(playerid,-1,"pretend to be that person. On the other hand you can");
    SendClientMessage(playerid,-1,"Feel free to walk and talk wherever you go and roam around");
    SendClientMessage(playerid,-1,"Stay on the server for awhile and eventually you will get the feeling");
    SendClientMessage(playerid,-1,"Of what has to be done. DeathMatching is absolutely prohibted and is");
    SendClientMessage(playerid,-1,"punishable. Let's be kind on you and help you whenever you are in need");
    SendClientMessage(playerid,-1,"of guidance. Enjoy your stay and keep roleplaying along with lots of fun");
    SendClientMessage(playerid,-1,"If you need any help,do not hesitate in anyway to ask,type /url for Bikini Bottom Roleplay Forums");
    return 1;
}
//==============================================================================
CMD:cmds(playerid,params[])
{
    if(IsJailedOrMuted(playerid))return 1;
	SendClientMessage(playerid,YELLOW,"Bikini Bottom Roleplay Server Commands");
 	SendClientMessage(playerid,-1,"/eject /rpname /smoke /bag /togglecell /showlicenses /licenses /tags(on/off) /admins /weaponids");
  	SendClientMessage(playerid,-1,"/offer /acceptoffer /rejectoffer /canceloffer /car /pickup /hangup /text /w(hisper /(un)ignore");
	SendClientMessage(playerid,-1,"/givecash /me /stats /changepass,/changename /s(hout) /buybus /sellbus /shareammo /transfer /url");
	SendClientMessage(playerid,-1,"/rules /buyskin /animlist /report /(un)lock  /refuel /autolock /music /showmarks /guide /helmet");
	SendClientMessage(playerid,-1,"/bribe /usedrugs /atm /help /payorg /fuelcan /sellprop /request /getweapon /saveweapon /weapons");
    SendClientMessage(playerid,-1,"/handweapon /carloc /call(911) /tosscoin /awards /t(alk)(anim) /ignorelist /buyprop /myskin /do");
   	SendClientMessage(playerid,-1,"OTHERS: /repair /bank /ocmds /propose /divorce /acceptproposal /withdraw /deposit");
	if(VIP[playerid]>0)
	{
		SendClientMessage(playerid,-1,"PREMIUM ACCOUNT: /carcolor /changeskin /changecar /weather /nos /nzt");
	}
	if(Teacher[playerid]==1)
	{
		SendClientMessage(playerid,-1,"RP-TEACHER CMDS: /lesson /endlesson /givemarks");
	}
	return 1;
}
//==============================================================================
CMD:car(playerid,params[])
{
	if(IsJailedOrMuted(playerid))return 1;
	if((GetPlayerState(playerid)==PLAYER_STATE_DRIVER) && !IsBicycle(GetPlayerVehicleID(playerid)))
	{
		ShowPlayerDialog(playerid,CAR,DIALOG_STYLE_LIST,"Vehicle Control","Engine\nLights\nHood\nTrunk\nDoors\nAlarm","Choose","");
	}else return SendClientMessage(playerid,GREY,"You need to be inside a vehicle");
	return 1;
}
//==============================================================================
CMD:fuelcan(playerid,params[])
{
	if(IsJailedOrMuted(playerid))return 1;
	if(FuelCan[playerid]==0)return SendClientMessage(playerid,GREY,"You dont have a fuelcan,go purchase it from 24/7 Shop");
	if(GetPlayerState(playerid)!=PLAYER_STATE_DRIVER)return SendClientMessage(playerid,GREY,"You need to be inside a vehicle");
	if(fuel[GetPlayerVehicleID(playerid)]>10)return SendClientMessage(playerid,GREY,"Your vehicle has enough fuel");
	FuelCan[playerid]=0;
	fuel[GetPlayerVehicleID(playerid)]=fuel[GetPlayerVehicleID(playerid)]+5;
	SetPlayerChatBubble(playerid,"*refueling the car tank",LBLUE,100.0,10000);
	SendClientMessage(playerid,YELLOW,"You have refueled the vehicle,with your fuelcan");
	return 1;
}
//==============================================================================
CMD:tagson(playerid,params[])
{
	if(IsJailedOrMuted(playerid))return 1;
	for(new i=0; i < MAX_PLAYERS; i++)
	{
		if(rname[i]==0)
		{
			ShowPlayerNameTagForPlayer(playerid,i,1);
		}
	}
	SendClientMessage(playerid,YELLOW,"Name tags enabled");
 	return 1;
}
//==============================================================================
CMD:tagsoff(playerid,params[])
{
	if(IsJailedOrMuted(playerid))return 1;
	for(new i=0; i < MAX_PLAYERS; i++) ShowPlayerNameTagForPlayer(playerid,i,0);
	SendClientMessage(playerid,YELLOW,"Name tags disabled");
	return 1;
}
//==============================================================================
CMD:lock(playerid,params[])
{
	if(IsJailedOrMuted(playerid))return 1;
	if(Keys[playerid]!=1) return SendClientMessage(playerid,GREY,"You don't have Vehicle Keys go buy them from 24/7 shop");
 	if(!IsPlayerInAnyVehicle(playerid)) return SendClientMessage(playerid,GREY,"You need to be inside a vehicle");
	if(IsBicycle(GetPlayerVehicleID(playerid))||IsBike(GetPlayerVehicleID(playerid)))return SendClientMessage(playerid,GREY,"You cannot lock bikes");
	for(new i=1;i<OrgsCount+1;i++)
	{
 		for(new a=0;a<MAX_ORG_VEHICLES;a++)
 		{
   			if(GetPlayerVehicleID(playerid)==Organization[i][Vehicles][a])return SendClientMessage(playerid,GREY,"You cannot lock organization vehicles");
		}
	}
	new engine,lights,alarm,bonnet,boot,objective,doors;
	SetPlayerChatBubble(playerid,"*locks the doors",LBLUE,100.0,10000);
	GetVehicleParamsEx(GetPlayerVehicleID(playerid),engine,lights,alarm,doors,bonnet,boot,objective);
	if(doors==1)return SendClientMessage(playerid,GREY,"The doors are already locked");
	SetVehicleParamsEx(GetPlayerVehicleID(playerid),engine,lights,alarm,1,bonnet,boot,objective);
 	SendClientMessage(playerid,YELLOW,"Vehicle Locked");
  	return 1;
}
//==============================================================================
CMD:unlock(playerid,params[])
{
	if(IsJailedOrMuted(playerid))return 1;
	if(Keys[playerid]!=1) return SendClientMessage(playerid,GREY,"You don't have Vehicle Keys go buy them from 24/7 shop");
 	if(!IsPlayerInAnyVehicle(playerid)) return SendClientMessage(playerid,GREY,"You need to be inside a vehicle");
	new engine,lights,alarm,bonnet,boot,objective,doors;
	SetPlayerChatBubble(playerid,"*unlocks the doors",LBLUE,100.0,10000);
	GetVehicleParamsEx(GetPlayerVehicleID(playerid),engine,lights,alarm,doors,bonnet,boot,objective);
	if(doors==0)return SendClientMessage(playerid,GREY,"The doors are already unlocked");
	SetVehicleParamsEx(GetPlayerVehicleID(playerid),engine,lights,alarm,0,bonnet,boot,objective);
    SendClientMessage(playerid,YELLOW,"Vehicle Unlocked");
    return 1;
}
//==============================================================================
CMD:bag(playerid,params[])
{
	if(IsJailedOrMuted(playerid))return 1;
	if(Bag[playerid]==1)
	{
 		new str[128];
		SendClientMessage(playerid,ORANGE,"Your Items:");
  		if(FuelCan[playerid]==0)
		{
			format(str,sizeof(str),"FuelCan: {FFFFFF}N/A");
			SendClientMessage(playerid,YELLOW,str);
		}
		else if(FuelCan[playerid]==1)
		{
			format(str,sizeof(str),"FuelCan: {FFFFFF}Yes");
			SendClientMessage(playerid,YELLOW,str);
		}
		if(Keys[playerid]==0)
		{
			format(str,sizeof(str),"Vehicle Keys: {FFFFFF}N/A");
			SendClientMessage(playerid,YELLOW,str);
		}
		else if(Keys[playerid]==1)
		{
			format(str,sizeof(str),"Vehicle Keys: {FFFFFF}Yes");
			SendClientMessage(playerid,YELLOW,str);
		}
		if(Cell[playerid] <=1)
		{
			SendClientMessage(playerid,-1,"CellPhone: {FFFFFF}N/A");
		}
		if(Cell[playerid] > 1)
		{
			format(str,sizeof(str),"CellPhone: {FFFFFF}%i",Cell[playerid]);
			SendClientMessage(playerid,YELLOW,str);
		}
		format(str,sizeof(str),"Cigarettes: {FFFFFF}%d",Cigars[playerid]);
		SendClientMessage(playerid,YELLOW,str);
		format(str,sizeof(str),"Drugs: {FFFFFF}%d",Drug[playerid]);
		SendClientMessage(playerid,YELLOW,str);
		format(str,sizeof(str),"NZT Tablets: {FFFFFF}%d",NZT[playerid]);
		SendClientMessage(playerid,YELLOW,str);
		SetPlayerChatBubble(playerid,"*checking his inventory",LBLUE,100.0,10000);
	}else return SendClientMessage(playerid,GREY,"You dont have a bag,go purchase it from 24/7 shop");
	return 1;
}
//==============================================================================
CMD:changename(playerid,params[])
{
	if(IsJailedOrMuted(playerid))return 1;
    if(!IsPlayerConnectedEx(playerid))return 0;
    new name[MAX_PLAYER_NAME],newname[MAX_PLAYER_NAME],file[128],msg[128],PlayerFile[50];
    if(sscanf(params,"s[25]",newname)) return SendClientMessage(playerid,GREY,"USAGE: /changename [name]");
	format(PlayerFile,sizeof(PlayerFile),"Accounts/%s.ini",newname);
	GetPlayerName(playerid,name,sizeof(name));
	if(NameLimit[playerid]==2)return SendClientMessage(playerid,GREY,"You have reached your changename limit,you will be able to use this feature after your next login");
	if(strlen(newname) > MAX_PLAYER_NAME) return SendClientMessage(playerid,GREY,"The name cannot contain more than 20 letters");
    if(fexist(PlayerFile)||strcmp(name,newname,true)==0)return SendClientMessage(playerid,GREY,"That name is currently unavailable");
	new bool:invalid=false;
	if(strfind(params," ",true,0)!=-1||strfind(params,"!",true,0)!=-1|| strfind(params,"@",true,0)!=-1
	|| strfind(params,"%",true,0)!=-1|| strfind(params,"^",true,0)!=-1|| strfind(params,"&",true,0)!=-1
	|| strfind(params,"*",true,0)!=-1|| strfind(params,"-",true,0)!=-1|| strfind(params,"=",true,0)!=-1
	|| strfind(params,"+",true,0)!=-1|| strfind(params,"`",true,0)!=-1|| strfind(params,"~",true,0)!=-1
	|| strfind(params,"'",true,0)!=-1|| strfind(params,";",true,0)!=-1|| strfind(params,":",true,0)!=-1
	|| strfind(params,"(",true,0)!=-1|| strfind(params,")",true,0)!=-1|| strfind(params,"|",true,0)!=-1
	|| strfind(params,"/",true,0)!=-1|| strfind(params,".",true,0)!=-1|| strfind(params,">",true,0)!=-1
	|| strfind(params,"<",true,0)!=-1|| strfind(params,",",true,0)!=-1|| strfind(params,"/",true,0)!=-1
	|| strfind(params,"#",true,0)!=-1)invalid=true;
	if(invalid==true)return SendClientMessage(playerid,GREY,"Your name contains invalid characters/symbols");
	if(strlen(params) >=3)
    {
        format(file,sizeof(file),"Accounts/%s.ini",name);
        SetPlayerName(playerid,newname);
        INI_Rename(file,Acc(playerid));
       	if(AdminLevel[playerid] > 0)
		{
			format(msg,sizeof(msg),"Your name has been changed to %s",newname);
        	SendClientMessage(playerid,-1,msg);
		}
       	if(AdminLevel[playerid]==0)
		{
			format(msg,sizeof(msg),"'%s' has changed his account name to '%s'",name,newname);
        	SendClientMessageToAll(YELLOW,msg);
        }
        if(BID[playerid]>0)
		{
			Business[BID[playerid]][bOwner]=newname;
		}
        if(PID[playerid]>0)
		{
		    new labelstring[40];
			Property[PID[playerid]][pOwner]=newname;
		    DestroyDynamic3DTextLabel(Property[PID[playerid]][pLabel]);
			format(labelstring,sizeof(labelstring),"%s",Property[PID[playerid]][pOwner]);
			Property[PID[playerid]][pLabel]=CreateDynamic3DTextLabel(labelstring,0xFFFFFFFF,Property[PID[playerid]][prX],Property[PID[playerid]][prY],Property[PID[playerid]][prZ],6.0);
		}
		new x[128]; format(x,sizeof(x),"Accounts/%s.ini",MarriedTo[playerid]);
		INI_Set(x,"MarriedTo",PlayerName(playerid));
        NameLimit[playerid]=NameLimit[playerid]+1;
        if(PlayerOrg[playerid]>0)
    	{
   			if(PlayerLeader[playerid]==1){Organization[PlayerOrg[playerid]][Leader]=PlayerName(playerid);}
    		if(strcmp(Organization[PlayerOrg[playerid]][Member1],name,true)==0){format(Organization[PlayerOrg[playerid]][Member1],25,PlayerName(playerid));}
    		if(strcmp(Organization[PlayerOrg[playerid]][Member2],name,true)==0){format(Organization[PlayerOrg[playerid]][Member2],25,PlayerName(playerid));}
    		if(strcmp(Organization[PlayerOrg[playerid]][Member3],name,true)==0){format(Organization[PlayerOrg[playerid]][Member3],25,PlayerName(playerid));}
    		if(strcmp(Organization[PlayerOrg[playerid]][Member4],name,true)==0){format(Organization[PlayerOrg[playerid]][Member4],25,PlayerName(playerid));}
    		if(strcmp(Organization[PlayerOrg[playerid]][Member5],name,true)==0){format(Organization[PlayerOrg[playerid]][Member5],25,PlayerName(playerid));}
    		if(strcmp(Organization[PlayerOrg[playerid]][Member6],name,true)==0){format(Organization[PlayerOrg[playerid]][Member6],25,PlayerName(playerid));}
    		if(strcmp(Organization[PlayerOrg[playerid]][Member7],name,true)==0){format(Organization[PlayerOrg[playerid]][Member7],25,PlayerName(playerid));}
		}
	}
    else return SendClientMessage(playerid,GREY,"That name is too short,pick another");
    return 1;
}
//==============================================================================
CMD:drivingschool(playerid,params[])
{
	if(IsJailedOrMuted(playerid))return 1;
	if(License[playerid][StepB] >=1||License[playerid][StepD] >=1||License[playerid][StepF] >=1)
	return SendClientMessage(playerid,GREY,"You can't use this command while giving tests");
	if(DL[playerid]==0)
 	{
		GivePlayerMoneyEx(playerid,-500);
		GameTextForPlayer(playerid,"~r~-$500",800,1);
		SetPlayerPos(playerid,-2027.8357,-98.8815,35.1641);
 		SendClientMessage(playerid,-1,"You've been teleported to driving school");
	}else return SendClientMessage(playerid,GREY,"You already have a driving license");
	return 1;
}
//==============================================================================
CMD:repair(playerid,params[])
{
	if(Job[playerid]==1||AdminLevel[playerid]>1)
	{
		if(IsJailedOrMuted(playerid))return 1;
		new Float:health,vehicleid=GetPlayerVehicleID(playerid);
		GetVehicleHealth(vehicleid,health);
 		if(!IsPlayerInAnyVehicle(playerid)) return SendClientMessage(playerid,GREY,"You need to be inside a vehicle");
		SetPlayerChatBubble(playerid,"*repaired the vehicle",LBLUE,100.0,10000);
 		if(AdminLevel[playerid]>1)
 		{
			RepairVehicle(vehicleid);
 			return 1;
		}
 		else if(Job[playerid]==1)
 		{
 		    if(GetPlayerWantedLevel(playerid)>0)return SendClientMessage(playerid,GREY,"You are wanted,loose the heat");
			if(health >=800) return SendClientMessage(playerid,GREY,"The engine is in good condition it doesnt need to repair");
 		    GivePlayerMoneyEx(playerid,-500);
			SetVehicleHealth(vehicleid,1000);
			GameTextForPlayer(playerid,"~r~-$500",3000,1);
			SendClientMessage(playerid,YELLOW,"You have repaired the vehicle");
		}
	}else return SendClientMessage(playerid,GREY,"You aren't a mechanic");
	return 1;
}
//==============================================================================
CMD:stats(playerid,params[])
{
	new str[128],name[20],yes[20];
    if(isnull(params))
    {
		if(IsJailedOrMuted(playerid))return 1;
		if(Job[playerid]==0){name="None";}
		if(Job[playerid]==1){name="Mechanic";}
		if(Job[playerid]==2){name="Bus Driver";}
		if(Job[playerid]==3){name="Taxi Driver";}
		if(Passport[playerid]==0){yes="None";}
		if(Passport[playerid]==1){yes="Los Santos";}
		if(Passport[playerid]==2){yes="Las Venturas";}
		if(Passport[playerid]==3){yes="San Fierro";}
		SendClientMessage(playerid,-1,"_________________________________________");
		format(str,sizeof(str),"***%s's Stats***",PlayerName(playerid));
		SendClientMessage(playerid,LRED,str);
		format(str,sizeof(str),"Experience: {FFFFFF}%d || {FF6347}Gamer Score: {FFFFFF}%d",GetPlayerScore(playerid),GamerScore[playerid]);
		SendClientMessage(playerid,LRED,str);
		format(str,sizeof(str),"Cash: {FFFFFF}$%d ||{FF6347} Bank Balance: {FFFFFF}$%d(Acc.Id: %i)",GetPlayerMoneyEx(playerid),Bank[playerid],BankID[playerid]);
		SendClientMessage(playerid,LRED,str);
		if(Cell[playerid] <=1){format(str,sizeof(str),"Phonenumber: {FFFFFF}N/A ");}
		if(Cell[playerid] > 1){format(str,sizeof(str),"Phonenumber: {FFFFFF}%i ",Cell[playerid]);}
		SendClientMessage(playerid,LRED,str);
		format(str,sizeof(str),"Connected Time: {FFFFFF}%d Hours(s),%d Min || {FF6347}Job: {FFFFFF}%s",Hours[playerid],Minutes[playerid],name);
		SendClientMessage(playerid,LRED,str);
		format(str,sizeof(str),"Passport: {FFFFFF}%s",yes);
		SendClientMessage(playerid,LRED,str);
 		if(Teacher[playerid]==1){SendClientMessage(playerid,LRED,"Roleplay Teacher: {FFFFFF}Yes,available");}
		format(str,sizeof(str),"RolePlay Mark: {FFFFFF}%d Out of 10",RP[playerid]);
		SendClientMessage(playerid,LRED,str);
		format(str,sizeof(str),"Organization: {FFFFFF}%s",GetOrgName(PlayerOrg[playerid]));
		SendClientMessage(playerid,LRED,str);
		SendClientMessage(playerid,-1,"_________________________________________");
   	}
    else
    {
        new ID=strval(params);
        if(AdminLevel[playerid]>1)
        {
   			if(ID==playerid)return SendClientMessage(playerid,RED,"Bitch Please");
        	if(IsPlayerConnectedEx(ID))
       		{
       		    if(IsMuted(playerid))return 1;
				if(Job[ID]==0){name="None";}
				if(Job[ID]==1){name="Mechanic";}
				if(Job[ID]==2){name="Bus Driver";}
				if(Job[ID]==3){name="Taxi Driver";}
				if(Passport[ID]==0){yes="None";}
				if(Passport[ID]==1){yes="Los Santos";}
				if(Passport[ID]==2){yes="Las Venturas";}
				if(Passport[ID]==3){yes="San Fierro";}
				SendClientMessage(playerid,-1,"______________________________________");
				format(str,sizeof(str),"***%s's Stats***",PlayerName(ID));
				SendClientMessage(playerid,LRED,str);
				format(str,sizeof(str),"Experience: {FFFFFF}%d || {FF6347}Gamer Score: {FFFFFF}%d",GetPlayerScore(ID),GamerScore[ID]);
				SendClientMessage(playerid,LRED,str);
				format(str,sizeof(str),"Cash: {FFFFFF}$%d ||{FF6347} Bank Balance: {FFFFFF}$%d(Acc.Id: %i)",GetPlayerMoneyEx(ID),Bank[ID],BankID[ID]);
				SendClientMessage(playerid,LRED,str);
				if(Cell[ID] <=1){format(str,sizeof(str),"Phonenumber: {FFFFFF}N/A ");}
				if(Cell[ID] > 1){format(str,sizeof(str),"Phonenumber: {FFFFFF}%i ",Cell[ID]);}
				SendClientMessage(playerid,LRED,str);
				format(str,sizeof(str),"Connected Time: {FFFFFF}%d Hours(s),%d Min || {FF6347}Job: {FFFFFF}%s",Hours[ID],Minutes[ID],name);
				SendClientMessage(playerid,LRED,str);
				format(str,sizeof(str),"Passport: {FFFFFF}%s",yes);
				SendClientMessage(playerid,LRED,str);
 				if(Teacher[ID]==1){SendClientMessage(playerid,LRED,"Roleplay Teacher: {FFFFFF}Yes,available");}
				format(str,sizeof(str),"RolePlay Mark: {FFFFFF}%d Out of 10",RP[ID]);
				SendClientMessage(playerid,LRED,str);
				format(str,sizeof(str),"Organization: {FFFFFF}%s",GetOrgName(PlayerOrg[ID]));
				SendClientMessage(playerid,LRED,str);
				SendClientMessage(playerid,-1,"______________________________________");
			}else return SendClientMessage(playerid,GREY,"Invalid player ID");
        }else return 0;
    }
    return 1;
}
//==============================================================================
CMD:licenses(playerid,params[])
{
	if(IsJailedOrMuted(playerid))return 1;
	SendClientMessage(playerid,ORANGE,"|_____________Licenses_____________|");
	if(DL[playerid]==1)
	{
		SendClientMessage(playerid,YELLOW,"Driving License: {FFFFFF}Yes");
	}
	if(DL[playerid]==0)
	{
		SendClientMessage(playerid,YELLOW,"Driving License: {FFFFFF}No");
	}
	if(GL[playerid]==1)
	{
		SendClientMessage(playerid,YELLOW,"Weapon License: {FFFFFF}Yes");
	}
	if(GL[playerid]==0)
	{
		SendClientMessage(playerid,YELLOW,"Weapon License: {FFFFFF}No");
	}
	if(FL[playerid]==1)
	{
		SendClientMessage(playerid,YELLOW,"Flying License: {FFFFFF}Yes");
	}
	if(FL[playerid]==0)
	{
		SendClientMessage(playerid,YELLOW,"Flying License: {FFFFFF}No");
	}
	if(BL[playerid]==1)
	{
		SendClientMessage(playerid,YELLOW,"Bike License: {FFFFFF}Yes");
	}
	if(BL[playerid]==0)
	{
		SendClientMessage(playerid,YELLOW,"Bike License: {FFFFFF}No");
	}
	if(BtL[playerid]==1)
	{
		SendClientMessage(playerid,YELLOW,"Boating License: {FFFFFF}Yes");
	}
	if(BtL[playerid]==0)
	{
		SendClientMessage(playerid,YELLOW,"Boating License: {FFFFFF}No");
	}
	SendClientMessage(playerid,ORANGE,"|__________________________________|");
	return 1;
}
//==============================================================================
CMD:refuel(playerid,params[])
{
	if(IsJailedOrMuted(playerid))return 1;
	if(!IsPlayerInAnyVehicle(playerid)) return SendClientMessage(playerid,GREY,"You need to be in a vehicle");
	if(IsBicycle(GetPlayerVehicleID(playerid)))return SendClientMessage(playerid,GREY,"You need to be in a vehicle");
 	if(Refuelling[playerid]) return SendClientMessage(playerid,GREY,"You are already refuelling");
  	if(GetPlayerMoneyEx(playerid)<4) return SendClientMessage(playerid,GREY,"You don't have enough money on you");
   	if(!IsAtFuelStation(playerid)&&GetPlayerState(playerid)!=PLAYER_STATE_DRIVER)return SendClientMessage(playerid,GREY,"You need to be near a gas station");
	new engine,lights,alarm,doors,bonnet,boot,objective,vehicleid=GetPlayerVehicleID(playerid);
	GetVehicleParamsEx(vehicleid,engine,lights,alarm,doors,bonnet,boot,objective);
	if(engine==1) return SendClientMessage(playerid,GREY,"Please switch off your /engine");
	SetPlayerChatBubble(playerid,"*refueling the tank",LBLUE,100.0,10000);
	if(fuel[vehicleid]>=35)return SendClientMessage(playerid,GREY,"Your vehicle is already fueled up");
  	Refuelling[playerid]=1;
  	return 1;
}
//==============================================================================
CMD:bank(playerid,params[])
{
	if(IsJailedOrMuted(playerid))return 1;
	if(IsPlayerInRangeOfPoint(playerid,5,1569.7124,-2263.4231,266.2109))
	{
		if(BankID[playerid]==0)
		{
			SendClientMessage(playerid,GREY,"You need a bank account");
			SendClientMessage(playerid,-1,"Use /registerbank to reigster a bank account");
		}
		else if(BankID[playerid]>0)
		{
		    ShowPlayerDialog(playerid,BANK,DIALOG_STYLE_LIST,"San Andreas Bank","1. Withdraw\n2. Deposit","Select","Close");
		}
	}else return SendClientMessage(playerid,GREY,"You need to be inside the bank");
	return 1;
}
//==============================================================================
CMD:withdraw(playerid,params[])
{
	if(IsJailedOrMuted(playerid))return 1;
	if(IsPlayerInRangeOfPoint(playerid,5,1569.7124,-2263.4231,266.2109))
	{
		if(BankID[playerid]==0)
		{
			SendClientMessage(playerid,GREY,"You need a bank account");
			SendClientMessage(playerid,GREY,"Use /registerbank to reigster a bank account");
		}
		else if(BankID[playerid]>0)
		{
    		if(isnull(params))
    		{
    			ShowPlayerDialog(playerid,WITHDRAW,DIALOG_STYLE_INPUT,"San Andreas Bank","{FFFFFF}Please Enter The Amount,You Would Like To Withdraw","Withdraw","Cancel");
			}
			if(!isnull(params))
			{
				if(strval(params) > Bank[playerid]||!IsNumeric(params))
				{
					SendClientMessage(playerid,GREY,"USAGE: /withdraw [amount]");
				}
				else
				{
				    new string[128];
					GivePlayerMoneyEx(playerid,strval(params));
					Bank[playerid]=Bank[playerid] - strval(params);
					format(string,sizeof(string),"You have withdrawn $%d from your Bank Account. New Balance: $%d",strval(params),Bank[playerid]);
					SendClientMessage(playerid,YELLOW,string);
					format(string,sizeof(string),"~g~+$%d",strval(params));
					GameTextForPlayer(playerid,string,800,1);
				}
			}
		}
	}else return SendClientMessage(playerid,GREY,"You aren't inside a bank");
	return 1;
}
//==============================================================================
CMD:deposit(playerid,params[])
{
	if(IsJailedOrMuted(playerid))return 1;
	if(IsPlayerInRangeOfPoint(playerid,5,1569.7124,-2263.4231,266.2109))
	{
		if(BankID[playerid]==0)
		{
			SendClientMessage(playerid,GREY,"You need a bank account");
			SendClientMessage(playerid,-1,"Use /registerbank to reigster a bank account");
		}
		else if(BankID[playerid]>0)
		{
    		if(isnull(params))
    		{
    			ShowPlayerDialog(playerid,DEPOSIT,DIALOG_STYLE_INPUT,"San Andreas Bank","{FFFFFF}Please Enter The Amount,You Would Like To Deposit","Deposit","Cancel");
			}
			if(!isnull(params))
			{
				if(strval(params) > GetPlayerMoneyEx(playerid)||!IsNumeric(params))
				{
					SendClientMessage(playerid,GREY,"USAGE: /deposit [amount]");
				}
				else
				{
				    new string[128];
					GivePlayerMoneyEx(playerid,-strval(params));
					Bank[playerid]=Bank[playerid] + strval(params);
					format(string,sizeof(string),"You have deposited $%d to your Bank Account. New Balance: $%d",strval(params),Bank[playerid]);
					SendClientMessage(playerid,YELLOW,string);
					format(string,sizeof(string),"~r~-$%d",strval(params));
					GameTextForPlayer(playerid,string,800,1);
				}
			}
		}
	}else return SendClientMessage(playerid,GREY,"You aren't inside a bank");
	return 1;
}
//==============================================================================
CMD:helmet(playerid,params)
{
	if(IsJailedOrMuted(playerid))return 1;
 	new vehicleid=GetPlayerVehicleID(playerid);
	if(GetVehicleModel(vehicleid)==522
	|| GetVehicleModel(vehicleid)==509
	|| GetVehicleModel(vehicleid)==481
	|| GetVehicleModel(vehicleid)==510
	|| GetVehicleModel(vehicleid)==462
	|| GetVehicleModel(vehicleid)==448
	|| GetVehicleModel(vehicleid)==581
	|| GetVehicleModel(vehicleid)==461
	|| GetVehicleModel(vehicleid)==521
	|| GetVehicleModel(vehicleid)==523
	|| GetVehicleModel(vehicleid)==463
	|| GetVehicleModel(vehicleid)==586
	|| GetVehicleModel(vehicleid)==468
	|| GetVehicleModel(vehicleid)==471)
	{
  		SetPlayerAttachedObject(playerid,4,18645,2,0.07,0,0,88,75,0);
  	}
	SetPlayerChatBubble(playerid,"*wears the helmet",LBLUE,100.0,10000);
	return 1;
}
//==============================================================================
CMD:acmds(playerid,params[])
{
	if(IsMuted(playerid))return 1;
	if(AdminLevel[playerid]==0)return 0;
	if(AdminLevel[playerid] >=1)
	{
		SendClientMessage(playerid,YELLOW,"Administrator LEVEL 1: {FFFFFF}/a /vips /unbug /carcolor /cellnumbers /ann /mute /getweaps /stats [id]");
		SendClientMessage(playerid,YELLOW,"Administrator LEVEL 1: {FFFFFF}/slap /disarm /explode /freeze /unfreeze /kick /unmute /nos /kill");
	}
	if(AdminLevel[playerid] >=2)
	{
		SendClientMessage(playerid,0x1344ECFF,"Administrator LEVEL 2: {FFFFFF}/setweather /tp /checkcash /goto /get /specoff /spec /sethealth /setarmor /registered");
		SendClientMessage(playerid,0x1344ECFF,"Administrator LEVEL 2: {FFFFFF}/repair /hide /cc /unban /vrespawn /refuelall /ban /flip /lastactive");
	}
	if(AdminLevel[playerid] >=3)
	{
        SendClientMessage(playerid,RED,"Administrator LEVEL 3: {FFFFFF}/givelicenses /v /getip /setskin /setcash /transfercash /setscore /teletohq /fuck");
        SendClientMessage(playerid,RED,"Administrator LEVEL 3: {FFFFFF}/resetcar /wipeorg /setleader /setdrugs /givegun /skydive /setskills /crash");
		SendClientMessage(playerid,RED,"Administrator LEVEL 3: {FFFFFF}/setvip /sethours /setteacher /payday /a(un)jail /banreason /gmx /say");
	}
	return 1;
}
//==============================================================================
CMD:smoke(playerid,params[])
{
	if(IsJailedOrMuted(playerid))return 1;
	if(Cigars[playerid] >=1)
	{
		SetPlayerSpecialAction(playerid,SPECIAL_ACTION_SMOKE_CIGGY);
		Cigars[playerid]=Cigars[playerid]-1;
		SetPlayerChatBubble(playerid,"*lightens his cigarette",LBLUE,100.0,10000);
	}else return SendClientMessage(playerid,GREY,"You dont have any cigars");
	return 1;
}
//==============================================================================
CMD:atm(playerid,params[])
{
	if(IsJailedOrMuted(playerid))return 1;
 	for(new i=0; i < sizeof(AtmInfo); i++)
	{
		if(IsPlayerInRangeOfPoint(playerid,1.5,AtmInfo[i][aX],AtmInfo[i][aY],AtmInfo[i][aZ]))
		{
			if(AtmInfo[i][aCreated]==1)
			{
				SetPlayerChatBubble(playerid,"*using the atm",LBLUE,100.0,10000);
	        	if(BankID[playerid]==0)return SendClientMessage(playerid,GREY,"You need a bank account");
          		ShowPlayerDialog(playerid,ATM,DIALOG_STYLE_INPUT,"San Andreas Bank","{FFFFFF}Please Enter The Amount,You would like to withdraw","Withdraw","Back");
 			}
   		}
	}
	return 1;
}
//==============================================================================
CMD:hide(playerid,params[])
{
	if(IsMuted(playerid))return 1;
	if(AdminLevel[playerid]>=2)
 	{
  		new string[128];
  		if(Hidden[playerid]==0)
		{
  			Hidden[playerid]=1;
			SetPlayerColor(playerid,-1);
			format(string,40,"~r~<~w~Left~r~>~w~ %s",PlayerName(playerid));
    		ConnectTextdraw(string);
			format(string,128,"*%s has left the server",PlayerName(playerid));
			SendClientMessageToAll(GREY,string);
	    	SendClientMessage(playerid,YELLOW,"You are now hidden from the Administrator List");
		}
		else if(Hidden[playerid]==1)
		{
  			Hidden[playerid]=0;
			format(string,40,"~g~<~w~Join~g~>~w~ %s",PlayerName(playerid));
    		ConnectTextdraw(string);
			SetPlayerColor(playerid,-1);
			format(string,128,"*{A9C4E4}%s{FFFFFF} has joined the server",PlayerName(playerid));
			SendClientMessageToAll(-1,string);
	    	SendClientMessage(playerid,YELLOW,"You are now un-hidden from the Administrator List");
			if(PlayerOrg[playerid]!=0)SetPlayerColor(playerid,Organization[PlayerOrg[playerid]][Color]);
		}
	}else return 0;
	return 1;
}
//==============================================================================
CMD:url(playerid,params[])
{
	if(IsJailedOrMuted(playerid))return 1;
	SendClientMessage(playerid,ORANGE,"URL: changeme.com");
 	return 1;
}
//==============================================================================
CMD:setlevel(playerid,params[])
{
	if(IsMuted(playerid))return 1;
    new levels,str[128],ID,mode[128];
    if(AdminLevel[playerid]==4 || IsPlayerAdmin(playerid))
    {
    	if(sscanf(params,"ui",ID,levels)) return SendClientMessage(playerid,GREY,"USAGE: /setlevel [playerid] [Level 1-4]");
    	if(levels > 4) return SendClientMessage(playerid,GREY,"LEVELS AVAILABLE 1-4");
    	if(!IsPlayerConnectedEx(ID))return SendClientMessage(playerid,GREY,"Invalid player ID");
    	if(AdminLevel[ID]==levels) return SendClientMessage(playerid,GREY,"That player is already this Administrator level");
    	if(levels==0)
		{mode="{FFFFFF}Regular Player(Level 0)";}
    	if(levels==1)
		{mode="{FFFF00}Server Moderator {FFFFFF}(Level 1)";}
		if(levels==2)
		{mode="{0000FF}Global Moderator {FFFFFF}(Level 2)";}
		if(levels==3)
		{mode="{FF0000}Administrator {FFFFFF}(Level 3)";}
		if(levels==4)
		{mode="{ADFF2F}Lead Admin {FFFFFF}(Level 3+)";}
    	format(str,sizeof(str),"An Administrator has set your level to %s",mode);
    	SendClientMessage(ID,YELLOW,str);
    	format(str,sizeof(str),"You have set %s's level to %s",PlayerName(ID),mode);
    	SendClientMessage(playerid,YELLOW,str);
		if(PlayerAwards[ID][Admin]==0)
		{
		    PlayerAwards[ID][Admin]=1;
		    GivePlayerMoneyEx(ID,10000);
			GamerScore[playerid]=GamerScore[playerid]+70;
		    SendClientMessage(ID,YELLOW,"Achievement Unlocked: {FFFFFF}I Made It!");
  			SendClientMessage(ID,LGREEN,"BONUS: $10000 || +70 Gamer Score");
		}
    	AdminLevel[ID]=levels;
 	}else return 0;
  	return 1;
}
//==============================================================================
CMD:setvip(playerid,params[])
{
	if(IsMuted(playerid))return 1;
    new str[128],ID,duration;
    if(AdminLevel[playerid] >=3)
    {
    	if(sscanf(params,"ui",ID,duration)) return SendClientMessage(playerid,GREY,"USAGE: /setvip [player] [Duration-Months]");
    	if(duration<1||duration>12)return SendClientMessage(playerid,GREY,"Duration cannot be less than 1 month or greater than 12 months");
    	if(!IsPlayerConnectedEx(ID))return SendClientMessage(playerid,GREY,"Invalid player ID");
    	if(VIP[ID]>0) return SendClientMessage(playerid,GREY,"That player is already VIP");
		NZT[ID]+=5;
    	VIP[ID]=gettime()+60*60*24*7*4*duration;
		Bank[ID]=Bank[ID]+1000000;
    	format(str,sizeof(str),"An Administrator has set your account status to Premium Account");
    	SendClientMessage(ID,YELLOW,str);
    	format(str,sizeof(str),"You have set %s's account to Premium Account",PlayerName(ID));
    	SendClientMessage(playerid,YELLOW,str);
 	}else return 0;
    return 1;
}
//==============================================================================
CMD:sethours(playerid,params[])
{
    new levels,str[128],ID;
	if(IsMuted(playerid))return 1;
    if(AdminLevel[playerid] > 2)
    {
    	if(sscanf(params,"ui",ID,levels)) return SendClientMessage(playerid,GREY,"USAGE: /sethours [playerid] [Hours]");
    	if(!IsPlayerConnectedEx(ID)||ID==playerid)return SendClientMessage(playerid,GREY,"Invalid player ID");
    	Hours[ID]=levels;
		format(str,sizeof(str),"An Administrator has set your hours to %d",levels);
    	SendClientMessage(ID,YELLOW,str);
    	format(str,sizeof(str),"You have set %s's hours to %d",PlayerName(ID),levels);
    	SendClientMessage(playerid,YELLOW,str);
	}else return 0;
    return 1;
}
//==============================================================================
CMD:cc(playerid,params[])
{
	if(IsMuted(playerid))return 1;
    if(AdminLevel[playerid] >1)
    {
		for(new i=0; i < 100; i++) SendClientMessageToAll(-1," ");
    	SendClientMessageToAll(SAMP,"An Administrator has cleared the server chat");
	}else return 0;
	return 1;
}
//==============================================================================
CMD:unban(playerid,params[])
{
	if(IsMuted(playerid))return 1;
	if(AdminLevel[playerid] >1)
	{
		if(!isnull(params))
		{
			new PlayerFile[50];
			format(PlayerFile,sizeof(PlayerFile),"Accounts/%s.ini",params);
			if(!fexist(PlayerFile))return SendClientMessage(playerid,GREY,"No such player found in the database");
			if(fexist(PlayerFile))
			{
			    if(INI_Int(PlayerFile,"Banned")==0)return SendClientMessage(playerid,GREY,"That player is already unbanned");
				INI_IntSet(PlayerFile,"Banned",0);
    			SendClientMessage(playerid,-1,"Account Unbanned");
			}
		}else return SendClientMessage(playerid,GREY,"USAGE: /unban [playername]");
 	}else return 0;
	return 1;
}
//==============================================================================
CMD:lastactive(playerid,params[])
{
	if(IsMuted(playerid))return 1;
	if(AdminLevel[playerid] >1)
	{
		if(!isnull(params))
		{
			new PlayerFile[50],string[128];
			format(PlayerFile,sizeof(PlayerFile),"Accounts/%s.ini",params);
			if(!fexist(PlayerFile))return SendClientMessage(playerid,GREY,"No such player found in the database");
			if(fexist(PlayerFile))
			{
			    format(string,sizeof(string),"%s's last activity was %s",params,INI_Get(PlayerFile,"LastOnline"));
   				SendClientMessage(playerid,-1,string);
			}
		}else return SendClientMessage(playerid,GREY,"USAGE: /lastactive [playername]");
 	}else return 0;
	return 1;
}
//==============================================================================
CMD:banreason(playerid,params[])
{
	if(IsMuted(playerid))return 1;
	if(AdminLevel[playerid] >2)
	{
  		if(!isnull(params))
  		{
			new PlayerFile[50],str[128];
			format(PlayerFile,sizeof(PlayerFile),"Accounts/%s.ini",params);
			if(!fexist(PlayerFile)) return SendClientMessage(playerid,GREY,"No such player found in the database");
			if(INI_Int(PlayerFile,"Banned")==0)return SendClientMessage(playerid,GREY,"That player is not banned");
			format(str,sizeof(str),"%s is banned for %s by %s",params,INI_Get(PlayerFile,"Reason"),INI_Get(PlayerFile,"Banner"));
			SendClientMessage(playerid,-1,str);
		}else return SendClientMessage(playerid,GREY,"USAGE: /banreason [playername]");
 	}else return 0;
	return 1;
}
//==============================================================================
CMD:admins(playerid,params[])
{
	if(IsJailedOrMuted(playerid))return 1;
	new count=0;
 	new string[128],name[50];
	for(new i=0; i < MAX_PLAYERS; i++)
	{
		if(IsPlayerConnectedEx(i))
		{
			if(AdminLevel[i] > 0)
			{
			    if(Hidden[i]==0)
		    	{
  					if(AdminLevel[i]==1){name="{FFFF00}Server Moderator {FFFFFF}(Level 1)";}
     				if(AdminLevel[i]==2){name="{0000FF}Global Moderator {FFFFFF}(Level 2)";}
           			if(AdminLevel[i]==3){name="{FF0000}Administrator {FFFFFF}(Level 3)";}
           			if(AdminLevel[i]==4){name="{ADFF2F}Head Admin {FFFFFF}(Level 3+)";}
					format(string,128,"%s - %s",PlayerName(i),name);
					SendClientMessage(playerid,-1,string);
					count++;
				}
		  	}
		}
	}
	if(count==0)
	SendClientMessage(playerid,GREY,"There are no admins online at the moment");
	return 1;
}
//==============================================================================
CMD:vips(playerid,params[])
{
	if(IsMuted(playerid))return 1;
	if(AdminLevel[playerid]==0)return 0;
	new count=0;
 	new string[128],name[50];
	for(new i=0; i < MAX_PLAYERS; i++)
	{
		if(IsPlayerConnectedEx(i))
		{
			if(VIP[i]>0)
			{
   				name="{FFFF00}Premium Account {FFFFFF}(Level 1)";
				format(string,128,"%s {%s}",PlayerName(i),name);
				SendClientMessage(playerid,-1,string);
				count++;
		  	}
		}
	}
	if(count==0)
	SendClientMessage(playerid,GREY,"There are no VIPS online at the moment");
	return 1;
}
//==============================================================================
CMD:report(playerid,params[])
{
    new Target,reason[50],rstring[128];
	if(IsJailedOrMuted(playerid))return 1;
    if(sscanf(params,"us[50]",Target,reason))return SendClientMessage(playerid,GREY,"USAGE: /report [playerid] [reason]");
	if(Target==playerid) return SendClientMessage(playerid,GREY,"You cannot report yourself");
	if(!IsPlayerConnectedEx(Target)) return SendClientMessage(playerid,GREY,"Invalid player ID");
	if(strlen(reason) > 50) return SendClientMessage(playerid,GREY,"Reason can't be longer than 50 characters");
	format(rstring,sizeof(rstring),"SERVER: {FFFFFF}%s reported %s(Reason: %s)",PlayerName(playerid),PlayerName(Target),reason);
	SendMessageToAdmins(RED,rstring);
	SendClientMessage(playerid,YELLOW,"Your report has been sucessfully sent to the online admins");
    return 1;
}
//==============================================================================
CMD:talkanim(playerid,params)
{
	if(IsJailedOrMuted(playerid))return 1;
	if(Talkanim[playerid]==0)
	{
	    Talkanim[playerid]=1;
	    SendClientMessage(playerid,-1,"You have enabled the talking animation while talking");
	}
	else if(Talkanim[playerid]==1)
	{
	    Talkanim[playerid]=0;
	    SendClientMessage(playerid,-1,"You have disabled the talking animation while talking");
	}
	return 1;
}
//==============================================================================
CMD:t(playerid,params[])
{
	if(IsMuted(playerid))return 1;
    new str[128];
  	if(sscanf(params,"s[128]",params)) return SendClientMessage(playerid,GREY,"USAGE: /t(alk) [text]");
	if(strlen(params) > 128) return SendClientMessage(playerid,GREY,"Text can't be longer than 128 characters");
   	if(rname[playerid]==0)
  	{
		if(PlayerOrgType(playerid)==LAW)
		{
		    if(Suited[playerid]>0)
		    {
		    	format(str,sizeof(str),"{0000FF}Officer {FF8000}%s says: '%s'",PlayerName(playerid),params);
			}
		    if(Suited[playerid]==0)
		    {
		    	format(str,sizeof(str),"%s says: '%s'",PlayerName(playerid),params);
			}
		}
		else
		{
 			format(str,sizeof(str),"%s says: '%s'",PlayerName(playerid),params);
	 	}
	}
	if(rname[playerid]==1)
	{
		if(PlayerOrgType(playerid)==LAW)
		{
		    if(Suited[playerid]>0)
		    {
		    	format(str,sizeof(str),"{0000FF}Officer {FF8000}%s(%i) says: '%s'",RPName[playerid],playerid,params);
			}
		    if(Suited[playerid]==0)
		    {
		    	format(str,sizeof(str),"%s(%i) says: '%s'",RPName[playerid],playerid,params);
			}
		}
		else
		{
			format(str,sizeof(str),"%s(%i) says: '%s'",RPName[playerid],playerid,params);
		}
	}
 	SendNearbyMessage(playerid,8.0,str,ORANGE);
	SetPlayerChatBubble(playerid,params,ORANGE,30.0,2000);
	if(Talkanim[playerid]==1&&!IsPlayerInAnyVehicle(playerid))
	{
		ClearAnimations(playerid);
		if(GetPlayerState(playerid) !=PLAYER_STATE_DRIVER)return
	 	ApplyPlayerAnimation(playerid,"PED","IDLE_CHAT",4.0,0,0,0,0,0);
	}
    return 1;
}
//==============================================================================
CMD:s(playerid,params[])
{
    new str[128];
	if(IsJailedOrMuted(playerid))return 1;
    if(sscanf(params,"s[128]",params)) return SendClientMessage(playerid,GREY,"USAGE: /s(hout) [text]");
	if(strlen(params) > 128) return SendClientMessage(playerid,GREY,"Text can't be longer than 128 characters");
    if(rname[playerid]==0)
    {
    	format(str,sizeof(str),"%s shouts: '%s'",PlayerName(playerid),params);
	}
	if(rname[playerid]==1)
	{
        format(str,sizeof(str),"%s(%i) shouts: '%s'",RPName[playerid],playerid,params);
    }
    SendClientMessageToAll(RED,str);
	SetPlayerChatBubble(playerid,params,RED,30.0,2000);
    return 1;
}
//==============================================================================
CMD:w(playerid,params[])
{
	if(IsMuted(playerid))return 1;
	new str[128];
  	if(sscanf(params,"s[128]",params)) return SendClientMessage(playerid,GREY,"USAGE: /w(hisper) [text]");
	if(strlen(params) > 128) return SendClientMessage(playerid,GREY,"Text can't be longer than 128 characters");
	if(rname[playerid]==0)
	{
		format(str,sizeof(str),"%s whispers: '%s'",PlayerName(playerid),params);
	}
	if(rname[playerid]==1)
	{
		format(str,sizeof(str),"%s(%i) whispers: '%s'",RPName[playerid],playerid,params);
	}
	SetPlayerChatBubble(playerid,params,0xEEE8AA00,30.0,2000);
	SendNearbyMessage(playerid,8.0,str,0xEEE8AA00);
 	return 1;
}
//==============================================================================
CMD:me(playerid,params[])
{
	if(IsMuted(playerid))return 1;
   	new str[128];
    if(sscanf(params,"s[128]",params)) return SendClientMessage(playerid,GREY,"USAGE: /me [action]");
	if(strlen(params) > 128) return SendClientMessage(playerid,GREY,"Text can't be longer than 128 characters");
    if(rname[playerid]==0)
    {
    	format(str,128,"%s %s",PlayerName(playerid),params);
	}
	if(rname[playerid]==1)
	{
        format(str,128,"%s(%i) %s",RPName[playerid],playerid,params);
    }
    SendClientMessageToAll(GREEN,str);
	SetPlayerChatBubble(playerid,params,GREEN,30.0,2000);
    return 1;
}
//==============================================================================
CMD:ad(playerid,params[])
{
   	new str[128];
   	if(PlayerOrg[playerid]!=4)return 0;
	if(IsJailedOrMuted(playerid))return 1;
    if(sscanf(params,"s[128]",params)) return SendClientMessage(playerid,GREY,"USAGE: /ad [text]");
	if(strlen(params) > 128) return SendClientMessage(playerid,GREY,"Text can't be longer than 128 characters");
    format(str,128,"(The Company) %s",params);
    SendClientMessageToAll(0x6F6F6FFF,str);
    return 1;
}
//==============================================================================
CMD:vrespawn(playerid,params[])
{
	if(IsMuted(playerid))return 1;
	if(AdminLevel[playerid] < 2)return 0;
	SendClientMessageToAll(SAMP,"An Administrator has respawned all unused vehicles");
	for(new cars=0; cars<MAX_VEHICLES; cars++)
	{
	    if(!VehicleOccupied(cars)&&!PersonalVehicle(cars))
		{
			SetVehicleToRespawn(cars);
		}
	}
	return 1;
}
//==============================================================================
CMD:refuelall(playerid,params[])
{
	if(IsMuted(playerid))return 1;
	if(AdminLevel[playerid] < 2)return 0;
	SendClientMessageToAll(SAMP,"An Administrator has refueled all vehicles");
	for(new i=0;i<MAX_VEHICLES;i++)fuel[i]=35;
	return 1;
}
//==============================================================================
CMD:changepass(playerid,params[])
{
	new  string[128];
   	if(!IsPlayerConnectedEx(playerid)) return 0;
	if(sscanf(params,"s[25]",params)) return SendClientMessage(playerid,GREY,"USAGE: /changepass [password]");
	if(strlen(params) > 25) return SendClientMessage(playerid,GREY,"Password can't be longer than 25 characters");
 	Password[playerid]=udb_hash(params);
	PlayerPlaySound(playerid,1057,0.0,0.0,0.0);
	format(string,sizeof(string),"You have changed your password to '%s'",params);
	SendClientMessage(playerid,YELLOW,string);
	return 1;
}
//==============================================================================
CMD:buyskin(playerid,params[])
{
	new skin;
	if(IsJailedOrMuted(playerid))return 1;
 	if(!IsAtClothesShop(playerid)) return SendClientMessage(playerid,GREY,"You must be in clothes shop to buy the skin");
  	if(GetPlayerMoneyEx(playerid)<1500) return SendClientMessage(playerid,GREY,"You don't have enough money on you");
  	if(sscanf(params,"i",skin)) return SendClientMessage(playerid,GREY,"USAGE: /buyskin [SkinID]");
  	if(!IsValidSkin(skin)) return SendClientMessage(playerid,GREY,"Invalid skin ID");
	if(IsOrgSkin(skin)) return SendClientMessage(playerid,GREY,"That skin is already bought by an organization");
	SendClientMessage(playerid,YELLOW,"You have bought your own skin");
  	GameTextForPlayer(playerid,"~r~-$1500",1000,1);
 	Skin[playerid]=skin;
  	GivePlayerMoneyEx(playerid,-1500);
  	SetPlayerSkin(playerid,skin);
  	return 1;
}
//==============================================================================
CMD:givecash(playerid,params[])
{
    new pID,value;
	if(IsJailedOrMuted(playerid))return 1;
    if(sscanf(params,"ui",pID,value)) return SendClientMessage(playerid,GREY,"USAGE: /givecash [playerid] [amount]");
	if(!IsPlayerConnectedEx(pID)||pID==playerid) return SendClientMessage(playerid,GREY,"Invalid player ID");
    if(value > GetPlayerMoneyEx(playerid)) return SendClientMessage(playerid,GREY,"You don't have enough money on you");
    if(value<0) return SendClientMessage(playerid,GREY,"USAGE: /givecash [playerid] [amount]");
    if(GetPlayerScore(playerid)==0 && value >500) return SendClientMessage(playerid,GREY,"No more cash than $500");
    if(GetPlayerScore(playerid)==1 && value >750) return SendClientMessage(playerid,GREY,"No more cash than $750");
	if(GetPlayerScore(playerid)==2 && value >1500) return SendClientMessage(playerid,GREY,"No more cash than $1500");
    if(GetPlayerScore(playerid)==3 && value >5000) return SendClientMessage(playerid,GREY,"No more cash than $5000");
    if(GetPlayerScore(playerid)==4 && value >7500) return SendClientMessage(playerid,GREY,"No more cash than $7500");
    if(GetPlayerScore(playerid)==5 && value >10000) return SendClientMessage(playerid,GREY,"No more cash than $10000");
    if(GetPlayerScore(playerid)==6 && value >20000) return SendClientMessage(playerid,GREY,"No more cash than $20000");
	new string[128];
    format(string,sizeof(string),"You have given $%i to %s",value,PlayerName(pID));
    SendClientMessage(playerid,YELLOW,string);
    format(string,sizeof(string),"You received $%i by %s",value,PlayerName(playerid));
    SendClientMessage(pID,YELLOW,string);
    GivePlayerMoneyEx(pID,value);
    GivePlayerMoneyEx(playerid,- value);
    format(string,sizeof(string),"~r~-$%d",value);
    GameTextForPlayer(playerid,string,800,1);
    format(string,sizeof(string),"~g~+$%d",value);
    GameTextForPlayer(pID,string,800,1);
    return 1;
}
//==============================================================================
CMD:shareammo(playerid,params[])
{
    new pID,value;
	if(IsJailedOrMuted(playerid))return 1;
    if(sscanf(params,"ui",pID,value)) return SendClientMessage(playerid,GREY,"USAGE: /shareammo [playerid] [amount]");
    else if(!IsPlayerConnectedEx(pID)||pID==playerid) return SendClientMessage(playerid,GREY,"Invalid player ID");
    else if(value > GetPlayerAmmo(playerid)) return SendClientMessage(playerid,GREY,"You Dont Have That Much Ammos");
    else if(GetPlayerWeapon(pID) !=GetPlayerWeapon(playerid)) return SendClientMessage(playerid,GREY,"The player needs to have the same gun as you are having");
	else
	{
        new string[128];
        format(string,sizeof(string),"You shared %i ammos to %s",value,PlayerName(pID));
        SendClientMessage(playerid,YELLOW,string);
        format(string,sizeof(string),"You got %i ammos by %s",value,PlayerName(playerid));
        SendClientMessage(pID,YELLOW,string);
        SetPlayerAmmo(pID,GetPlayerWeapon(pID),GetPlayerAmmo(pID)+value);
        SetPlayerAmmo(playerid,GetPlayerWeapon(playerid),GetPlayerAmmo(playerid)-value);
    }
    return 1;
}
//==============================================================================
CMD:handweapon(playerid,params[])
{
    new pID,wname[40];
	if(IsJailedOrMuted(playerid))return 1;
    if(sscanf(params,"u",pID)) return SendClientMessage(playerid,GREY,"USAGE: /handweapon [playerid]");
    else if(!IsPlayerConnectedEx(pID)||pID==playerid) return SendClientMessage(playerid,GREY,"Invalid player ID");
    else if(GetPlayerWeapon(playerid)==0) return SendClientMessage(playerid,GREY,"You don't have any armed weapon");
    else
	{
        new string[128];
		GetWeaponName(GetPlayerWeapon(playerid),wname,sizeof(wname));
        format(string,sizeof(string),"You have handed %s your %s",PlayerName(pID),wname);
        SendClientMessage(playerid,YELLOW,string);
        format(string,sizeof(string),"%s has handed you his %s",PlayerName(playerid),wname);
        SendClientMessage(pID,YELLOW,string);
        GivePlayerWeaponEx(pID,GetPlayerWeapon(playerid),GetPlayerAmmo(playerid));
        SetPlayerAmmo(playerid,GetPlayerWeapon(playerid),0);
    }
    return 1;
}
//==============================================================================
CMD:transfer(playerid,params[])
{
    new pID,value;
	if(IsJailedOrMuted(playerid))return 1;
    if(sscanf(params,"ii",pID,value)) return SendClientMessage(playerid,GREY,"USAGE: /transfer [Acc.ID] [amount]");
    if(BankID[playerid]==0) return SendClientMessage(playerid,GREY,"You don't have a bank account");
    if(value > Bank[playerid]) return SendClientMessage(playerid,GREY,"You Dont Have That Much Balance");
    if(GetPlayerScore(playerid)<5) return SendClientMessage(playerid,GREY,"You need to be level 5 to use this function");
    if(BankID[playerid]==pID) return SendClientMessage(playerid,GREY,"USAGE: /transfer [Acc.ID] [amount]");
	for(new i=0; i<MAX_PLAYERS; i++)
    {
        if(BankID[i]==pID && pID > 0)
        {
        	new string[128];
        	format(string,sizeof(string),"You transfered $%i to Bank Account %i",value,BankID[i]);
        	SendClientMessage(playerid,YELLOW,string);
       	 	format(string,sizeof(string),"You received $%i by Bank Account %i",value,BankID[playerid]);
        	SendClientMessage(pID,YELLOW,string);
  			Bank[playerid]=Bank[playerid]-value;
        	Bank[i]=Bank[i]+value;
		}
    }
    return 1;
}
//==============================================================================
CMD:transfercash(playerid,params[])
{
	if(IsMuted(playerid))return 1;
    new ID,ID1,value,status,string[128];
	if(AdminLevel[playerid]<3)return 0;
    if(sscanf(params,"iuui",status,ID,ID1,value)) return SendClientMessage(playerid,GREY,"USAGE: /transfercash [TYPE] [From playerid] [To playerid] [Amount]")&&SendClientMessage(playerid,-1,"Type 1=Bank,Type 2=Cash");
	if(!IsPlayerConnectedEx(ID))return SendClientMessage(playerid,GREY,"Player 1 is not connected");
	if(!IsPlayerConnectedEx(ID1))return SendClientMessage(playerid,GREY,"Player 2 is not connected");
    if(status<1 ||status>2)return SendClientMessage(playerid,GREY,"USAGE: /transfercash [1=Bank || 2=Cash] [From playerid] [To playerid] [Amount]");
    if(status==1)
    {
    	if(BankID[ID]==0) return SendClientMessage(playerid,GREY,"Player 1 has no bank account");
    	if(value > Bank[ID]) return SendClientMessage(playerid,GREY,"Player 1 has not that much cash");
    	if(BankID[ID1]==0) return SendClientMessage(playerid,GREY,"Player 2 has no bank account");
  		Bank[ID]=Bank[ID]-value;
       	Bank[ID1]=Bank[ID1]+value;
       	format(string,128,"An Administrator has transfered %s's amount of $%d to your bank account",PlayerName(ID),value);
       	SendClientMessage(ID1,YELLOW,string);
       	format(string,128,"An Administrator has transfered your ammount of $%d to %s's bank account",value,PlayerName(ID1));
       	SendClientMessage(ID,YELLOW,string);
       	format(string,128,"You have transfered ammount of $%d from %s to %s's bank account",value,PlayerName(ID),PlayerName(ID1));
       	SendClientMessage(playerid,YELLOW,string);
	}
    if(status==2)
    {
        if(GetPlayerMoneyEx(ID)<value)return SendClientMessage(playerid,GREY,"Player 1 has not that much cash");
  		GivePlayerMoneyEx(ID,-value);
       	GivePlayerMoneyEx(ID1,value);
       	format(string,128,"An Administrator has transfered %s's amount of $%d to you",PlayerName(ID),value);
       	SendClientMessage(ID1,YELLOW,string);
       	format(string,128,"An Administrator has transfered your ammount of $%d to %s",value,PlayerName(ID1));
       	SendClientMessage(ID,YELLOW,string);
       	format(string,128,"You have transfered ammount of $%d from %s to %s",value,PlayerName(ID),PlayerName(ID1));
       	SendClientMessage(playerid,YELLOW,string);
	}
    return 1;
}
//==============================================================================
CMD:engine(playerid,params[])
{
	if(IsJailedOrMuted(playerid))return 1;
    if(GetPlayerState(playerid) != PLAYER_STATE_DRIVER)return 0;
	new vehicleid=GetPlayerVehicleID(playerid),engine,lights,alarm,doors,bonnet,boot,objective;
	GetVehicleParamsEx(vehicleid,engine,lights,alarm,doors,bonnet,boot,objective);
	if(engine == 1)
	{
	    TextDrawHideForPlayer(playerid,td_fuel[playerid]);
		TextDrawHideForPlayer(playerid,sdisplay[playerid]);
	   	SetVehicleParamsEx(vehicleid,0,0,alarm,doors,bonnet,boot,objective);
	}
	else
	{
		if(IsDL(vehicleid))return SendClientMessage(playerid,GREY,"You cannot drive the dealership vehicles");
	   	if(fuel[vehicleid]<1)return SendClientMessage(playerid,GREY,"Your vehicle is out of fuel");
 		if(!IsBoat(vehicleid)){TextDrawShowForPlayer(playerid,td_fuel[playerid]);}
	   	SetVehicleParamsEx(vehicleid,1,lights,alarm,doors,bonnet,boot,objective);
		GameTextForPlayer(playerid,"~n~~n~~n~Starting Engine",1000,5);
 		TextDrawShowForPlayer(playerid,sdisplay[playerid]);
	}
    return 1;
}
//==============================================================================
CMD:setteacher(playerid,params[])
{
    new str[128],ID;
	if(IsMuted(playerid))return 1;
    if(AdminLevel[playerid] >=3)
    {
    	if(sscanf(params,"u",ID)) return SendClientMessage(playerid,GREY,"USAGE: /setteacher [playerid]");
    	if(!IsPlayerConnectedEx(ID))return SendClientMessage(playerid,GREY,"Invalid player ID");
    	if(Teacher[ID]==0)
    	{
    		format(str,sizeof(str),"An Administrator has set you RolePlay Teacher");
    		SendClientMessage(ID,YELLOW,str);
    		SendClientMessage(ID,-1,"Use /givemarks to give a player RolePlay Marks");
    		SendClientMessage(ID,-1,"Use /lesson and /endlesson,to start or end a player's driving test,respectively");
    		format(str,sizeof(str),"You have set %s as a RP teacher",PlayerName(ID));
    		SendClientMessage(playerid,YELLOW,str);
    		Teacher[ID]=1;
		}
		else if(Teacher[ID]==1)
    	{
    		format(str,sizeof(str),"An Administrator has removed you from RolePlay Teacher Job");
    		SendClientMessage(ID,YELLOW,str);
    		format(str,sizeof(str),"You have removed %s as a RP teacher",PlayerName(ID));
    		SendClientMessage(playerid,YELLOW,str);
    		Teacher[ID]=0;
		}
   	}else return 0;
    return 1;
}
//==============================================================================
CMD:showmarks(playerid,params[])
{
    new str[128],ID;
	if(IsJailedOrMuted(playerid))return 1;
   	if(sscanf(params,"u",ID)) return SendClientMessage(playerid,GREY,"USAGE: /showmarks [playerid]");
   	if(!IsPlayerConnectedEx(ID))return SendClientMessage(playerid,GREY,"Invalid player ID");
   	format(str,sizeof(str),"%s has shown you his RolePlay Marks. It's %d out of 10",PlayerName(playerid),RP[playerid]);
   	SendClientMessage(ID,YELLOW,str);
   	SendClientMessage(playerid,-1,"You've shown your marks");
    return 1;
}
//==============================================================================
CMD:givemarks(playerid,params[])
{
	if(IsJailedOrMuted(playerid))return 1;
    new levels,str[128],ID,Float:x,Float:y,Float:z;
    if(Teacher[playerid]==1)
    {
    	if(sscanf(params,"ui",ID,levels)) return SendClientMessage(playerid,GREY,"USAGE: /givemarks [playerid] [Marks 1-10]");
		GetPlayerPos(playerid,x,y,z);
		if(!IsPlayerInRangeOfPoint(ID,10,x,y,z))return SendClientMessage(playerid,GREY,"That player is far away from you");
		if(levels > 10) return SendClientMessage(playerid,GREY,"MARKS AVAILABLE 1-10");
    	if(GetPlayerScore(ID)<3) return SendClientMessage(playerid,GREY,"The player has a score less than 3");
    	if(RP[ID] > 0) return SendClientMessage(playerid,GREY,"That player has already got RP marks");
    	if(!IsPlayerConnectedEx(ID) || ID==playerid)return SendClientMessage(playerid,GREY,"Invalid player ID");
    	format(str,sizeof(str),"Teacher %s has given you %d RolePlay Marks",PlayerName(playerid),levels);
    	SendClientMessage(ID,YELLOW,str);
    	format(str,sizeof(str),"You have set %s's RolePlay Marks to %d",PlayerName(ID),levels);
    	SendClientMessage(playerid,YELLOW,str);
    	RP[ID]=levels;
    	if(PlayerAwards[ID][School]==0)
		{
			PlayerAwards[ID][School]=1;
 			GivePlayerMoneyEx(ID,150);
			GamerScore[playerid]=GamerScore[playerid]+80;
  			SendClientMessage(ID,YELLOW,"Achievement Unlocked: {FFFFFF}Back To School!");
			SendClientMessage(ID,LGREEN,"BONUS: $150 || +80 Gamer Score");
		}
    }else return SendClientMessage(playerid,GREY,"You aren't a teacher");
    return 1;
}
//==============================================================================
CMD:resetmarks(playerid,params[])
{
    new str[128],ID;
	if(IsMuted(playerid))return 1;
    if(AdminLevel[playerid] > 2)
    {
    	if(sscanf(params,"u",ID)) return SendClientMessage(playerid,GREY,"USAGE: /resetmarks [playerid]");
    	if(!IsPlayerConnectedEx(ID) || ID==playerid)return SendClientMessage(playerid,GREY,"Invalid player ID");
    	SendClientMessage(ID,YELLOW,"An Administrator has resetted your RolePlay Marks");
    	format(str,sizeof(str),"You have resetted %s's RolePlay Marks to 0",PlayerName(ID));
    	SendClientMessage(playerid,YELLOW,str);
    	RP[ID]=0;
    }else return 0;
    return 1;
}
//==============================================================================
CMD:rpname(playerid,params[])
{
	new str[128];
	if(IsJailedOrMuted(playerid))return 1;
    if(sscanf(params,"s[128]",params))
	{
		SendClientMessage(playerid,GREY,"USAGE: /rpname [Name]");
		if(strlen(params) > 24) return SendClientMessage(playerid,-1,"The name cannot contain more than 20 letters");
        format(RPName[playerid],25,"None");
		Delete3DTextLabel(Label[playerid]);
     	SendClientMessage(playerid,ORANGE,"Roleplay name has been removed");
     	SendClientMessage(playerid,-1,"Use /rpname [name(space allowed)] to add your roleplay name,leave [name] blank to remove it");
     	for(new i=0; i < MAX_PLAYERS; i++){ShowPlayerNameTagForPlayer(i,playerid,1);}
		rname[playerid]=0;
	}
	else
	{
		if(rname[playerid]==0 ||rname[playerid]==1)
		{
    		new bool:invalid=false;
			if(strfind(params,"[",true,0) !=-1|| strfind(params,"]",true,0)!=-1|| strfind(params,"_",true,0)!=-1
			|| strfind(params,"!",true,0)!=-1|| strfind(params,"@",true,0)!=-1|| strfind(params,"#",true,0)!=-1
			|| strfind(params,"%",true,0)!=-1|| strfind(params,"^",true,0)!=-1|| strfind(params,"&",true,0)!=-1
			|| strfind(params,"*",true,0)!=-1|| strfind(params,"-",true,0)!=-1|| strfind(params,"=",true,0)!=-1
			|| strfind(params,"+",true,0)!=-1|| strfind(params,"`",true,0)!=-1|| strfind(params,"~",true,0)!=-1
			|| strfind(params,"'",true,0)!=-1|| strfind(params,";",true,0)!=-1|| strfind(params,":",true,0)!=-1
			|| strfind(params,"(",true,0)!=-1|| strfind(params,")",true,0)!=-1|| strfind(params,"|",true,0)!=-1
			|| strfind(params,"/",true,0)!=-1|| strfind(params,".",true,0)!=-1|| strfind(params,">",true,0)!=-1
			|| strfind(params,"<",true,0)!=-1|| strfind(params,",",true,0)!=-1|| strfind(params,"/",true,0)!=-1)invalid=true;
			if(invalid==true)return SendClientMessage(playerid,GREY,"Your name contains invalid characters/symbols");
			Delete3DTextLabel(Label[playerid]);
	    	format(str,sizeof(str),"%s(%i)",params,playerid);
    		Label[playerid]=Create3DTextLabel(str,0xFFFFFFFF,0,0,0,6,0,1 );
   			Attach3DTextLabelToPlayer(Label[playerid],playerid,0.0,0.0,0.2);
			for(new i=0; i < MAX_PLAYERS; i++){ShowPlayerNameTagForPlayer(i,playerid,0);}
    		SendClientMessage(playerid,ORANGE,"Roleplay name has been added successfully");
    		format(RPName[playerid],25,"%s",params);
			rname[playerid]=1;
		}
	}
	return 1;
}
//==============================================================================
CMD:a(playerid,params[])
{
	if(IsMuted(playerid))return 1;
	if(AdminLevel[playerid]>=1)
    {
        new str[128];
    	if(sscanf(params,"s[128]",params)) return SendClientMessage(playerid,GREY,"USAGE: /a(dmin Chat) [Text]");
    	if(strlen(params) > 128) return SendClientMessage(playerid,GREY,"Text can't be longer than 128 characters");
    	format(str,sizeof(str),"Administrator Chat - %s : {FFFFFF}%s",PlayerName(playerid),params);
        for(new a=0;a<MAX_PLAYERS;a++)
        {
        	if(IsPlayerConnectedEx(a))
       		{
        		if(AdminLevel[a]>=1)
         		{
           			SendClientMessage(a,LRED,str);
             	}
			}
        }
	}else return 0;
	return 1;
}
//==============================================================================
CMD:setweather(playerid,params[])
{
	if(IsMuted(playerid))return 1;
	if(AdminLevel[playerid] >=2)
	{
	    new id,string[128],str[20];
	    if(sscanf(params,"d",id)) return
	    SendClientMessage(playerid,GREY,"USAGE: /setweather [WeatherID]")&&
		SendClientMessage(playerid,-1,"1=Normal || 8=Stormy,9=Foggy || 10=Cloudy || 11=Hot || 12=Dull || 17=Hot || 19=Sandstorm || 20=Foggy");
		SetWeather(id);
		if(id==1){str="to Normal";}
		if(id==8){str="to Stormy";}
		if(id==9){str="to Foggy";}
		if(id==10){str="to Cloudy";}
		if(id==11){str="to Hot";}
		if(id==12){str="to Dull";}
		if(id==17){str="to Scorching hot";}
		if(id==19){str="to Sandstorm";}
		if(id==20){str="to Foggy";}
		format(string,sizeof(string),"An Administrator has changed the weather %s",str);
		return SendClientMessageToAll(SAMP,string);
	}
    else return 0;
}
//==============================================================================
CMD:unbug(playerid,params[])
{
	if(IsMuted(playerid))return 1;
	if(AdminLevel[playerid]>=1)
 	{
    	new id,str[128];
    	if(sscanf(params,"u",id))return SendClientMessage(playerid,GREY,"USAGE: /unbug [playerid]");
    	if(IsPlayerConnectedEx(id))
    	{
  			SetPlayerInterior(id,0);
  			SetPlayerVirtualWorld(id,0);
  			TogglePlayerControllable(id,1);
  			GameTextForPlayer(id,"Unbugged",2000,0);
  			SetPlayerPos(id,2035.7804,-1413.1953,16.9922);
  			format(str,sizeof(str),"You have unbugged %s",PlayerName(id));
  			SendClientMessage(playerid,YELLOW,str);
        }else  SendClientMessage(playerid,GREY,"Invalid player ID");
    }else return 0;
    return 1;
}
//==============================================================================
CMD:showlicenses(playerid,params[])
{
    new str[128],ID,yes[5],gl[5],fl[5],bl[5],btl[5];
	if(IsJailedOrMuted(playerid))return 1;
   	if(sscanf(params,"u",ID)) return SendClientMessage(playerid,GREY,"USAGE: /showlicenses [playerid]");
   	if(!IsPlayerConnectedEx(ID) || ID==playerid)return SendClientMessage(playerid,GREY,"Invalid player ID");
   	if(DL[playerid]==1)
   	{yes="Yes";}
   	if(DL[playerid]==0)
   	{yes="No";}
   	if(GL[playerid]==1)
   	{gl="Yes";}
   	if(GL[playerid]==0)
   	{gl="No";}
   	if(FL[playerid]==1)
   	{fl="Yes";}
   	if(FL[playerid]==0)
   	{fl="No";}
   	if(BL[playerid]==1)
   	{bl="Yes";}
   	if(BL[playerid]==0)
   	{bl="No";}
   	if(BtL[playerid]==1)
   	{btl="Yes";}
   	if(BtL[playerid]==0)
   	{btl="No";}
   	format(str,sizeof(str),"%s has shown you his Licenses",PlayerName(playerid));
   	SendClientMessage(ID,-1,str);
   	format(str,sizeof(str),"|-%s's Licenses-|",PlayerName(playerid));
	SendClientMessage(ID,ORANGE,str);
	format(str,sizeof(str),"Driving License: {FFFFFF}%s",yes);
	SendClientMessage(ID,YELLOW,str);
	format(str,sizeof(str),"Weapon License: {FFFFFF}%s",gl);
	SendClientMessage(ID,YELLOW,str);
	format(str,sizeof(str),"Flying License: {FFFFFF}%s",fl);
	SendClientMessage(ID,YELLOW,str);
	format(str,sizeof(str),"Bike License: {FFFFFF}%s",bl);
	SendClientMessage(ID,YELLOW,str);
	format(str,sizeof(str),"Boat License: {FFFFFF}%s",btl);
	SendClientMessage(ID,YELLOW,str);
   	SendClientMessage(playerid,-1,"You've shown your licenses");
    return 1;
}
//==============================================================================
CMD:givelicenses(playerid,params[])
{
    new ID;
	if(IsMuted(playerid))return 1;
	if(AdminLevel[playerid]<3)return 0;
   	if(sscanf(params,"u",ID)) return SendClientMessage(playerid,GREY,"USAGE: /givelicenses [playerid]");
   	if(!IsPlayerConnectedEx(ID) || ID==playerid)return SendClientMessage(playerid,GREY,"Invalid player ID");
   	DL[ID]=1;
   	GL[ID]=1;
   	FL[ID]=1;
   	BL[ID]=1;
   	BtL[ID]=1;
   	SendClientMessage(ID,YELLOW,"An Administrator has given you all the licenses");
   	SendClientMessage(playerid,YELLOW,"You gave that player all the licenses");
    return 1;
}
//==============================================================================
CMD:do(playerid,params[])
{
	if(IsJailedOrMuted(playerid))return 1;
    new Float:X,Float:Y,Float:Z,str[128];
    if(sscanf(params,"s[128]",params)) return SendClientMessage(playerid,GREY,"USAGE: /do [action]");
    GetPlayerPos(playerid,X,Y,Z);
    format(str,sizeof(str),"(( %s )) %s",PlayerName(playerid),params);
    for(new i=0; i<MAX_PLAYERS; i++)if(i!=playerid)
    {
        if(IsPlayerConnectedEx(i)&&IsPlayerInRangeOfPoint(i,15.0,X,Y,Z))
        {
            SendClientMessage(i,YELLOW,str);
            SendClientMessage(playerid,YELLOW,str);
    		SetPlayerChatBubble(playerid,params,YELLOW,30.0,2000);
    		return 1;
        }else return SendClientMessage(playerid,GREY,"You did something but no one saw you");
	}
    return 1;
}
//==============================================================================
CMD:call(playerid,params[])
{
	new number,str[128];
	if(IsJailedOrMuted(playerid))return 1;
	if(sscanf(params,"i",number))return SendClientMessage(playerid,GREY,"USAGE: /call [phonenumber]");
	if(Cell[playerid]<=1)return SendClientMessage(playerid,GREY,"You don't have a cell phone,go buy it from 24/7 Shop");
	if(number==911)
	{
	   	Reporting[playerid]=1;
		SendClientMessage(playerid,-1,"Please type the report and afterwards it will be sent to online medics and cops");
	}
	if(number==666666)
	{
	    GivePlayerMoneyEx(playerid,-1000);
    	GameTextForPlayer(playerid,"~r~-$1000",800,1);
	   	if(PlayerAwards[playerid][Bill]==0)
		{
			PlayerAwards[playerid][Bill]=1;
 			GivePlayerMoneyEx(playerid,100);
			GamerScore[playerid]=GamerScore[playerid]+90;
  			SendClientMessage(playerid,YELLOW,"Achievement Unlocked: {FFFFFF}NOT That Phone Bill!");
			SendClientMessage(playerid,LGREEN,"BONUS: $100 || +90 Gamer Score");
		}
	}
	for(new i=0; i<MAX_PLAYERS; i++)
    {
        if(Cell[i]==number)
        {
            if(onphone[playerid]==1)return SendClientMessage(playerid,GREY,"You are on phone already");
			SetPlayerChatBubble(playerid,"*takes out cellphone",-1,100.0,10000);
			if(!IsPlayerConnectedEx(i))return SendClientMessage(playerid,GREY,"Caller ID not found");
            if(Cellswitched[i]==1)return SendClientMessage(playerid,GREY,"The number you have dialed is switched off,please try later");
			if(Cellswitched[playerid]==1)return SendClientMessage(playerid,GREY,"You cannot make calls while your cell phone is switched off");
			if(called[i]==1||onphone[i]==1)return SendClientMessage(playerid,GREY,"The player is already on phone");
			if(called[playerid]==1||onphone[playerid]==1)return SendClientMessage(playerid,GREY,"You are already being called or you are on phone");
			if(Cell[i]<=1)return SendClientMessage(playerid,GREY,"That player doesn't have a cell phone");
 			if(Cell[playerid]==number)return SendClientMessage(playerid,GREY,"You can't call yourself");
   			SetPVarInt(playerid,"receiverid",i);
   			SetPVarInt(i,"receiverid",playerid);
    		format(str,sizeof str,"Calling %i...",number);
    		SendClientMessage(playerid,-1,str);
    		SetPlayerSpecialAction(playerid,SPECIAL_ACTION_USECELLPHONE);
    		format(str,sizeof str,"<%i> is calling you. Use /pickup to answer",Cell[playerid]);
        	PlayerPlaySound(i,3600,0.0,0.0,0.0);
    		SendClientMessage(i,YELLOW,str);
    		called[i]=1;
		}
	}
    return 1;
}
//==============================================================================
CMD:text(playerid,params[])
{
	new number,text[128],str[128];
	if(IsJailedOrMuted(playerid))return 1;
	if(GetPlayerMoneyEx(playerid) < 13) return SendClientMessage(playerid,GREY,"You don't have enough money on you");
	if(sscanf(params,"is[128]",number,text))return SendClientMessage(playerid,GREY,"USAGE: /text [phonenumber] [text]");
	if(Cell[playerid]<=1)return SendClientMessage(playerid,GREY,"You don't have a cell phone,go buy it from 24/7 Shop");
    if(strlen(text) > 128) return SendClientMessage(playerid,GREY,"Text can't be longer than 100 characters");
	for(new i=0; i<MAX_PLAYERS; i++)
    {
        if(Cell[i]==number)
        {
			if(!IsPlayerConnectedEx(i))return SendClientMessage(playerid,GREY,"Recipent not found");
			if(Cellswitched[i]==1)return SendClientMessage(playerid,GREY,"The number you have texted is switched off,please try later");
			if(Cellswitched[playerid]==1)return SendClientMessage(playerid,GREY,"You cannot send texts while your cell phone is switched off");
			if(Cell[i]<=1)return SendClientMessage(playerid,GREY,"USAGE: /text [phonenumber] [text]");
 			format(str,sizeof str,"<%i>: {FFFFFF}%s",Cell[playerid],text);
 			SendClientMessage(i,YELLOW,str);
 			format(str,sizeof str,"SMS Preview: %s",text);
 			SendClientMessage(playerid,-1,str);
 			GameTextForPlayer(playerid,"~r~-$13",3000,1);
 			GivePlayerMoneyEx(playerid,-13);
		}
	}
 	return 1;
}
//==============================================================================
CMD:pickup(playerid,params[])
{
	if(IsJailedOrMuted(playerid))return 1;
	if(called[playerid]==0)return SendClientMessage(playerid,GREY,"Nobody is calling you");
	if(onphone[playerid]==1)return SendClientMessage(playerid,GREY,"You are on phone already");
	if(Cell[playerid]<=1)return SendClientMessage(playerid,GREY,"You don't have a cell phone,go buy it from 24/7 Shop");
 	new receiverid=GetPVarInt(playerid,"receiverid");
  	onphone[playerid]=1;
  	onphone[receiverid]=1;
  	called[playerid]=0;
  	SendClientMessage(receiverid,-1,"Your call has been answered");
  	SendClientMessage(playerid,-1,"You have answered the call");
  	SetPlayerSpecialAction(playerid,SPECIAL_ACTION_USECELLPHONE);
  	return 1;
}
//==============================================================================
CMD:hangup(playerid,params[])
{
	if(IsJailedOrMuted(playerid))return 1;
    new receiverid=GetPVarInt(playerid,"receiverid");
    if(Cell[playerid]<=1)return SendClientMessage(playerid,GREY,"You don't have a cell phone,go buy it from 24/7 Shop");
    if(called[playerid]==0&&onphone[playerid]==0)return SendClientMessage(playerid,GREY,"Nobody is calling you nor you are on phone call");
   	SendClientMessage(playerid,GREY,"You hanged up the phone call");
   	SendClientMessage(receiverid,GREY,"The caller has diconnected");
   	SetPlayerSpecialAction(playerid,SPECIAL_ACTION_STOPUSECELLPHONE);
   	SetPlayerSpecialAction(receiverid,SPECIAL_ACTION_STOPUSECELLPHONE);
	called[playerid]=0;
   	onphone[playerid]=0;
	called[receiverid]=0;
   	onphone[receiverid]=0;
   	SetPVarInt(receiverid,"receiverid",-1);
   	SetPVarInt(playerid,"receiverid",-1);
	return 1;
}
//==============================================================================
CMD:togglecell(playerid,cmdtext[])
{
	if(IsJailedOrMuted(playerid))return 1;
  	if(Cell[playerid]<=1)return SendClientMessage(playerid,-1,"You don't have a cell phone,go buy it from 24/7 Shop");
	if(Cellswitched[playerid]==1)
	{
		Cellswitched[playerid]=0;
		SendClientMessage(playerid,YELLOW,"You have switched on your cell phone");
		SendClientMessage(playerid,-1,"You can now make/receive calls or send/receive texts");
	}
	else if(Cellswitched[playerid]==0)
	{
		Cellswitched[playerid]=1;
		SendClientMessage(playerid,YELLOW,"You have switched off your cell phone");
		SendClientMessage(playerid,-1,"You can not make/receive calls and you wont send/receive texts");
	}
	return 1;
}
//==============================================================================
CMD:payday(playerid,params[])
{
	if(IsMuted(playerid))return 1;
	if(AdminLevel[playerid]<3)return 0;
	Hour();
	return 1;
}
//-=============================================================================
CMD:tp(playerid,params[])
{
	if(IsMuted(playerid))return 1;
    if(AdminLevel[playerid] >=2)
	{
		new player1,player2;
	    if(sscanf(params,"uu",player1,player2))return SendClientMessage(playerid,GREY,"USAGE: /teleport [playerid] to [playerid]");
		new string[128];
		new Float:plocx,Float:plocy,Float:plocz;
		if(IsPlayerConnectedEx(player1))
	 	{
 			if(IsPlayerConnectedEx(player2))
		  	{
				GetPlayerPos(player2,plocx,plocy,plocz);
				new intid=GetPlayerInterior(player2);
				SetPlayerInterior(player1,intid);
				SetPlayerVirtualWorld(player1,GetPlayerVirtualWorld(player2));
				if(GetPlayerState(player1)==PLAYER_STATE_DRIVER)
				{
					new VehicleID=GetPlayerVehicleID(player1);
					SetVehiclePos(VehicleID,plocx+2,plocy,plocz); LinkVehicleToInterior(VehicleID,intid);
					SetVehicleVirtualWorld(VehicleID,GetPlayerVirtualWorld(player2));
				}
				else SetPlayerPos(player1,plocx+2,plocy,plocz);
				format(string,sizeof(string),"An Administrator has teleported %s to %s's position",PlayerName(player1),PlayerName(player2));
				SendClientMessage(player1,YELLOW,string); SendClientMessage(player2,YELLOW,string);
				format(string,sizeof(string),"You have teleported %s to %s's position",PlayerName(player1),PlayerName(player2));
 		 	    return SendClientMessage(playerid,YELLOW,string);
 		 	}
		  	else return SendClientMessage(playerid,GREY,"Player Two is not connected");
		}
		else return SendClientMessage(playerid,GREY,"Player One is not connected");
	}
	else return 0;
}
//==============================================================================
CMD:eject(playerid,params[])
{
	if(IsJailedOrMuted(playerid))return 1;
	new pid,msg[128];
	if(sscanf(params,"u",pid)) return SendClientMessage(playerid,GREY,"USAGE: /eject [playerid]");
	if(GetPlayerState(playerid) !=PLAYER_STATE_DRIVER) return SendClientMessage(playerid,GREY,"You are not driving a vehicle");
	if(!IsPlayerConnectedEx(pid)||playerid==pid) return SendClientMessage(playerid,GREY,"Invalid player ID");
	new vehicleid=GetPlayerVehicleID(playerid);
	if(!IsPlayerInVehicle(pid,vehicleid)&&Teacher[playerid]==0) return SendClientMessage(playerid,GREY,"Player is not in your vehicle");
	RemovePlayerFromVehicle(pid);
	format(msg,sizeof(msg),"%s has removed you from his/her vehicle",PlayerName(playerid));
	SendClientMessage(pid,YELLOW,msg);
	format(msg,sizeof(msg),"You have removed %s from your vehicle",PlayerName(pid));
	SendClientMessage(playerid,YELLOW,msg);
	return 1;
}
//==============================================================================
CMD:v(playerid,params[])
{
	if(AdminLevel[playerid]< 3) return 0;
	if(IsJailedOrMuted(playerid))return 1;
	new vid,Float:X,Float:Y,Float:Z,Float:R;
	if(sscanf(params,"i",vid)) return SendClientMessage(playerid,GREY,"USAGE: /v [vehicleid]");
	if(vid < 400 || vid > 611) return  SendClientMessage(playerid,GREY,"Invalid Vehicle Model ID");
	if(IsRC(vid))return SendClientMessage(playerid,GREY,"You cannot spawn remote control vehicles or trailers");
	GetPlayerPos(playerid,X,Y,Z);
	DestroyVehicle(ACar[playerid]);
	GetPlayerFacingAngle(playerid,R);
	ACar[playerid]=AddStaticVehicleEx(vid,X,Y,Z,R,-1,-1,0);
	PutPlayerInVehicle(playerid,ACar[playerid],0);
 	fuel[ACar[playerid]]=35;
	return 1;
}
//==============================================================================
CMD:carcolor(playerid,params[])
{
	new color1,color2;
	if(IsJailedOrMuted(playerid))return 1;
    if(VIP[playerid]<1||AdminLevel[playerid]<1) return SendClientMessage(playerid,GREY,"You aren't a VIP");
 	if(GetPlayerState(playerid)==PLAYER_STATE_DRIVER)
	{
		if(sscanf(params,"ii",color1,color2))return SendClientMessage(playerid,GREY,"USAGE: /carcolor [id1] [id2]");
		if(VIP[playerid]>0&&GetPlayerVehicleID(playerid)!=Car[playerid])return SendClientMessage(playerid,GREY,"This car is not owned by you");
		ChangeVehicleColor(GetPlayerVehicleID(playerid),color1,color2);
 		CarColor1[playerid]=color1;
		CarColor2[playerid]=color2;
  	}else return SendClientMessage(playerid,GREY,"You must be in a vehicle");
    return 1;
}
//==============================================================================
CMD:nos(playerid,params[])
{
	if(IsJailedOrMuted(playerid))return 1;
    if(VIP[playerid]<1||AdminLevel[playerid]<1) return SendClientMessage(playerid,GREY,"You aren't a VIP");
   	if(GetPlayerState(playerid)==PLAYER_STATE_DRIVER)
	{
 		switch(GetVehicleModel(GetPlayerVehicleID(playerid)))
		{
			case 448,461,462,463,468,471,509,510,521,522,523,581,586,449:
			return SendClientMessage(playerid,GREY,"You can not tune this vehicle");
		}
  		AddVehicleComponent(GetPlayerVehicleID(playerid),1010);
		PlayerPlaySound(playerid,1133,0.0,0.0,0.0);
	}else return SendClientMessage(playerid,GREY,"You must be in a vehicle");
	return 1;
}
//==============================================================================
CMD:weather(playerid,params[])
{
 	new id;
	if(IsJailedOrMuted(playerid))return 1;
	if(VIP[playerid] < 1)return SendClientMessage(playerid,GREY,"You aren't a VIP");
 	if(sscanf(params,"d",id)) return SendClientMessage(playerid,GREY,"USAGE: /weather [WeatherID]");
	SetPlayerWeather(playerid,id);PlayerPlaySound(playerid,1057,0.0,0.0,0.0);
	return 1;
}
//==============================================================================
CMD:changeskin(playerid,params[])
{
	new skin;
	if(IsJailedOrMuted(playerid))return 1;
	if(VIP[playerid]<1) return SendClientMessage(playerid,GREY,"You aren't a VIP");
  	if(sscanf(params,"i",skin)) return SendClientMessage(playerid,GREY,"USAGE: /changeskin [SkinID]");
  	if(!IsValidSkin(skin)) return SendClientMessage(playerid,GREY,"You entered an invalid skin ID");
 	Skin[playerid]=skin;
  	SetPlayerSkin(playerid,skin);
  	return 1;
}
//==============================================================================
CMD:nzt(playerid,params[])
{
	if(IsJailedOrMuted(playerid))return 1;
	if(NZT[playerid]>0)
	{
		NZT[playerid]--;
		SetPlayerDrunkLevel(playerid,3000);
		SetPlayerSkillLevel(playerid,WEAPONSKILL_M4,1000);
		SetPlayerSkillLevel(playerid,WEAPONSKILL_MP5,1000);
		SetPlayerSkillLevel(playerid,WEAPONSKILL_AK47,1000);
		SetPlayerSkillLevel(playerid,WEAPONSKILL_SHOTGUN,1000);
		SetPlayerSkillLevel(playerid,WEAPONSKILL_MICRO_UZI,1000);
		SetPlayerSkillLevel(playerid,WEAPONSKILL_SNIPERRIFLE,1000);
		SetPlayerSkillLevel(playerid,WEAPONSKILL_DESERT_EAGLE,1000);
		SetPlayerSkillLevel(playerid,WEAPONSKILL_SPAS12_SHOTGUN,1000);
		SetPlayerSkillLevel(playerid,WEAPONSKILL_SAWNOFF_SHOTGUN,1000);
		SetPlayerSkillLevel(playerid,WEAPONSKILL_PISTOL_SILENCED,1000);
	}else return SendClientMessage(playerid,GREY,"You don't have any NZT tablets");
  	return 1;
}
//==============================================================================
CMD:checkcash(playerid,params[])
{
	if(IsMuted(playerid))return 1;
	if(AdminLevel[playerid]>=2)
	{
		new id,str[128];
  		if(sscanf(params,"u",id)) return SendClientMessage(playerid,GREY,"USAGE: /checkcash [playerid]");
  		if(!IsPlayerConnectedEx(id)||id==playerid)return SendClientMessage(playerid,GREY,"Invalid player ID");
		format(str,sizeof(str),"%s has a Cash of $%i and $%i in his bank account",PlayerName(id),GetPlayerMoneyEx(id),Bank[id]);
		SendClientMessage(playerid,YELLOW,str);
	}else return 0;
  	return 1;
}
//==============================================================================
CMD:cellnumbers(playerid,params[])
{
	new count=0,string[128];
	if(IsMuted(playerid))return 1;
  	if(AdminLevel[playerid]==0)return 0;
	for(new i=0; i < MAX_PLAYERS; i++)
	{
		if(IsPlayerConnectedEx(i))
		{
			if(Cell[i] > 0)
			{
			    format(string,128,"%s {FFFFFF}{Cell Number: %d}",PlayerName(i),Cell[i]);
				SendClientMessage(playerid,YELLOW,string);
				count++;
		  	}
		}
	}
	if(count==0)
	SendClientMessage(playerid,GREY,"None of any online players have cell phone");
	return 1;
}
//==============================================================================
CMD:lesson(playerid,params[])
{
	new id,string[128];
	if(IsJailedOrMuted(playerid))return 1;
	if(Teacher[playerid]==0) return SendClientMessage(playerid,GREY,"You aren't a teacher");
	if(Lesson[playerid]!=-1)return SendClientMessage(playerid,GREY,"You are already taking a RolePlay Driving Test");
	if(sscanf(params,"u",id)) return SendClientMessage(playerid,GREY,"USAGE: /lesson [playerid]");
	if(!IsPlayerConnectedEx(id)||id==playerid)return SendClientMessage(playerid,GREY,"Invalid player ID");
	if(!RPVehicle(GetPlayerVehicleID(id)))return SendClientMessage(playerid,GREY,"You both need to be inside a RP School Car");
	format(string,sizeof(string),"Teacher %s has started your RolePlay Driving Test",PlayerName(playerid));
	SendClientMessage(id,YELLOW,string);
	format(string,sizeof(string),"You have started the RolePlay Driving Test of {FFFFFF}%s",PlayerName(id));
	SendClientMessage(playerid,YELLOW,string);
	Lesson[playerid]=id;
	Lesson[id]=playerid;
	return 1;
}
//==============================================================================
CMD:endlesson(playerid,params[])
{
	new string[128];
	if(IsJailedOrMuted(playerid))return 1;
	if(Teacher[playerid]==0) return SendClientMessage(playerid,GREY,"You aren't a teacher");
	if(Lesson[playerid]==-1)return SendClientMessage(playerid,GREY,"You aren't performing anyone's lesson test");
	format(string,sizeof(string),"Teacher %s has ended your RolePlay Driving Test",PlayerName(playerid));
	SendClientMessage(Lesson[playerid],YELLOW,string);
	format(string,sizeof(string),"You have ended the RolePlay Driving Test of {FFFFFF}%s",PlayerName(Lesson[playerid]));
	SendClientMessage(playerid,YELLOW,string);
	RemovePlayerFromVehicle(Lesson[playerid]);
	Lesson[Lesson[playerid]]=-1;
	Lesson[playerid]=-1;
	return 1;
}
//==============================================================================
CMD:ann(playerid,params[])
{
	if(AdminLevel[playerid]>=1)
	{
		new id,str[128],ann[50];
		if(IsMuted(playerid))return 1;
  		if(sscanf(params,"us[50]",id,ann)) return SendClientMessage(playerid,GREY,"USAGE: /ann [playerid] [announcement]");
		if(strlen(ann) > 50) return SendClientMessage(playerid,GREY,"Text can't be longer than 50 characters");
		if(!IsPlayerConnectedEx(id)||id==playerid)return SendClientMessage(playerid,GREY,"Invalid player ID");
		format(str,sizeof(str),"You announced '%s' to %s",ann,PlayerName(id));
		SendClientMessage(playerid,YELLOW,str);
		format(str,sizeof(str),"~y~%s",ann);
		GameTextForPlayer(id,str,6000,4);
	}else return 0;
	return 1;
}
//==============================================================================
CMD:mute(playerid,params[])
{
    new str[128],ID,time;
	if(IsMuted(playerid))return 1;
    if(AdminLevel[playerid] >=1)
    {
    	if(sscanf(params,"ui",ID,time)) return SendClientMessage(playerid,GREY,"USAGE: /mute [playerid] [TIME]");
    	if(!IsPlayerConnectedEx(ID)||ID==playerid)return SendClientMessage(playerid,GREY,"Invalid player ID");
    	if(time<1||time>60)return SendClientMessage(playerid,GREY,"Time period cannot be less than 1 or greater than 60 minutes");
    	if(AdminLevel[playerid]<AdminLevel[ID])return SendClientMessage(playerid,GREY,"You can't perform this command on your seniors");
    	if(Mute[ID]> 0) return SendClientMessage(playerid,GREY,"That player is already muted");
    	format(str,sizeof(str),"You have muted %s for %i minutes",PlayerName(ID),time);
		SendClientMessage(playerid,LRED,str);
		format(str,sizeof(str),"You have been muted by an Administrator");
		SendClientMessage(ID,LRED,str);
		Mute[ID]=time;
    }else return 0;
    return 1;
}
//==============================================================================
CMD:unmute(playerid,params[])
{
    new str[128],ID;
	if(IsMuted(playerid))return 1;
    if(AdminLevel[playerid] >=1)
    {
		if(sscanf(params,"u",ID)) return SendClientMessage(playerid,GREY,"USAGE: /unmute [playerid]");
    	if(!IsPlayerConnectedEx(ID)||ID==playerid)return SendClientMessage(playerid,GREY,"Invalid player ID");
    	if(AdminLevel[playerid]<AdminLevel[ID])return SendClientMessage(playerid,GREY,"You can't perform this command on your seniors");
    	if(Mute[ID]==0) return SendClientMessage(playerid,GREY,"That player is not muted");
    	format(str,sizeof(str),"You have unmuted %s",PlayerName(ID));
		SendClientMessage(playerid,YELLOW,str);
		format(str,sizeof(str),"You have been unmuted by an Administrator");
		SendClientMessage(ID,YELLOW,str);
		Mute[ID]=0;
    }else return 0;
    return 1;
}
//==============================================================================
CMD:slap(playerid,params[])
{
    new str[128],ID;
	if(IsMuted(playerid))return 1;
    if(AdminLevel[playerid] >=1)
    {
    	if(sscanf(params,"u",ID)) return SendClientMessage(playerid,GREY,"USAGE: /slap [playerid]");
    	if(!IsPlayerConnectedEx(ID)||ID==playerid)return SendClientMessage(playerid,GREY,"Invalid player ID");
    	if(AdminLevel[playerid]<AdminLevel[ID])return SendClientMessage(playerid,GREY,"You can't perform this command on your seniors");
    	format(str,sizeof(str),"You have slapped %s",PlayerName(ID));
		SendClientMessage(playerid,LRED,str);
		format(str,sizeof(str),"You have been slapped by an Administrator");
		SendClientMessage(ID,LRED,str);
		new Float:x,Float:y,Float:z;
		GetPlayerPos(ID,x,y,z);
		SetPlayerPos(ID,x,y,z+5);
    }else return 0;
    return 1;
}
//==============================================================================
CMD:disarm(playerid,params[])
{
    new str[128],ID;
	if(IsMuted(playerid))return 1;
    if(AdminLevel[playerid] >=1)
    {
    	if(sscanf(params,"u",ID)) return SendClientMessage(playerid,GREY,"USAGE: /disarm [playerid]");
    	if(!IsPlayerConnectedEx(ID)||ID==playerid)return SendClientMessage(playerid,GREY,"Invalid player ID");
    	if(AdminLevel[playerid]<AdminLevel[ID])return SendClientMessage(playerid,GREY,"You can't perform this command on your seniors");
    	format(str,sizeof(str),"You have disarmed %s",PlayerName(ID));
		SendClientMessage(playerid,LRED,str);
		format(str,sizeof(str),"You have been disarmed by an Administrator");
		SendClientMessage(ID,LRED,str);
		ResetPlayerWeaponsEx(ID);
    }else return 0;
    return 1;
}
//==============================================================================
CMD:kill(playerid,params[])
{
    new str[128],ID;
	if(IsMuted(playerid))return 1;
    if(AdminLevel[playerid] >=1)
    {
    	if(sscanf(params,"u",ID)) return SendClientMessage(playerid,GREY,"USAGE: /kill [playerid]");
    	if(!IsPlayerConnectedEx(ID)||ID==playerid)return SendClientMessage(playerid,GREY,"Invalid player ID");
    	if(AdminLevel[playerid]<AdminLevel[ID])return SendClientMessage(playerid,GREY,"You can't perform this command on your seniors");
    	format(str,sizeof(str),"You have killed %s",PlayerName(ID));
		SendClientMessage(playerid,LRED,str);
		format(str,sizeof(str),"You have been killed by an Administrator");
		SendClientMessage(ID,LRED,str);
		SetPlayerHealth(ID,0);
    }else return 0;
    return 1;
}
//==============================================================================
CMD:explode(playerid,params[])
{
    new str[128],ID;
	if(IsMuted(playerid))return 1;
    if(AdminLevel[playerid] >=1)
    {
    	if(sscanf(params,"u",ID)) return SendClientMessage(playerid,GREY,"USAGE: /explode [playerid]");
    	if(!IsPlayerConnectedEx(ID)||ID==playerid)return SendClientMessage(playerid,GREY,"Invalid player ID");
    	if(AdminLevel[playerid]<AdminLevel[ID])return SendClientMessage(playerid,GREY,"You can't perform this command on your seniors");
    	format(str,sizeof(str),"You have exploded %s",PlayerName(ID));
		SendClientMessage(playerid,LRED,str);
		format(str,sizeof(str),"You have been exploded by an Administrator");
		SendClientMessage(ID,LRED,str);
		new Float:tX,Float:tY,Float:tZ;
		GetPlayerPos(ID,tX,tY,tZ);
		CreateExplosion(tX,tY,tZ,1,20.0);
		tX=0.0;
		tY=0.0;
		tZ=0.0;
 	}else return 0;
 	return 1;
}
//==============================================================================
CMD:freeze(playerid,params[])
{
    new str[128],ID;
	if(IsMuted(playerid))return 1;
    if(AdminLevel[playerid] >=1)
    {
    	if(sscanf(params,"u",ID)) return SendClientMessage(playerid,GREY,"USAGE: /freeze [playerid]");
    	if(!IsPlayerConnectedEx(ID)||ID==playerid)return SendClientMessage(playerid,GREY,"Invalid player ID");
    	if(AdminLevel[playerid]<AdminLevel[ID])return SendClientMessage(playerid,GREY,"You can't perform this command on your seniors");
    	format(str,sizeof(str),"You have frozen %s",PlayerName(ID));
		SendClientMessage(playerid,LRED,str);
		format(str,sizeof(str),"You have been frozen by an Administrator");
		SendClientMessage(ID,LRED,str);
		TogglePlayerControllable(ID,false);
    }else return 0;
    return 1;
}
//==============================================================================
CMD:unfreeze(playerid,params[])
{
    new str[128],ID;
	if(IsMuted(playerid))return 1;
    if(AdminLevel[playerid] >=1)
    {
    	if(sscanf(params,"u",ID)) return SendClientMessage(playerid,GREY,"USAGE: /unfreeze [playerid]");
    	if(!IsPlayerConnectedEx(ID)||ID==playerid)return SendClientMessage(playerid,GREY,"Invalid player ID");
    	if(AdminLevel[playerid]<AdminLevel[ID])return SendClientMessage(playerid,GREY,"You can't perform this command on your seniors");
    	format(str,sizeof(str),"You have unfrozen %s",PlayerName(ID));
		SendClientMessage(playerid,YELLOW,str);
		format(str,sizeof(str),"You have been unfrozen by an Administrator");
		SendClientMessage(ID,YELLOW,str);
		TogglePlayerControllable(ID,true);
    }else return 0;
    return 1;
}
//==============================================================================
CMD:goto(playerid,params[])
{
    new str[128],ID;
	if(IsMuted(playerid))return 1;
    if(AdminLevel[playerid] >=2)
    {
    	if(sscanf(params,"u",ID)) return SendClientMessage(playerid,GREY,"USAGE: /goto [playerid]");
    	if(!IsPlayerConnectedEx(ID)||ID==playerid)return SendClientMessage(playerid,GREY,"Invalid player ID");
    	if(AdminLevel[playerid]<AdminLevel[ID])return SendClientMessage(playerid,GREY,"You can't perform this command on your seniors");
    	format(str,sizeof(str),"You have teleported to %s",PlayerName(ID));
		SendClientMessage(playerid,YELLOW,str);
		format(str,sizeof(str),"An Administrator has teleported to your position");
		SendClientMessage(ID,YELLOW,str);
		new Float:tX,Float:tY,Float:tZ;
		GetPlayerPos(ID,tX,tY,tZ);
		SetPlayerInterior(playerid,GetPlayerInterior(ID));
		if(GetPlayerState(playerid)==PLAYER_STATE_DRIVER)
		{
			new VehicleID=GetPlayerVehicleID(playerid);
			SetVehiclePos(VehicleID,tX+2,tY,tZ);
		}
		else
		{
			SetPlayerPos(playerid,tX+2,tY,tZ);
		}
    }else return 0;
    return 1;
}
//==============================================================================
CMD:get(playerid,params[])
{
    new str[128],ID;
	if(IsMuted(playerid))return 1;
    if(AdminLevel[playerid] >=2)
    {
    	if(sscanf(params,"u",ID)) return SendClientMessage(playerid,GREY,"USAGE: /get [playerid]");
    	if(!IsPlayerConnectedEx(ID)||ID==playerid)return SendClientMessage(playerid,GREY,"Invalid player ID");
    	if(AdminLevel[playerid]<AdminLevel[ID])return SendClientMessage(playerid,GREY,"You can't perform this command on your seniors");
    	format(str,sizeof(str),"You have teleported %s to yourself",PlayerName(ID));
		SendClientMessage(playerid,YELLOW,str);
		format(str,sizeof(str),"An Administrator has teleported you to his position");
		SendClientMessage(ID,YELLOW,str);
		new Float:tX,Float:tY,Float:tZ;
		GetPlayerPos(playerid,tX,tY,tZ);
		SetPlayerInterior(ID,GetPlayerInterior(playerid));
		if(GetPlayerState(ID)==PLAYER_STATE_DRIVER)
		{
			new VehicleID=GetPlayerVehicleID(ID);
			SetVehiclePos(VehicleID,tX+2,tY,tZ);
		}
		else
		{
			SetPlayerPos(ID,tX+2,tY,tZ);
		}
    }else return 0;
    return 1;
}
//==============================================================================
CMD:spec(playerid,params[])
{
    new string[128],id;
	if(IsMuted(playerid))return 1;
    if(AdminLevel[playerid]<2)return 0;
    if(sscanf(params,"u",id))return SendClientMessage(playerid,GREY,"USAGE: /spec [playerid]");
    if(id==playerid)return SendClientMessage(playerid,GREY,"You cannot spec yourself");
    if(!IsPlayerConnectedEx(id))return SendClientMessage(playerid,GREY,"Invalid player ID");
    if(IsSpecing[playerid]==1)return SendClientMessage(playerid,GREY,"You are already specing someone");
    if(IsSpecing[id]==1)return SendClientMessage(playerid,GREY,"That player is spectating another player");
    GetPlayerPos(playerid,pX[playerid],pY[playerid],pZ[playerid]);
    Inter[playerid]=GetPlayerInterior(playerid);
    TogglePlayerSpectating(playerid,true);
    if(IsPlayerInAnyVehicle(id))
    {
        if(GetPlayerInterior(id) > 0)
        {
            SetPlayerInterior(playerid,GetPlayerInterior(id));
        }
        PlayerSpectateVehicle(playerid,GetPlayerVehicleID(id));
    }
    else
    {
        if(GetPlayerInterior(id) > 0)
        {
            SetPlayerInterior(playerid,GetPlayerInterior(id));
        }
        PlayerSpectatePlayer(playerid,id);
    }
    format(string,sizeof(string),"You have started to spectate %s",PlayerName(playerid));
    SendClientMessage(playerid,YELLOW,string);
    SendClientMessage(playerid,YELLOW,"Use /specoff to toggle spectating off");
    IsSpecing[playerid]=1;
    IsBeingSpeced[id]=1;
    spectatorid[playerid]=id;
    return 1;
}
//==============================================================================
CMD:specoff(playerid,params[])
{
	if(IsMuted(playerid))return 1;
    if(AdminLevel[playerid] >=2)
    {
    	if(IsSpecing[playerid]==0)return SendClientMessage(playerid,GREY,"You are not spectating anyone");
    	IsBeingSpeced[spectatorid[playerid]]=0;
    	IsSpecing[playerid]=0;
    	spectatorid[playerid]=0;
    	SetPlayerInterior(playerid,Inter[playerid]);
    	TogglePlayerSpectating(playerid,0);
    	SetPlayerPos(playerid,pX[playerid],pY[playerid],pZ[playerid]);
    }else return 0;
    return 1;
}
//==============================================================================
CMD:getip(playerid,params[])
{
    new string[128],ID,tmp3[50];
	if(IsMuted(playerid))return 1;
    if(AdminLevel[playerid] >=3)
    {
    	if(sscanf(params,"u",ID)) return SendClientMessage(playerid,GREY,"USAGE: /getip [playerid]");
    	if(!IsPlayerConnectedEx(ID)||ID==playerid)return SendClientMessage(playerid,GREY,"Invalid player ID");
    	if(AdminLevel[playerid]<AdminLevel[ID])return SendClientMessage(playerid,GREY,"You can't perform this command on your seniors");
    	GetPlayerIp(ID,tmp3,50);
    	format(string,sizeof(string),"PlayerName: {FFFFFF}'%s' | IP: {FFFFFF}'%s'",PlayerName(ID),tmp3);
		SendClientMessage(playerid,YELLOW,string);
    }else return 0;
    return 1;
}
//==============================================================================
CMD:sethealth(playerid,params[])
{
    new str[128],ID,value;
	if(IsMuted(playerid))return 1;
    if(AdminLevel[playerid] >=2)
    {
    	if(sscanf(params,"ui",ID,value)) return SendClientMessage(playerid,GREY,"USAGE: /sethealth [playerid] [0-100]");
    	if(!IsPlayerConnectedEx(ID)||ID==playerid)return SendClientMessage(playerid,GREY,"Invalid player ID");
    	if(AdminLevel[playerid]<AdminLevel[ID])return SendClientMessage(playerid,GREY,"You can't perform this command on your seniors");
		if(value<0||value>100)return SendClientMessage(playerid,GREY,"USAGE: /sethealth [playerid] [0-100]");
		format(str,sizeof(str),"You have set %s's health to %i",PlayerName(ID),value);
		SendClientMessage(playerid,YELLOW,str);
		format(str,sizeof(str),"Your health was set to %i by an Administrator",value);
		SendClientMessage(ID,YELLOW,str);
		SetPlayerHealth(ID,value);
    }else return 0;
    return 1;
}
//==============================================================================
CMD:setarmor(playerid,params[])
{
    new str[128],ID,value;
	if(IsMuted(playerid))return 1;
    if(AdminLevel[playerid] >=2)
    {
    	if(sscanf(params,"ui",ID,value)) return SendClientMessage(playerid,GREY,"USAGE: /setarmor [playerid] [0-100]");
    	if(!IsPlayerConnectedEx(ID)||ID==playerid)return SendClientMessage(playerid,GREY,"Invalid player ID");
    	if(value<0||value>100)return SendClientMessage(playerid,GREY,"USAGE: /setarmor [playerid] [0-100]");
    	if(AdminLevel[playerid]<AdminLevel[ID])return SendClientMessage(playerid,GREY,"You can't perform this command on your seniors");
    	format(str,sizeof(str),"You have set %s's armor to %i",PlayerName(ID),value);
		SendClientMessage(playerid,YELLOW,str);
		format(str,sizeof(str),"Your armor was set to %i by an Administrator",value);
		SendClientMessage(ID,YELLOW,str);
		SetPlayerArmourEx(ID,value);
	}
    return 1;
}
//==============================================================================
CMD:setscore(playerid,params[])
{
    new str[128],ID,value;
	if(IsMuted(playerid))return 1;
    if(AdminLevel[playerid] >=3)
    {
    	if(sscanf(params,"ui",ID,value)) return SendClientMessage(playerid,GREY,"USAGE: /setscore [playerid] [value]");
    	if(!IsPlayerConnectedEx(ID)||ID==playerid)return SendClientMessage(playerid,GREY,"Invalid player ID");
    	if(value<0)return SendClientMessage(playerid,GREY,"USAGE: /setscore [playerid] [value]");
    	if(AdminLevel[playerid]<AdminLevel[ID])return SendClientMessage(playerid,GREY,"You can't perform this command on your seniors");
    	format(str,sizeof(str),"You have set %s's score to %i",PlayerName(ID),value);
		SendClientMessage(playerid,YELLOW,str);
		format(str,sizeof(str),"Your score was set to %i by an Administrator",value);
		SendClientMessage(ID,YELLOW,str);
		SetPlayerScore(ID,value);
    }else return 0;
    return 1;
}
//==============================================================================
CMD:setskin(playerid,params[])
{
    new str[128],ID,value;
	if(IsMuted(playerid))return 1;
    if(AdminLevel[playerid] >=3)
    {
    	if(sscanf(params,"ui",ID,value)) return SendClientMessage(playerid,GREY,"USAGE: /setskin [playerid] [Skin ID]");
    	if(!IsPlayerConnectedEx(ID)||ID==playerid)return SendClientMessage(playerid,GREY,"Invalid player ID");
    	if(AdminLevel[playerid]<AdminLevel[ID])return SendClientMessage(playerid,GREY,"You can't perform this command on your seniors");
    	if(!IsValidSkin(value)) return SendClientMessage(playerid,-1,"You have entered an invalid skin ID");
    	format(str,sizeof(str),"You have set %s's skin to %i",PlayerName(ID),value);
		SendClientMessage(playerid,YELLOW,str);
		format(str,sizeof(str),"Your skin was set to %i by an Administrator",value);
		Skin[playerid]=value;
		SendClientMessage(ID,YELLOW,str);
		SetPlayerSkin(ID,value);
    }else return 0;
    return 1;
}
//==============================================================================
CMD:setcash(playerid,params[])
{
    new str[128],ID,value;
	if(IsMuted(playerid))return 1;
    if(AdminLevel[playerid] >=3)
    {
    	if(sscanf(params,"ui",ID,value)) return SendClientMessage(playerid,GREY,"USAGE: /setmoney [playerid] [Value]");
    	if(!IsPlayerConnectedEx(ID)||ID==playerid)return SendClientMessage(playerid,GREY,"Invalid player ID");
    	if(value<0)return SendClientMessage(playerid,GREY,"Invalid amount");
    	if(AdminLevel[playerid]<AdminLevel[ID])return SendClientMessage(playerid,GREY,"You can't perform this command on your seniors");
    	format(str,sizeof(str),"You have set %s's cash to %i",PlayerName(ID),value);
		SendClientMessage(playerid,YELLOW,str);
		format(str,sizeof(str),"Your cash was set to %i by an Administrator",value);
		SendClientMessage(ID,YELLOW,str);
		SetPlayerMoneyEx(ID,value);
    }else return 0;
    return 1;
}
//==============================================================================
CMD:kick(playerid,params[])
{
	if(IsMuted(playerid))return 1;
	new string[128],ID,reason[100];
	if(AdminLevel[playerid] >=1)
	{
	    if(!sscanf(params,"us[100]",ID,reason))
    	{
    		if(!IsPlayerConnectedEx(ID)||ID==playerid)return SendClientMessage(playerid,GREY,"Invalid player ID");
    		if(strlen(reason) >100) return SendClientMessage(playerid,GREY,"Reason can't be longer than 100 characters");
    		if(AdminLevel[playerid]<AdminLevel[ID])return SendClientMessage(playerid,GREY,"You can't perform this command on your seniors");
    		format(string,sizeof(string),"~%s has been kicked from the server for '%s'",PlayerName(ID),reason);
			SendClientMessageToAll(RED,string);
			TogglePlayerControllable(ID,false);
			SetCameraBehindPlayer(ID);
			Kicked[ID]=1;
    	}
    	else if(!sscanf(params,"u",ID))
   		{
    		if(!IsPlayerConnectedEx(ID)||ID==playerid)return SendClientMessage(playerid,GREY,"Invalid player ID");
    		if(AdminLevel[playerid]<AdminLevel[ID])return SendClientMessage(playerid,GREY,"You can't perform this command on your seniors");
    		format(string,sizeof(string),"~%s has been kicked from the server",PlayerName(ID));
			SendClientMessageToAll(RED,string);
			TogglePlayerControllable(ID,false);
			SetCameraBehindPlayer(ID);
			Kicked[ID]=1;
    	}else return SendClientMessage(playerid,GREY,"USAGE: /kick [playerid] [reason]");
    }else return 0;
    return 1;
}
//==============================================================================
CMD:ban(playerid,params[])
{
	if(IsMuted(playerid))return 1;
    new string[128],ID,reason[128];
	if(AdminLevel[playerid] >=2)
    {
    	if(!sscanf(params,"us[128]",ID,reason))
    	{
    		if(!IsPlayerConnectedEx(ID)||ID==playerid)return SendClientMessage(playerid,GREY,"Invalid player ID");
    		if(strlen(reason) >128) return SendClientMessage(playerid,GREY,"Reason can't be longer than 100 characters");
    		if(AdminLevel[playerid]<AdminLevel[ID])return SendClientMessage(playerid,GREY,"You can't perform this command on your seniors");
    		format(string,sizeof(string),"~%s has been banned from the server for '%s'",PlayerName(ID),reason);
			SetCameraBehindPlayer(ID);
			INI_IntSet(Acc(ID),"Banned",1);
			INI_Set(Acc(ID),"Reason",reason);
			TogglePlayerControllable(ID,false);
			SendClientMessageToAll(RED,string);
			INI_Set(Acc(ID),"Banner",PlayerName(playerid));
			Kicked[ID]=1;
 		}
    	else if(!sscanf(params,"u",ID))
    	{
    		if(!IsPlayerConnectedEx(ID)||ID==playerid)return SendClientMessage(playerid,GREY,"Invalid player ID");
    		if(AdminLevel[playerid]<AdminLevel[ID])return SendClientMessage(playerid,GREY,"You can't perform this command on your seniors");
    		format(string,sizeof(string),"~%s has been banned from the server",PlayerName(ID));
			SetCameraBehindPlayer(ID);
			INI_IntSet(Acc(ID),"Banned",1);
			INI_Set(Acc(ID),"Reason","N/A");
			TogglePlayerControllable(ID,false);
			SendClientMessageToAll(RED,string);
			INI_Set(Acc(ID),"Banner",PlayerName(playerid));
			Kicked[ID]=1;
    	}
		else if(!sscanf(params,"s[50]",reason))
		{
			new PlayerFile[50];
			if(AdminLevel[playerid]<3)return 0;
			format(PlayerFile,sizeof(PlayerFile),"Accounts/%s.ini",reason);
			if(!fexist(PlayerFile)) return SendClientMessage(playerid,GREY,"No such player found in the database");
			if(fexist(PlayerFile))
			{
			    if(INI_Int(PlayerFile,"Banned")==1)return SendClientMessage(playerid,GREY,"That player is already banned");
    			INI_IntSet(PlayerFile,"Banned",1);
    			SendClientMessage(playerid,-1,"Account Banned");
				INI_Set(PlayerFile,"Banner",PlayerName(playerid));
			}
		}else return SendClientMessage(playerid,GREY,"USAGE: /ban [playerid] [reason]")&&
		SendClientMessage(playerid,-1,"USAGE: /ban [PlayerName] [For Offline Ban]");
    }else return 0;
    return 1;
}
//==============================================================================
CMD:givegun(playerid,params[])
{
	if(IsMuted(playerid))return 1;
	new playerb,gunid,ammo,string[128],wname[32];
   	if(AdminLevel[playerid] < 3) return 0;
	if(sscanf(params,"uii",playerb,gunid,ammo))
	{
		SendClientMessage(playerid,GREY,"USAGE: /givegun [playerid] [gunid] [ammo]");
		SendClientMessage(playerid,YELLOW,"Type /weaponids for a list of weapon ids");
		return 1;
	}
	GetWeaponName(gunid,wname,sizeof(wname));
	if(gunid==35||gunid==37||gunid==38)return SendClientMessage(playerid,GREY,"Invalid Weapon ID");
	if(!IsPlayerConnectedEx(playerb)) return SendClientMessage(playerid,GREY,"Invalid player ID");
	if(gunid < 0 || gunid > 46 || gunid==19 || gunid==20 || gunid==21 ||gunid==22 || gunid==35|| gunid==36) return SendClientMessage(playerid,-1,"You have entered an invalid weapon id");
	GivePlayerWeaponEx(playerb,gunid,ammo);
	format(string,sizeof(string),"You have given %s a %s with %d ammo",PlayerName(playerb),wname,ammo);
	SendClientMessage(playerid,YELLOW,string);
	format(string,sizeof(string),"An Administrator has given you a %s with %d ammo",wname,ammo);
	SendClientMessage(playerb,YELLOW,string);
	return 1;
}
//==============================================================================
CMD:weaponids(playerid,params[])
{
	if(IsJailedOrMuted(playerid))return 1;
	SendClientMessage(playerid,YELLOW,"_________________________________________Weapon IDs_____________________________________________________________");
	SendClientMessage(playerid,-1,"1: Brass Knuckles 2: Golf Club 3: Nite Stick 4: Knife 5: Baseball Bat 6: Shovel 7: Pool Cue 8: Katana 9: Chainsaw");
	SendClientMessage(playerid,-1,"10: Purple Dildo 11: Small White Vibrator 12: Large White Vibrator 13: Silver Vibrator 14: Flowers 15: Cane");
	SendClientMessage(playerid,-1,"16: Frag Grenade 17: Tear Gas 18: Molotov Cocktail 19: Vehicle Missile 20: Hydra Flare 21: Jetpack 22: 9mm 23: Silenced 9mm");
	SendClientMessage(playerid,-1,"24: Desert Eagle 25: Shotgun 26: Sawnoff Shotgun 27: SPAS-12 28: Micro SMG(Mac 10) 29: SMG(MP5) 30: AK-47 31: M4 32: Tec9");
	SendClientMessage(playerid,-1,"33: Rifle 25: Shotgun 34: Sniper Rifle 35: Rocket Launcher 37: Flamethrower 38: Minigun 39: Satchel Charge");
	SendClientMessage(playerid,YELLOW,"_________________________________________________________________________________________________________________");
	return 1;
}
//==============================================================================
CMD:animlist(playerid,params[])
{
	if(IsJailedOrMuted(playerid))return 1;
	SendClientMessage(playerid,YELLOW,"Bikini Bottom Roleplay Animations");
	SendClientMessage(playerid,-1,"/handsup /bomb /getarrested /laugh /lookout /robman /arrest /cellin /cellout /slapass");
 	SendClientMessage(playerid,-1,"/crossarms /vomit /eat /wave /taichi /relax /carjack /laydown /laugh /hi /chairsit");
  	SendClientMessage(playerid,-1,"/deal /crack /smokem /smokef /groundsit /chat /dance /f**ku /cuffed /uncuffme /drunk");
   	SendClientMessage(playerid,-1,"/injured /kickass /funwalk /glitched /rofl /slap /fallback /chant /adie /kiss /wank");
    SendClientMessage(playerid,-1,"Press 'Y' to stop animations");
	return 1;
}
//==============================================================================
CMD:dance(playerid,params[])
{
	if(IsJailedOrMuted(playerid))return 1;
	new dancestyle;
	if(sscanf(params,"i",dancestyle)) return SendClientMessage(playerid,GREY,"USAGE: /dance [1-4]");
	if(dancestyle<1||dancestyle>4)return SendClientMessage(playerid,GREY,"USAGE: /dance [1-4]");
	ClearAnimations(playerid);
	if(dancestyle==1){SetPlayerSpecialAction(playerid,SPECIAL_ACTION_DANCE1);}
	else if(dancestyle==2) {SetPlayerSpecialAction(playerid,SPECIAL_ACTION_DANCE2);}
 	else if(dancestyle==3) {SetPlayerSpecialAction(playerid,SPECIAL_ACTION_DANCE3);}
 	else if(dancestyle==4) {SetPlayerSpecialAction(playerid,SPECIAL_ACTION_DANCE4);}
	return 1;
}
//==============================================================================
CMD:cuffed(playerid,params[])
{
	ClearAnimations(playerid);
	if(IsJailedOrMuted(playerid))return 1;
	SetPlayerAttachedObject(playerid,5,19418,6,-0.031999,0.024000,-0.024000,-7.900000,-32.000011,-72.299987,1.115998,1.322000,1.406000);
 	SetPlayerSpecialAction(playerid,SPECIAL_ACTION_CUFFED);
  	return 1;
}
//==============================================================================
CMD:carloc(playerid,params[])
{
	if(IsJailedOrMuted(playerid))return 1;
	if(Car[playerid]>0)
   	{
  		new str[128];
    	new zone[MAX_ZONE_NAME],string[30];
		GetVehicle2DZone(Car[playerid],zone,MAX_ZONE_NAME);
		format(string,sizeof(string),"%s",zone);
		format(str,sizeof(str),"{FFFFFF}Location of your car: %s",string);
		ShowPlayerDialog(playerid,MISCEL,DIALOG_STYLE_MSGBOX,"Tracker",str,"Close","");
	}
 	else return SendClientMessage(playerid,GREY,"You donot own any car");
  	return 1;
}
//==============================================================================
CMD:resetcar(playerid,params[])
{
	if(IsMuted(playerid))return 1;
	new id,Float:x,Float:y,Float:z,str[128];
	if(AdminLevel[playerid]<3)return 0;
    if(sscanf(params,"u",id)) return SendClientMessage(playerid,GREY,"USAGE: /resetcar [playerid]");
    if(Car[id]==0)return SendClientMessage(playerid,GREY,"That player doesn't own any car");
	GetPlayerPos(id,x,y,z);
	SetVehiclePos(Car[id],x,y+2,z);
	LinkVehicleToInterior(Car[id],GetPlayerInterior(playerid));
	SetVehicleVirtualWorld(Car[id],0);
	if(id!=playerid)
	{
		format(str,sizeof(str),"You have resetted the vehicle position of %s's personal vehicle",PlayerName(id));
		SendClientMessage(playerid,YELLOW,str);
		SendClientMessage(id,YELLOW,"An Administrator has resetted your personal vehicle's position");
	}
	if(id==playerid)
	{
		SendClientMessage(id,YELLOW,"You have resetted your personal vehicle's position");
	}
	return 1;
}
//==============================================================================
CMD:crash(playerid,params[])
{
	if(IsMuted(playerid))return 1;
	new player1,str[128],Float:X,Float:Y,Float:Z;
	if(AdminLevel[playerid]>=3)
	{
		if(sscanf(params,"u",player1)) return SendClientMessage(playerid,GREY,"USAGE: /crash [playerid]");
		if(IsPlayerConnectedEx(player1)&&player1!=playerid)
 		{
 			GetPlayerPos(player1,X,Y,Z);
			format(str,sizeof(str),"You have crashed %s",PlayerName(player1));
  			SendClientMessage(playerid,YELLOW,str);
  			GameTextForPlayer(player1," ~rlol",800,1);
    		new CrashObj=CreatePlayerObject(player1,11111111,X,Y,Z,0,0,0);
			DestroyObject(CrashObj);
		}else return SendClientMessage(playerid,GREY,"Invalid player ID");
	}else return 0;
	return 1;
}
//==============================================================================
CMD:changecar(playerid,params[])
{
	if(IsMuted(playerid))return 1;
	new name[32],Float:nx,Float:ny,Float:nz,Float:nrot,id;
	if(GetPlayerState(playerid)==PLAYER_STATE_DRIVER)
	{
	    if(VIP[playerid]>0||AdminLevel[playerid]>2) {
	    if(sscanf(params,"i",id)) return SendClientMessage(playerid,GREY,"USAGE: /changecar [model]");
	    if(id < 400 || id > 611) return  SendClientMessage(playerid,GREY,"Invalid Vehicle Model ID");
		if(IsRC(id)||IsCopCar(id))return SendClientMessage(playerid,GREY,"Invalid Vehicle Model ID");
	    if(GetPlayerVehicleID(playerid)!=Car[playerid])return SendClientMessage(playerid,GREY,"This car is not owned by you");
		if(Car[playerid]==0)return SendClientMessage(playerid,GREY,"You don't own a car");
		GetVehicleName(id,name,32);
		GetVehiclePos(Car[playerid],nx,ny,nz);
        GetVehicleZAngle(Car[playerid],nrot);
        DestroyVehicle(Car[playerid]);
        Car[playerid]=AddStaticVehicleEx(id,nx,ny,nz,nrot,-1,-1,-1);
        PutPlayerInVehicle(playerid,Car[playerid],0);}
	}else return SendClientMessage(playerid,GREY,"You need to be inside your car");
	return 1;
}
//==============================================================================
CMD:autolock(playerid,params[])
{
	if(IsJailedOrMuted(playerid))return 1;
	if(Car[playerid]==0)return SendClientMessage(playerid,GREY,"You don't own a car");
	if(Lock[playerid]==0)return SendClientMessage(playerid,GREY,"You don't have a car lock system");
	new engine,lights,alarm,doors,bonnet,boot,objective;
	GetVehicleParamsEx(Car[playerid],engine,lights,alarm,doors,bonnet,boot,objective);
	if(doors==1)
	{
		SetVehicleParamsEx(Car[playerid],engine,lights,alarm,0,bonnet,boot,objective);
		SendClientMessage(playerid,YELLOW,"You have unlocked your personal vehicle's doors");
	}
	else
	{
		SetVehicleParamsEx(Car[playerid],engine,lights,alarm,1,bonnet,boot,objective);
		SendClientMessage(playerid,YELLOW,"You have locked your personal vehicle's doors");
	}
    return 1;
}
//==============================================================================
CMD:registerbank(playerid,params[])
{
	new password[32],tmp=Password[playerid];
	if(IsJailedOrMuted(playerid))return 1;
	if(!IsPlayerInRangeOfPoint(playerid,5,1569.7124,-2263.4231,266.2109))return SendClientMessage(playerid,GREY,"You need to be inside a bank");
	if(sscanf(params,"s[25]",password)) return SendClientMessage(playerid,GREY,"USAGE: /registerbank [Your server account password]");
	if(strlen(password)>31)return SendClientMessage(playerid,GREY,"USAGE: /registerbank [Your server account password]");
	if(udb_hash(password)==tmp )
	{
		if(BankID[playerid]>0)return SendClientMessage(playerid,GREY,"You already have a bank account");
		new rand=10000 + random(9999),string[128];
		BankID[playerid]=rand;
		format(string,sizeof(string),"You've registered your own bank account,your bank account ID is {FFFF00}%d",rand);
		SendClientMessage(playerid,YELLOW,string);
		SendClientMessage(playerid,-1,"Your credit card has been automatically linked with your bank account");
	}else return SendClientMessage(playerid,GREY,"You have entered a invalid password");
	return 1;
}
//==============================================================================
CMD:resign(playerid,params[])
{
	new string[120];
	if(IsJailedOrMuted(playerid))return 1;
    if(PlayerOrg[playerid]==0) return SendClientMessage(playerid,GREY,"You are not a member of an organization");
	if(PlayerLeader[playerid]==0)
	{
		if(gettime() < OrgTime[playerid])return SendClientMessage(playerid,GREY,"You have to be atleast 7 days in your organization");
	}
	format(string,sizeof(string),"You have resigned from %s",Organization[PlayerOrg[playerid]][Name]);
	SendClientMessage(playerid,-1,string);
	if(PlayerLeader[playerid]==1)
	{
	    for(new i=0;i<MAX_PLAYERS;i++)
		{
        	if(IsPlayerConnectedEx(i))
			{
            	if(PlayerOrg[i]==PlayerOrg[playerid] && i !=playerid)
				{
                	ResetPlayerOrg(i);
                	SendClientMessage(i,-1,"Your leader has left leading your org,thus you have been automatically kicked");
            	}
        	}
    	}
	}
	ResetPlayerOrg(playerid);
	return 1;
}
//==============================================================================
CMD:wipeorg(playerid,params[])
{
	if(IsMuted(playerid))return 1;
	if(AdminLevel[playerid]<3)return 0;
    new string[128],ID;
	if(sscanf(params,"i",ID)) return SendClientMessage(playerid,GREY,"USAGE: /wipeorg [orgid]");
	if(ID<1||ID>OrgsCount)return SendClientMessage(playerid,GREY,"Invalid Organization ID");
	Organization[ID][Members]=0;
	format(Organization[ID][Leader],25,"None");
	format(Organization[ID][Member1],25,"None");
	format(Organization[ID][Member2],25,"None");
	format(Organization[ID][Member3],25,"None");
	format(Organization[ID][Member4],25,"None");
	format(Organization[ID][Member5],25,"None");
	format(Organization[ID][Member6],25,"None");
	format(Organization[ID][Member7],25,"None");
	for(new i=0;i<MAX_PLAYERS;i++)
	{
		if(PlayerOrg[i]==ID)
		{
			ResetPlayerOrg(i);
			SendClientMessage(i,YELLOW,"An Administrator has wiped the memberlist of your organization");
			SendClientMessage(i,-1,"Your state has been set to civillian");
    	}
	}
	format(string,128,"Members of Organization %s have been wiped",GetOrgName(ID));
	SendClientMessage(playerid,-1,string);
	return 1;
}
//==============================================================================
CMD:oc(playerid,params[])
{
    new string[128];
    new org=PlayerOrg[playerid];
	if(IsJailedOrMuted(playerid))return 1;
    if(PlayerOrg[playerid]==0) return SendClientMessage(playerid,GREY,"You are not a member of an organization");
    if(sscanf(params,"s[128]",params)) return SendClientMessage(playerid,GREY,"USAGE: /ochat [message]");
	if(strlen(params) > 128) return SendClientMessage(playerid,GREY,"Text can't be longer than 128 characters");
    format(string,sizeof(string),"Org Chat - %s: %s",PlayerName(playerid),params);
    SendClientMessageToOrg(GetOrgName(org),LBLUE,string);
    return 1;
}
//==============================================================================
CMD:setmember(playerid,params[])
{
    new ID,string[120],part[5];
	if(IsJailedOrMuted(playerid))return 1;
    if(PlayerLeader[playerid]==0) return SendClientMessage(playerid,GREY,"You aren't an org leader");
    if(sscanf(params,"u",ID)) return SendClientMessage(playerid,GREY,"USAGE: /setmember [playerid]");
    if(!IsPlayerConnectedEx(ID) || ID==playerid) return SendClientMessage(playerid,GREY,"Invalid player ID");
    new org=PlayerOrg[playerid];
    if(Job[ID]>0)return SendClientMessage(playerid,GREY,"That player has a job");
    if(PlayerOrg[ID]) return SendClientMessage(playerid,GREY,"That player already belongs to an organization");
    if(Requesting[ID] !=org) return SendClientMessage(playerid,GREY,"That player is not requesting to join your organization");
	format(part,sizeof(part),"None");
	if(strcmp(Organization[org][Member1],part,false)==0){format(Organization[org][Member1],25,PlayerName(ID));}
	else if(strcmp(Organization[org][Member2],part,false)==0){format(Organization[org][Member2],25,PlayerName(ID));}
	else if(strcmp(Organization[org][Member3],part,false)==0){format(Organization[org][Member3],25,PlayerName(ID));}
	else if(strcmp(Organization[org][Member4],part,false)==0){format(Organization[org][Member4],25,PlayerName(ID));}
	else if(strcmp(Organization[org][Member5],part,false)==0){format(Organization[org][Member5],25,PlayerName(ID));}
	else if(strcmp(Organization[org][Member6],part,false)==0){format(Organization[org][Member6],25,PlayerName(ID));}
	else if(strcmp(Organization[org][Member7],part,false)==0){format(Organization[org][Member7],25,PlayerName(ID));}
	else return SendClientMessage(playerid,GREY,"You cannot set more members for your org");
    OrgTime[ID]=gettime() + 60*60*24*7;
	if(Organization[org][Type]==LAW && GL[ID]==0)
	{
	    GL[ID]=1;
	    SendClientMessage(ID,ORANGE,"You have gained your Weapon License");
	}
	if(Organization[org][Type]==GANG||Organization[org][Type]==MAFIA)
	{
		if(PlayerAwards[ID][Gangster]==0)
		{
   			GivePlayerMoneyEx(ID,550);
		    PlayerAwards[ID][Gangster]=1;
			GamerScore[playerid]=GamerScore[playerid]+50;
  			SendClientMessage(ID,YELLOW,"Achievement Unlocked: {FFFFFF}The Dark Side!");
  			SendClientMessage(ID,LGREEN,"BONUS: $550 || +50 Gamer Score");
		}
	}
	if(Organization[org][Type]==LAW)
	{
		if(PlayerAwards[ID][Cop]==0)
		{
		    PlayerAwards[ID][Cop]=1;
   			GivePlayerMoneyEx(ID,550);
			GamerScore[playerid]=GamerScore[playerid]+50;
  			SendClientMessage(ID,YELLOW,"Achievement Unlocked: {FFFFFF}I Like Donuts!");
  			SendClientMessage(ID,LGREEN,"BONUS: $550 || +50 Gamer Score");
		}
	}
	format(string,sizeof(string),"The Leader of the organization '%s' has set you as a member",GetOrgName(org));
    SendClientMessage(ID,YELLOW,string);
    format(string,sizeof(string),"You have set %s a member of %s",PlayerName(ID),GetOrgName(org));
    SendClientMessage(playerid,YELLOW,string);
    PlayerOrg[ID]=org;
    Requesting[ID]=0;
    Rank[ID]=1;
	SetPlayerColor(ID,Organization[PlayerOrg[ID]][Color]);
    Organization[org][Members]=Organization[org][Members]+1;
    return 1;
}
//==============================================================================
CMD:setleader(playerid,params[])
{
	if(IsMuted(playerid))return 1;
    if(AdminLevel[playerid]<3)return 0;
    new ID,orgid,string[140];
    if(sscanf(params,"ui",ID,orgid)) return SendClientMessage(playerid,GREY,"USAGE: /setleader [playerid] [orgid]");
    if (!IsPlayerConnectedEx(ID)) return SendClientMessage(playerid,GREY,"Invalid player ID");
    if (PlayerOrg[ID]) return SendClientMessage(playerid,GREY,"That player already belongs to an organization");
    if (orgid < 1 || orgid > OrgsCount) return SendClientMessage(playerid,GREY,"You entered an invalid organization ID");
	if(strcmp(Organization[orgid][Leader],"None",false)==0){Organization[orgid][Members]=1;}
	for (new i=0;i<MAX_PLAYERS;i++)
	{
    	if(PlayerLeader[i]==1&&PlayerOrg[i]==orgid)
		{
    		Rank[i]=0;
    		Suited[i]=0;
    		PlayerOrg[i]=0;
    		Requesting[i]=0;
    		PlayerLeader[i]=0;
    		SetPlayerColor(i,-1);
    		SetPlayerSkin(i,Skin[i]);
			SetPlayerAmmo(i,Organization[orgid][OWeapons][0],0);
			SetPlayerAmmo(i,Organization[orgid][OWeapons][1],0);
			SendClientMessage(i,ORANGE,"An Administrator has removed you from leadership");
    	}
	}
	if(ID!=playerid)
 	{
    	format(string,sizeof(string),"An Administrator has set you as the leader of %s",GetOrgName(orgid));
    	SendClientMessage(ID,YELLOW,string);
    	format(string,sizeof(string),"You have set %s the leader of %s",PlayerName(ID),GetOrgName(orgid));
    	SendClientMessage(playerid,YELLOW,string);
	}
	if(ID==playerid)
 	{
    	format(string,sizeof(string),"You have set yourself the leader of %s",GetOrgName(orgid));
    	SendClientMessage(playerid,YELLOW,string);
	}
    PlayerLeader[ID]=1;
	PlayerOrg[ID]=orgid;
    Organization[orgid][Leader]=PlayerName(ID);
	SetPlayerColor(ID,Organization[PlayerOrg[ID]][Color]);
    return 1;
}
//==============================================================================
CMD:setrank(playerid,params[])
{
    new ID,rank;
	if(IsJailedOrMuted(playerid))return 1;
    if (PlayerLeader[playerid]==0) return SendClientMessage(playerid,GREY,"You aren't an org leader");
    if (sscanf(params,"ud",ID,rank)) return SendClientMessage(playerid,GREY,"USAGE: /setrank [playerid] [rank]")&&
    SendClientMessage(playerid,GREY,"1=Trial,2=Member,3=Adv.Member,4=Co-Leader");
    if (rank > 4||rank < 1) return SendClientMessage(playerid,GREY,"Invalid Rank");
    if (!IsPlayerConnectedEx(ID)) return SendClientMessage(playerid,GREY,"Invalid player ID");
    if (ID==playerid) return SendClientMessage(playerid,GREY,"You are a fool");
    new org=PlayerOrg[playerid];
    if (PlayerOrg[ID] !=org) return SendClientMessage(playerid,GREY,"That player does not belong to your organization");
    new string[120],ra[24];
    if(rank==1) {ra="Trial";}
    if(rank==2) {ra="Member";}
    if(rank==3) {ra="Adv.Member";}
    if(rank==4) {ra="Co-Leader";}
    format(string,sizeof(string),"Leader %s has set your rank as '%s'",PlayerName(playerid),ra);
    SendClientMessage(ID,-1,string);
    format(string,sizeof(string),"You have given %s rank of %s",PlayerName(ID),ra);
    SendClientMessage(playerid,-1,string);
   	Rank[ID]=rank;
    return 1;
}
//==============================================================================
CMD:okickmember(playerid,params[])
{
	if(PlayerLeader[playerid]==1)
	{
		new name[24];
		if(IsJailedOrMuted(playerid))return 1;
	    if(!sscanf(params,"s[50]",name))
   		{
        	if(strcmp(name,PlayerName(playerid),true)==0)return SendClientMessage(playerid,GREY,"You dog!");
        	new org=PlayerOrg[playerid];
			if(strcmp(Organization[org][Member1],name,false)==0){format(Organization[org][Member1],25,"None");}
			else if(strcmp(Organization[org][Member2],name,false)==0){format(Organization[org][Member2],25,"None");}
			else if(strcmp(Organization[org][Member3],name,false)==0){format(Organization[org][Member3],25,"None");}
			else if(strcmp(Organization[org][Member4],name,false)==0){format(Organization[org][Member4],25,"None");}
			else if(strcmp(Organization[org][Member5],name,false)==0){format(Organization[org][Member5],25,"None");}
			else if(strcmp(Organization[org][Member6],name,false)==0){format(Organization[org][Member6],25,"None");}
			else if(strcmp(Organization[org][Member7],name,false)==0){format(Organization[org][Member7],25,"None");}
			else return SendClientMessage(playerid,-1,"That player doesn't belong to your org");
     	    SendClientMessage(playerid,-1,"Player Kicked");
			Organization[PlayerOrg[playerid]][Members]=Organization[PlayerOrg[playerid]][Members]-1;
  		}else return SendClientMessage(playerid,GREY,"USAGE: /okickmember [PLAYERNAME]");
    }else return SendClientMessage(playerid,GREY,"You aren't an org leader");
    return 1;
}
//==============================================================================
CMD:kickmember(playerid,params[])
{
	if(PlayerLeader[playerid]==1)
	{
		new ID;
		if(IsJailedOrMuted(playerid))return 1;
	    if (!sscanf(params,"u",ID))
    	{
    		new org=PlayerOrg[playerid];
    		if (!IsPlayerConnectedEx(ID) || ID==playerid) return SendClientMessage(playerid,GREY,"Invalid player ID");
    		if (PlayerOrg[ID] !=org) return SendClientMessage(playerid,GREY,"That player does not belong to your organization");
    		new string[130];
    		format(string,sizeof(string),"The leader of your organization has removed you as a member",PlayerName(playerid),GetOrgName(org));
    		SendClientMessage(ID,YELLOW,string);
    		ResetPlayerOrg(ID);
    		SendClientMessage(playerid,YELLOW,"Player Kicked");
    		SendClientMessage(ID,-1,"Your new state is Civilian");
  		}else return SendClientMessage(playerid,GREY,"USAGE: /kickmember [ID]");
    }else return SendClientMessage(playerid,GREY,"You aren't an org leader");
    return 1;
}
//==============================================================================
CMD:request(playerid,params[])
{
	if(IsJailedOrMuted(playerid))return 1;
    if(isnull(params))
	{
    	new string[1000];
    	new fstring[128];
    	for (new i=1;i<OrgsCount+1;i++)
		{
    	    format(fstring,sizeof(fstring),"\n%s (%d)",GetOrgName(i),i);
    	    strcat(string,fstring,sizeof(string));
    	}
    	ShowPlayerDialog(playerid,ORGREQUEST,DIALOG_STYLE_LIST,"Available Organizations",string,"Request","Close");
	}
	else
	{
		new ID=strval(params),string[120];
		if (PlayerOrg[playerid] > 0) return SendClientMessage(playerid,GREY,"You already belong to an organization");
		if (Requesting[playerid] > 0) return SendClientMessage(playerid,GREY,"You are already requesting to join an organization");
		if (ID < 1 || ID > OrgsCount) return SendClientMessage(playerid,GREY,"Invalid organization ID");
		if (!IsLeaderOnline(ID)) return SendClientMessage(playerid,GREY,"The leader of this organization is currently offline");
		format(string,sizeof(string),"%s is requesting to join the %s",PlayerName(playerid),GetOrgName(ID));
   		GameTextForPlayer(playerid,"~w~Request Sent",1000,4);
   		SendClientMessageToAll(-1,string);
		Requesting[playerid]=ID;
	}
	return 1;
}
//==============================================================================
CMD:decline(playerid,params[])
{
	if(IsJailedOrMuted(playerid))return 1;
    if (PlayerLeader[playerid]==0)return SendClientMessage(playerid,GREY,"You aren't an org leader");
    new ID;
    if (sscanf(params,"u",ID)) return SendClientMessage(playerid,GREY,"USAGE: /decline [playerid]");
    if (!IsPlayerConnectedEx(ID) || ID==playerid) return 1;
    new org=PlayerOrg[playerid];
    if (Requesting[ID] !=org) return SendClientMessage(playerid,GREY,"That player is not requesting to join your organization");
    new string[120];
    format(string,sizeof(string),"Your request to join %s has been declined by %s",GetOrgName(org),PlayerName(playerid));
    SendClientMessage(ID,YELLOW,string);
    format(string,sizeof(string),"You have declined %s's request",PlayerName(ID));
    SendClientMessage(playerid,YELLOW,string);
    Requesting[ID]=0;
    return 1;
}
//==============================================================================
CMD:ocmds(playerid,params[])
{
	if(IsJailedOrMuted(playerid))return 1;
	new str[128];
	if(PlayerOrg[playerid]==0)return SendClientMessage(playerid,GREY,"You aren't an org member");
	format(str,sizeof(str),"%s Commands",Organization[PlayerOrg[playerid]][Name]);
	SendClientMessage(playerid,ORANGE,str);
	SendClientMessage(playerid,-1,"/resign /oc /civil /odeposit /owithdraw /suitup");
    if(PlayerOrgType(playerid)==MAFIA)SendClientMessage(playerid,-1,"/(un)tie /(un)cuff /robbank /depositloot /loot /shipdrugs /takeover /removeturf /protectbus /removeprotection /protection");
    if(PlayerOrgType(playerid)==LAW)SendClientMessage(playerid,-1,"{FFFFFF}/(un)tie /(un)cuff /pu /loc /(un)jail /setwant /lc /ticket /pd /speed /tazer");
	if(PlayerOrgType(playerid)==GANG)SendClientMessage(playerid,-1,"/(un)tie /getdrugs /takeover /removeturf  /robhouse");
    if(PlayerOrg[playerid]==2)SendClientMessage(playerid,-1,"/heal /wanted");
    if(PlayerOrg[playerid]==4)SendClientMessage(playerid,-1,"/ad(vertisement)");
	if(PlayerLeader[playerid]==1)SendClientMessage(playerid,-1,"Leader commands: /setmember /(o)kickmember /setrank /members /decline");
    return 1;
}
//==============================================================================
CMD:pd(playerid,params[])
{
	if(IsJailedOrMuted(playerid))return 1;
	if(PlayerOrgType(playerid)==LAW)
	{
    	if(IsPlayerInRangeOfPoint(playerid,20.0,1588.5,-1638.3912,13))
		{
    	    if(GateOpen==0)
			{
  				MoveDynamicObject(pd,1589.26,-1638,14.3-5,1);
  				GateOpen=1;
  			}
  			else
			{
  				MoveDynamicObject(pd,1589.26,-1638,14.3,1);
  				GateOpen=0;
  			}
		}else return SendClientMessage(playerid,GREY,"You are not near to the PD gate");
	}else return SendClientMessage(playerid,GREY,"You are not a police officer");
    return 1;
}
//==============================================================================
CMD:uncuff(playerid,params[])
{
	if(IsJailedOrMuted(playerid))return 1;
    if(PlayerOrgType(playerid)==LAW ||PlayerOrgType(playerid)==MAFIA)
	{
        new otherid;
        if (sscanf(params,"u",otherid)) return SendClientMessage(playerid,GREY,"USAGE: /uncuff [playerid]");
        new Float:x,Float:y,Float:z;
        new message[128],str[128];
        GetPlayerPos(playerid,x,y,z);
        if(!IsPlayerConnectedEx(otherid) || otherid==playerid)return SendClientMessage(playerid,GREY,"Invalid player ID");
        if(Suited[playerid]==0)return SendClientMessage(playerid,GREY,"You can perform organization commands only while suited up");
        format(str,sizeof(str),"%s has uncuffed you",PlayerName(playerid));
        format(message,sizeof(message),"You have uncuffed %s",PlayerName(otherid));
        if(IsPlayerInRangeOfPoint(otherid,5.0,x,y,z))
		{
            SendClientMessage(playerid,YELLOW,message);
            SendClientMessage(otherid,YELLOW,str);
            TogglePlayerControllable(otherid,1);
        }else return SendClientMessage(playerid,GREY,"That Player should be near to you");
    }else return SendClientMessage(playerid,GREY,"You are not a police officer or a gangmember");
    return 1;
}
//==============================================================================
CMD:cuff(playerid,params[])
{
	if(IsJailedOrMuted(playerid))return 1;
    if(PlayerOrgType(playerid)==LAW ||PlayerOrgType(playerid)==MAFIA) {
        new otherid;
        if (sscanf(params,"u",otherid)) return SendClientMessage(playerid,GREY,"USAGE: /cuff [playerid]");
        new Float:x,Float:y,Float:z;
        new message[128],str[128];
        GetPlayerPos(playerid,x,y,z);
        if(!IsPlayerConnectedEx(otherid) || otherid==playerid)return SendClientMessage(playerid,GREY,"Invalid player ID");
        if(Suited[playerid]==0)return SendClientMessage(playerid,GREY,"You can perform organization commands only while suited up");
        format(str,sizeof(str),"%s has cuffed you",PlayerName(playerid));
        format(message,sizeof(message),"You have cuffed %s",PlayerName(otherid));
        if(IsPlayerInRangeOfPoint(otherid,5.0,x,y,z))
		{
            new playerState=GetPlayerState(otherid);
            if (playerState==PLAYER_STATE_PASSENGER)
			{
                SendClientMessage(playerid,YELLOW,message);
                SendClientMessage(otherid,YELLOW,str);
                TogglePlayerControllable(otherid,0);
            }else return SendClientMessage(playerid,GREY,"You cannot cuff the player while he is on foot");
        }else return SendClientMessage(playerid,GREY,"That player should be near to you");
    }else return SendClientMessage(playerid,GREY,"You are not a police officer or a gangmember");
    return 1;
}
//==============================================================================
CMD:civil(playerid,params[])
{
	if(IsJailedOrMuted(playerid))return 1;
	Suited[playerid]=0;
    SetPlayerSkin(playerid,Skin[playerid]);
	SetPlayerFightingStyle(playerid,Fstyle[playerid]);
	SetPlayerAmmo(playerid,Organization[PlayerOrg[playerid]][OWeapons][0],0);
	SetPlayerAmmo(playerid,Organization[PlayerOrg[playerid]][OWeapons][1],0);
  	SendClientMessage(playerid,-1,"You have changed to your Civilian Skin");
    return 1;
}
//==============================================================================
CMD:myskin(playerid,params[])
{
	if(IsJailedOrMuted(playerid))return 1;
    Suited[playerid]=0;
    SetPlayerSkin(playerid,Skin[playerid]);
	SetPlayerFightingStyle(playerid,Fstyle[playerid]);
 	SendClientMessage(playerid,-1,"You have changed to your own Skin");
    return 1;
}
//==============================================================================
CMD:suitup(playerid,params[])
{
	if(IsJailedOrMuted(playerid))return 1;
	if(Suited[playerid]>0)return SendClientMessage(playerid,GREY,"You are already suited up");
	if (PlayerOrg[playerid] !=0)
	{
		GiveOrgFeatures(playerid);
  	}else return SendClientMessage(playerid,GREY,"You aren't in any organization");
  	return 1;
}
//==============================================================================
CMD:odeposit(playerid,params[])
{
	if(IsJailedOrMuted(playerid))return 1;
    if(PlayerOrg[playerid] !=0) {
        new value;
        if (sscanf(params,"i",value)) return SendClientMessage(playerid,GREY,"USAGE: /odeposit [amount]");
        new str[128];
        if(value > GetPlayerMoneyEx(playerid)) return SendClientMessage(playerid,GREY,"You don't have enough money on you");
        if (IsPlayerInRangeOfPoint(playerid,3.0,Organization[PlayerOrg[playerid]][OrgX],Organization[PlayerOrg[playerid]][OrgY],Organization[PlayerOrg[playerid]][OrgZ])) {
            GivePlayerMoneyEx(playerid,-value);
            Organization[PlayerOrg[playerid]][Money]=(Organization[PlayerOrg[playerid]][Money])+value;
            format(str,sizeof(str),"You have deposited $%d to your org",value);
            SendClientMessage(playerid,YELLOW,str);
            format(str,sizeof(str),"Org's New Balance=$%d",Organization[PlayerOrg[playerid]][Money]);
            SendClientMessage(playerid,-1,str);
        }else SendClientMessage(playerid,GREY,"You need to be near your org HQ");
    }else return SendClientMessage(playerid,GREY,"You are not a member of an organization");
    return 1;
}
//==============================================================================
CMD:owithdraw(playerid,params[])
{
	if(IsJailedOrMuted(playerid))return 1;
    if(PlayerOrg[playerid] !=0) {
        new value;
        if(PlayerLeader[playerid]==0)return SendClientMessage(playerid,GREY,"You aren't an org leader");
        if (sscanf(params,"i",value)) return SendClientMessage(playerid,GREY,"USAGE: /owithdraw [amount]");
        new str[128];
        if(value > Organization[PlayerOrg[playerid]][Money]) return SendClientMessage(playerid,GREY,"Your org doesn't have enough money");
        if (IsPlayerInRangeOfPoint(playerid,3.0,Organization[PlayerOrg[playerid]][OrgX],Organization[PlayerOrg[playerid]][OrgY],Organization[PlayerOrg[playerid]][OrgZ])) {
            GivePlayerMoneyEx(playerid,value);
            Organization[PlayerOrg[playerid]][Money]=(Organization[PlayerOrg[playerid]][Money])-value;
            format(str,sizeof(str),"You have withdrawn $%d from your org",value);
            SendClientMessage(playerid,YELLOW,str);
            format(str,sizeof(str),"Org's New Balance=$%d",Organization[PlayerOrg[playerid]][Money]);
            SendClientMessage(playerid,-1,str);
        }else SendClientMessage(playerid,GREY,"You need to be near your org HQ");
    }else return SendClientMessage(playerid,GREY,"You are not a member of an organization");
    return 1;
}
//=============================================================================
CMD:stoprob(playerid,params[])
{
	if(IsJailedOrMuted(playerid))return 1;
    if(PlayerLeader[playerid]==1)
	{
        if(PlayerOrgType(playerid)==MAFIA)
		{
            if(IsRobbing[playerid]==1)
			{
                IsRobbing[playerid]=0;
                SendClientMessage(playerid,-1,"You've stopped robbing the bank,you better run now");
            }else return SendClientMessage(playerid,GREY,"You arent robbing the bank");
        }else return SendClientMessage(playerid,GREY,"You are not a gangmember");
    }else return SendClientMessage(playerid,GREY,"You are not a gang leader");
    return 1;
}
//==============================================================================
CMD:payorg(playerid,params[])
{
	if(IsJailedOrMuted(playerid))return 1;
    new value,oid,str[128];
    if (sscanf(params,"ii",oid,value)) return SendClientMessage(playerid,GREY,"USAGE: /payorg [Org ID] [amount]");
    if(value > GetPlayerMoneyEx(playerid)) return SendClientMessage(playerid,GREY,"You don't have enough money on you");
    if (oid < 1 || oid > 15) return SendClientMessage(playerid,GREY,"You have entered an invalid organization ID");
    if (GetPlayerScore(playerid)==0) return SendClientMessage(playerid,GREY,"Your level is too low");
    if(oid==PlayerOrg[playerid])return SendClientMessage(playerid,GREY,"Why not /odeposit instead?");
    GivePlayerMoneyEx(playerid,-value);
    Organization[oid][Money]=(Organization[oid][Money])+value;
    format(str,sizeof(str),"You have sent $%d to '%s'",value,GetOrgName(oid));
    SendClientMessage(playerid,-1,str);
    format(str,sizeof(str),"%s has paid your org $%d",PlayerName(playerid),value);
    SendClientMessageToOrg(GetOrgName(oid),YELLOW,str);
    return 1;
}
//==============================================================================
CMD:jail(playerid,params[])
{
	if(IsJailedOrMuted(playerid))return 1;
    if(PlayerOrgType(playerid)==LAW) {
        new player1,string[128];
        if (sscanf(params,"u",player1)) return SendClientMessage(playerid,GREY,"USAGE: /jail [playerid]");
        if(IsPlayerConnectedEx(player1) || player1 !=playerid) {
        	if(Suited[playerid]==0)return SendClientMessage(playerid,GREY,"You can perform organization commands only while suited up");
            if(!IsPlayerInRangeOfPoint(playerid,25,263.7495,77.5508,1001.0391)) return SendClientMessage(playerid,GREY,"You need to be near the jail with the suspect");
            if(!IsPlayerInRangeOfPoint(player1,25,263.7495,77.5508,1001.0391)) return SendClientMessage(playerid,GREY,"The suspect needs to be near the jail with you");
            if(GetPlayerWantedLevel(player1)==0)return SendClientMessage(playerid,GREY,"The Player isn't wanted");
            CagePlayer(player1);
            format(string,sizeof(string),"%s has been Arrested by Officer %s",PlayerName(player1),PlayerName(playerid));
            SendClientMessageToAll(RED,string);
        }
        else return SendClientMessage(playerid,GREY,"Invalid player ID");
    }else return SendClientMessage(playerid,GREY,"You are not a police officer");
    return 1;
}
//==============================================================================
CMD:speed(playerid,params[])
{
	if(IsJailedOrMuted(playerid))return 1;
    if(PlayerOrgType(playerid)==LAW) {
        new player1,string[128],Float:x,Float:y,Float:z;
        if (sscanf(params,"u",player1)) return SendClientMessage(playerid,GREY,"USAGE: /speed [playerid]");
        if(!IsCopCar(GetPlayerVehicleID(playerid)))return SendClientMessage(playerid,GREY,"You need to be in a police cruiser");
        if(IsPlayerConnectedEx(player1) || player1 !=playerid)
		{
            GetPlayerPos(playerid,x,y,z);
        	if(Suited[playerid]==0)return SendClientMessage(playerid,GREY,"You can perform organization commands only while suited up");
            if(!IsPlayerInRangeOfPoint(player1,35,x,y,z))return SendClientMessage(playerid,GREY,"The player's car should be near the Speed cam");
            GetVehicleVelocity(GetPlayerVehicleID(playerid),svx[playerid],svy[playerid],svz[playerid]);
    		sa1[playerid]=floatsqroot(((svx[playerid]*svx[playerid])+(svy[playerid]*svy[playerid]))+(svz[playerid]*svz[playerid]))*100;
    		sa2[playerid]=floatround(sa1[playerid],floatround_round);
            format(string,sizeof(string),"%s is driving with a speed of %d mph",PlayerName(player1),sa2);
            SendClientMessage(playerid,LRED,string);
        }
        else return SendClientMessage(playerid,GREY,"Invalid player ID");
    }else return SendClientMessage(playerid,GREY,"You are not a police officer");
    return 1;
}
//==============================================================================
CMD:unjail(playerid,params[])
{
	if(IsJailedOrMuted(playerid))return 1;
    if(PlayerOrgType(playerid)==LAW) {
        new player1;
        if (sscanf(params,"u",player1)) return SendClientMessage(playerid,GREY,"USAGE: /unjail [playerid]");
        if(IsPlayerConnectedEx(player1) ||  player1 !=playerid)
		{
        	if(Suited[playerid]==0)return SendClientMessage(playerid,GREY,"You can perform organization commands only while suited up");
		    if(Jailed[player1]==0)return SendClientMessage(playerid,GREY,"Player is not jailed");
            new string[128];
            format(string,sizeof(string),"Officer '%s' has Unjailed you",PlayerName(playerid));
            SendClientMessage(player1,LRED,string);
            for (new a=0;a<MAX_PLAYERS;a++)
        	{
        		if (IsPlayerConnectedEx(a))
       			{
        			if(PlayerOrgType(a)==LAW)
         			{
            			format(string,sizeof(string),"RADIO - Officer '%s' has Unjailed '%s'",PlayerName(playerid),PlayerName(player1));
           				SendClientMessage(a,BLUE,string);
             		}
				}
        	}
            UnCagePlayer(player1);
        }
        else return SendClientMessage(playerid,GREY,"Invalid player ID");
    }else return SendClientMessage(playerid,GREY,"You are not a police officer");
    return 1;
}
//==============================================================================
CMD:robbank(playerid,params[])
{
	if(IsJailedOrMuted(playerid))return 1;
    new count=0,str[128];
    if(PlayerOrgType(playerid)==MAFIA)
	{
    	if(PlayerLeader[playerid]==0)return SendClientMessage(playerid,GREY,"You aren't an org leader");
    	if(IsRobbing[playerid]==1)return 0;
        if(Suited[playerid]==0)return SendClientMessage(playerid,GREY,"You can perform organization commands only while suited up");
    	if(GetPlayerWantedLevel(playerid)>0)return SendClientMessage(playerid,GREY,"You're already wanted,loose the heat");
    	if(!IsPlayerInRangeOfPoint(playerid,50,1549.5024,-2264.3220,253.3183))return SendClientMessage(playerid,GREY,"You need to be inside the bank");
    	for (new a=0;a<MAX_PLAYERS;a++)
		{
        	if (IsPlayerConnectedEx(a))
			{
        	    if (PlayerOrgType(a)==LAW)
				{
        	        count++;
        	    }
        	}
    	}
    	if(count < 2)return SendClientMessage(playerid,GREY,"There should be atleast 2 cops online");for (new a=0;a<MAX_PLAYERS;a++)
		for (new i=0;i<MAX_PLAYERS;i++)
		{
        	if (IsPlayerConnectedEx(i))
			{
        	    if (PlayerOrgType(i)==MAFIA&&Suited[i]>0)
				{
					SetPlayerAttachedObject(i,7,1550,1,0.1,-0.2,0,0,90,0.5,0.8,0.8,0.8);
				    IsRobbing[i]=1;
        	        count++;
        	    }
        	}
    	}
    	format(str,sizeof(str),"[BREAKING NEWS]: %s has started robbing the San Andreas Bank",GetOrgName(PlayerOrg[playerid]));
    	IsRobbing[playerid]=1;
    	SendClientMessageToAll(RED,str);
    	SendClientMessage(playerid,-1,"To stop robbing the bank type /stoprob");
	}else return SendClientMessage(playerid,GREY,"You are not a gangmember");
    return 1;
}
//==============================================================================
CMD:setwant(playerid,params[])
{
	if(IsJailedOrMuted(playerid))return 1;
	new player1,wanted,string[128],reason[25];
    if(PlayerOrgType(playerid)!=LAW)return SendClientMessage(playerid,GREY,"You are not a police officer");
    if (!sscanf(params,"ui",player1,wanted))
	{
		new Float:x,Float:y,Float:z;
       	GetPlayerPos(player1,x,y,z);
       	if(wanted > 6)return SendClientMessage(playerid,GREY,"Invalid Wanted Level! (0-6)");
       	if(Suited[playerid]==0)return SendClientMessage(playerid,GREY,"You can perform organization commands only while suited up");
       	if(PlayerOrgType(player1)==LAW)return SendClientMessage(playerid,GREY,"You cannot want your fellow members");
       	if(!IsPlayerConnectedEx(player1)||player1==playerid)return SendClientMessage(playerid,GREY,"Invalid player ID");
		if(!IsPlayerInRangeOfPoint(playerid,100,x,y,z)) return SendClientMessage(playerid,GREY,"That player is far away from you");
       	format(string,sizeof(string),"Officer '%s' has set your Wanted Level to '%d'",PlayerName(playerid),wanted);
  		SendClientMessage(player1,LRED,string);
   		SetPlayerWantedLevel(player1,wanted);
     	for (new a=0;a<MAX_PLAYERS;a++)
		{
			if (IsPlayerConnectedEx(a))
			{
        		if(PlayerOrgType(a)==LAW)
				{
  					format(string,sizeof(string),"RADIO - Officer %s has set %s's Wanted Level to '%d'",PlayerName(playerid),PlayerName(player1),wanted);
   					SendClientMessage(a,BLUE,string);
	    		}
			}
		}
	}
	if (!sscanf(params,"uis[25]",player1,wanted,reason))
	{
		new Float:x,Float:y,Float:z;
       	GetPlayerPos(player1,x,y,z);
       	if(wanted > 6)return SendClientMessage(playerid,GREY,"Invalid Wanted Level! (0-6)");
       	if(Suited[playerid]==0)return SendClientMessage(playerid,GREY,"You can perform organization commands only while suited up");
       	if(PlayerOrgType(player1)==LAW)return SendClientMessage(playerid,GREY,"You cannot want your fellow members");
       	if(!IsPlayerConnectedEx(player1)||player1==playerid)return SendClientMessage(playerid,GREY,"Invalid player ID");
		if(!IsPlayerInRangeOfPoint(playerid,100,x,y,z)) return SendClientMessage(playerid,GREY,"That player is far away from you");
       	format(string,sizeof(string),"Officer '%s' has set your Wanted Level to '%d' (Reason: %s)",PlayerName(playerid),wanted,reason);
  		SendClientMessage(player1,LRED,string);
   		SetPlayerWantedLevel(player1,wanted);
  		format(Reason[playerid],25,reason);
     	for (new a=0;a<MAX_PLAYERS;a++)
		{
			if (IsPlayerConnectedEx(a))
			{
        		if(PlayerOrgType(a)==LAW)
				{
  					format(string,sizeof(string),"RADIO - Officer %s has set %s's Wanted Level to '%d' (Reason: %s)",PlayerName(playerid),PlayerName(player1),wanted,reason);
   					SendClientMessage(a,BLUE,string);
	    		}
			}
		}
	}else return SendClientMessage(playerid,GREY,"USAGE: /setwant [PlayerID] [WantedLevel(0-6)] [Reason]");
    return 1;
}
//==============================================================================
CMD:pu(playerid,params[])
{
	if(IsJailedOrMuted(playerid))return 1;
    if(PlayerOrgType(playerid)==LAW) {
        if(Suited[playerid]==0)return SendClientMessage(playerid,GREY,"You can perform organization commands only while suited up");
        new str[128];
        format(str,sizeof(str),"This is Police,pull over immediately");
		SendNearbyMessage(playerid,25.0,str,BLUE);
    }else return SendClientMessage(playerid,GREY,"You are not a police officer");
    return 1;
}
//==============================================================================
CMD:wanted(playerid,params[])
{
    new count=0;
    new string[128];
	if(IsJailedOrMuted(playerid))return 1;
    if(PlayerOrgType(playerid)==LAW||PlayerOrg[playerid]==2) {
        if(!IsCopCar(GetPlayerVehicleID(playerid)))return SendClientMessage(playerid,GREY,"You need to be in a police cruiser");
        for(new i=0; i < MAX_PLAYERS; i++)
		{
            if (IsPlayerConnectedEx(i))
			{
                if(GetPlayerWantedLevel(i) > 0)
				{
                    format(string,128,"Name : %s (Wanted Level %d) (Reason: %s)",PlayerName(i),GetPlayerWantedLevel(i),Reason[i]);
                    SendClientMessage(playerid,BLUE,string);
                    count++;
                }
            }
        }
        if (count==0)
            SendClientMessage(playerid,GREY,"There is no one currently wanted");
    }else return SendClientMessage(playerid,GREY,"You are not a police officer");
    return 1;
}
//==============================================================================
CMD:heal(playerid,params[])
{
	if(IsJailedOrMuted(playerid))return 1;
    if(PlayerOrg[playerid]==2) {
        new player1;
        if (sscanf(params,"u",player1)) return SendClientMessage(playerid,GREY,"USAGE: /heal [playerid]");
        if(IsPlayerConnectedEx(player1) || player1 !=playerid) {
            new Float:x,Float:y,Float:z;
            GetPlayerPos(playerid,x,y,z);
        	if(Suited[playerid]==0)return SendClientMessage(playerid,GREY,"You can perform organization commands only while suited up");
            if(!IsPlayerInRangeOfPoint(player1,3,x,y,z)) return SendClientMessage(playerid,GREY,"The player needs to be near to you");
            new string[128];
            format(string,sizeof(string),"Medic %s has healed you",PlayerName(playerid));
            SendClientMessage(player1,YELLOW,string);
            IsBleeding[player1]=0;
            if(DrugAddict[player1]==1)
            {
                DrugAddict[player1]=0;
                SendClientMessage(player1,LRED,"You are now free from drug addiction");
			}
            format(string,sizeof(string),"You've healed %s",PlayerName(player1));
            SendClientMessage(playerid,YELLOW,string);
            SetPlayerHealth(player1,100);
        }
        else return SendClientMessage(playerid,GREY,"Invalid player ID");
    }else return SendClientMessage(playerid,GREY,"You are not a paramedic");
    return 1;
}
//=============================================================================
CMD:tie(playerid,params[])
{
	if(IsJailedOrMuted(playerid))return 1;
    new id,string[128];
    if(PlayerOrgType(playerid)==LAW||PlayerOrgType(playerid)==GANG||PlayerOrgType(playerid)==MAFIA) {
        new Float:x1,Float:y1,Float:z1;
        GetPlayerPos(playerid,x1,y1,z1);
        if(sscanf(params,"u",id))return SendClientMessage(playerid,GREY,"USAGE: /tie [playerid]");
        if (!IsPlayerConnectedEx(id))return SendClientMessage(playerid,GREY,"Invalid player ID");
        if(Suited[playerid]==0)return SendClientMessage(playerid,GREY,"You can perform organization commands only while suited up");
        if(IsPlayerInAnyVehicle(playerid)) return SendClientMessage(playerid,GREY,"You can't tie someone from a vehicle");
        if(id==playerid)return SendClientMessage(playerid,GREY,"You cannot tie yourself");
        if(GetPlayerState(id)==PLAYER_STATE_PASSENGER ||GetPlayerState(id)==PLAYER_STATE_DRIVER)return SendClientMessage(playerid,GREY,"You cannot uncuff while the suspect is in car");
        if(!IsPlayerInRangeOfPoint(id,3,x1,y1,z1))return SendClientMessage(playerid,GREY,"Target needs to be near to you");
        SetPlayerAttachedObject(id,5,19418,6,-0.031999,0.024000,-0.024000,-7.900000,-32.000011,-72.299987,1.115998,1.322000,1.406000);
  	 	SetPlayerSpecialAction(id,SPECIAL_ACTION_CUFFED);
        format(string,sizeof(string),"You have been tied by %s",PlayerName(playerid));
        SendClientMessage(id,YELLOW,string);
        format(string,sizeof(string),"You have tied %s",PlayerName(id));
        SendClientMessage(playerid,YELLOW,string);
    }else return SendClientMessage(playerid,GREY,"You are not a police officer or a gangmember");
    return 1;
}
//=============================================================================
CMD:untie(playerid,params[])
{
	if(IsJailedOrMuted(playerid))return 1;
    new id,string[128];
    new Float:x1,Float:y1,Float:z1;
    GetPlayerPos(playerid,x1,y1,z1);
    if(PlayerOrgType(playerid)==LAW||PlayerOrgType(playerid)==GANG||PlayerOrgType(playerid)==MAFIA) {
        if(sscanf(params,"u",id))return SendClientMessage(playerid,GREY,"USAGE: /untie [playerid]");
        if (!IsPlayerConnectedEx(id))return  SendClientMessage(playerid,GREY,"Invalid player ID");
        if(Suited[playerid]==0)return SendClientMessage(playerid,GREY,"You can perform organization commands only while suited up");
        if(IsPlayerInAnyVehicle(playerid)) return SendClientMessage(playerid,GREY,"You can't untie someone from a vehicle");
        if(id==playerid)return SendClientMessage(playerid,GREY,"You cannot untie yourself");
        if(!IsPlayerInRangeOfPoint(id,3,x1,y1,z1))return SendClientMessage(playerid,GREY,"Target needs to be near to you");
        if(GetPlayerState(id)==PLAYER_STATE_PASSENGER ||GetPlayerState(id)==PLAYER_STATE_DRIVER)return SendClientMessage(playerid,GREY,"You cannot uncuff while the suspect is in car");
        if(IsPlayerAttachedObjectSlotUsed(id,5))
 		{
			RemovePlayerAttachedObject(id,5);
 		}
		SetPlayerSpecialAction(id,SPECIAL_ACTION_NONE);
        format(string,sizeof(string),"You have been untied by %s",PlayerName(playerid));
        SendClientMessage(id,YELLOW,string);
        format(string,sizeof(string),"You have untied %s",PlayerName(id));
        SendClientMessage(playerid,YELLOW,string);
    }else return SendClientMessage(playerid,GREY,"You are not a police officer or a gangmember");
    return 1;
}
//==============================================================================
CMD:lc(playerid,params[])
{
	if(IsJailedOrMuted(playerid))return 1;
    if(PlayerOrgType(playerid)==LAW)
	{
        new str[128];
        if(sscanf(params,"s[128]",params)) return SendClientMessage(playerid,GREY,"USAGE: /lc [Text]");
        if(Suited[playerid]==0)return SendClientMessage(playerid,GREY,"You can perform organization commands only while suited up");
        format(str,sizeof(str),"Law Chat - %s : %s",PlayerName(playerid),params);
        for (new a=0;a<MAX_PLAYERS;a++)
        {
        	if (IsPlayerConnectedEx(a))
       		{
        		if(PlayerOrgType(a)==LAW)
         		{
           			SendClientMessage(a,BLUE,str);
             	}
			}
        }
    }else return SendClientMessage(playerid,GREY,"You are not a police officer");
    return 1;
}
//==============================================================================
CMD:ticket(playerid,params[])
{
	if(IsJailedOrMuted(playerid))return 1;
    if(PlayerOrgType(playerid)==LAW) {
        new pID,value,Float:x,Float:y,Float:z;
        GetPlayerPos(playerid,x,y,z);
        if(sscanf(params,"ui",pID,value)) return SendClientMessage(playerid,GREY,"USAGE: /ticket [playerid] [amount]");
        else if(!IsPlayerConnectedEx(pID)) return SendClientMessage(playerid,GREY,"Invalid player ID");
        if(Suited[playerid]==0)return SendClientMessage(playerid,GREY,"You can perform organization commands only while suited up");
        else if(value > GetPlayerMoneyEx(pID)) return SendClientMessage(playerid,GREY,"Player doesn't have enough money");
        else if(pID==playerid) return SendClientMessage(playerid,-1,"That's You,You idiot");
        else if(GetPlayerWantedLevel(pID)==0) return SendClientMessage(playerid,GREY,"Player Isnt wanted");
        if(!IsPlayerInRangeOfPoint(pID,10,x,y,z)) return SendClientMessage(playerid,GREY,"The player needs to be near to you");
        else {
            new string[128];
            format(string,sizeof(string),"You ticketed %s a fine of $%i",PlayerName(pID),value);
            SendClientMessage(playerid,LRED,string);
            format(string,sizeof(string),"You got tickted $%i by Officer %s",PlayerName(playerid),value);
            SendClientMessage(pID,LRED,string);
            GivePlayerMoneyEx(playerid,value);
            GivePlayerMoneyEx(pID,- value);
            SetPlayerWantedLevel(pID,0);
            Ticket[pID]++;
            if(Ticket[pID]>=3&&DL[pID]==1)
            {
		        DL[pID]=0;
                Ticket[pID]=0;
				format(string,sizeof(string),"The driving license of %s has been suspended",PlayerName(pID));
				SendClientMessage(playerid,LRED,string);
				format(string,sizeof(string),"Officer %s has suspended your driving license",PlayerName(playerid));
				SendClientMessage(pID,LRED,string);
            }
        }
    }else return SendClientMessage(playerid,GREY,"You are not a police officer");
    return 1;
}
//==============================================================================
CMD:depositloot(playerid,params[])
{
	if(IsJailedOrMuted(playerid))return 1;
    if(PlayerOrgType(playerid)==MAFIA)
	{
    	if (IsPlayerInRangeOfPoint(playerid,3.0,Organization[PlayerOrg[playerid]][OrgX],Organization[PlayerOrg[playerid]][OrgY],Organization[PlayerOrg[playerid]][OrgZ]))
		{
        	if(IsRobbing[playerid]==0)
			{
            	new str[128];
            	if(IsRobbing[playerid]==1)return 0;
            	RemovePlayerAttachedObject(playerid,7);
            	format(str,sizeof(str),"You deposited the loot of $%d",rcash[playerid]);
            	SendClientMessage(playerid,YELLOW,str);
            	Organization[PlayerOrg[playerid]][Money]=(Organization[PlayerOrg[playerid]][Money])+rcash[playerid];
            	rcash[playerid]=0;
        	}
    	}else return SendClientMessage(playerid,GREY,"You aren't near the HQ");
	}else return SendClientMessage(playerid,GREY,"You are not a gangmember");
    return 1;
}
//==============================================================================
CMD:loot(playerid,params[])
{
	if(IsJailedOrMuted(playerid))return 1;
    new str[128];
    if(PlayerOrgType(playerid)==MAFIA){
    if(rcash[playerid]==0)return SendClientMessage(playerid,GREY,"You didn't rob anything yet");
    format(str,sizeof(str),"You have robbed a loot of $%d",rcash[playerid]);
    SendClientMessage(playerid,-1,str);}else return SendClientMessage(playerid,GREY,"You are not a gangmember");
    return 1;
}
//==============================================================================
CMD:startpaintball(playerid,params[])
{
	if(IsJailedOrMuted(playerid))return 1;
    if(PB[playerid]==1)return 0;
    if(IsPlayerInRangeOfPoint(playerid,10,1310.1403,-1367.4672,13.5349)) {
        if(GetPlayerWantedLevel(playerid) >=1)return SendClientMessage(playerid,GREY,"You are wanted");
        SendClientMessage(playerid,-1,"use /stoppaintball to stop dueling");
        SetPlayerPos(playerid,-330.3668,2222.4561,42.4898);
        GivePlayerWeaponEx(playerid,29,2500);
        SetPlayerVirtualWorld(playerid,1);
        PB[playerid]=1;
    }
    return 1;
}
//==============================================================================
CMD:stoppaintball(playerid,params[])
{
	if(IsJailedOrMuted(playerid))return 1;
    if(PB[playerid]==1) {
        SetPlayerPos(playerid,1312.1403,-1367.4672,13.5349);
        SendClientMessage(playerid,-1,"Come back soon!");
        SetPlayerVirtualWorld(playerid,0);
        SetPlayerAmmo(playerid,29,0);
        SetPlayerHealth(playerid,100);
        PB[playerid]=0;
    }
    return 1;
}
//==============================================================================
CMD:robhouse(playerid,params[])
{
	if(IsJailedOrMuted(playerid))return 1;
    new str[128];
    if(PlayerOrgType(playerid)==GANG)
	{
    	if(PlayerLeader[playerid]==0)return SendClientMessage(playerid,GREY,"You aren't an org leader");
    	if(Suited[playerid]==0)return SendClientMessage(playerid,GREY,"You can perform organization commands only while suited up");
    	if(GetPlayerWantedLevel(playerid)>0)return SendClientMessage(playerid,GREY,"You're already wanted,loose the heat");
    	if(IsRobbing[playerid]==1)return 0;
    	if(GetPlayerInterior(playerid)==5 ||GetPlayerInterior(playerid)==8)
		{
    	    format(str,sizeof(str),"[BREAKING NEWS]: %s HAVE STARTED TO ROB A HOUSE",GetOrgName(PlayerOrg[playerid]));
    	    SendClientMessageToAll(RED,str);
			new rand=1000 +random(899);
			GivePlayerMoneyEx(playerid,rand);
			SetPlayerWantedLevel(playerid,4);
			format(Reason[playerid],25,"Robbery");
			format(str,sizeof(str),"~g~+$%s",rand);
			GameTextForPlayer(playerid,str,1500,1);
  		}else return SendClientMessage(playerid,GREY,"You need to be inside a goddamn interior");
    }else return SendClientMessage(playerid,GREY,"You are not a gangmember");
    return 1;
}
//==============================================================================
CMD:loc(playerid,params[])
{
	if(IsJailedOrMuted(playerid))return 1;
    if(PlayerOrgType(playerid)==LAW)
	{
        new player1,str[128];
        if(sscanf(params,"u",player1)) return SendClientMessage(playerid,GREY,"USAGE: /loc [playerid]");
		if(Suited[playerid]==0)return SendClientMessage(playerid,GREY,"You can perform organization commands only while suited up");
        if(IsPlayerConnectedEx(player1) ||  player1 !=playerid)
		{
        	if(!IsCopCar(GetPlayerVehicleID(playerid)))return SendClientMessage(playerid,GREY,"You need to be in a police cruiser");
		    if(GetPlayerWantedLevel(player1)>0)
		    {
		        if(Cell[playerid]==0||GetPlayerInterior(playerid)>0)return SendClientMessage(playerid,GREY,"The Player's location was not found");
		    	new zone[MAX_ZONE_NAME],string[30];
				GetPlayer2DZone(player1,zone,MAX_ZONE_NAME);
				format(string,sizeof(string),"%s",zone);
				format(str,sizeof(str),"Location of %s : %s",PlayerName(playerid),string);
				SendClientMessage(playerid,BLUE,str);
			}else return SendClientMessage(playerid,GREY,"Player is not wanted");
        }
        else return SendClientMessage(playerid,GREY,"Invalid player ID");
    }else return SendClientMessage(playerid,GREY,"You are not a police officer");
    return 1;
}
//==============================================================================
CMD:bribe(playerid,params[])
{
	if(IsJailedOrMuted(playerid))return 1;
    if(GetPlayerWantedLevel(playerid)==0)return  SendClientMessage(playerid,GREY,"You aren't wanted");
    new pID,value,Float:x,Float:y,Float:z;
    if(sscanf(params,"ui",pID,value)) return SendClientMessage(playerid,GREY,"USAGE: /bribe [playerid] [amount]");
    else if(!IsPlayerConnectedEx(pID)) return SendClientMessage(playerid,GREY,"Invalid player ID");
    else if(value > GetPlayerMoneyEx(playerid)) return SendClientMessage(playerid,GREY,"You don't have enough money on you");
    else if(pID==playerid) return SendClientMessage(playerid,-1,"That's You,You IDIOT");
    GetPlayerPos(playerid,x,y,z);
    if(!IsPlayerInRangeOfPoint(pID,10,x,y,z)) return SendClientMessage(playerid,GREY,"The Officer needs to be near to you");
	if(PlayerOrgType(pID)==LAW)
    {
        new string[128];
        format(string,sizeof(string),"You bribed $%i to Officer :%s ",value,PlayerName(pID));
        SendClientMessage(playerid,LRED,string);
        format(string,sizeof(string),"You got $%i by %s as a bribe",value,PlayerName(playerid));
        SendClientMessage(pID,LRED,string);
        GivePlayerMoneyEx(pID,value);
        GivePlayerMoneyEx(playerid,- value);
    }else return SendClientMessage(playerid,GREY,"Do you know whom you are bribing to?");
    return 1;
}
//==============================================================================
CMD:shipdrugs(playerid,params[])
{
	if(PlayerOrgType(playerid)==MAFIA)
	{
    	new value,oid,str[128];
		if(IsJailedOrMuted(playerid))return 1;
        if(PlayerLeader[playerid]==0)return SendClientMessage(playerid,GREY,"You aren't an org leader");
    	if (sscanf(params,"ii",oid,value)) return SendClientMessage(playerid,GREY,"USAGE: /shipdrugs [Org ID] [amount]");
        if(Suited[playerid]==0)return SendClientMessage(playerid,GREY,"You can perform organization commands only while suited up");
    	if(value > Organization[PlayerOrg[playerid]][Drugs]) return SendClientMessage(playerid,GREY,"You Dont Have That Much Drugs");
    	if (oid==7||oid==8)
    	{
    		if(oid==PlayerOrg[playerid])return SendClientMessage(playerid,GREY,"Excuse me?");
    		Organization[PlayerOrg[playerid]][Drugs]=Organization[PlayerOrg[playerid]][Drugs]-value;
    		Organization[oid][Drugs]=(Organization[oid][Drugs])+value;
    		format(str,sizeof(str),"You have shipped %d drugs to '%s'",value,GetOrgName(oid));
    		SendClientMessage(playerid,YELLOW,str);
    		format(str,sizeof(str),"%s has shipped %d drugs to your org",PlayerName(playerid),value);
    		SendClientMessageToOrg(GetOrgName(oid),YELLOW,str);
		}
	}else return SendClientMessage(playerid,GREY,"You are not a gang leader");
    return 1;
}
//==============================================================================
CMD:getdrugs(playerid,params[])
{
    if(PlayerOrgType(playerid)==GANG)
	{
		if(IsJailedOrMuted(playerid))return 1;
        if(Suited[playerid]==0)return SendClientMessage(playerid,GREY,"You can perform organization commands only while suited up");
        if (IsPlayerInRangeOfPoint(playerid,3.0,Organization[PlayerOrg[playerid]][OrgX],Organization[PlayerOrg[playerid]][OrgY],Organization[PlayerOrg[playerid]][OrgZ]))
		{
            if(Organization[PlayerOrg[playerid]][Drugs]<1)return SendClientMessage(playerid,GREY,"Your org is out of drug");
            Organization[PlayerOrg[playerid]][Drugs]=(Organization[PlayerOrg[playerid]][Drugs])-1;
            SendClientMessage(playerid,YELLOW,"You have got one drug packet");
            Drug[playerid]++;
        }else SendClientMessage(playerid,GREY,"You need to be near your org HQ");
    }else return SendClientMessage(playerid,GREY,"You are not a gangmember");
    return 1;
}
//==============================================================================
CMD:givedrugs(playerid,params[])
{
    if(PlayerOrgType(playerid)==GANG)
	{
		if(IsJailedOrMuted(playerid))return 1;
        new str[128],ID,Float:x,Float:y,Float:z;
        if (sscanf(params,"u",ID)) return SendClientMessage(playerid,GREY,"USAGE: /givedrugs [playerid]");
        if(Suited[playerid]==0)return SendClientMessage(playerid,GREY,"You can perform organization commands only while suited up");
        if(IsPlayerConnectedEx(ID) || ID !=playerid)
        {
			GetPlayerPos(ID,x,y,z);
			if (IsPlayerInRangeOfPoint(playerid,3.0,x,y,z))
	 		{
            	if(Drug[playerid]<1)return SendClientMessage(playerid,GREY,"You  don't have any drugs");
            	SendClientMessage(playerid,-1,"You have given one drug packet");
            	Drug[playerid]=Drug[playerid]-1;
            	Drug[ID]=Drug[ID]+1;
            	format(str,sizeof(str),"%s has given you one drug packet",PlayerName(playerid));
            	SendClientMessage(ID,YELLOW,str);
             	for(new i=0; i<MAX_PLAYERS; i++)
				{
            		if(IsPlayerInRangeOfPoint(i,15,x,y,z))
					{
					    if(i!=playerid&&i!=ID)
					    {
					        if(GetPlayerWantedLevel(playerid)==0&&GetPlayerWantedLevel(ID)==0)
					        {
					    		if (PlayerOrgType(i)==LAW)
								{
								    SetPlayerWantedLevel(ID,1);
								    SetPlayerWantedLevel(playerid,1);
									format(Reason[i],25,"Drug Dealing");
									format(Reason[playerid],25,"Drug Dealing");
									SendClientMessage(i,LRED,"There's a drug dealing being held nearby you");
                					SendClientMessage(ID,LRED,"Shit! Cops got notified about this drug dealing");
                					SendClientMessage(playerid,LRED,"Shit! Cops got notified about this drug dealing");
								}
							}
						}
            		}
        		}
        	}else return SendClientMessage(playerid,GREY,"You need to be near the player");
		}else return SendClientMessage(playerid,GREY,"Invalid player ID");
    }else return SendClientMessage(playerid,GREY,"You are not a gangmember");
    return 1;
}
//==============================================================================
CMD:usedrugs(playerid,params[])
{
	if(IsJailedOrMuted(playerid))return 1;
    if(Drug[playerid]<1)return SendClientMessage(playerid,GREY,"You don't have any drugs");
    Drug[playerid]=Drug[playerid]-1;
    new Float:health,rand=2+random(5);
	if(rand==4&&DrugAddict[playerid]==0)
	{
	    DrugAddict[playerid]=1;
	    SendClientMessage(playerid,LRED,"You are now addicted to drugs,you will loose your health if you don't take drugs");
        if(PlayerAwards[playerid][Addict]==0)
		{
   			GivePlayerMoneyEx(playerid,500);
   			PlayerAwards[playerid][Addict]=1;
			GamerScore[playerid]=GamerScore[playerid]+55;
  			SendClientMessage(playerid,YELLOW,"Achievement Unlocked: {FFFFFF}BLOW!");
			SendClientMessage(playerid,LGREEN,"BONUS: $500 || +55 Gamer Score");
		}
	}
    HadDrugs[playerid]++;
    GetPlayerHealth(playerid,health);
    SetPlayerHealth(playerid,health+25);
    SetPlayerDrunkLevel (playerid,GetPlayerDrunkLevel(playerid)+3000);
    return 1;
}
//==============================================================================
CMD:setdrugs(playerid,params[])
{
	if(IsMuted(playerid))return 1;
	if(AdminLevel[playerid]>2)
	{
    	new value,oid,str[128];
    	if (sscanf(params,"ii",oid,value)) return SendClientMessage(playerid,GREY,"USAGE: /setdrugs [Org ID] [amount]");
    	if (oid==1||oid==6)
    	{
    		Organization[oid][Drugs]=(Organization[oid][Drugs])+value;
    		format(str,sizeof(str),"You have given %d drugs to '%s'",value,GetOrgName(oid));
    		SendClientMessage(playerid,YELLOW,str);
    		format(str,sizeof(str),"An Administrator has given %d drugs to your org",value);
    		SendClientMessageToOrg(GetOrgName(oid),YELLOW,str);
		}
	}else return 0;
    return 1;
}
//==============================================================================
CMD:music(playerid,params[])
{
	if(IsJailedOrMuted(playerid))return 1;
	ShowPlayerDialog(playerid,MUSIC,DIALOG_STYLE_LIST,"AG - Music Station","Desi Boyz - Jhak Maar Ke\nLinkin Park - Papercut\nLinkin Park - Points Of Authority","Play","Stop Music");
	return 1;
}
//==============================================================================
CMD:guide(playerid,params[])
{
	if(IsJailedOrMuted(playerid))return 1;
	GetPlayerPos(playerid,pX[playerid],pY[playerid],pZ[playerid]);
	if(GetPlayerWantedLevel(playerid)>0)return SendClientMessage(playerid,GREY,"You are wanted,loose the heat");
    ShowPlayerDialog(playerid,TUT,DIALOG_STYLE_MSGBOX,"Server Guide","{FFFFFF}Do you wish to go through a short tutorial of the server and its features?","Yes","Close");
 	return 1;
}
//==============================================================================
CMD:flip(playerid,params[])
{
	if(IsMuted(playerid))return 1;
    if(AdminLevel[playerid] > 2 )
    {
	    if(IsPlayerInAnyVehicle(playerid))
		{
			new Float:X,Float:Y,Float:Z,Float:Angle;
			GetPlayerPos(playerid,X,Y,Z);
			GetVehicleZAngle(GetPlayerVehicleID(playerid),Angle);
			SetVehiclePos(GetPlayerVehicleID(playerid),X,Y,Z);
			SetVehicleZAngle(GetPlayerVehicleID(playerid),Angle);
			RepairVehicle(GetPlayerVehicleID(playerid));
			SetPlayerChatBubble(playerid,"*flips the vehicle",LBLUE,100.0,10000);
		}
	}else return 0;
	return 1;
}
//==============================================================================
CMD:propose(playerid,params[])
{
	new ID,str[128],count=0;
	if(IsJailedOrMuted(playerid))return 1;
	if(!IsPlayerInRangeOfPoint(playerid,10,-1989.0254,1117.9299,54.4717))return SendClientMessage(playerid,GREY,"You need to be near the church and the player");
 	if(sscanf(params,"u",ID)) return SendClientMessage(playerid,GREY,"USAGE: /propose [playerid]");
	if(strcmp(MarriedTo[playerid],"None",true)==0)
	{
 		if(!IsPlayerConnectedEx(ID))return SendClientMessage(playerid,GREY,"That player is not connected");
 		if(GetPVarInt(playerid,"mariedid")!=-1)return SendClientMessage(playerid,GREY,"You can propose only once");
		if(GetPVarInt(ID,"mariedid")!=-1)return SendClientMessage(playerid,GREY,"That player is already engaged with someone else");
		for(new i=0; i<MAX_PLAYERS; i++)
		{
		    if(i!=ID&&i!=playerid)
		    {
		        if(IsPlayerInRangeOfPoint(i,10,-1989.0254,1117.9299,54.4717))
		        {
		        	count++;
				}
			}
			if(count<1)return SendClientMessage(playerid,GREY,"You need atleast 1 witness");
		}
		format(str,128,"%s has proposed you to marry him",PlayerName(playerid));
		SendClientMessage(ID,YELLOW,str);
		SendClientMessage(ID,-1,"You can accept the proposal by /acceptproposal,otherwise ignore it");
		format(str,128,"You have proposed %s to marry you",PlayerName(ID));
		SendClientMessage(playerid,-1,str);
		SetPVarInt(playerid,"mariedid",ID);
    }else return SendClientMessage(playerid,GREY,"You are already married");
	return 1;
}
//==============================================================================
CMD:acceptproposal(playerid,params[])
{
	new ID,str[128];
	if(IsJailedOrMuted(playerid))return 1;
	if(!IsPlayerInRangeOfPoint(playerid,10,-1989.0254,1117.9299,54.4717))return SendClientMessage(playerid,GREY,"You need to be near the church and the player");
 	if(sscanf(params,"u",ID)) return SendClientMessage(playerid,GREY,"USAGE: /acceptproposal [playerid]");
 	if(!IsPlayerConnectedEx(ID))return SendClientMessage(playerid,-1,"That player is not connected");
	if(strcmp(MarriedTo[playerid],"None",true)==0)
	{
 		if(GetPVarInt(playerid,"mariedid")!=-1)return SendClientMessage(playerid,GREY,"You already proposed someone else");
		if(GetPVarInt(ID,"mariedid")!=playerid)return SendClientMessage(playerid,GREY,"That player has not proposed you");
		for(new i=0; i<MAX_PLAYERS; i++)
		{
		    if(i!=ID&&i!=playerid)
		    {
		        if(IsPlayerInRangeOfPoint(i,10,-1989.0254,1117.9299,54.4717))
		        {
		            format(str,128,"You have witnessed the marriage of %s and %s",PlayerName(ID),PlayerName(playerid));
					SendClientMessage(i,YELLOW,str);
				}
			}
		}
		format(str,128,"%s has accepted your proposal to marry you",PlayerName(playerid));
		SendClientMessage(ID,YELLOW,str);
		format(str,128,"You have accepted the proposal of %s",PlayerName(ID));
		SendClientMessage(playerid,-1,str);
		format(str,128,"%s has married to %s,Greetings to them",PlayerName(ID),PlayerName(playerid));
		SendClientMessageToAll(GREEN,str);
		MarriedTo[playerid]=PlayerName(ID);
		MarriedTo[ID]=PlayerName(playerid);
	}else return SendClientMessage(playerid,GREY,"You are already married");
	return 1;
}
//==============================================================================
CMD:divorce(playerid,params[])
{
	new ID,str[128];
	if(IsJailedOrMuted(playerid))return 1;
	if(!IsPlayerInRangeOfPoint(playerid,10,-1989.0254,1117.9299,54.4717))return SendClientMessage(playerid,GREY,"You need to be near the church and the player");
 	if(sscanf(params,"u",ID)) return SendClientMessage(playerid,GREY,"USAGE: /divorce [playerid]");
 	if(!IsPlayerConnectedEx(ID))return SendClientMessage(playerid,GREY,"That player is not connected");
	if(strcmp(MarriedTo[playerid],PlayerName(playerid),true)==0)
	{
 		format(str,128,"%s has divorced %s,they are not married anymore",PlayerName(playerid),PlayerName(ID));
 		SendClientMessageToAll(GREEN,str);
		MarriedTo[ID]="None";
		MarriedTo[playerid]="None";
	}else return SendClientMessage(playerid,GREY,"You cannot divorce someone who is not married to you");
	return 1;
}
//==============================================================================
CMD:gmx(playerid,params[])
{
	if(IsMuted(playerid))return 1;
	if(AdminLevel[playerid]<3)return 0;
	for(new i=0; i<MAX_PLAYERS; i++)
	{
    	if(IsPlayerConnectedEx(i))
		{
			SaveOrg();
			SStats(i);
			CStats(i);
			KillTimer(globaltimer);
			SendClientMessage(i,RED,"An Administrator has restarted the server");
			SendClientMessage(i,RED,"Please wait till the server restarts,and then you may continue playing");
		}
	}
	SendRconCommand("gmx");
	return 1;
}
//==============================================================================
CMD:say(playerid,params[])
{
	new str[128];
	if(IsMuted(playerid))return 1;
	if(AdminLevel[playerid]<3)return 0;
	if(sscanf(params,"s[128]",params)) return SendClientMessage(playerid,GREY,"USAGE: /say [text]");
	if(strlen(params) > 128) return SendClientMessage(playerid,GREY,"Text can't be longer than 128 characters");
 	format(str,128,"Administrator: {FFFFFF}%s",params);
 	SendClientMessageToAll(LRED,str);
	return 1;
}
//==============================================================================
CMD:tosscoin(playerid,params[])
{
	if(IsJailedOrMuted(playerid))return 1;
	new coinname[20],string[128];
	new coin=random(2)+1;
	if(coin==1){coinname="heads";}
	else{coinname="tails";}
	format(string,sizeof(string),"You tossed a coin and it landed on %s",coinname);
	SendClientMessage(playerid,YELLOW,string);
	return 1;
}
//==============================================================================
CMD:skydive(playerid,params[])
{
	new id;
	if(IsJailedOrMuted(playerid))return 1;
    if(AdminLevel[playerid] > 2)
    {
		if(sscanf(params,"u",id)) return SendClientMessage(playerid,GREY,"USAGE: /skydive [playerid]");
		if(IsPlayerConnectedEx(id))
		{
		    if(GetPlayerState(playerid)==PLAYER_STATE_ONFOOT)
		    {
				GetPlayerPos(id,pX[id],pY[id],pZ[id]);
				GivePlayerWeaponEx(id,46,1);
				SetPlayerPos(id,pX[id],pY[id],pZ[id]+1500);
				SendClientMessage(id,-1,"GO!! GO!! GO!!");
			}
			if(GetPlayerState(playerid)==PLAYER_STATE_DRIVER)
		    {
				GetVehiclePos(GetPlayerVehicleID(id),pX[id],pY[id],pZ[id]);
				GivePlayerWeaponEx(id,46,1);
				SetVehiclePos(GetPlayerVehicleID(id),pX[id],pY[id],pZ[id]+1500);
				SendClientMessage(id,-1,"GO!! GO!! GO!!");
			}
		}else return SendClientMessage(playerid,GREY,"Invalid player ID");
	}else return 0;
	return 1;
}
//==============================================================================
CMD:setskills(playerid,params[])
{
	new id;
	if(IsMuted(playerid))return 1;
    if(AdminLevel[playerid] > 2)
    {
		if(sscanf(params,"u",id)) return SendClientMessage(playerid,GREY,"USAGE: /setskills [playerid]");
		if(IsPlayerConnectedEx(id))
		{
			SetPlayerSkillLevel(id,WEAPONSKILL_M4,1000);
			SetPlayerSkillLevel(id,WEAPONSKILL_MP5,1000);
			SetPlayerSkillLevel(id,WEAPONSKILL_AK47,1000);
			SetPlayerSkillLevel(id,WEAPONSKILL_SHOTGUN,1000);
			SetPlayerSkillLevel(id,WEAPONSKILL_MICRO_UZI,1000);
			SetPlayerSkillLevel(id,WEAPONSKILL_SNIPERRIFLE,1000);
			SetPlayerSkillLevel(id,WEAPONSKILL_DESERT_EAGLE,1000);
			SetPlayerSkillLevel(id,WEAPONSKILL_SPAS12_SHOTGUN,1000);
			SetPlayerSkillLevel(id,WEAPONSKILL_SAWNOFF_SHOTGUN,1000);
			SetPlayerSkillLevel(id,WEAPONSKILL_PISTOL_SILENCED,1000);
			SendClientMessage(id,YELLOW,"An Administrator has set you as a Professional killer");
		}else return SendClientMessage(playerid,GREY,"Invalid player ID");
	}else return 0;
	return 1;
}
//==============================================================================
CMD:loadpackages(playerid,params[])
{
	if(IsJailedOrMuted(playerid))return 1;
   	if(Trucking[playerid]==2) return SendClientMessage(playerid,GREY,"You already have overloaded packages");
	if(!IsPlayerInAnyVehicle(playerid) || GetVehicleModel(GetPlayerVehicleID(playerid))!=403 || !IsTrailerAttachedToVehicle(GetPlayerVehicleID(playerid))) return SendClientMessage(playerid,GREY,"You are not in a Trucker vehicle or you have no trailer attached");
   	if(!IsPlayerInRangeOfPoint(playerid,5,1727.3557,2309.9985,10.8203)) return SendClientMessage(playerid,GREY,"You are not near a packages pickup");
    if(Trucking[playerid]==0)
    {
		Trucking[playerid]=1;
   		if(GetPlayerMoneyEx(playerid)<400) return SendClientMessage(playerid,GREY,"You don't have $400 on you");
	   	SendClientMessage(playerid,YELLOW,"Welcome to the San Andreas Truckers");
    	SendClientMessage(playerid,-1,"You have chose to perform trucking job. You need to take the truck with the trailer attached safely");
    	SendClientMessage(playerid,-1,"and reach within the required time to the docks for the exports. And then you will be rewarded for your job");
    	SendClientMessage(playerid,ORANGE,"You have loaded the packages for $400,deliver them to the dropoff");
        SendClientMessage(playerid,-1,"You can overload packages by typing /loadpackages again,cops will be notified though");
    	GameTextForPlayer(playerid,"~r~-$400",800,1);
    	GivePlayerMoneyEx(playerid,-400);
    }
    else if(Trucking[playerid]==1)
    {
		Trucking[playerid]=2;
   		if(GetPlayerMoneyEx(playerid)<1000) return SendClientMessage(playerid,GREY,"You don't have $1000 on you");
	    SendClientMessage(playerid,LRED,"You have overloaded the packages,the Police Department has been notified as a result");
		GameTextForPlayer(playerid,"~r~-$1000",800,1);
		format(Reason[playerid],25,"Over Loading Truck");
    	GivePlayerMoneyEx(playerid,-1000);
		if(GetPlayerWantedLevel(playerid)<5)
		{SetPlayerWantedLevel(playerid,GetPlayerWantedLevel(playerid)+2);}
		if(GetPlayerWantedLevel(playerid)==5){SetPlayerWantedLevel(playerid,6);}
    	for(new a=0;a<MAX_PLAYERS;a++)
		{
			if(IsPlayerConnectedEx(a))
			{
				if(PlayerOrgType(a)==LAW)
				{
    				new str[128];
					format(str,sizeof(str),"Law Chat - %s has been reported for overloading his truck illegally",PlayerName(playerid));
					SendClientMessage(a,BLUE,str);
 				}
			}
		}
    }
    Time[playerid]=gettime()+60*5;
    new rand=1 +random(2);
    if(rand==1)
    {
    	SetPlayerCheckpoint(playerid,2222,-2682,13,3);
	}
 	if(rand !=1)
 	{
    	SetPlayerCheckpoint(playerid,-1546,126,2,3);
	}
	return 1;
}
//==============================================================================
CMD:delieverpackages(playerid,params[])
{
	new Float:health;
	if(IsJailedOrMuted(playerid))return 1;
	GetVehicleHealth(GetPlayerVehicleID(playerid),health);
	if(Trucking[playerid]==0)return SendClientMessage(playerid,GREY,"You are not on a trucking mission neither you have any packages loaded");
	if(health<500)return SendClientMessage(playerid,GREY,"Sorry,but we do not accept broken packages,better luck next time");
	if(gettime()>Time[playerid])return SendClientMessage(playerid,GREY,"Sorry,but you were too late to deliver packages,try to reach within 5 mintues");
	if(!IsPlayerInAnyVehicle(playerid) || GetVehicleModel(GetPlayerVehicleID(playerid))!=403 || !IsTrailerAttachedToVehicle(GetPlayerVehicleID(playerid))) return SendClientMessage(playerid,GREY,"You are not in a Trucker vehicle or you have no trailer attached");
   	if(!IsPlayerInRangeOfPoint(playerid,5,2222.5107,-2682.7368,13.5409)||!IsPlayerInRangeOfPoint(playerid,5,2222,-2682,14)) return SendClientMessage(playerid,GREY,"You are not near the dropoff");
	if(Trucking[playerid]==1)
	{
    	GivePlayerMoneyEx(playerid,4000);
		GameTextForPlayer(playerid,"~g~+$4000",800,1);
		SendClientMessage(playerid,YELLOW,"You have delievered the packages and earned $4000,Good Job");
	}
	if(Trucking[playerid]==2)
	{
    	GivePlayerMoneyEx(playerid,10000);
    	GameTextForPlayer(playerid,"~g~+$10000",800,1);
		SendClientMessage(playerid,YELLOW,"You have delievered the packages and earned $10000,Excellent Job");
	}
	Trucking[playerid]=0;
	DisablePlayerCheckpoint(playerid);
	DetachTrailerFromVehicle(GetPlayerVehicleID(playerid));
	SetVehicleToRespawn(GetVehicleTrailer(GetPlayerVehicleID(playerid)));
	return 1;
}
//==============================================================================
CMD:buybus(playerid,params[])
{
	if(IsJailedOrMuted(playerid))return 1;
    for(new i=1;i<BusinessCount+1;i++)
    {
 		new string[100];
		if(BankID[playerid]==0)return SendClientMessage(playerid,GREY,"You need a bank account");
        if(GetPlayerScore(playerid)<4)return SendClientMessage(playerid,GREY,"You need a score of atleast Level 4");
        if(!IsPlayerInRangeOfPoint(playerid,1.0,Business[i][bX],Business[i][bY],Business[i][bZ]))continue;
        if(GetPlayerMoneyEx(playerid) < Business[i][bCost]) return SendClientMessage(playerid,GREY,"You don't have enough money");
       	if(strcmp(Business[i][bOwner],"None") !=0) return SendClientMessage(playerid,GREY,"This business is already owned by someone");
		if(BID[playerid]>0)return SendClientMessage(playerid,GREY,"You already own a business");
		BID[playerid]=i;
       	format(Business[i][bOwner],24,"%s",PlayerName(playerid));
       	GivePlayerMoneyEx(playerid,-Business[i][bCost]);
		format(string,sizeof(string),"You've purchased the %s of Cost $%i",Business[i][bName],Business[i][bCost]);
		SendClientMessage(playerid,YELLOW,string);
		format(string,sizeof(string),"You will receive a payout of $%i from your business",Business[i][bProfit]);
		SendClientMessage(playerid,-1,string);
		if(PlayerAwards[playerid][Buss]==0)
		{
		    PlayerAwards[playerid][Buss]=1;
		    GivePlayerMoneyEx(playerid,1000);
			GamerScore[playerid]=GamerScore[playerid]+60;
		    SendClientMessage(playerid,YELLOW,"Achievement Unlocked: {FFFFFF}I Am Involved In One!");
  			SendClientMessage(playerid,LGREEN,"BONUS: $1000 || +60 Gamer Score");
		}
		format(string,sizeof(string),"~r~-$%i",Business[i][bCost]);
		GameTextForPlayer(playerid,string,800,1);
        return 1;
    }
    return 1;
}
//==============================================================================
CMD:sellbus(playerid,params[])
{
	if(IsJailedOrMuted(playerid))return 1;
    for (new i=1;i<BusinessCount+1;i++)
    {
        if(!IsPlayerInRangeOfPoint(playerid,1.0,Business[i][bX],Business[i][bY],Business[i][bZ]))continue;
		if(strcmp(Business[i][bOwner],"None")==0) return SendClientMessage(playerid,GREY,"This business isn't owned by anyone");
 		if(strcmp(Business[i][bOwner],PlayerName(playerid)) !=0) return SendClientMessage(playerid,GREY,"You aren't the owner of this business");
       	BID[playerid]=0;
       	new string[100];
       	format(Business[i][bOwner],24,"None");
       	Bank[playerid]=Bank[playerid]+Business[i][bCost];
		format(string,sizeof(string),"You've sold %s of cost $%i,the money has been sent to your bank account",Business[i][bName],Business[i][bCost]);
		SendClientMessage(playerid,YELLOW,string);
		format(string,sizeof(string),"~g~+$%i",Business[i][bCost]);
		GameTextForPlayer(playerid,string,800,1);
 		return 1;
    }
    return 1;
}
//==============================================================================
CMD:buyprop(playerid,params[])
{
	if(IsJailedOrMuted(playerid))return 1;
    for (new i=1;i<PropertyCount+1;i++)
    {
 		new string[100],labelstring[40];
		if(BankID[playerid]==0)return SendClientMessage(playerid,GREY,"You need a bank account");
        if(GetPlayerScore(playerid)<3)return SendClientMessage(playerid,GREY,"You need a score of atleast Level 3");
        if(!IsPlayerInRangeOfPoint(playerid,1.0,Property[i][prX],Property[i][prY],Property[i][prZ]))continue;
		if(PID[playerid]>0)return SendClientMessage(playerid,GREY,"You already own a property");
        if(GetPlayerMoneyEx(playerid) < Property[i][pCost]) return SendClientMessage(playerid,GREY,"You don't have enough money on you");
       	if(strcmp(Property[i][pOwner],"None") !=0) return SendClientMessage(playerid,GREY,"This property is already owned by someone");
		PID[playerid]=i;
		DestroyDynamicPickup(Property[i][pPickup]);
		DestroyDynamicMapIcon(Property[i][pMapicon]);
		DestroyDynamic3DTextLabel(Property[i][pLabel]);
       	GivePlayerMoneyEx(playerid,-Property[i][pCost]);
       	format(Property[i][pOwner],24,"%s",PlayerName(playerid));
		format(string,sizeof(string),"~r~-$%i",Property[i][pCost]);
		GameTextForPlayer(playerid,string,800,1);
		format(labelstring,sizeof(labelstring),"Owner: %s",Property[i][pOwner]);
		Property[i][pPickup]=CreateDynamicPickup(1272,1,Property[i][prX],Property[i][prY],Property[i][prZ],-1);
		Property[i][pLabel]=CreateDynamic3DTextLabel(labelstring,0xFFFFFFFF,Property[i][prX],Property[i][prY],Property[i][prZ],6.0);
		format(string,sizeof(string),"You've purchased this property of Cost $%i",Property[i][pCost]);
		SendClientMessage(playerid,YELLOW,string);
		if(PlayerAwards[playerid][House]==0)
		{
		    PlayerAwards[playerid][House]=1;
		    GivePlayerMoneyEx(playerid,2500);
			GamerScore[playerid]=GamerScore[playerid]+70;
		    SendClientMessage(playerid,YELLOW,"Achievement Unlocked: {FFFFFF}Home Sweet Home!");
  			SendClientMessage(playerid,LGREEN,"BONUS: $2500 || +70 Gamer Score");
		}
        return 1;
    }
    return 1;
}
//==============================================================================
CMD:sellprop(playerid,params[])
{
	if(IsJailedOrMuted(playerid))return 1;
    for (new i=1;i<PropertyCount+1;i++)
    {
       	new string[100],labelstring[40];
        if(!IsPlayerInRangeOfPoint(playerid,1.0,Property[i][prX],Property[i][prY],Property[i][prZ]))continue;
		if(strcmp(Property[i][pOwner],"None")==0) return SendClientMessage(playerid,GREY,"This property isn't owned by anyone");
 		if(strcmp(Property[i][pOwner],PlayerName(playerid)) !=0) return SendClientMessage(playerid,GREY,"You aren't the owner of this property");
       	PID[playerid]=0;
       	format(Property[i][pOwner],24,"None");
		DestroyDynamicPickup(Property[i][pPickup]);
		DestroyDynamicMapIcon(Property[i][pMapicon]);
		DestroyDynamic3DTextLabel(Property[i][pLabel]);
       	GivePlayerMoneyEx(playerid,Property[i][pCost]);
		format(string,sizeof(string),"~g~+$%i",Property[i][pCost]);
		GameTextForPlayer(playerid,string,800,1);
		format(string,sizeof(string),"You've sold this property of cost $%i",Property[i][pCost]);
		SendClientMessage(playerid,YELLOW,string);
		format(labelstring,sizeof(labelstring),"$%i",Property[i][pCost]);
		Property[i][pPickup]=CreateDynamicPickup(1273,1,Property[i][prX],Property[i][prY],Property[i][prZ],-1);
		Property[i][pMapicon]=CreateDynamicMapIcon(Property[i][prX],Property[i][prY],Property[i][prZ],31,0,-1,-1,-1,250.0);
		Property[i][pLabel]=CreateDynamic3DTextLabel(labelstring,0xFFFFFFFF,Property[i][prX],Property[i][prY],Property[i][prZ],6.0);
 		return 1;
    }
    return 1;
}
//==============================================================================
CMD:saveweapon(playerid,params[])
{
	if(IsJailedOrMuted(playerid))return 1;
    for (new i=1;i<PropertyCount+1;i++)
    {
    	new wname[40],string[128];
		if(!IsPlayerInRangeOfPoint(playerid,3.0,Property[i][prX],Property[i][prY],Property[i][prZ]))continue;
 		if(strcmp(Property[i][pOwner],PlayerName(playerid)) !=0) return SendClientMessage(playerid,GREY,"You aren't the owner of this property");
    	if(GetPlayerWeapon(playerid)==0) return SendClientMessage(playerid,GREY,"You don't have any armed weapon");
  		if(SavedWeaps[playerid][0]==0&&SavedAmmos[playerid][0]==0)
  		{
		  	SavedAmmos[playerid][0]=GetPlayerAmmo(playerid);
		  	SavedWeaps[playerid][0]=GetPlayerWeapon(playerid);
    		SetPlayerAmmo(playerid,GetPlayerWeapon(playerid),0);
			GetWeaponName(GetPlayerWeapon(playerid),wname,sizeof(wname));
 			format(string,sizeof(string),"You have saved %s (%d Ammos) in your property",wname,GetPlayerAmmo(playerid));
  			SendClientMessage(playerid,YELLOW,string);
  		}
  		else if(SavedWeaps[playerid][1]==0&&SavedAmmos[playerid][1]==0)
  		{
		  	SavedAmmos[playerid][1]=GetPlayerAmmo(playerid);
		  	SavedWeaps[playerid][1]=GetPlayerWeapon(playerid);
    		SetPlayerAmmo(playerid,GetPlayerWeapon(playerid),0);
			GetWeaponName(GetPlayerWeapon(playerid),wname,sizeof(wname));
 			format(string,sizeof(string),"You have saved %s (%d Ammos) in your property",wname,GetPlayerAmmo(playerid));
  			SendClientMessage(playerid,YELLOW,string);
  		}
  		else if(SavedWeaps[playerid][2]==0&&SavedAmmos[playerid][2]==0)
  		{
		  	SavedAmmos[playerid][2]=GetPlayerAmmo(playerid);
		  	SavedWeaps[playerid][2]=GetPlayerWeapon(playerid);
    		SetPlayerAmmo(playerid,GetPlayerWeapon(playerid),0);
			GetWeaponName(GetPlayerWeapon(playerid),wname,sizeof(wname));
 			format(string,sizeof(string),"You have saved %s (%d Ammos) in your property",wname,GetPlayerAmmo(playerid));
  			SendClientMessage(playerid,YELLOW,string);
  		}
  		else if(SavedWeaps[playerid][3]==0&&SavedAmmos[playerid][3]==0)
  		{
		  	SavedAmmos[playerid][3]=GetPlayerAmmo(playerid);
		  	SavedWeaps[playerid][3]=GetPlayerWeapon(playerid);
    		SetPlayerAmmo(playerid,GetPlayerWeapon(playerid),0);
			GetWeaponName(GetPlayerWeapon(playerid),wname,sizeof(wname));
 			format(string,sizeof(string),"You have saved %s (%d Ammos) in your property",wname,GetPlayerAmmo(playerid));
  			SendClientMessage(playerid,YELLOW,string);
  		}
  		else if(SavedWeaps[playerid][4]==0&&SavedAmmos[playerid][4]==0)
  		{
		  	SavedAmmos[playerid][4]=GetPlayerAmmo(playerid);
		  	SavedWeaps[playerid][4]=GetPlayerWeapon(playerid);
    		SetPlayerAmmo(playerid,GetPlayerWeapon(playerid),0);
			GetWeaponName(GetPlayerWeapon(playerid),wname,sizeof(wname));
 			format(string,sizeof(string),"You have saved %s (%d Ammos) in your property",wname,GetPlayerAmmo(playerid));
  			SendClientMessage(playerid,YELLOW,string);
  		}else return SendClientMessage(playerid,GREY,"No empty slots found");
	}
	return 1;
}
//==============================================================================
CMD:getweapon(playerid,params[])
{
	if(IsJailedOrMuted(playerid))return 1;
	for (new i=1;i<PropertyCount+1;i++)
    {
    	new slot;
		if(!IsPlayerInRangeOfPoint(playerid,3.0,Property[i][prX],Property[i][prY],Property[i][prZ]))continue;
 		if(strcmp(Property[i][pOwner],PlayerName(playerid)) !=0) return SendClientMessage(playerid,GREY,"You aren't the owner of this property");
		if(sscanf(params,"i",slot)) return SendClientMessage(playerid,GREY,"USAGE: /getweapon [slot 1-5]");
  		if(slot==1)
  		{
  			if(SavedWeaps[playerid][0]==0)return SendClientMessage(playerid,GREY,"There is no weapon in that slot");
    		GivePlayerWeaponEx(playerid,SavedWeaps[playerid][0],SavedAmmos[playerid][0]);
		  	SavedAmmos[playerid][0]=0;
		  	SavedWeaps[playerid][0]=0;
		}
  		if(slot==2)
  		{
  			if(SavedWeaps[playerid][1]==0)return SendClientMessage(playerid,GREY,"There is no weapon in that slot");
    		GivePlayerWeaponEx(playerid,SavedWeaps[playerid][1],SavedAmmos[playerid][1]);
		  	SavedAmmos[playerid][1]=0;
		  	SavedWeaps[playerid][1]=0;
		}
  		if(slot==3)
  		{
  			if(SavedWeaps[playerid][2]==0)return SendClientMessage(playerid,GREY,"There is no weapon in that slot");
    		GivePlayerWeaponEx(playerid,SavedWeaps[playerid][2],SavedAmmos[playerid][2]);
		  	SavedAmmos[playerid][2]=0;
		  	SavedWeaps[playerid][2]=0;
		}
  		if(slot==4)
  		{
  			if(SavedWeaps[playerid][3]==0)return SendClientMessage(playerid,GREY,"There is no weapon in that slot");
    		GivePlayerWeaponEx(playerid,SavedWeaps[playerid][3],SavedAmmos[playerid][3]);
		  	SavedAmmos[playerid][3]=0;
		  	SavedWeaps[playerid][3]=0;
		}
  		if(slot==5)
  		{
  			if(SavedWeaps[playerid][4]==0)return SendClientMessage(playerid,GREY,"There is no weapon in that slot");
    		GivePlayerWeaponEx(playerid,SavedWeaps[playerid][4],SavedAmmos[playerid][4]);
		  	SavedAmmos[playerid][4]=0;
		  	SavedWeaps[playerid][4]=0;
		}
	}
    return 1;
}
//==============================================================================
CMD:weapons(playerid,params[])
{
	if(IsJailedOrMuted(playerid))return 1;
    for (new i=1;i<PropertyCount+1;i++)
    {
    	new wname[40],str[128],count=0;
		if(!IsPlayerInRangeOfPoint(playerid,3.0,Property[i][prX],Property[i][prY],Property[i][prZ]))continue;
 		if(strcmp(Property[i][pOwner],PlayerName(playerid)) !=0) return SendClientMessage(playerid,GREY,"You aren't the owner of this property");
 		SendClientMessage(playerid,-1,"Weapons saved in your property:");
  		if(SavedWeaps[playerid][0]!=0&&SavedAmmos[playerid][0]!=0)
  		{
  		    count++;
  		    GetWeaponName(SavedWeaps[playerid][0],wname,sizeof(wname));
  			format(str,128,"(Slot:1) %s (Ammos: %d)",wname,SavedAmmos[playerid][0]);
 			SendClientMessage(playerid,GREEN,str);
  		}
  		if(SavedWeaps[playerid][1]!=0&&SavedAmmos[playerid][1]!=0)
  		{
  		    count++;
  		    GetWeaponName(SavedWeaps[playerid][1],wname,sizeof(wname));
  			format(str,128,"(Slot:2) %s (Ammos: %d)",wname,SavedAmmos[playerid][1]);
 			SendClientMessage(playerid,GREEN,str);
  		}
  		if(SavedWeaps[playerid][2]!=0&&SavedAmmos[playerid][2]!=0)
  		{
  		    count++;
  		    GetWeaponName(SavedWeaps[playerid][2],wname,sizeof(wname));
  			format(str,128,"(Slot:3) %s (Ammos: %d)",wname,SavedAmmos[playerid][2]);
 			SendClientMessage(playerid,GREEN,str);
  		}
  		if(SavedWeaps[playerid][3]!=0&&SavedAmmos[playerid][3]!=0)
  		{
  		    count++;
  		    GetWeaponName(SavedWeaps[playerid][3],wname,sizeof(wname));
  			format(str,128,"(Slot:4) %s (Ammos: %d)",wname,SavedAmmos[playerid][3]);
 			SendClientMessage(playerid,GREEN,str);
  		}
  		if(SavedWeaps[playerid][4]!=0&&SavedAmmos[playerid][4]!=0)
  		{
  		    count++;
  		    GetWeaponName(SavedWeaps[playerid][4],wname,sizeof(wname));
  			format(str,128,"(Slot:5) %s (Ammos: %d)",wname,SavedAmmos[playerid][4]);
 			SendClientMessage(playerid,GREEN,str);
  		}
  		if(count==0)return SendClientMessage(playerid,GREY,"No weapons found");
	}
	return 1;
}
//==============================================================================
CMD:offer(playerid,params[])
{
	new id,demand,str[128],veh[40];
	if(IsJailedOrMuted(playerid))return 1;
    if(sscanf(params,"ui",id,demand)) return SendClientMessage(playerid,GREY,"USAGE: /offer [playerid] [amount]");
	if(!IsPlayerConnectedEx(id))return SendClientMessage(playerid,GREY,"Invalid player ID");
	if(GetPVarInt(playerid,"offered")!=-1)SendClientMessage(playerid,GREY,"You have already offered someone your personal car");
	if(GetPVarInt(id,"offered")!=-1)SendClientMessage(playerid,GREY,"The player has been already offered by someone else");
	if(Car[playerid]==0)return SendClientMessage(playerid,GREY,"You have no personal vehicle");
	if(Car[id]>0)return SendClientMessage(playerid,GREY,"That player already owns a personal vehicle");
	if(GetPlayerMoneyEx(id)<=0)return SendClientMessage(playerid,GREY,"That player doesn't have enough cash on him");
	GetVehicleName(Car[playerid],veh,40);
	format(str,128,"%s has offered you his %s for $%d",PlayerName(playerid),veh,demand);
	SendClientMessage(id,YELLOW,str);
	format(str,128,"You have offered %s for your %s for $%d",PlayerName(id),veh,demand);
	SendClientMessage(playerid,YELLOW,str);
	SetPVarInt(playerid,"offered",id);
	SetPVarInt(id,"offered",playerid);
	return 1;
}
//==============================================================================
CMD:canceloffer(playerid,params[])
{
	if(IsJailedOrMuted(playerid))return 1;
	if(GetPVarInt(playerid,"offered")==-1)return SendClientMessage(playerid,GREY,"You've not offered anyone you car");
	SendClientMessage(GetPVarInt(playerid,"offered"),-1,"The player has cancelled offering you his car");
	SendClientMessage(playerid,-1,"You have canceled the offer to sell your car to that player");
	SetPVarInt(GetPVarInt(playerid,"offered"),"offered",-1);
	SetPVarInt(playerid,"offered",-1);
	return 1;
}
//==============================================================================
CMD:rejectoffer(playerid,params[])
{
	if(IsJailedOrMuted(playerid))return 1;
	if(GetPVarInt(playerid,"offered")==-1)return SendClientMessage(playerid,GREY,"No one has offered you their car");
	SendClientMessage(playerid,-1,"You have rejected the offer of that player to purchase his car");
	SendClientMessage(GetPVarInt(playerid,"offered"),-1,"The player has rejected your offer");
	SetPVarInt(GetPVarInt(playerid,"offered"),"offered",-1);
	SetPVarInt(playerid,"offered",-1);
	return 1;
}
//==============================================================================
CMD:acceptoffer(playerid,params[])
{
	if(IsJailedOrMuted(playerid))return 1;
	new Float:x,Float:y,Float:z,Float:r,string[128],vname[40];
	if(GetPVarInt(playerid,"offered")==-1)return SendClientMessage(playerid,GREY,"No one has offered you their car");
 	GetVehicleZAngle(Car[GetPVarInt(playerid,"offered")],r);
	GetVehiclePos(Car[GetPVarInt(playerid,"offered")],x,y,z);
	Car[playerid]=AddStaticVehicleEx(Car[GetPVarInt(playerid,"offered")],x,y,z,r,CarColor1[GetPVarInt(playerid,"offered")],CarColor2[GetPVarInt(playerid,"offered")],-1);
	AddVehicleComponent(Car[playerid],GetVehicleComponentInSlot(Car[GetPVarInt(playerid,"offered")],CARMODTYPE_SPOILER));
	AddVehicleComponent(Car[playerid],GetVehicleComponentInSlot(Car[GetPVarInt(playerid,"offered")],CARMODTYPE_HOOD));
	AddVehicleComponent(Car[playerid],GetVehicleComponentInSlot(Car[GetPVarInt(playerid,"offered")],CARMODTYPE_ROOF));
	AddVehicleComponent(Car[playerid],GetVehicleComponentInSlot(Car[GetPVarInt(playerid,"offered")],CARMODTYPE_SIDESKIRT));
	AddVehicleComponent(Car[playerid],GetVehicleComponentInSlot(Car[GetPVarInt(playerid,"offered")],CARMODTYPE_EXHAUST));
	AddVehicleComponent(Car[playerid],GetVehicleComponentInSlot(Car[GetPVarInt(playerid,"offered")],CARMODTYPE_WHEELS));
	AddVehicleComponent(Car[playerid],GetVehicleComponentInSlot(Car[GetPVarInt(playerid,"offered")],CARMODTYPE_HYDRAULICS));
	AddVehicleComponent(Car[playerid],GetVehicleComponentInSlot(Car[GetPVarInt(playerid,"offered")],CARMODTYPE_FRONT_BUMPER));
	AddVehicleComponent(Car[playerid],GetVehicleComponentInSlot(Car[GetPVarInt(playerid,"offered")],CARMODTYPE_REAR_BUMPER));
	AddVehicleComponent(Car[playerid],GetVehicleComponentInSlot(Car[GetPVarInt(playerid,"offered")],CARMODTYPE_LAMPS));
	AddVehicleComponent(Car[playerid],GetVehicleComponentInSlot(Car[GetPVarInt(playerid,"offered")],CARMODTYPE_NITRO));
	AddVehicleComponent(Car[playerid],GetVehicleComponentInSlot(Car[GetPVarInt(playerid,"offered")],CARMODTYPE_VENT_RIGHT));
	AddVehicleComponent(Car[playerid],GetVehicleComponentInSlot(Car[GetPVarInt(playerid,"offered")],CARMODTYPE_VENT_LEFT));
	ChangeVehiclePaintjob(Car[playerid],CarPaint[GetPVarInt(playerid,"offered")]);
	DestroyVehicle(Car[GetPVarInt(playerid,"offered")]);
	Car[GetPVarInt(playerid,"offered")]=0;
	Lock[GetPVarInt(playerid,"offered")]=0;
	Alarm[GetPVarInt(playerid,"offered")]=0;
	Insurance[GetPVarInt(playerid,"offered")]=0;
	GetVehicleName(playerid,vname,40);
	format(string,sizeof(string),"You sold your %s to %s",vname,PlayerName(playerid));
	SendClientMessage(GetPVarInt(playerid,"offered"),YELLOW,string);
	format(string,sizeof(string),"You accepted the offer of %s for buying his %s",PlayerName(GetPVarInt(playerid,"offered")),vname);
	SendClientMessage(playerid,YELLOW,string);
	SetPVarInt(GetPVarInt(playerid,"offered"),"offered",-1);
	SetPVarInt(playerid,"offered",-1);
	return 1;
}
//==============================================================================
CMD:tazer(playerid,params[])
{
	if(PlayerOrgType(playerid)==LAW)
	{
		if(IsJailedOrMuted(playerid))return 1;
	    if(IsPlayerInAnyVehicle(playerid))return SendClientMessage(playerid,GREY,"Doesn't work in a vehicle");
        if(Suited[playerid]==0)return SendClientMessage(playerid,GREY,"You can perform organization commands only while suited up");
	    if(Tazer[playerid]==0)
	    {
	        Tazer[playerid]=1;
			SendClientMessage(playerid,-1,"You have equiped a tazer");
			SetPlayerAttachedObject(playerid,6,18642,6,0.06,0.01,0.08,180.0,0.0,0.0);
	    }
		else if(Tazer[playerid]==1)
	    {
	        Tazer[playerid]=0;
			RemovePlayerAttachedObject(playerid,6);
			SendClientMessage(playerid,-1,"You have holstered the tazer");
	    }
	}else return SendClientMessage(playerid,GREY,"You are not a police officer");
	return 1;
}
//==============================================================================
CMD:getdrunk(playerid,params[])
{
	if(IsJailedOrMuted(playerid))return 1;
	new id,string[128],Float:x,Float:y,Float:z;
    if(sscanf(params,"u",id)) return SendClientMessage(playerid,GREY,"USAGE: /getdrunk [playerid]");
	if(PlayerOrgType(playerid) !=LAW)return SendClientMessage(playerid,GREY,"You are not a police officer");
 	if(Suited[playerid]==0)return SendClientMessage(playerid,GREY,"You can perform organization commands only while suited up");
	if(!IsPlayerConnectedEx(id))return SendClientMessage(playerid,GREY,"Invalid player ID");
	GetPlayerPos(id,x,y,z);
	if(IsPlayerInRangeOfPoint(playerid,5.0,x,y,z))
	{
  		if(GetPlayerDrunkLevel(playerid)<100)
		{
		    format(string,sizeof(string),"You have tested the drunk level of %s and he is sober",PlayerName(id));
		}
		if(GetPlayerDrunkLevel(playerid)>100&&GetPlayerDrunkLevel(playerid)<3000)
		{
		    format(string,sizeof(string),"You have tested the drunk level of %s and he is slightly drunk",PlayerName(id));
		}
		if(GetPlayerDrunkLevel(playerid)>3500)
		{
		    format(string,sizeof(string),"You have tested the drunk level of %s and he is drunk",PlayerName(id));
		}
		if(GetPlayerDrunkLevel(playerid)>5000)
		{
		    format(string,sizeof(string),"You have tested the drunk level of %s and he is heavily drunk",PlayerName(id));
		}
		SendClientMessage(playerid,LRED,string);
		format(string,sizeof(string),"Officer %s has tested your alcohol level",PlayerName(playerid));
		SendClientMessage(id,LRED,string);
	}else return SendClientMessage(playerid,GREY,"The player needs to be near to you");
	return 1;
}
//==============================================================================
CMD:fuck(playerid,params[])
{
	new id,string[128];
	if(IsMuted(playerid))return 1;
	if(AdminLevel[playerid]<3)return 0;
    if(sscanf(params,"u",id)) return SendClientMessage(playerid,GREY,"USAGE: /fuck [playerid]");
	if(!IsPlayerConnectedEx(id))return SendClientMessage(playerid,GREY,"Invalid player ID");
	format(string,sizeof(string),"You have fucked up %s by setting his drunk level to max",PlayerName(id));
	SendClientMessage(playerid,YELLOW,string);
	SendClientMessage(id,LRED,"You have been fucked up");
	SetPlayerDrunkLevel(id,200000);
	return 1;
}
//==============================================================================
CMD:ajail(playerid,params[])
{
	if(IsMuted(playerid))return 1;
    if(AdminLevel[playerid]> 2)
	{
        new player1,string[128],minutes;
        if (sscanf(params,"ui",player1,minutes)) return SendClientMessage(playerid,GREY,"USAGE: /ajail [playerid] [minutes]");
        if(minutes<1||minutes>100)return SendClientMessage(playerid,GREY,"Time period cannot be less than one or greater than 100");
        if(!IsPlayerConnectedEx(player1)||player1==playerid)return SendClientMessage(playerid,GREY,"Invalid player ID");
        if(Jailed[player1]>0)return SendClientMessage(playerid,GREY,"That player is already jailed");
        if(IsPlayerConnectedEx(player1)) {
			Jailed[player1]=minutes;
            SetPlayerSkin(player1,177);
    		SetPlayerInterior(player1,6);
			TogglePlayerControllable(player1,0);
			SetPlayerFacingAngle(player1,266.9391);
    		SetPlayerPos(player1,263.7495,77.5508,1001.0391);
            format(string,sizeof(string),"You have jailed %s for %d minutes",PlayerName(player1),minutes);
            SendClientMessage(playerid,LRED,string);
            SendClientMessage(player1,LRED,"You have been jailed by an Administrator");
        }
        else return SendClientMessage(playerid,GREY,"Invalid player ID");
    }else return 0;
    return 1;
}
//==============================================================================
CMD:aunjail(playerid,params[])
{
	if(IsMuted(playerid))return 1;
    if(AdminLevel[playerid]> 2) {
        new player1,string[128];
        if (sscanf(params,"u",player1)) return SendClientMessage(playerid,GREY,"USAGE: /aunjail [playerid]");
        if(Jailed[player1]==0)return SendClientMessage(playerid,GREY,"That player is already unjailed");
        if(!IsPlayerConnectedEx(player1)||player1==playerid)return SendClientMessage(playerid,GREY,"Invalid player ID");
        if(IsPlayerConnectedEx(player1)) {
            UnCagePlayer(player1);
			TogglePlayerControllable(player1,1);
            format(string,sizeof(string),"You have unjailed %s",PlayerName(player1));
            SendClientMessage(playerid,YELLOW,string);
            SendClientMessage(player1,YELLOW,"You have been unjailed by an Administrator");
        }
        else return SendClientMessage(playerid,GREY,"Invalid player ID");
    }else return 0;
    return 1;
}
//==============================================================================
CMD:getweaps(playerid,params[])
{
	if(IsMuted(playerid))return 1;
    if(AdminLevel[playerid]> 0)
	{
        new id,string[128],ammo,weaponid,weapon[24],count=0;
        if (sscanf(params,"u",id)) return SendClientMessage(playerid,GREY,"USAGE: /getweaps [playerid]");
        if(IsPlayerConnectedEx(id))
		{
            for (new c=0; c < 13; c++)
            {
            	GetPlayerWeaponData(id,c,weaponid,ammo);
             	if (weaponid !=0 && ammo !=0)
              	{
               		count++;
               	}
			}
   			if(count > 0)
      		{
        		for (new c=0; c < 13; c++)
          		{
            		GetPlayerWeaponData(id,c,weaponid,ammo);
              		if (weaponid !=0 && ammo !=0)
                	{
                 		GetWeaponName(weaponid,weapon,24);
                   		format(string,sizeof(string),"Weapons: %s  Ammo: %d",weapon,ammo);
                   		SendClientMessage(playerid,-1,string);
                   	}
              	}
        	}
			else
   			{
      			SendClientMessage(playerid,GREY,"Player has no weapons!");
         	}
		}else return SendClientMessage(playerid,GREY,"Invalid player ID");
    }else return 0;
    return 1;
}
//==============================================================================
CMD:teletohq(playerid,params[])
{
	new id;
	if(IsJailedOrMuted(playerid))return 1;
	if(AdminLevel[playerid]<3)return 0;
 	if (sscanf(params,"i",id)) return SendClientMessage(playerid,GREY,"USAGE: /teletohq [orgid]");
	if(id<1||id>OrgsCount)return SendClientMessage(playerid,GREY,"Invalid Organization ID");
	if(IsPlayerInRangeOfPoint(playerid,5.0,Organization[id][OrgX],Organization[id][OrgY],Organization[id][OrgZ]))
	return SendClientMessage(playerid,GREY,"You are already near to the organization HQ");
	SetPlayerInterior(playerid,Organization[id][Interior]);
	SetPlayerPos(playerid,Organization[id][OrgX],Organization[id][OrgY],Organization[id][OrgZ]);
	return 1;
}
//==============================================================================
CMD:ignore(playerid,params[])
{
	new id,string[128];
	if(IsMuted(playerid))return 1;
 	if (sscanf(params,"u",id)) return SendClientMessage(playerid,GREY,"USAGE: /ignore [playerid]");
	if(!IsPlayerConnectedEx(id)||id==playerid)return SendClientMessage(playerid,GREY,"Invalid player ID");
	if(Ignore[playerid][id]==1)return SendClientMessage(playerid,GREY,"You have already ignored that player");
	if(AdminLevel[id]>0)return SendClientMessage(playerid,GREY,"You can't ignore an admin");
 	format(string,128,"You have ignored %s",PlayerName(id));
  	SendClientMessage(playerid,YELLOW,string);
	Ignore[playerid][id]=1;
  	return 1;
}
//==============================================================================
CMD:unignore(playerid,params[])
{
	new id,string[128];
	if(IsMuted(playerid))return 1;
 	if (sscanf(params,"u",id)) return SendClientMessage(playerid,GREY,"USAGE: /unignore [playerid]");
	if(!IsPlayerConnectedEx(id))return SendClientMessage(playerid,GREY,"Invalid player ID");
	if(Ignore[playerid][id]==0)return SendClientMessage(playerid,GREY,"You haven't ignored that player");
 	format(string,128,"You have unignored %s",PlayerName(id));
  	SendClientMessage(playerid,YELLOW,string);
	Ignore[playerid][id]=0;
  	return 1;
}
//==============================================================================
CMD:ignorelist(playerid,params[])
{
	new string[128];
	if(IsMuted(playerid))return 1;
  	for(new i=0; i<MAX_PLAYERS; i++)
   	{
  		if(Ignore[playerid][i]==1)
  		{
      		format(string,sizeof(string),"* %s (%d)",PlayerName(i),i);
      		SendClientMessage(playerid,YELLOW,string);
        	return 1;
  		}
    	else
   		{
     		SendClientMessage(playerid,GREY,"You haven't ignored anybody");
       		return 1;
       	}
   	}
  	return 1;
}
//==============================================================================
CMD:removeturf(playerid,params[])
{
	new ID=PlayerOrg[playerid],str[128];
	if(IsJailedOrMuted(playerid))return 1;
	if(PlayerOrgType(playerid)==MAFIA||PlayerOrgType(playerid)==GANG)
	{
		if(PlayerLeader[playerid]==0)return SendClientMessage(playerid,GREY,"You aren't an org leader");
		if(GetPlayerInterior(playerid)!=0)return SendClientMessage(playerid,GREY,"You cannot set interiors as your turf");
		if(Suited[playerid]==0)return SendClientMessage(playerid,GREY,"You can perform organization commands only while suited up");
		if(IsPlayerInZone(playerid,Organization[ID][Turf]))
		{
			for (new a=1;a<Organization[ID][ZoneCreated]+1;a++)
			{
				GangZoneDestroy(Organization[ID][OrgZones][a]);
				GangZoneHideForAll(Organization[ID][OrgZones][a]);
			}
			format(str,128,"%s has removed %s as their territory",GetOrgName(ID),Organization[ID][Turf]);
			format(Organization[ID][Turf],50,"None");
			SendClientMessageToAll(LBLUE,str);
			Organization[ID][ZoneCreated]=0;
		}else return SendClientMessage(playerid,GREY,"This is not your turf");
	}else return SendClientMessage(playerid,GREY,"You are not a gangmember");
	return 1;
}
//==============================================================================
CMD:takeover(playerid,params[])
{
	new ID=PlayerOrg[playerid],str[128];
	if(IsJailedOrMuted(playerid))return 1;
	if(PlayerOrgType(playerid)==MAFIA||PlayerOrgType(playerid)==GANG)
	{
		if(PlayerLeader[playerid]==0)return SendClientMessage(playerid,GREY,"You aren't an org leader");
		if(GetPlayerInterior(playerid)!=0)return SendClientMessage(playerid,GREY,"You cannot set interiors as your turf");
		if(Suited[playerid]==0)return SendClientMessage(playerid,GREY,"You can perform organization commands only while suited up");
		if(strcmp(Organization[PlayerOrg[playerid]][Turf],"None") !=0)return SendClientMessage(playerid,GREY,"You cannot take over more than one turf");
		if(IsPlayerInZone(playerid,"Los Santos"))return SendClientMessage(playerid,GREY,"You cannot takeover the whole Los Santos");
		if(IsPlayerInZone(playerid,"San Fierro"))return SendClientMessage(playerid,GREY,"You cannot takeover the whole San Fierro");
		if(IsPlayerInZone(playerid,"Las Venturas"))return SendClientMessage(playerid,GREY,"You cannot takeover the whole Las Venturas");
		format(str,128,"%s has taken over %s as their territory",GetOrgName(ID),Organization[ID][Turf]);
		SendClientMessageToAll(LBLUE,str);
		SetOrgTurf(playerid);
	}else return SendClientMessage(playerid,GREY,"You are not a gangmember");
	return 1;
}
//==============================================================================
CMD:protectbus(playerid,params[])
{
	if(IsJailedOrMuted(playerid))return 1;
    for (new i=1;i<BusinessCount+1;i++)
    {
 		new string[100];
 		if(PlayerLeader[playerid]==0&&PlayerOrgType(playerid) !=MAFIA)return SendClientMessage(playerid,GREY,"You are not a gangleader");
        if(!IsPlayerInRangeOfPoint(playerid,1.0,Business[i][bX],Business[i][bY],Business[i][bZ]))continue;
        if(Suited[playerid]==0)return SendClientMessage(playerid,GREY,"You can perform organization commands only while suited up");
        if(Business[i][bProtected]>0)return SendClientMessage(playerid,GREY,"This business is already protected by a mafia");
		if(Organization[PlayerOrg[playerid]][Protection]>0)return SendClientMessage(playerid,GREY,"You already protect a business");
		Business[i][bProtected]=PlayerOrg[playerid];
		Organization[PlayerOrg[playerid]][Protection]=i;
		format(string,sizeof(string),"You've protected the business %s",Business[i][bName]);
		SendClientMessage(playerid,YELLOW,string);
        return 1;
    }
    return 1;
}
//==============================================================================
CMD:protection(playerid,params[])
{
    new string[100];
	if(IsJailedOrMuted(playerid))return 1;
	if(PlayerLeader[playerid]==0&&PlayerOrgType(playerid) !=MAFIA)return SendClientMessage(playerid,GREY,"You are not a gangleader");
	if(Suited[playerid]==0)return SendClientMessage(playerid,GREY,"You can perform organization commands only while suited up");
	if(Organization[PlayerOrg[playerid]][Protection]==0)return SendClientMessage(playerid,GREY,"You do not protect any business");
	format(string,sizeof(string),"You protect the business %s",Business[Organization[PlayerOrg[playerid]][Protection]][bName]);
	SendClientMessage(playerid,YELLOW,string);
    return 1;
}
//==============================================================================
CMD:removeprotection(playerid,params[])
{
	if(IsJailedOrMuted(playerid))return 1;
    for (new i=1;i<BusinessCount+1;i++)
    {
 		new string[100];
 		if(PlayerLeader[playerid]==0&&PlayerOrgType(playerid) !=MAFIA)return SendClientMessage(playerid,GREY,"You are not a gangleader");
        if(!IsPlayerInRangeOfPoint(playerid,1.0,Business[i][bX],Business[i][bY],Business[i][bZ]))continue;
        if(Business[i][bProtected]==0)return SendClientMessage(playerid,GREY,"This business isn't protected by anyone");
        if(Suited[playerid]==0)return SendClientMessage(playerid,GREY,"You can perform organization commands only while suited up");
		if(Organization[PlayerOrg[playerid]][Protection]==0)return SendClientMessage(playerid,GREY,"You donot protect any business");
		Business[i][bProtected]=0;
		Organization[PlayerOrg[playerid]][Protection]=0;
		format(string,sizeof(string),"You've removed your protection from the business %s",Business[i][bName]);
		SendClientMessage(playerid,YELLOW,string);
        return 1;
    }
    return 1;
}
//==============================================================================
CMD:registered(playerid,params[])
{
	new player1,str[128];
	if(IsMuted(playerid))return 1;
    if(AdminLevel[playerid]< 2)return 0;
 	if(sscanf(params,"u",player1)) return SendClientMessage(playerid,GREY,"USAGE: /registered [playerid]");
 	if(!IsPlayerConnectedEx(player1)||player1==playerid)return SendClientMessage(playerid,GREY,"Invalid player ID");
  	format(str,128,"%s had registered his account on %s",PlayerName(player1),INI_Get(Acc(player1),"Registered"));
	SendClientMessage(playerid,YELLOW,str);
	return 1;
}
//==============================================================================
CMD:awards(playerid,params)
{
	aid[playerid]=playerid;
	if(IsJailedOrMuted(playerid))return 1;
	if(IsPlayerConnectedEx(playerid))return OnPlayerClickPlayer(playerid,aid[playerid],1);
	return 1;
}
//==============================================================================
CMD:taketest(playerid,params)
{
	if(IsJailedOrMuted(playerid))return 1;
    if(IsPlayerInRangeOfPoint(playerid,2,1173.1650,1348.8018,10.9219))
    {
		License[playerid][StepB]=1;
		GivePlayerMoneyEx(playerid,-200);
		License[playerid][Vehicle]=AddStaticVehicleEx(461,1158.6492,1370.7532,10.6719,274.4697,-1,-1,-1);
		SetVehicleParamsEx(License[playerid][Vehicle],1,0,0,0,0,0,0);
		PutPlayerInVehicle(playerid,License[playerid][Vehicle],0);
		Time[playerid]=gettime()+60*2;
		GameTextForPlayer(playerid,"~r~-$200",1000,1);
	}
	if(IsPlayerInRangeOfPoint(playerid,2,415.4908,2533.2776,19.1484))
 	{
  		GivePlayerMoneyEx(playerid,-500);
		License[playerid][StepF]=1;
		Time[playerid]=gettime()+60*3;
		License[playerid][Vehicle]=AddStaticVehicleEx(511,402.8387,2506.3025,17.8582,86.0507,-1,-1,-1);
		SetVehicleParamsEx(License[playerid][Vehicle],1,0,0,0,0,0,0);
		PutPlayerInVehicle(playerid,License[playerid][Vehicle],0);
  		GameTextForPlayer(playerid,"~r~-$500",1000,1);
	}
	return 1;
}
//==============================================================================
CMD:boatlicense(playerid,params)
{
	if(IsJailedOrMuted(playerid))return 1;
    if(!IsPlayerInRangeOfPoint(playerid,2,-2186.9304,2414.8867,5.1563))return SendClientMessage(playerid,GREY,"You aren't near to the boat license school");
	if(GetPlayerScore(playerid)<1)return SendClientMessage(playerid,GREY,"You need to have a score of at least 1");
	if(GetPlayerMoneyEx(playerid)<25000)return SendClientMessage(playerid,GREY,"You don't have enough money on you");
	GivePlayerMoneyEx(playerid,-25000);
	BtL[playerid]=1;
	GameTextForPlayer(playerid,"~r~-$25000",1000,1);
	SendClientMessage(playerid,YELLOW,"You got your boating license");
	return 1;
}
//==============================================================================
CMD:uncuffme(playerid,params[])
{
	ClearAnimations(playerid);
	if(IsJailedOrMuted(playerid))return 1;
	if(IsPlayerAttachedObjectSlotUsed(playerid,5))
 	{
		RemovePlayerAttachedObject(playerid,5);
 	}
 	SetPlayerSpecialAction(playerid,SPECIAL_ACTION_NONE);
  	return 1;
}
//==============================================================================
CMD:chairsit(playerid,params[]){
	ClearAnimations(playerid);
	if(IsJailedOrMuted(playerid))return 1;
	if(GetPlayerState(playerid) !=PLAYER_STATE_DRIVER)return
 	ApplyPlayerAnimation(playerid,"BAR","dnk_stndF_loop",4.0,1,0,0,0,0);
  	return 1;
}
//==============================================================================
CMD:taichi(playerid,params[]){
	ClearAnimations(playerid);
	if(IsJailedOrMuted(playerid))return 1;
	if(GetPlayerState(playerid) !=PLAYER_STATE_DRIVER)return
	ApplyPlayerAnimation(playerid,"PARK","Tai_Chi_Loop",4.0,1,0,0,0,0);
   	return 1;
}
//==============================================================================
CMD:handsup(playerid,params[]) {
	ClearAnimations(playerid);
	if(IsJailedOrMuted(playerid))return 1;
	if(GetPlayerState(playerid) !=PLAYER_STATE_DRIVER)return
	SetPlayerSpecialAction(playerid,SPECIAL_ACTION_HANDSUP);
  	return 1;
}
//==============================================================================
CMD:cellin(playerid,params[]) {
	ClearAnimations(playerid);
	if(IsJailedOrMuted(playerid))return 1;
	if(GetPlayerState(playerid) !=PLAYER_STATE_DRIVER)return
	SetPlayerSpecialAction(playerid,SPECIAL_ACTION_USECELLPHONE);
  	return 1;
}
//==============================================================================
CMD:cellout(playerid,params[]) {
	ClearAnimations(playerid);
	if(IsJailedOrMuted(playerid))return 1;
	if(GetPlayerState(playerid) !=PLAYER_STATE_DRIVER)return
	SetPlayerSpecialAction(playerid,SPECIAL_ACTION_STOPUSECELLPHONE);
 	return 1;
}
//==============================================================================
CMD:drunk(playerid,params[]) {
	ClearAnimations(playerid);
	if(IsJailedOrMuted(playerid))return 1;
	if(GetPlayerState(playerid) !=PLAYER_STATE_DRIVER)return
	ApplyPlayerAnimation(playerid,"PED","WALK_DRUNK",4.0,1,1,1,1,0);
	return 1;
}
//==============================================================================
CMD:bomb(playerid,params[]){
	if(IsJailedOrMuted(playerid))return 1;
	if(GetPlayerState(playerid) !=PLAYER_STATE_DRIVER)
	ClearAnimations(playerid);
	ApplyPlayerAnimation(playerid,"BOMBER","BOM_Plant",4.0,0,0,0,0,0);
	return 1;
}
//==============================================================================
CMD:getarrested(playerid,params[]){
	ClearAnimations(playerid);
	if(IsJailedOrMuted(playerid))return 1;
	if(GetPlayerState(playerid) !=PLAYER_STATE_DRIVER)return
 	ApplyPlayerAnimation(playerid,"ped","ARRESTgun",4.0,0,1,1,1,-1);
  	return 1;
}
//==============================================================================
CMD:laugh(playerid,params[]){
	ClearAnimations(playerid);
	if(IsJailedOrMuted(playerid))return 1;
	if(GetPlayerState(playerid) !=PLAYER_STATE_DRIVER)return
 	ApplyPlayerAnimation(playerid,"RAPPING","Laugh_01",4.0,0,0,0,0,0);
  	return 1;
}
//==============================================================================
CMD:lookout(playerid,params[]){
	ClearAnimations(playerid);
	if(IsJailedOrMuted(playerid))return 1;
	if(GetPlayerState(playerid) !=PLAYER_STATE_DRIVER)return
 	ApplyPlayerAnimation(playerid,"SHOP","ROB_Shifty",4.0,0,0,0,0,0);
  	return 1;
}
//==============================================================================
CMD:robman(playerid,params[]){
	ClearAnimations(playerid);
	if(IsJailedOrMuted(playerid))return 1;
	if(GetPlayerState(playerid) !=PLAYER_STATE_DRIVER)return
 	ApplyPlayerAnimation(playerid,"SHOP","ROB_Loop_Threat",4.0,1,0,0,0,0);
  	return 1;
}
//==============================================================================
CMD:crossarms(playerid,params[]){
	ClearAnimations(playerid);
	if(IsJailedOrMuted(playerid))return 1;
	if(GetPlayerState(playerid) !=PLAYER_STATE_DRIVER)return
 	ApplyPlayerAnimation(playerid,"COP_AMBIENT","Coplook_loop",4.0,0,1,1,1,-1);
  	return 1;
}
//==============================================================================
CMD:lay(playerid,params[]) {
	ClearAnimations(playerid);
	if(IsJailedOrMuted(playerid))return 1;
	if(GetPlayerState(playerid) !=PLAYER_STATE_DRIVER)return
	ApplyPlayerAnimation(playerid,"BEACH","bather",4.0,1,0,0,0,0);
 	return 1;
}
//==============================================================================
CMD:hi(playerid,params[]) {
	ClearAnimations(playerid);
	if(IsJailedOrMuted(playerid))return 1;
	if(GetPlayerState(playerid) !=PLAYER_STATE_DRIVER)return
 	ApplyPlayerAnimation(playerid,"ped","cower",3.0,1,0,0,0,0);
  	return 1;
}
//==============================================================================
CMD:vomit(playerid,params[]){
	ClearAnimations(playerid);
	if(IsJailedOrMuted(playerid))return 1;
	if(GetPlayerState(playerid)==PLAYER_STATE_DRIVER)return 0;
 	ApplyPlayerAnimation(playerid,"FOOD","EAT_Vomit_P",3.0,0,0,0,0,0);
 	if(PlayerAwards[playerid][Vomit]==0&&GetPlayerDrunkLevel(playerid)>100)
	{
		PlayerAwards[playerid][Vomit]=1;
		GivePlayerMoneyEx(playerid,1000);
		GamerScore[playerid]=GamerScore[playerid]+90;
		SendClientMessage(playerid,YELLOW,"Achievement Unlocked: {FFFFFF}That Was Too Much!");
		SendClientMessage(playerid,LGREEN,"BONUS: $1000 || +90 Gamer Score");
	}
  	return 1;
}
//==============================================================================
CMD:eat(playerid,params[]) {
	ClearAnimations(playerid);
	if(IsJailedOrMuted(playerid))return 1;
	if(GetPlayerState(playerid) !=PLAYER_STATE_DRIVER)return
 	ApplyPlayerAnimation(playerid,"FOOD","EAT_Burger",3.0,0,0,0,0,0);
  	return 1;
}
//==============================================================================
CMD:wave(playerid,params[]){
	ClearAnimations(playerid);
	if(IsJailedOrMuted(playerid))return 1;
	if(GetPlayerState(playerid) !=PLAYER_STATE_DRIVER)return
 	ApplyPlayerAnimation(playerid,"ON_LOOKERS","wave_loop",4.0,1,0,0,0,0);
  	return 1;
}
//==============================================================================
CMD:deal(playerid,params[])
{
	ClearAnimations(playerid);
	if(IsJailedOrMuted(playerid))return 1;
	if(GetPlayerState(playerid) !=PLAYER_STATE_DRIVER)return
 	ApplyPlayerAnimation(playerid,"DEALER","DEALER_DEAL",4.0,0,0,0,0,0);
  	return 1;
}
//==============================================================================
CMD:crack(playerid,params[]){
	ClearAnimations(playerid);
	if(IsJailedOrMuted(playerid))return 1;
	if(GetPlayerState(playerid) !=PLAYER_STATE_DRIVER)return
 	ApplyPlayerAnimation(playerid,"CRACK","crckdeth2",4.0,1,0,0,0,0);
  	return 1;
}
//==============================================================================
CMD:smokem(playerid,params[])
{
	ClearAnimations(playerid);
	if(IsJailedOrMuted(playerid))return 1;
	if(GetPlayerState(playerid) !=PLAYER_STATE_DRIVER)return
 	ApplyPlayerAnimation(playerid,"SMOKING","M_smklean_loop",4.0,1,0,0,0,0);
  	return 1;
}
//==============================================================================
CMD:smokef(playerid,params[])
{
	ClearAnimations(playerid);
	if(IsJailedOrMuted(playerid))return 1;
	if(GetPlayerState(playerid) !=PLAYER_STATE_DRIVER)return
 	ApplyPlayerAnimation(playerid,"SMOKING","F_smklean_loop",4.0,1,0,0,0,0);
  	return 1;
}
//==============================================================================
CMD:groundsit(playerid,params[])
{
	ClearAnimations(playerid);
	if(IsJailedOrMuted(playerid))return 1;
	if(GetPlayerState(playerid) !=PLAYER_STATE_DRIVER)return
 	ApplyPlayerAnimation(playerid,"BEACH","ParkSit_M_loop",4.0,1,0,0,0,0);
  	return 1;
}
//==============================================================================
CMD:chat(playerid,params[]) {
	ClearAnimations(playerid);
	if(IsJailedOrMuted(playerid))return 1;
	if(GetPlayerState(playerid) !=PLAYER_STATE_DRIVER)return
 	ApplyPlayerAnimation(playerid,"PED","IDLE_CHAT",4.0,0,0,0,0,0);
  	return 1;
}
//==============================================================================
CMD:fucku(playerid,params[])
{
	ClearAnimations(playerid);
	if(IsJailedOrMuted(playerid))return 1;
	if(GetPlayerState(playerid) !=PLAYER_STATE_DRIVER)return
 	ApplyPlayerAnimation(playerid,"PED","fucku",4.0,0,0,0,0,0);
  	return 1;
}
//==============================================================================
CMD:wank(playerid,params[]) return ApplyPlayerAnimation(playerid,"PAULNMAC","wank_loop",1.800001,1,0,0,1,600);
//==============================================================================
CMD:kiss(playerid,params[])return ApplyPlayerAnimation(playerid,"KISSING","Grlfrd_Kiss_02",1.800001,1,0,0,1,600);
//==============================================================================
CMD:medic(playerid,params[])return ApplyPlayerAnimation(playerid,"MEDIC","CPR",4.1,0,1,1,1,1);
//==============================================================================
CMD:adie(playerid,params[])return ApplyPlayerAnimation(playerid,"PED","BIKE_fallR",4.1,0,1,1,1,1);
//==============================================================================
CMD:chant(playerid,params[])return ApplyPlayerAnimation(playerid,"RIOT","RIOT_CHANT",4.0,1,1,1,1,0);
//==============================================================================
CMD:fallback(playerid,params[])return ApplyPlayerAnimation(playerid,"PED","FLOOR_hit_f",4.0,1,0,0,0,0);
//==============================================================================
CMD:rofl(playerid,params[])return ApplyPlayerAnimation(playerid,"PED","Crouch_Roll_L",4.1,0,1,1,1,1);
//==============================================================================
CMD:glitched(playerid,params[])return ApplyPlayerAnimation(playerid,"TATTOOS","TAT_Sit_Out_O",4.1,0,1,1,1,1);
//==============================================================================
CMD:funwalk(playerid,params[])return ApplyPlayerAnimation(playerid,"WUZI","Wuzi_Walk",4.1,0,1,1,1,1);
//==============================================================================
CMD:kickass(playerid,params[])return ApplyPlayerAnimation(playerid,"FIGHT_E","Hit_fightkick",4.1,0,1,1,1,1);
//==============================================================================
CMD:injured(playerid,params[])return ApplyPlayerAnimation(playerid,"SWEET","Sweet_injuredloop",4.0,1,0,0,0,0);
//==============================================================================
CMD:slapass(playerid,params[])return ApplyPlayerAnimation(playerid,"SWEET","sweet_ass_slap",4.0,0,0,0,0,0);
//==============================================================================
CMD:laydown(playerid,params[])return ApplyPlayerAnimation(playerid,"BEACH","bather",4.0,1,0,0,0,0);
//==============================================================================
CMD:arrest(playerid,params[])return ApplyPlayerAnimation(playerid,"ped","ARRESTgun",4.0,0,1,1,1,-1);
//==============================================================================
CMD:carjack(playerid,params[])return ApplyPlayerAnimation(playerid,"PED","CAR_jackedLHS",4.0,0,1,1,1,0);
//==============================================================================
CMD:relax(playerid,params[])return ApplyPlayerAnimation(playerid,"BEACH","bather",4.0,1,0,0,0,0);
//==============================================================================
stock Acc(playerid)
{
  	new x[128]; format(x,sizeof(x),"Accounts/%s.ini",PlayerName(playerid));
  	return x;
}
//==============================================================================
stock CStats(playerid)
{
	PB[playerid]=0;
	bp[playerid]=0;
	GL[playerid]=0;
	RP[playerid]=0;
	FL[playerid]=0;
	DL[playerid]=0;
	BL[playerid]=0;
	pZ[playerid]=0;
	pX[playerid]=0;
	pY[playerid]=0;
	sa2[playerid]=0;
	BtL[playerid]=0;
	Job[playerid]=0;
	Bag[playerid]=0;
	VIP[playerid]=0;
	NZT[playerid]=0;
	PID[playerid]=0;
	Car[playerid]=0;
	BID[playerid]=0;
	aid[playerid]=-1;
	TAFK[playerid]=0;
	Died[playerid]=0;
	ACar[playerid]=0;
	Keys[playerid]=0;
	Skin[playerid]=0;
	Drug[playerid]=0;
	Lock[playerid]=0;
	Mute[playerid]=0;
	Cell[playerid]=0;
	Bank[playerid]=0;
	Rank[playerid]=0;
	Time[playerid]=0;
	Hours[playerid]=0;
	Alarm[playerid]=0;
	rname[playerid]=0;
	Lotto[playerid]=0;
	Inter[playerid]=0;
	rcash[playerid]=0;
	Tazer[playerid]=0;
	Tazed[playerid]=0;
	Suited[playerid]=0;
	called[playerid]=0;
	Hidden[playerid]=0;
	Kicked[playerid]=0;
	Fstyle[playerid]=4;
	Cigars[playerid]=0;
	Jailed[playerid]=0;
	BankID[playerid]=0;
	Ticket[playerid]=0;
	Chance[playerid]=0;
	Lesson[playerid]=-1;
	OrgZone[playerid]=0;
	Airport[playerid]=0;
	onphone[playerid]=0;
	Minutes[playerid]=0;
	Teacher[playerid]=0;
	FuelCan[playerid]=0;
	OrgTime[playerid]=0;
	CMDUsed[playerid]=0;
	IsLogged[playerid]=0;
	Talkanim[playerid]=0;
	Trucking[playerid]=0;
	HadDrugs[playerid]=0;
	Passport[playerid]=0;
	Password[playerid]=0;
	CarColor1[playerid]=0;
	CarColor2[playerid]=0;
	Insurance[playerid]=0;
	IsRobbing[playerid]=0;
	dfbltimer[playerid]=0;
	PlayerOrg[playerid]=0;
	NameLimit[playerid]=0;
	Reporting[playerid]=0;
	Questions[playerid]=0;
	IsSpecing[playerid]=0;
	ChatLine[playerid]="";
	AdminLevel[playerid]=0;
	GamerScore[playerid]=0;
	DrugAddict[playerid]=0;
	registered[playerid]=0;
	Requesting[playerid]=0;
	CarPaint[playerid]=255;
	IsBleeding[playerid]=0;
	Refuelling[playerid]=0;
	Reason[playerid]="None";
	RPName[playerid]="None";
	VehNum[playerid]="None";
	spectatorid[playerid]=0;
	TheoryPassed[playerid]=0;
	Cellswitched[playerid]=0;
  	License[playerid][CP]=-1;
	PlayerLeader[playerid]=0;
	SavedWeaps[playerid][0]=0;
	SavedAmmos[playerid][0]=0;
	SavedWeaps[playerid][1]=0;
	SavedAmmos[playerid][1]=0;
	SavedWeaps[playerid][2]=0;
	SavedAmmos[playerid][2]=0;
	SavedWeaps[playerid][3]=0;
	SavedAmmos[playerid][3]=0;
	SavedWeaps[playerid][4]=0;
	SavedAmmos[playerid][4]=0;
	CollectedWage[playerid]=0;
	IsBeingSpeced[playerid]=0;
	License[playerid][StepB]=0;
	License[playerid][StepF]=0;
	License[playerid][StepD]=0;
	MarriedTo[playerid]="None";
  	SetPlayerScore(playerid,0);
	SetPlayerColor(playerid,-1);
	SetPlayerMoneyEx(playerid,0);
	SetPlayerArmourEx(playerid,0);
	PlayerAwards[playerid][Cop]=0;
	SetPlayerInterior(playerid,0);
	ResetPlayerWeaponsEx(playerid);
	PlayerAwards[playerid][Jail]=0;
	PlayerAwards[playerid][Buss]=0;
	PlayerAwards[playerid][Bill]=0;
	PlayerAwards[playerid][House]=0;
	PlayerAwards[playerid][Admin]=0;
	PlayerAwards[playerid][Guide]=0;
	PlayerAwards[playerid][Vomit]=0;
	PlayerAwards[playerid][Jailer]=0;
	PlayerAwards[playerid][Plates]=0;
	PlayerAwards[playerid][School]=0;
	PlayerAwards[playerid][Kainat]=0;
	PlayerAwards[playerid][Shutup]=0;
	PlayerAwards[playerid][Addict]=0;
  	SetPVarInt(playerid,"maxcash",0);
	PlayerAwards[playerid][Suicide]=0;
	SetPVarInt(playerid,"offered",-1);
	PlayerAwards[playerid][AirPlane]=0;
	PlayerAwards[playerid][Gangster]=0;
	SetPVarInt(playerid,"mariedid",-1);
	SetPVarInt(playerid,"receiverid",-1);
	RemovePlayerAttachedObject(playerid,4);
	RemovePlayerAttachedObject(playerid,5);
	RemovePlayerAttachedObject(playerid,6);
	RemovePlayerAttachedObject(playerid,7);
 	for(new i=0;i<MAX_PLAYERS;i++){Ignore[playerid][i]=0;}
	return 1;
}
//==============================================================================
stock LoadStats(playerid)
{
	if(!fexist(Acc(playerid)))return 0;
	if(INI_Int(Acc(playerid),"Banned")==1)return Kick(playerid);
	pX[playerid]=INI_Int(Acc(playerid),"X1");
	pY[playerid]=INI_Int(Acc(playerid),"Y1");
	pZ[playerid]=INI_Int(Acc(playerid),"Z1");
	Bag[playerid]=INI_Int(Acc(playerid),"Bag");
	Job[playerid]=INI_Int(Acc(playerid),"Job");
	VIP[playerid]=INI_Int(Acc(playerid),"VIP");
	NZT[playerid]=INI_Int(Acc(playerid),"NZT");
	Rank[playerid]=INI_Int(Acc(playerid),"Rank");
	Mute[playerid]=INI_Int(Acc(playerid),"Mute");
	Drug[playerid]=INI_Int(Acc(playerid),"Drug");
	Skin[playerid]=INI_Int(Acc(playerid),"Skin");
	Bank[playerid]=INI_Int(Acc(playerid),"Bank");
	BID[playerid]=INI_Int(Acc(playerid),"BusID");
	Keys[playerid]=INI_Int(Acc(playerid),"Keys");
	Cell[playerid]=INI_Int(Acc(playerid),"Cell");
	Lock[playerid]=INI_Int(Acc(playerid),"Lock");
	RP[playerid]=INI_Int(Acc(playerid),"RPMarks");
	PID[playerid]=INI_Int(Acc(playerid),"PropID");
	Alarm[playerid]=INI_Int(Acc(playerid),"Alarm");
	Jailed[playerid]=INI_Int(Acc(playerid),"Jailed");
	Fstyle[playerid]=INI_Int(Acc(playerid),"FStyle");
	Cigars[playerid]=INI_Int(Acc(playerid),"Cigars");
	BankID[playerid]=INI_Int(Acc(playerid),"BankID");
	GL[playerid]=INI_Int(Acc(playerid),"GunLicense");
	BL[playerid]=INI_Int(Acc(playerid),"BikeLicense");
	CarColor1[playerid]=INI_Int(Acc(playerid),"Col1");
	CarColor2[playerid]=INI_Int(Acc(playerid),"Col2");
	OrgTime[playerid]=INI_Int(Acc(playerid),"OrgTime");
	BtL[playerid]=INI_Int(Acc(playerid),"BoatLicense");
	FuelCan[playerid]=INI_Int(Acc(playerid),"FuelCan");
	Teacher[playerid]=INI_Int(Acc(playerid),"Teacher");
	FL[playerid]=INI_Int(Acc(playerid),"FlyingLicense");
	Hours[playerid]=INI_Int(Acc(playerid),"HoursPlayed");
	Talkanim[playerid]=INI_Int(Acc(playerid),"Talkanim");
	DL[playerid]=INI_Int(Acc(playerid),"DrivingLicense");
	Passport[playerid]=INI_Int(Acc(playerid),"Passport");
	Password[playerid]=INI_Int(Acc(playerid),"Password");
	CarPaint[playerid]=INI_Int(Acc(playerid),"CarPaint");
	Insurance[playerid]=INI_Int(Acc(playerid),"Insurance");
	GamerScore[playerid]=INI_Int(Acc(playerid),"GamerScore");
	AdminLevel[playerid]=INI_Int(Acc(playerid),"AdminLevel");
	Minutes[playerid]=INI_Int(Acc(playerid),"MinutesPlayed");
	format(VehNum[playerid],9,INI_Get(Acc(playerid),"VehNum"));
	DrugAddict[playerid]=INI_Int(Acc(playerid),"DrugAddicted");
	GivePlayerMoneyEx(playerid,INI_Int(Acc(playerid),"Money"));
	PlayerAwards[playerid][Cop]=INI_Int(Acc(playerid),"Award1");
	format(RPName[playerid],25,INI_Get(Acc(playerid),"RPName"));
	SavedWeaps[playerid][0]=INI_Int(Acc(playerid),"SavedWeaps0");
	SavedAmmos[playerid][0]=INI_Int(Acc(playerid),"SavedAmmos0");
	SavedWeaps[playerid][1]=INI_Int(Acc(playerid),"SavedWeaps1");
	SavedAmmos[playerid][1]=INI_Int(Acc(playerid),"SavedAmmos1");
	SavedWeaps[playerid][2]=INI_Int(Acc(playerid),"SavedWeaps2");
	SavedAmmos[playerid][2]=INI_Int(Acc(playerid),"SavedAmmos2");
	SavedWeaps[playerid][3]=INI_Int(Acc(playerid),"SavedWeaps3");
	SavedAmmos[playerid][3]=INI_Int(Acc(playerid),"SavedAmmos3");
	SavedWeaps[playerid][4]=INI_Int(Acc(playerid),"SavedWeaps4");
	SavedAmmos[playerid][4]=INI_Int(Acc(playerid),"SavedAmmos4");
	PlayerAwards[playerid][Bill]=INI_Int(Acc(playerid),"Award2");
	PlayerAwards[playerid][Buss]=INI_Int(Acc(playerid),"Award3");
	PlayerAwards[playerid][Jail]=INI_Int(Acc(playerid),"Award4");
	PlayerAwards[playerid][Admin]=INI_Int(Acc(playerid),"Award5");
	SetPlayerInterior(playerid,INI_Int(Acc(playerid),"Interior"));
	PlayerAwards[playerid][House]=INI_Int(Acc(playerid),"Award6");
	PlayerAwards[playerid][Guide]=INI_Int(Acc(playerid),"Award7");
	PlayerAwards[playerid][Vomit]=INI_Int(Acc(playerid),"Award8");
	SetPlayerScore(playerid,INI_Int(Acc(playerid),"HoursPlayed"));
	CollectedWage[playerid]=INI_Int(Acc(playerid),"CollectedWage");
	PlayerAwards[playerid][Kainat]=INI_Int(Acc(playerid),"Award9");
	PlayerAwards[playerid][Shutup]=INI_Int(Acc(playerid),"Award10");
	PlayerAwards[playerid][Addict]=INI_Int(Acc(playerid),"Award11");
	PlayerAwards[playerid][Jailer]=INI_Int(Acc(playerid),"Award12");
	PlayerAwards[playerid][Plates]=INI_Int(Acc(playerid),"Award13");
	PlayerAwards[playerid][School]=INI_Int(Acc(playerid),"Award14");
	PlayerAwards[playerid][Abooze]=INI_Int(Acc(playerid),"Award15");
	PlayerAwards[playerid][Suicide]=INI_Int(Acc(playerid),"Award16");
	format(Reason[playerid],25,INI_Get(Acc(playerid),"WantedReason"));
	format(MarriedTo[playerid],25,INI_Get(Acc(playerid),"MarriedTo"));
	PlayerAwards[playerid][Gangster]=INI_Int(Acc(playerid),"Award17");
	PlayerAwards[playerid][AirPlane]=INI_Int(Acc(playerid),"Award18");
	SetPlayerWantedLevel(playerid,INI_Int(Acc(playerid),"WantedLevel"));
	if(INI_Int(Acc(playerid),"Car")>0)
	{
  		Car[playerid]=AddStaticVehicleEx(INI_Int(Acc(playerid),"Car"),INI_Int(Acc(playerid),"CarX"),INI_Int(Acc(playerid),"CarY"),INI_Int(Acc(playerid),"CarZ"),INI_Int(Acc(playerid),"CarR"),CarColor1[playerid],CarColor1[playerid],-1);
		fuel[Car[playerid]]=INI_Int(Acc(playerid),"Fuel");
		SetVehicleParamsEx(Car[playerid],0,0,0,1,0,0,0);
		ChangeVehiclePaintjob(Car[playerid],CarPaint[playerid]);
		AddVehicleComponent(Car[playerid],INI_Int(Acc(playerid),"C1"));
		AddVehicleComponent(Car[playerid],INI_Int(Acc(playerid),"C2"));
		AddVehicleComponent(Car[playerid],INI_Int(Acc(playerid),"C3"));
		AddVehicleComponent(Car[playerid],INI_Int(Acc(playerid),"C4"));
		AddVehicleComponent(Car[playerid],INI_Int(Acc(playerid),"C5"));
		AddVehicleComponent(Car[playerid],INI_Int(Acc(playerid),"C6"));
		AddVehicleComponent(Car[playerid],INI_Int(Acc(playerid),"C7"));
		AddVehicleComponent(Car[playerid],INI_Int(Acc(playerid),"C8"));
		AddVehicleComponent(Car[playerid],INI_Int(Acc(playerid),"C9"));
		AddVehicleComponent(Car[playerid],INI_Int(Acc(playerid),"C10"));
		AddVehicleComponent(Car[playerid],INI_Int(Acc(playerid),"C11"));
		AddVehicleComponent(Car[playerid],INI_Int(Acc(playerid),"C12"));
		AddVehicleComponent(Car[playerid],INI_Int(Acc(playerid),"C13"));
		if(strcmp(VehNum[playerid],"None",true)!=0){SetVehicleNumberPlate(Car[playerid],VehNum[playerid]);}
		if(strcmp(VehNum[playerid],"None",true)==0){SetVehicleNumberPlate(Car[playerid],PlayerName(playerid));}
	}
	return 1;
}
//==============================================================================
stock SStats(playerid)
{
	if(IsPlayerConnectedEx(playerid)&&fexist(Acc(playerid)))
	{
		new Year,Month,Day,str[32];
		getdate(Year,Month,Day);
		format(str,32,"%d/%d/%d",Day,Month,Year);
		INI_Set(Acc(playerid),"LastOnline",str);
		GetPlayerPos(playerid,pX[playerid],pY[playerid],pZ[playerid]);
		INI_IntSet(Acc(playerid),"NZT",NZT[playerid]);
		INI_IntSet(Acc(playerid),"Bag",Bag[playerid]);
		INI_IntSet(Acc(playerid),"VIP",VIP[playerid]);
		INI_IntSet(Acc(playerid),"Job",Job[playerid]);
		INI_IntSet(Acc(playerid),"Drug",Drug[playerid]);
		INI_IntSet(Acc(playerid),"BusID",BID[playerid]);
		INI_IntSet(Acc(playerid),"Mute",Mute[playerid]);
		INI_IntSet(Acc(playerid),"Keys",Keys[playerid]);
		INI_IntSet(Acc(playerid),"Rank",Rank[playerid]);
		INI_IntSet(Acc(playerid),"Lock",Lock[playerid]);
		INI_IntSet(Acc(playerid),"Cell",Cell[playerid]);
		INI_IntSet(Acc(playerid),"Skin",Skin[playerid]);
		INI_Set(Acc(playerid),"VehNum",VehNum[playerid]);
		INI_IntSet(Acc(playerid),"RPMarks",RP[playerid]);
		INI_IntSet(Acc(playerid),"Bank",Bank[playerid]);
		INI_Set(Acc(playerid),"RPName",RPName[playerid]);
		INI_IntSet(Acc(playerid),"PropID",PID[playerid]);
		INI_IntSet(Acc(playerid),"Alarm",Alarm[playerid]);
		INI_IntSet(Acc(playerid),"FStyle",Fstyle[playerid]);
		INI_IntSet(Acc(playerid),"Cigars",Cigars[playerid]);
		INI_IntSet(Acc(playerid),"Jailed",Jailed[playerid]);
		INI_IntSet(Acc(playerid),"GunLicense",GL[playerid]);
		INI_IntSet(Acc(playerid),"BikeLicense",BL[playerid]);
		INI_IntSet(Acc(playerid),"BankID",BankID[playerid]);
		INI_IntSet(Acc(playerid),"Teacher",Teacher[playerid]);
		INI_IntSet(Acc(playerid),"OrgTime",OrgTime[playerid]);
		INI_IntSet(Acc(playerid),"BoatLicense",BtL[playerid]);
		INI_IntSet(Acc(playerid),"FlyingLicense",FL[playerid]);
		INI_IntSet(Acc(playerid),"FuelCan",FuelCan[playerid]);
		INI_Set(Acc(playerid),"MarriedTo",MarriedTo[playerid]);
		INI_Set(Acc(playerid),"WantedReason",Reason[playerid]);
		INI_IntSet(Acc(playerid),"Talkanim",Talkanim[playerid]);
		INI_IntSet(Acc(playerid),"DrivingLicense",DL[playerid]);
		INI_IntSet(Acc(playerid),"X1",floatround(pX[playerid]));
		INI_IntSet(Acc(playerid),"Y1",floatround(pY[playerid]));
		INI_IntSet(Acc(playerid),"Z1",floatround(pZ[playerid]));
		INI_IntSet(Acc(playerid),"HoursPlayed",Hours[playerid]);
		INI_IntSet(Acc(playerid),"Passport",Passport[playerid]);
		INI_IntSet(Acc(playerid),"Password",Password[playerid]);
		INI_IntSet(Acc(playerid),"Insurance",Insurance[playerid]);
		INI_IntSet(Acc(playerid),"LastActive",gettime()+60*60*24*7);
		INI_IntSet(Acc(playerid),"MinutesPlayed",Minutes[playerid]);
		INI_IntSet(Acc(playerid),"AdminLevel",AdminLevel[playerid]);
		INI_IntSet(Acc(playerid),"GamerScore",GamerScore[playerid]);
		INI_IntSet(Acc(playerid),"Money",GetPlayerMoneyEx(playerid));
		INI_IntSet(Acc(playerid),"DrugAddicted",DrugAddict[playerid]);
		INI_IntSet(Acc(playerid),"Award1",PlayerAwards[playerid][Cop]);
		INI_IntSet(Acc(playerid),"Award2",PlayerAwards[playerid][Bill]);
		INI_IntSet(Acc(playerid),"Award3",PlayerAwards[playerid][Buss]);
		INI_IntSet(Acc(playerid),"Award4",PlayerAwards[playerid][Jail]);
		INI_IntSet(Acc(playerid),"SavedWeaps0",SavedWeaps[playerid][0]);
		INI_IntSet(Acc(playerid),"SavedAmmos0",SavedAmmos[playerid][0]);
		INI_IntSet(Acc(playerid),"SavedWeaps1",SavedWeaps[playerid][1]);
		INI_IntSet(Acc(playerid),"SavedAmmos1",SavedAmmos[playerid][1]);
		INI_IntSet(Acc(playerid),"SavedWeaps2",SavedWeaps[playerid][2]);
		INI_IntSet(Acc(playerid),"SavedAmmos2",SavedAmmos[playerid][2]);
		INI_IntSet(Acc(playerid),"SavedWeaps3",SavedWeaps[playerid][3]);
		INI_IntSet(Acc(playerid),"SavedAmmos3",SavedAmmos[playerid][3]);
		INI_IntSet(Acc(playerid),"SavedWeaps4",SavedWeaps[playerid][4]);
		INI_IntSet(Acc(playerid),"SavedAmmos4",SavedAmmos[playerid][4]);
		INI_IntSet(Acc(playerid),"Award5",PlayerAwards[playerid][Admin]);
		INI_IntSet(Acc(playerid),"Award6",PlayerAwards[playerid][House]);
		INI_IntSet(Acc(playerid),"Award7",PlayerAwards[playerid][Guide]);
		INI_IntSet(Acc(playerid),"Award8",PlayerAwards[playerid][Vomit]);
		INI_IntSet(Acc(playerid),"Interior",GetPlayerInterior(playerid));
		INI_IntSet(Acc(playerid),"CollectedWage",CollectedWage[playerid]);
		INI_IntSet(Acc(playerid),"Award9",PlayerAwards[playerid][Kainat]);
		INI_IntSet(Acc(playerid),"Award10",PlayerAwards[playerid][Shutup]);
		INI_IntSet(Acc(playerid),"Award11",PlayerAwards[playerid][Addict]);
		INI_IntSet(Acc(playerid),"Award12",PlayerAwards[playerid][Jailer]);
		INI_IntSet(Acc(playerid),"Award13",PlayerAwards[playerid][Plates]);
		INI_IntSet(Acc(playerid),"Award14",PlayerAwards[playerid][School]);
		INI_IntSet(Acc(playerid),"Award15",PlayerAwards[playerid][Abooze]);
		INI_IntSet(Acc(playerid),"Award16",PlayerAwards[playerid][Suicide]);
		INI_IntSet(Acc(playerid),"Award17",PlayerAwards[playerid][Gangster]);
		INI_IntSet(Acc(playerid),"Award18",PlayerAwards[playerid][AirPlane]);
		if(GetPlayerMoneyEx(playerid)<0){INI_IntSet(Acc(playerid),"Money",-1);}
		INI_IntSet(Acc(playerid),"WantedLevel",GetPlayerWantedLevel(playerid));
		if(Car[playerid]==0)
		{
			INI_IntSet(Acc(playerid),"C1",0);
			INI_IntSet(Acc(playerid),"C2",0);
			INI_IntSet(Acc(playerid),"C3",0);
			INI_IntSet(Acc(playerid),"C4",0);
			INI_IntSet(Acc(playerid),"C5",0);
			INI_IntSet(Acc(playerid),"C6",0);
			INI_IntSet(Acc(playerid),"C7",0);
			INI_IntSet(Acc(playerid),"C8",0);
			INI_IntSet(Acc(playerid),"C9",0);
			INI_IntSet(Acc(playerid),"C10",0);
			INI_IntSet(Acc(playerid),"C11",0);
			INI_IntSet(Acc(playerid),"C12",0);
			INI_IntSet(Acc(playerid),"C13",0);
			INI_IntSet(Acc(playerid),"Car",0);
			INI_IntSet(Acc(playerid),"Fuel",0);
			INI_IntSet(Acc(playerid),"CarX",0);
			INI_IntSet(Acc(playerid),"CarY",0);
			INI_IntSet(Acc(playerid),"CarZ",0);
			INI_IntSet(Acc(playerid),"CarR",0);
			INI_IntSet(Acc(playerid),"CarPaint",255);
		}
		if(Car[playerid]>0)
		{
    		new Float:nx,Float:ny,Float:nz,Float:nrot;
    	   	GetVehicleZAngle(Car[playerid],nrot);
    	   	GetVehiclePos(Car[playerid],nx,ny,nz);
			INI_IntSet(Acc(playerid),"CarX",floatround(nx));
			INI_IntSet(Acc(playerid),"CarY",floatround(ny));
			INI_IntSet(Acc(playerid),"CarZ",floatround(nz));
			INI_IntSet(Acc(playerid),"CarR",floatround(nrot));
			INI_IntSet(Acc(playerid),"Col1",CarColor1[playerid]);
			INI_IntSet(Acc(playerid),"Col2",CarColor2[playerid]);
			INI_IntSet(Acc(playerid),"Fuel",fuel[Car[playerid]]);
			INI_IntSet(Acc(playerid),"CarPaint",CarPaint[playerid]);
			INI_IntSet(Acc(playerid),"Car",GetVehicleModel(Car[playerid]));
			INI_IntSet(Acc(playerid),"C1",GetVehicleComponentInSlot(Car[playerid],CARMODTYPE_SPOILER));
			INI_IntSet(Acc(playerid),"C2",GetVehicleComponentInSlot(Car[playerid],CARMODTYPE_HOOD));
			INI_IntSet(Acc(playerid),"C3",GetVehicleComponentInSlot(Car[playerid],CARMODTYPE_ROOF));
			INI_IntSet(Acc(playerid),"C4",GetVehicleComponentInSlot(Car[playerid],CARMODTYPE_SIDESKIRT));
			INI_IntSet(Acc(playerid),"C5",GetVehicleComponentInSlot(Car[playerid],CARMODTYPE_EXHAUST));
			INI_IntSet(Acc(playerid),"C6",GetVehicleComponentInSlot(Car[playerid],CARMODTYPE_WHEELS));
			INI_IntSet(Acc(playerid),"C7",GetVehicleComponentInSlot(Car[playerid],CARMODTYPE_HYDRAULICS));
			INI_IntSet(Acc(playerid),"C8",GetVehicleComponentInSlot(Car[playerid],CARMODTYPE_FRONT_BUMPER));
			INI_IntSet(Acc(playerid),"C9",GetVehicleComponentInSlot(Car[playerid],CARMODTYPE_REAR_BUMPER));
			INI_IntSet(Acc(playerid),"C10",GetVehicleComponentInSlot(Car[playerid],CARMODTYPE_LAMPS));
			INI_IntSet(Acc(playerid),"C11",GetVehicleComponentInSlot(Car[playerid],CARMODTYPE_NITRO));
			INI_IntSet(Acc(playerid),"C12",GetVehicleComponentInSlot(Car[playerid],CARMODTYPE_VENT_RIGHT));
			INI_IntSet(Acc(playerid),"C13",GetVehicleComponentInSlot(Car[playerid],CARMODTYPE_VENT_LEFT));
		}
	}
	return 1;
}
//==============================================================================
stock Second()
{
	for(new playerid=0; playerid<MAX_PLAYERS; playerid++)
	{
	 	if(IsPlayerConnectedEx(playerid))
		{
 			LSAP(playerid);CMDUsed[playerid]=0;
			SetPlayerTime(playerid,sminute,ssecond);
		    new string[128],Float:AP,count,name[40];
		    if(GetPlayerState(playerid)==PLAYER_STATE_DRIVER)
		    {
    			new Zone[MAX_ZONE_NAME];
				GetVehicleVelocity(GetPlayerVehicleID(playerid),svx[playerid],svy[playerid],svz[playerid]);
				sa1[playerid]=floatsqroot(((svx[playerid]*svx[playerid])+(svy[playerid]*svy[playerid]))+(svz[playerid]*svz[playerid]))*100;
				sa2[playerid]=floatround(sa1[playerid],floatround_round);
				format(s3[playerid],128,"~b~Speed: ~w~%i mph",sa2[playerid]);
				TextDrawSetString(sdisplay[playerid],s3[playerid]);
				GetPlayer2DZone(playerid,Zone,MAX_ZONE_NAME);
				format(string,sizeof(string),"~w~%s",Zone);
				TextDrawSetString(Zones[playerid],string);
				format(string,50,"~b~Fuel: ~w~%d Liters",fuel[GetPlayerVehicleID(playerid)]);
				TextDrawSetString(td_fuel[playerid],string);
				new engine,lights,alarm,doors,bonnet,boot,objective,Float:health;
				GetVehicleHealth(GetPlayerVehicleID(playerid),health);
				GetVehicleParamsEx(GetPlayerVehicleID(playerid),engine,lights,alarm,doors,bonnet,boot,objective);
				if(engine==1&&health<350)
				{
					TextDrawHideForPlayer(playerid,sdisplay[playerid]);
	    			TextDrawHideForPlayer(playerid,td_fuel[playerid]);
					SetVehicleParamsEx(GetPlayerVehicleID(playerid),0,0,0,0,0,0,0);
					SendClientMessage(playerid,LRED,"Your vehicles engine has broken,you better get a mechanic");
				}
        		if(Refuelling[playerid]==1)
        		{
    				new vid=GetPlayerVehicleID(playerid),str[50];
    				fuel[vid]=fuel[vid] + 1;
    				format(str,50,"%dL",fuel[vid]);
        			GameTextForPlayer(playerid,str,1000,6);
    				GivePlayerMoneyEx(playerid,-4);
					if(fuel[vid]>=35||GetPlayerMoneyEx(playerid)<4||!IsAtFuelStation(playerid))
					{
						Refuelling[playerid]=0;
        				GameTextForPlayer(playerid,"Refuelling Done",1000,6);
					}
				}
				if(License[playerid][StepB] >=1||License[playerid][StepD] >=1||License[playerid][StepF] >=1)
				{
				    new str[50];
		    		dfbltimer[playerid]++;
					format(str,50,"%d",dfbltimer[playerid]);
        			GameTextForPlayer(playerid,str,1200,6);
				}
			}
            for (new c=1;c<OrgsCount+1;c++)
			{
                if (DoesOrgExist(GetOrgName(c)))
				{
                    for (new a=1;a<Organization[c][ZoneCreated]+1;a++)
					{
                        if (IsPlayerInArea(playerid,Organization[c][ZoneMinX][a],Organization[c][ZoneMinY][a],Organization[c][ZoneMaxX][a],Organization[c][ZoneMaxY][a]))
						{
                            count++;
                            name=GetOrgName(c);
                        }

                    }
                }
            }
            if(count !=0)
			{
                if (OrgZone[playerid]==0)
				{
                    if (PlayerOrg[playerid]==GetOrgID(name))
					{
                        format(string,sizeof(string),"{FFFFFF}Welcome back to your territory");
                    }
                    if (PlayerOrg[playerid] !=GetOrgID(name))
					{
                        format(string,sizeof(string),"You have entered the territory of %s",name);
                    }
     				SendClientMessage(playerid,LBLUE,string);
                    OrgZone[playerid]=1;
                }
            }
            if(count==0)
			{
                OrgZone[playerid]=0;
            }
			if(IsAtAmmunation(playerid))
			{
				if(GetPlayerInterior(playerid)==1||GetPlayerInterior(playerid)==6||GetPlayerInterior(playerid)==4)
				{
					Weapons[playerid][GetPlayerWeapon(playerid)]=true;
        	    }
			}
			GetPlayerArmour(playerid,AP);
   			if(AP !=Armor[playerid])
			{
				if(AP < Armor[playerid])
				{
					SetPlayerArmourEx(playerid,AP);
				}
				if(AP > Armor[playerid])
				{
					if(AP==100&&IsAtAmmunation(playerid))return SetPlayerArmourEx(playerid,99);
					format(string,sizeof(string),"SERVER: {FFFFFF}%s has hacked Armor of value %d",PlayerName(playerid),floatround(AP-Armor[playerid]));
					SendMessageToAdmins(RED,string);
					SendMessageToAdmins(-1,"NOTE: /spec them,and if they are in ammunation or near org hq,it can possibly be a bug");
			    	SetPlayerArmourEx(playerid,AP);
				}
			}
			if(GetPlayerMoney(playerid) > GetPVarInt(playerid,"maxcash"))
			{
				format(string,sizeof(string),"SERVER: {FFFFFF}%s has hacked $%d",PlayerName(playerid),GetPlayerMoney(playerid)-GetPVarInt(playerid,"maxcash"));
				SendMessageToAdmins(RED,string);
				SetPlayerMoneyEx(playerid,GetPlayerMoney(playerid));
			}
			if(Tazer[playerid]==1)
			{
			    SetPlayerArmedWeapon(playerid,0);
			}
			if(Kicked[playerid]==1)
			{
			    Kick(playerid);
			}
			if(TAFK[playerid]>0&&gettime()>TAFK[playerid])
			{
    			GetPlayerPos(playerid,positions[playerid][0],positions[playerid][1],positions[playerid][2]);
				if(positions[playerid][0]==positions[playerid][3] && positions[playerid][1]==positions[playerid][4] && positions[playerid][2]==positions[playerid][5])
    			{
	 				format(string,sizeof(string),"%s has been kicked from the server for inactivity",PlayerName(playerid));
					TogglePlayerControllable(playerid,false);
					SendClientMessageToAll(-1,string);
					SetCameraBehindPlayer(playerid);
				  	if(PlayerAwards[playerid][Abooze]==0)
					{
						PlayerAwards[playerid][Abooze]=1;
						GivePlayerMoneyEx(playerid,1000);
						GamerScore[playerid]=GamerScore[playerid]+90;
						SendClientMessage(playerid,YELLOW,"Achievement Unlocked: {FFFFFF}Ab00ze!");
						SendClientMessage(playerid,LGREEN,"BONUS: $1000 || +90 Gamer Score");
					}
	    			Kicked[playerid]=1;
    				return 1;
				}
				else
				{
			 	   	positions[playerid][3]=positions[playerid][0];
					positions[playerid][4]=positions[playerid][1];
					positions[playerid][5]=positions[playerid][2];
		    		TAFK[playerid]=gettime()+300;
		    		return 1;
				}
			}
		}
	}
	return 1;
}
//==============================================================================
stock Minute()
{
	for(new i=0; i < MAX_PLAYERS; i++)
    {
		if(IsPlayerConnectedEx(i))
		{
			Minutes[i] ++;
    		if(Minutes[i]==60)
    		{
    		    Hours[i]++;
        		new str[128];
        		Minutes[i]=0;
				SetPlayerScore(i,Hours[i]);
				GivePlayerMoneyEx(i,Hours[i]*1000);
				format(str,sizeof(str),"Congratulations! Your Level has increased to %d!",GetPlayerScore(i));
				SendClientMessage(i,LGREEN,str);
				format(str,sizeof(str),"~y~Bonus: $%d",Hours[i]*1000);
				GameTextForPlayer(i,str,4500,4);
			}
			if(Jailed[i]>=1)
	    	{
	    	    Jailed[i]=Jailed[i]-1;
				if(Jailed[i]==0)
				{
			    	UnCagePlayer(i);
					SendClientMessage(i,LRED,"You have been unjailed");
				}
			}
			if(VIP[i]>0)
        	{
        	    if(gettime()>VIP[i])
        	    {
    				VIP[i]=0;
        	        SendClientMessage(i,-1,"The duration of your VIP package has been expired");
				}
			}
			if(Mute[i]>0)
	    	{
				Mute[i]=Mute[i]-1;
				if(Mute[i]==0)
				{
				    Mute[i]=0;
				    SendClientMessage(i,RED,"SERVER:{FFFFFF} You have been un-muted");
				}
			}
			if(IsBleeding[i]==1||DrugAddict[i]==1&&HadDrugs[i]==0)
			{
			    new Float:health;
   				GetPlayerHealth(i,health);
   				SetPlayerHealth(i,health-7);
			}
			if(HadDrugs[i]>0)
			{
    			HadDrugs[i]=HadDrugs[i]-1;
			}
			if(called[i]==1)
			{
				called[i]=0;
    			SetPlayerSpecialAction(i,SPECIAL_ACTION_STOPUSECELLPHONE);
		    	SendClientMessage(GetPVarInt(i,"receiverid"),GREY,"The player has failed to answer your call");
			}
			if(Airport[i]==1)
			{
	    		Airport[i]=0;
	    		SetPlayerInterior(i,0);
	    		SetPlayerPos(i,1646.6692,-2327.8423,13.5469);
	    		SendClientMessage(i,YELLOW,"We have reached Los Santos,We hope that you enjoyed the flight");
				if(PlayerAwards[i][AirPlane]==0)
				{
					PlayerAwards[i][AirPlane]=1;
 					GivePlayerMoneyEx(i,700);
					GamerScore[i]=GamerScore[i]+90;
  					SendClientMessage(i,YELLOW,"Achievement Unlocked: {FFFFFF}Free Roaming!");
					SendClientMessage(i,LGREEN,"BONUS: $700 || +90 Gamer Score");
				}
			}
			if(Airport[i]==2)
			{
	    		Airport[i]=0;
	    		SetPlayerInterior(i,0);
	    		SetPlayerPos(i,1678.9028,1447.7567,10.7747);
	    		SendClientMessage(i,YELLOW,"We have reached Las Venturas,We hope that you enjoyed the flight");
				if(PlayerAwards[i][AirPlane]==0)
				{
					PlayerAwards[i][AirPlane]=1;
 					GivePlayerMoneyEx(i,700);
					GamerScore[i]=GamerScore[i]+90;
  					SendClientMessage(i,YELLOW,"Achievement Unlocked: {FFFFFF}Free Roaming!");
					SendClientMessage(i,LGREEN,"BONUS: $700 || +90 Gamer Score");
				}
			}
			if(Airport[i]==3)
			{
	    		Airport[i]=0;
	    		SetPlayerInterior(i,0);
	    		SetPlayerPos(i,-1425.7683,-287.0605,14.1484);
	    		SendClientMessage(i,YELLOW,"We have reached San Fierro,We hope that you enjoyed the flight");
				if(PlayerAwards[i][AirPlane]==0)
				{
					PlayerAwards[i][AirPlane]=1;
 					GivePlayerMoneyEx(i,700);
					GamerScore[i]=GamerScore[i]+90;
  					SendClientMessage(i,YELLOW,"Achievement Unlocked: {FFFFFF}Free Roaming!");
					SendClientMessage(i,LGREEN,"BONUS: $700 || +90 Gamer Score");
				}
			}
			if(Refuelling[i]==0)
	    	{
        		new vid=GetPlayerVehicleID(i),objective,boot,bonnet,doors,alarm,lights,engine;
    			GetVehicleParamsEx(vid,engine,lights,alarm,doors,bonnet,boot,objective);
        		if(GetPlayerVehicleSeat(i)==0)
				{
        		    fuel[vid]=fuel[vid] -1;
        	    	if (fuel[vid]<1&&engine==1)
        	    	{
        	        	fuel[vid]=0;
        	        	new vehicleid=GetPlayerVehicleID(i);
	    				TextDrawHideForPlayer(i,td_fuel[i]);
        	        	TextDrawHideForPlayer(i,sdisplay[i]);
        	        	SetVehicleParamsEx(vehicleid,0,0,0,0,0,0,0);
        	        	SendClientMessage(i,GREY,"Your vehicle is out of fuel");
        	    	}
        	    	if(DL[i]==0&&License[i][StepD]==0&&engine==1)
        	    	{
        	    	    new rand=1 + random(6);
        	    	    if(rand==4)
        	    	    {
							TextDrawHideForPlayer(i,sdisplay[i]);
			    			TextDrawHideForPlayer(i,td_fuel[i]);
			    			SetVehicleParamsEx(vid,0,0,alarm,doors,bonnet,boot,objective);
			    			SendClientMessage(i,LRED,"You've stalled your vehicle's engine,type /engine to switch it on again");
						}
					}
        		}
			}
			if(IsRobbing[i]==1)
 			{
     			if(PlayerOrgType(i)==MAFIA && Suited[i]>0)
				{
			    	if (IsPlayerInRangeOfPoint(i,50,1549.5024,-2264.3220,253.3183))
					{
   						rcash[i]=rcash[i]+10000;
						format(Reason[i],25,"Robbery");
        	  			GameTextForPlayer(i,"~g~+$10000",1500,1);
				    	if(rcash[i]==30000){SetPlayerWantedLevel(i,6);}
        	    		if(rcash[i]==100000)
        	    		{
        	  				IsRobbing[i]=0;
        					SendClientMessage(i,GREY,"The vault is empty,you cannot rob anymore");
						}
        	  	  	}
        		}
			}
			if(Tazed[i]==1)
			{
			    Tazed[i]=0;
			    ClearAnimations(i);
			    TogglePlayerControllable(i,1);
			    SendClientMessage(i,BLUE,"You have recovered from the electric shock");
			}
		}
	}
 	return 1;
}
//==============================================================================
stock Hour()
{
	for (new i=1;i<BusinessCount+1;i++)
	{
	    if(strcmp(Business[i][bOwner],"None") !=0)
		{
  			new ammount,string[128];
			format(string,sizeof(string),"Accounts/%s.txt",Business[i][bOwner]);
			ammount=INI_Int(string,"Profit");
			ammount=ammount+Business[i][bProfit];
			INI_IntSet(string,"Profit",ammount);
			if(gettime()>INI_Int(string,"LastActive"))
			{
			    INI_IntSet(string,"BusID",0);
			    format(Business[i][bOwner],24,"None");
			}
		}
	}
	for (new i=1;i<PropertyCount+1;i++)
	{
	    if(strcmp(Property[i][pOwner],"None") !=0)
		{
  			new string[128],labelstring[40];
			format(string,sizeof(string),"Accounts/%s.ini",Property[i][pOwner]);
			if(gettime()>INI_Int(string,"LastActive"))
			{
			    INI_IntSet(string,"PropID",0);
			    format(Property[i][pOwner],24,"None");
				DestroyDynamicPickup(Property[i][pPickup]);
				DestroyDynamicMapIcon(Property[i][pMapicon]);
				DestroyDynamic3DTextLabel(Property[i][pLabel]);
				format(labelstring,sizeof(labelstring),"$%i",Property[i][pCost]);
				Property[i][pPickup]=CreateDynamicPickup(1273,1,Property[i][prX],Property[i][prY],Property[i][prZ],-1);
				Property[i][pMapicon]=CreateDynamicMapIcon(Property[i][prX],Property[i][prY],Property[i][prZ],31,0,-1,-1,-1,250.0);
				Property[i][pLabel]=CreateDynamic3DTextLabel(labelstring,0xFFFFFFFF,Property[i][prX],Property[i][prY],Property[i][prZ],6.0);
			}
		}
	}
	for(new i=0; i < MAX_PLAYERS; i++)
	{
		if(IsPlayerConnectedEx(i)&&BankID[i]!=0)
 		{
			new string[128],non;
			SendClientMessage(i,YELLOW,"$$$ San Andreas Bank $$$");
			format(string,sizeof(string),"Your Old Balance : $%d",Bank[i]);
			SendClientMessage(i,-1,string);
			SendClientMessage(i,-1,"Tax : $0.2 Percent");
			non=(Bank[i]/10000)*2;
			format(string,sizeof(string),"Profit : $%d",non);
			SendClientMessage(i,-1,string);
			Bank[i] +=non;
			if(Job[i]==1)
			{
			    Bank[i]=Bank[i]+80;
				SendClientMessage(i,-1,"Paycheck: $80");
			}
			if(Job[i]==2)
			{
			    Bank[i]=Bank[i]+85;
				SendClientMessage(i,-1,"Paycheck: $85");
			}
			if(Job[i]==3)
			{
			    Bank[i]=Bank[i]+75;
				SendClientMessage(i,-1,"Paycheck: $75");
			}
			if(Insurance[i]==1&&Car[i]>0)
			{
			    Bank[i]=Bank[i]-GetVehiclePrice(Car[i])/100;
				format(string,sizeof(string),"Vehicle Insurance : $%d",GetVehiclePrice(Car[i])/100);
				SendClientMessage(i,-1,string);
			}
			if (PlayerOrg[i] !=0)
			{
		 		if(Organization[PlayerOrg[i]][Money]>=2000)
		   		{
		   		    if(Rank[i]==4)
  					{
					  	CollectedWage[i]+=Organization[PlayerOrg[i]][Wage];
					  	Organization[PlayerOrg[i]][Money]=Organization[PlayerOrg[i]][Money]-Organization[PlayerOrg[i]][Wage];
				  	}
			 		if(Rank[i]==3)
			  		{
			  			CollectedWage[i]+=Organization[PlayerOrg[i]][Wage]/2;
 			  			Organization[PlayerOrg[i]][Money]=Organization[PlayerOrg[i]][Money]-Organization[PlayerOrg[i]][Wage]/2;
					}
  					if(Rank[i]==2)
				  	{
 						CollectedWage[i]+=Organization[PlayerOrg[i]][Wage]/5;
 	 					Organization[PlayerOrg[i]][Money]=Organization[PlayerOrg[i]][Money]-Organization[PlayerOrg[i]][Wage]/5;
			  		}
		 			if(Rank[i]==1)
		 			{
		 				CollectedWage[i]+=Organization[PlayerOrg[i]][Wage]/10;
	  					Organization[PlayerOrg[i]][Money]=Organization[PlayerOrg[i]][Money]-Organization[PlayerOrg[i]][Wage]/10;
				  	}
				}
		 	}
			new randlotto=70+random(11);
			if(randlotto==Lotto[i])
			{
			    Lotto[i]=0;
				GivePlayerMoneyEx(i,5000);
	            GameTextForPlayer(i,"~g~+$5000",1000,1);
				format(string,sizeof(string),"Lottery: $5000",Lotto[i]);
				SendClientMessage(i,-1,string);
			}
			if(Lotto[i]>0&&randlotto!=Lotto[i])
			{
				Lotto[i]=0;
				GameTextForPlayer(i,"You did not win any lottery~n~better luck next time",4500,4);
			}
			format(string,sizeof(string),"Your New Balance : $%d",Bank[i]);
			SendClientMessage(i,-1,string);
			SendClientMessage(i,YELLOW,"$$$==================$$$");
			if(Insurance[i]==1&&Car[i]>0)
			{
				if(Bank[i]<0)
				{
				    Insurance[i]=0;
				    SendClientMessage(i,-1,"You have gone in debts,therefore,insurance of your vehicle has been discontinued");
    			}
			}
			if(BID[i]>0){SendClientMessage(i,YELLOW,"Your business profit has been updated");}
			if(GetPlayerWantedLevel(i) > 0){SetPlayerWantedLevel(i,GetPlayerWantedLevel(i)-1);}
			if(PlayerOrgType(i)==LAW){SendClientMessage(i,BLUE,"RADIO - The wanted levels have been decreased by one star");}
  		}
	}
 	return 1;
}
//==============================================================================
stock LSAP(playerid)
{
	if(IsPlayerInRangeOfPoint(playerid,10,1959,-2189,13))
	{
		if(lsap==0)
		{
			MoveDynamicObject(lsap1,1969,-2189,13.5,1);
			MoveDynamicObject(lsap2,1954,-2189,13.5,1);
			lsap=1;
		}
		return 1;
	}
	if(lsap==1)
	{
		MoveDynamicObject(lsap1,1964.313476,-2189,13.5,1);
		MoveDynamicObject(lsap2,1959.052734,-2189,13.5,1);
		lsap=0;
	}
	return 1;
}
//==============================================================================
stock SetupPlayerForClassSelection(playerid)
{
	SetPlayerInterior(playerid,14);
	SetPlayerFacingAngle(playerid,270.0);
	PlayerPlaySound(playerid,1186,0.0,0.0,5.0);
	SetPlayerPos(playerid,258.4893,-41.4008,1002.0234);
	SetPlayerCameraPos(playerid,256.0815,-43.0475,1004.0234);
	SetPlayerCameraLookAt(playerid,258.4893,-41.4008,1002.0234);
	return 1;
}
//==============================================================================
stock PersonalVehicle(vehicleid)
{
	for(new i=0;i<MAX_PLAYERS;i++)
	{
		if(vehicleid==Car[i]||vehicleid==ACar[i])
  		return 1;
	}
	return 0;
}
//==============================================================================
stock IsBicycle(vehicleid)
{
	switch(GetVehicleModel(vehicleid))
	{case 481,509,510: return 1;}
	return 0;
}
//==============================================================================
stock GetPlayer2DZone(playerid,zone[],len)
{
	new Float:x,Float:y,Float:z;
 	GetPlayerPos(playerid,x,y,z);
  	for(new i=0; i !=sizeof(gSAZones); i++ )
   	{
    	if(x >=gSAZones[i][SAZONE_AREA][0] && x <=gSAZones[i][SAZONE_AREA][3] && y >=gSAZones[i][SAZONE_AREA][1] && y <=gSAZones[i][SAZONE_AREA][4] && z >=gSAZones[i][SAZONE_AREA][2] && z <=gSAZones[i][SAZONE_AREA][5])
     	{
      		return format(zone,len,gSAZones[i][SAZONE_NAME],0);
        }
   	}
    return 0;
}
//==============================================================================
stock IsPlayerInZone(playerid,zone[])
{
	new TmpZone[MAX_ZONE_NAME];
 	GetPlayer2DZone(playerid,TmpZone,sizeof(TmpZone));
  	for(new i=0; i !=sizeof(gSAZones); i++)
   	{
   		if(strfind(TmpZone,zone,true) !=-1)
    	return 1;
    }
   	return 0;
}
//==============================================================================
stock GetVehicle2DZone(vehicleid,zone[],len)
{
	new Float:x,Float:y,Float:z;
	GetVehiclePos(vehicleid,x,y,z);
 	for(new i=0; i !=sizeof(gSAZones); i++ )
 	{
		if(x >=gSAZones[i][SAZONE_AREA][0] && x <=gSAZones[i][SAZONE_AREA][3] && y >=gSAZones[i][SAZONE_AREA][1] && y <=gSAZones[i][SAZONE_AREA][4])
		{
		    return format(zone,len,gSAZones[i][SAZONE_NAME],0);
		}
	}
	return 0;
}
//==============================================================================
stock IsJailedOrMuted(playerid)
{
	if(!IsPlayerConnectedEx(playerid))return 1;
    if(Mute[playerid]>0)return SendClientMessage(playerid,RED,"ERROR: {FFFFFF}You are muted");
	if(Jailed[playerid]>0)return SendClientMessage(playerid,RED,"ERROR: {FFFFFF}You are jailed");
	if(CMDUsed[playerid]==1)return SendClientMessage(playerid,RED,"ERROR: {FFFFFF}Anti Command Flood");
	CMDUsed[playerid]=1;
 	return 0;
}
//==============================================================================
stock IsMuted(playerid)
{
	if(!IsPlayerConnectedEx(playerid))return 1;
    if(Mute[playerid]>0)return SendClientMessage(playerid,RED,"ERROR: {FFFFFF}You are muted");
	if(CMDUsed[playerid]==1)return SendClientMessage(playerid,RED,"ERROR: {FFFFFF}Anti Command Flood");
	CMDUsed[playerid]=1;
 	return 0;
}
//==============================================================================
stock IsPlayerConnectedEx(playerid)
{
    if (IsPlayerConnected(playerid)&&IsLogged[playerid]==1&&Died[playerid]==0&&playerid!=INVALID_PLAYER_ID) return 1;
    return 0;
}
//==============================================================================
stock IsValidSkin(SkinID)
{
	if((SkinID >=1 && SkinID <=299)) return 1;
 	else return 0;
}
//==============================================================================
stock IsOrgSkin(SkinID)
{
	for(new i=1;i<OrgsCount+1;i++)
	if(SkinID==Organization[i][Lsk]||SkinID==Organization[i][OSkin]||SkinID==Organization[i][Skin1])return 1;
	return 0;
}
//==============================================================================
stock CreateAtm(Float:x,Float:y,Float:z,Float:rz)
{
	for(new i=0; i < sizeof(AtmInfo); i++)
 	{
  		if(AtmInfo[i][aCreated]==0)
    	{
            AtmInfo[i][aCreated]=1;
            AtmInfo[i][aX]=x;
            AtmInfo[i][aY]=y;
            AtmInfo[i][aZ]=z;
            AtmInfo[i][arZ]=rz;
    		CreateDynamic3DTextLabel("/atm",-1,x,y,z,7);
            AtmInfo[i][aObject]=CreateDynamicObject(2754,x,y,z-0.3,0,0,rz);
            return 1;
     	}
	}
 	return 0;
}
//==============================================================================
stock CreateTextdraws()
{
	ssecond=0;sminute=0;
    Textdraw1=TextDrawCreate(609.5,377," ");
    TextDrawLetterSize(Textdraw1,0.3,1.3);
    TextDrawSetOutline(Textdraw1,1);
    TextDrawAlignment(Textdraw1,3);
    Textdraw2=TextDrawCreate(609.5,387," ");
    TextDrawLetterSize(Textdraw2,0.3,1.3);
    TextDrawSetOutline(Textdraw2,1);
    TextDrawAlignment(Textdraw2,3);
    Textdraw3=TextDrawCreate(609.5,397," ");
    TextDrawLetterSize(Textdraw3,0.3,1.3);
    TextDrawSetOutline(Textdraw3,1);
    TextDrawAlignment(Textdraw3,3);
    Textdraw4=TextDrawCreate(609.5,407," ");
    TextDrawLetterSize(Textdraw4,0.3,1.3);
    TextDrawSetOutline(Textdraw4,1);
    TextDrawAlignment(Textdraw4,3);
    Textdraw5=TextDrawCreate(609.5,417," ");
    TextDrawLetterSize(Textdraw5,0.3,1.3);
    TextDrawSetOutline(Textdraw5,1);
    TextDrawAlignment(Textdraw5,3);
    for(new i=0; i<MAX_PLAYERS; i++)
	{
      	Zones[i]=TextDrawCreate(87,424," ");
    	//td_fuel[i]=TextDrawCreate(498,140," ");
    	td_fuel[i]=TextDrawCreate(609.5,357," ");
     	//sdisplay[i]=TextDrawCreate(498,123," ");
     	sdisplay[i]=TextDrawCreate(609.5,346," ");
    }
	return 1;
}
//==============================================================================
stock IsDL(vehicleid)
{
	for(new i=0; i < 5; i++)
	{
	    if(vehicleid==DL1[i]||vehicleid==DL1[5])
	    {
	        dealer=1;
	        return 1;
 		}
	    if(vehicleid==DL2[i]||vehicleid==DL2[5])
	    {
	        dealer=2;
	        return 1;
 		}
	    if(vehicleid==DL3[i])
	    {
	        dealer=3;
	        return 1;
 		}
	    if(vehicleid==DL4[i])
	    {
	        dealer=4;
	        return 1;
 		}
	    if(vehicleid==DL5[i])
	    {
	        dealer=5;
	        return 1;
		}
	    if(vehicleid==DL6[i]||vehicleid==DL6[5])
	    {
	        dealer=6;
	        return 1;
 		}
	    if(vehicleid==DL7[i]||vehicleid==DL7[5])
	    {
	        dealer=7;
	        return 1;
 		}
	    if(vehicleid==DL8[i]||vehicleid==DL8[5])
	    {
	        dealer=8;
	        return 1;
 		}
	    if(vehicleid==DL9[i]||vehicleid==DL9[5])
	    {
	        dealer=9;
	        return 1;
 		}
	    if(vehicleid==DL10[i]||vehicleid==DL10[5])
	    {
	        dealer=10;
	        return 1;
 		}
	    if(vehicleid==DL11[i]||vehicleid==DL11[5])
	    {
	        dealer=11;
	        return 1;
 		}
	    if(vehicleid==DL12[i])
	    {
	        dealer=12;
	        return 1;
 		}
	}
	return 0;
}
//==============================================================================
stock BRVehicle(vehicleid)
{
	for(new i=0; i < sizeof(br); i++)
	{if(vehicleid==br[i]) return 1;}
	return 0;
}
//==============================================================================
stock RPVehicle(vehicleid)
{
	for(new i=0; i < sizeof(RPCars); i++)
	{if(vehicleid==RPCars[i]) return 1;}
	return 0;
}
//==============================================================================
stock SKVehicle(vehicleid)
{
	for(new i=0; i < sizeof(sk); i++)
	{if(vehicleid==sk[i]) return 1;}
	return 0;
}
//==============================================================================
stock IsTruck(vehicleid)
{
	new m=GetVehicleModel(vehicleid);
	if(m==406||m==573||m==444||m==556||m==557||m==568||m==424
	||m==504||m==457||m==483||m==508||m==571||m==500||m==495||m==539||m==499
	||m==498||m==524||m==532||m==578||m==486||m==455||m==588||m==403||m==423
	||m==414||m==443||m==515||m==514||m==531||m==456||m==459||m==422||m==482
	||m==530||m==418||m==572||m==582||m==413||m==440||m==543||m==583||m==478
	||m==554){return 1;}
	return 0;
}
//==============================================================================
stock IsRC(vehicleid)
{
	new m=GetVehicleModel(vehicleid);
	if(m==441||m==464|| m==465|| m==501|| m==564|| m==594
	|| m==435|| m==450|| m==569|| m==570|| m==584|| m==590
	|| m==591|| m==606|| m==607|| m==608|| m==610|| m==611)
	{return 1;}
	return 0;
}
//==============================================================================
stock IsCar(vehicleid)
{
	new m=GetVehicleModel(vehicleid);
	if(m==536||m==575||m==534||m==567||m==535||m==576||m==412||m==562||m==598||m==436||
	m==565||m==559||m==561||m==560||m==558||m==402||m==542||m==603||m==475||m==579||
	m==400||m==404||m==489||m==479||m==442||m==458||m==429||m==541||m==415||m==480||
	m==434||m==494||m==411||m==506||m==451||m==555||m==477||m==485||m==431||m==438||
	m==437||m==574||m==420||m==525||m==409||m==552||m==416||m==433||m==427||m==490||
	m==528||m==407||m==570||m==597||m==599||m==428||m==601||m==445||m==507||m==585||
	m==587||m==466||m==492||m==546||m==551||m==516||m==467||m==426||m==547||m==405||
	m==409||m==550||m==566||m==540||m==421||m==529||m==602||m==496||m==401||m==518||
	m==527||m==589||m==419||m==533||m==526||m==474||m==545||m==517||m==410||m==600||
	m==580||m==439||m==549||m==491)
	{return 1;}
	return 0;
}
//==============================================================================
stock IsCopCar(vehicleid)
{
	new m=GetVehicleModel(vehicleid);
	if(m==523||m==427|| m==490|| m==528|| m==596|| m==599|| m==423|| m==601||m==470||m==520)
	{return 1;}
	return 0;
}
//==============================================================================
stock IsPlane(vehicleid)
{
	new m=GetVehicleModel(vehicleid);
	if(m==592||m==577||m==593||m==520 ||m==553||m==476||m==519||m==460||m==513||m==548
	|| m==511||m==512|| m==425||m==417||m==487||m==488||m==497||m==469||m==563||m==447)
	{return 1;}
	return 0;
}
//==============================================================================
stock IsBike(vehicleid)
{
	new m=GetVehicleModel(vehicleid);
	if(m==462||m==521||m==461||m==463||m==581
	||m==448||m==586||m==523||m==468||m==471||m==522)
	{return 1;}
	return 0;
}
//==============================================================================
stock IsBoat(vehicleid)
{
	new m=GetVehicleModel(vehicleid);
	if(m==472||m==473||m==493||m==595||m==484
	||m==430||m==453||m==452||m==446||m==454)
	{return 1;}
	return 0;
}
//==============================================================================
stock SendMessageToAdmins(color,const string[])
{
    for(new i=0; i < MAX_PLAYERS; i++)
    {
        if(IsPlayerConnectedEx(i))
        if(AdminLevel[i] >=1)
        SendClientMessage(i,color,string);
    }
    return 1;
}
//==============================================================================
stock IsAtFuelStation(playerid)
{
	if(IsPlayerInRangeOfPoint(playerid,10,1595.5406,2198.0520,10.3863) || IsPlayerInRangeOfPoint(playerid,10,2202.0649,2472.6697,10.5677) ||
	IsPlayerInRangeOfPoint(playerid,10,2115.1929,919.9908,10.5266) || IsPlayerInRangeOfPoint(playerid,10,2640.7209,1105.9565,10.5274) ||
	IsPlayerInRangeOfPoint(playerid,10,608.5971,1699.6238,6.9922) || IsPlayerInRangeOfPoint(playerid,10,618.4878,1684.5792,6.9922) ||
	IsPlayerInRangeOfPoint(playerid,10,2146.3467,2748.2893,10.5245) || IsPlayerInRangeOfPoint(playerid,10,-1679.4595,412.5129,6.9973) ||
	IsPlayerInRangeOfPoint(playerid,10,-1327.5607,2677.4316,49.8093) || IsPlayerInRangeOfPoint(playerid,10,-1470.0050,1863.2375,32.3521) ||
	IsPlayerInRangeOfPoint(playerid,10,-2409.2200,976.2798,45.2969) || IsPlayerInRangeOfPoint(playerid,10,-2244.1396,-2560.5833,31.9219) ||
	IsPlayerInRangeOfPoint(playerid,10,-1606.0544,-2714.3083,48.5335) || IsPlayerInRangeOfPoint(playerid,10,1937.4293,-1773.1865,13.3828) ||
	IsPlayerInRangeOfPoint(playerid,10,-91.3854,-1169.9175,2.4213) || IsPlayerInRangeOfPoint(playerid,10,1383.4221,462.5385,20.1506) ||
	IsPlayerInRangeOfPoint(playerid,10,660.4590,-565.0394,16.3359) || IsPlayerInRangeOfPoint(playerid,10,1381.7206,459.1907,20.3452) ||
	IsPlayerInRangeOfPoint(playerid,10,-1605.7156,-2714.4573,48.5335)||IsPlayerInRangeOfPoint(playerid,10,1362.7048,1698.0651,10.5474)||
	IsPlayerInRangeOfPoint(playerid,10,1484.1288,-2447.6877,13.2818)||IsPlayerInRangeOfPoint(playerid,10,-1350.4796,-229.8320,13.8710))
	{ return 1; }
	return 0;
}
//==============================================================================
stock VehicleOccupied(vehicleid)
{
	for(new i=0;i<MAX_PLAYERS;i++)
	{
		if(IsPlayerInVehicle(i,vehicleid))
		return 1;
	}
	return 0;
}
//==============================================================================
stock IsAtClothesShop(playerid)
{
	if(IsPlayerInRangeOfPoint(playerid,20,161.5236,-83.3203,1001.8047)||
 	IsPlayerInRangeOfPoint(playerid,20,207.7182,-100.9436,1005.2578)  ||
  	IsPlayerInRangeOfPoint(playerid,20,203.9261,-43.2656,1001.8047)   ||
   	IsPlayerInRangeOfPoint(playerid,20,206.3746,-8.1824,1001.2109) 	  ||
    IsPlayerInRangeOfPoint(playerid,20,207.0685,-129.1833,1003.5078))
    { return 1; }
    return 0;
}
//==============================================================================
stock PlayerName(playerid)
{
  	new playername[24];
  	GetPlayerName(playerid,playername,24);
  	return playername;
}
//==============================================================================
stock GetVehicleName(vehicleid,model[],len)
{
	new checking=GetVehicleModel(vehicleid);
	if(checking==400) return format(model,len,"Landstalker",0);
	else if(checking==401) return format(model,len,"Bravura",0);
	else if(checking==402) return format(model,len,"Buffalo",0);
	else if(checking==403) return format(model,len,"Linerunner",0);
	else if(checking==404) return format(model,len,"Perenail",0);
	else if(checking==405) return format(model,len,"Sentinel",0);
	else if(checking==406) return format(model,len,"Dumper",0);
	else if(checking==407) return format(model,len,"Firetruck",0);
	else if(checking==408) return format(model,len,"Trashmaster",0);
	else if(checking==409) return format(model,len,"Stretch",0);
	else if(checking==410) return format(model,len,"Manana",0);
	else if(checking==411) return format(model,len,"Infernus",0);
	else if(checking==412) return format(model,len,"Vodooo",0);
	else if(checking==413) return format(model,len,"Pony",0);
	else if(checking==414) return format(model,len,"Mule",0);
	else if(checking==415) return format(model,len,"Cheetah",0);
	else if(checking==416) return format(model,len,"Ambulance",0);
	else if(checking==417) return format(model,len,"Leviathan",0);
	else if(checking==418) return format(model,len,"Moonbeam",0);
	else if(checking==419) return format(model,len,"Esperanto",0);
	else if(checking==420) return format(model,len,"Taxi",0);
	else if(checking==421) return format(model,len,"Washington",0);
	else if(checking==422) return format(model,len,"Bobcat",0);
	else if(checking==423) return format(model,len,"Mr Whoopee",0);
	else if(checking==424) return format(model,len,"BF Injection",0);
	else if(checking==425) return format(model,len,"Hunter",0);
	else if(checking==426) return format(model,len,"Premier",0);
	else if(checking==427) return format(model,len,"S.W.A.T Truck",0);
	else if(checking==428) return format(model,len,"Securicar",0);
	else if(checking==429) return format(model,len,"Banshee",0);
	else if(checking==430) return format(model,len,"Predator",0);
	else if(checking==431) return format(model,len,"Bus",0);
	else if(checking==432) return format(model,len,"Rhino",0);
	else if(checking==433) return format(model,len,"Barracks",0);
	else if(checking==434) return format(model,len,"Hotknife",0);
	else if(checking==435) return format(model,len,"Trailer",0);
	else if(checking==436) return format(model,len,"Previon",0);
	else if(checking==437) return format(model,len,"Coach",0);
	else if(checking==438) return format(model,len,"Cabbie",0);
	else if(checking==439) return format(model,len,"Stallion",0);
	else if(checking==440) return format(model,len,"Rumpo",0);
	else if(checking==441) return format(model,len,"RC Bandit",0);
	else if(checking==442) return format(model,len,"Romero",0);
	else if(checking==443) return format(model,len,"Packer",0);
	else if(checking==444) return format(model,len,"Monster",0);
	else if(checking==445) return format(model,len,"Admiral",0);
	else if(checking==446) return format(model,len,"Squalo",0);
	else if(checking==447) return format(model,len,"Seasparrow",0);
	else if(checking==448) return format(model,len,"Pizza Boy",0);
	else if(checking==449) return format(model,len,"Tram",0);
	else if(checking==450) return format(model,len,"Trailer 2",0);
	else if(checking==451) return format(model,len,"Turismo",0);
	else if(checking==452) return format(model,len,"Speeder",0);
	else if(checking==453) return format(model,len,"Refeer",0);
	else if(checking==454) return format(model,len,"Tropic",0);
	else if(checking==455) return format(model,len,"Flatbed",0);
	else if(checking==456) return format(model,len,"Yankee",0);
	else if(checking==457) return format(model,len,"Caddy",0);
	else if(checking==458) return format(model,len,"Solair",0);
	else if(checking==459) return format(model,len,"Top Fun",0);
	else if(checking==460) return format(model,len,"Skimmer",0);
	else if(checking==461) return format(model,len,"PCJ-600",0);
	else if(checking==462) return format(model,len,"Faggio",0);
	else if(checking==463) return format(model,len,"Freeway",0);
	else if(checking==464) return format(model,len,"RC Baron",0);
	else if(checking==465) return format(model,len,"RC Raider",0);
	else if(checking==466) return format(model,len,"Glendade",0);
	else if(checking==467) return format(model,len,"Oceanic",0);
	else if(checking==468) return format(model,len,"Sanchez",0);
	else if(checking==469) return format(model,len,"Sparrow",0);
	else if(checking==470) return format(model,len,"Patriot",0);
	else if(checking==471) return format(model,len,"Quad",0);
	else if(checking==472) return format(model,len,"Coastguard",0);
	else if(checking==473) return format(model,len,"Dinghy",0);
	else if(checking==474) return format(model,len,"Hermes",0);
	else if(checking==475) return format(model,len,"Sabre",0);
	else if(checking==476) return format(model,len,"Rustler",0);
	else if(checking==477) return format(model,len,"ZR-350",0);
	else if(checking==478) return format(model,len,"Walton",0);
	else if(checking==479) return format(model,len,"Regina",0);
	else if(checking==480) return format(model,len,"Comet",0);
	else if(checking==481) return format(model,len,"BMX",0);
	else if(checking==482) return format(model,len,"Burrito",0);
	else if(checking==483) return format(model,len,"Camper",0);
	else if(checking==484) return format(model,len,"Marquis",0);
	else if(checking==485) return format(model,len,"Baggage",0);
	else if(checking==486) return format(model,len,"Dozer",0);
	else if(checking==487) return format(model,len,"Maverick",0);
	else if(checking==488) return format(model,len,"News Maverick",0);
	else if(checking==489) return format(model,len,"Rancher",0);
	else if(checking==490) return format(model,len,"Federal Rancher",0);
	else if(checking==491) return format(model,len,"Virgo",0);
	else if(checking==492) return format(model,len,"Greenwood",0);
	else if(checking==493) return format(model,len,"Jetmax",0);
	else if(checking==494) return format(model,len,"Hotring",0);
	else if(checking==495) return format(model,len,"Sandking",0);
	else if(checking==496) return format(model,len,"Blista Compact",0);
	else if(checking==497) return format(model,len,"Police Maverick",0);
	else if(checking==498) return format(model,len,"Boxville",0);
	else if(checking==499) return format(model,len,"Benson",0);
	else if(checking==500) return format(model,len,"Mesa",0);
	else if(checking==501) return format(model,len,"RC Goblin",0);
	else if(checking==502) return format(model,len,"Hotring A",0);
	else if(checking==503) return format(model,len,"Hotring B",0);
	else if(checking==504) return format(model,len,"Blooding Banger",0);
	else if(checking==505) return format(model,len,"Rancher",0);
	else if(checking==506) return format(model,len,"Super GT",0);
	else if(checking==507) return format(model,len,"Elegant",0);
	else if(checking==508) return format(model,len,"Journey",0);
	else if(checking==509) return format(model,len,"Bike",0);
	else if(checking==510) return format(model,len,"Mountain Bike",0);
	else if(checking==511) return format(model,len,"Beagle",0);
	else if(checking==512) return format(model,len,"Cropduster",0);
	else if(checking==513) return format(model,len,"Stuntplane",0);
	else if(checking==514) return format(model,len,"Petrol",0);
	else if(checking==515) return format(model,len,"Roadtrain",0);
	else if(checking==516) return format(model,len,"Nebula",0);
	else if(checking==517) return format(model,len,"Majestic",0);
	else if(checking==518) return format(model,len,"Buccaneer",0);
	else if(checking==519) return format(model,len,"Shamal",0);
	else if(checking==520) return format(model,len,"Hydra",0);
	else if(checking==521) return format(model,len,"FCR-300",0);
	else if(checking==522) return format(model,len,"NRG-500",0);
	else if(checking==523) return format(model,len,"HPV-1000",0);
	else if(checking==524) return format(model,len,"Cement Truck",0);
	else if(checking==525) return format(model,len,"Towtruck",0);
	else if(checking==526) return format(model,len,"Fortune",0);
	else if(checking==527) return format(model,len,"Cadrona",0);
	else if(checking==528) return format(model,len,"Federal Truck",0);
	else if(checking==529) return format(model,len,"Williard",0);
	else if(checking==530) return format(model,len,"Fork Lift",0);
	else if(checking==531) return format(model,len,"Tractor",0);
	else if(checking==532) return format(model,len,"Combine",0);
	else if(checking==533) return format(model,len,"Feltzer",0);
	else if(checking==534) return format(model,len,"Remington",0);
	else if(checking==535) return format(model,len,"Slamvan",0);
	else if(checking==536) return format(model,len,"Blade",0);
	else if(checking==537) return format(model,len,"Freight",0);
	else if(checking==538) return format(model,len,"Streak",0);
	else if(checking==539) return format(model,len,"Vortex",0);
	else if(checking==540) return format(model,len,"Vincent",0);
	else if(checking==541) return format(model,len,"Bullet",0);
	else if(checking==542) return format(model,len,"Clover",0);
	else if(checking==543) return format(model,len,"Sadler",0);
	else if(checking==544) return format(model,len,"Stairs Firetruck",0);
	else if(checking==545) return format(model,len,"Hustler",0);
	else if(checking==546) return format(model,len,"Intruder",0);
	else if(checking==547) return format(model,len,"Primo",0);
	else if(checking==548) return format(model,len,"Cargobob",0);
	else if(checking==549) return format(model,len,"Tampa",0);
	else if(checking==550) return format(model,len,"Sunrise",0);
	else if(checking==551) return format(model,len,"Merit",0);
	else if(checking==552) return format(model,len,"Utility Van",0);
	else if(checking==553) return format(model,len,"Nevada",0);
	else if(checking==554) return format(model,len,"Yosemite",0);
	else if(checking==555) return format(model,len,"Windsor",0);
	else if(checking==556) return format(model,len,"Monster A",0);
	else if(checking==557) return format(model,len,"Monster B",0);
	else if(checking==558) return format(model,len,"Uranus",0);
	else if(checking==559) return format(model,len,"Jester",0);
	else if(checking==560) return format(model,len,"Sultan",0);
	else if(checking==561) return format(model,len,"Stratum",0);
	else if(checking==562) return format(model,len,"Elegy",0);
	else if(checking==563) return format(model,len,"Raindance",0);
	else if(checking==564) return format(model,len,"RC Tiger",0);
	else if(checking==565) return format(model,len,"Flash",0);
	else if(checking==566) return format(model,len,"Tahoma",0);
	else if(checking==567) return format(model,len,"Savanna",0);
	else if(checking==568) return format(model,len,"Bandito",0);
	else if(checking==569) return format(model,len,"Freight Flat",0);
	else if(checking==570) return format(model,len,"Streak",0);
	else if(checking==571) return format(model,len,"Kart",0);
	else if(checking==572) return format(model,len,"Mower",0);
	else if(checking==573) return format(model,len,"Duneride",0);
	else if(checking==574) return format(model,len,"Sweeper",0);
	else if(checking==575) return format(model,len,"Broadway",0);
	else if(checking==576) return format(model,len,"Tornado",0);
	else if(checking==577) return format(model,len,"AT-400",0);
	else if(checking==578) return format(model,len,"DFT-30",0);
	else if(checking==579) return format(model,len,"Huntley",0);
	else if(checking==580) return format(model,len,"Stafford",0);
	else if(checking==581) return format(model,len,"BF-400",0);
	else if(checking==582) return format(model,len,"Raindance",0);
	else if(checking==583) return format(model,len,"News Van",0);
	else if(checking==584) return format(model,len,"Tug",0);
	else if(checking==585) return format(model,len,"Petrol Tanker",0);
	else if(checking==586) return format(model,len,"Wayfarer",0);
	else if(checking==587) return format(model,len,"Euros",0);
	else if(checking==588) return format(model,len,"Hotdog",0);
	else if(checking==589) return format(model,len,"Club",0);
	else if(checking==590) return format(model,len,"Freight Box",0);
	else if(checking==591) return format(model,len,"Trailer 3",0);
	else if(checking==592) return format(model,len,"Andromada",0);
	else if(checking==593) return format(model,len,"Dodo",0);
	else if(checking==594) return format(model,len,"RC Cam",0);
	else if(checking==595) return format(model,len,"Launch",0);
	else if(checking==596) return format(model,len,"LSPD Patrol Car",0);
	else if(checking==597) return format(model,len,"FBI Patrol Car",0);
	else if(checking==598) return format(model,len,"NG Patrol Car",0);
	else if(checking==599) return format(model,len,"LSPD Patrol Ranger",0);
	else if(checking==600) return format(model,len,"Picador",0);
	else if(checking==601) return format(model,len,"S.W.A.T Tank",0);
    else if(checking==602) return format(model,len,"Alpha",0);
	else if(checking==603) return format(model,len,"Phoenix",0);
	else if(checking==609) return format(model,len,"Boxville",0);
	else return format(model,len,"None",0);
}
//==============================================================================
stock GetVehiclePrice(vehicleid)
{
	new model=GetVehicleModel(vehicleid);
	if(model==400) return 40000;
	else if(model==401) return 30000;
	else if(model==402) return 100000;
	else if(model==403) return 90000;
	else if(model==404) return 25000;
	else if(model==405) return 40000;
	else if(model==406) return 200000;
	else if(model==408) return 80000;
	else if(model==409) return 90000;
	else if(model==410) return 25000;
	else if(model==411) return 150000;
	else if(model==412) return 60000;
	else if(model==413) return 55000;
	else if(model==414) return 75000;
	else if(model==415) return 100000;
	else if(model==417) return 250000;
	else if(model==418) return 20000;
	else if(model==419) return 30000;
	else if(model==421) return 75000;
	else if(model==422) return 60000;
	else if(model==423) return 100000;
	else if(model==424) return 85000;
	else if(model==426) return 80000;
	else if(model==428) return 40000;
	else if(model==429) return 125000;
	else if(model==434) return 150000;
	else if(model==436) return 45000;
	else if(model==439) return 55000;
	else if(model==443) return 100000;
	else if(model==444) return 175000;
	else if(model==445) return 75000;
	else if(model==446) return 175000;
	else if(model==451) return 150000;
	else if(model==452) return 175000;
	else if(model==453) return 125000;
	else if(model==454) return 130000;
	else if(model==455) return 80000;
	else if(model==456) return 70000;
	else if(model==457) return 85000;
	else if(model==458) return 50000;
	else if(model==459) return 60000;
	else if(model==460) return 215000;
	else if(model==461) return 40000;
	else if(model==462) return 20000;
	else if(model==463) return 35000;
	else if(model==466) return 70000;
	else if(model==467) return 70000;
	else if(model==468) return 35000;
	else if(model==469) return 175000;
	else if(model==471) return 15000;
	else if(model==472) return 125000;
	else if(model==473) return 125000;
	else if(model==474) return 65000;
	else if(model==475) return 65000;
	else if(model==477) return 100000;
	else if(model==478) return 40000;
	else if(model==479) return 75000;
	else if(model==480) return 150000;
	else if(model==481) return 5000;
	else if(model==482) return 65000;
	else if(model==483) return 70000;
	else if(model==484) return 125000;
	else if(model==485) return 30000;
	else if(model==486) return 150000;
	else if(model==487) return 200000;
	else if(model==489) return 75000;
	else if(model==491) return 60000;
	else if(model==492) return 70000;
	else if(model==493) return 200000;
	else if(model==494) return 100000;
	else if(model==495) return 90000;
	else if(model==496) return 60000;
	else if(model==498) return 80000;
	else if(model==499) return 80000;
	else if(model==500) return 70000;
	else if(model==502) return 100000;
	else if(model==503) return 100000;
	else if(model==504) return 100000;
	else if(model==505) return 75000;
	else if(model==506) return 115000;
	else if(model==507) return 75000;
	else if(model==508) return 50000;
	else if(model==509) return 2500;
	else if(model==510) return 10000;
	else if(model==511) return 215000;
	else if(model==512) return 200000;
	else if(model==513) return 220000;
	else if(model==514) return 90000;
	else if(model==515) return 90000;
	else if(model==516) return 67500;
	else if(model==517) return 70000;
	else if(model==518) return 65000;
	else if(model==519) return 300000;
	else if(model==521) return 35000;
	else if(model==522) return 75000;
	else if(model==524) return 80000;
	else if(model==526) return 65000;
	else if(model==527) return 65000;
	else if(model==529) return 70000;
	else if(model==530) return 90000;
	else if(model==531) return 40000;
	else if(model==532) return 200000;
	else if(model==533) return 70000;
	else if(model==534) return 76000;
	else if(model==535) return 80000;
	else if(model==536) return 75000;
	else if(model==539) return 150000;
	else if(model==540) return 70000;
	else if(model==541) return 150000;
	else if(model==542) return 80000;
	else if(model==543) return 50000;
	else if(model==545) return 125000;
	else if(model==546) return 70000;
	else if(model==547) return 70000;
	else if(model==549) return 60000;
	else if(model==550) return 90000;
	else if(model==551) return 80000;
	else if(model==552) return 30000;
	else if(model==553) return 250000;
	else if(model==554) return 50000;
	else if(model==555) return 50000;
	else if(model==556) return 200000;
	else if(model==557) return 200000;
	else if(model==558) return 70000;
	else if(model==559) return 70000;
	else if(model==560) return 115000;
	else if(model==561) return 50000;
	else if(model==562) return 95000;
	else if(model==563) return 200000;
	else if(model==565) return 90000;
	else if(model==566) return 70000;
	else if(model==567) return 75000;
	else if(model==568) return 50000;
	else if(model==571) return 85000;
	else if(model==572) return 15000;
	else if(model==573) return 90000;
	else if(model==575) return 80000;
	else if(model==576) return 65000;
	else if(model==578) return 90000;
	else if(model==579) return 90000;
	else if(model==580) return 75000;
	else if(model==581) return 30000;
	else if(model==583) return 25000;
	else if(model==585) return 35000;
	else if(model==586) return 20000;
	else if(model==587) return 90000;
	else if(model==588) return 90000;
	else if(model==589) return 90000;
	else if(model==592) return 350000;
	else if(model==593) return 225000;
	else if(model==600) return 50000;
    else if(model==602) return 75000;
	else if(model==603) return 100000;
	else if(model==609) return 85000;
	else return 0;
}
//==============================================================================
stock CreateOrganization(name[40],skin,skin1,lsk,Float:x,Float:y,Float:z,interior,wp1=0,a1=0,wp2=0,a2=0,color,type)
{
	OrgsCount++;new string[100];
	if (OrgsCount >=MAX_ORGS)return printf("You have exceeded the MAX_ORG limit");
	Organization[OrgsCount][Name]=name;
	Organization[OrgsCount][OSkin]=skin;
	Organization[OrgsCount][Skin1]=skin1;
	Organization[OrgsCount][Lsk]=lsk;
	Organization[OrgsCount][OrgX]=x;
	Organization[OrgsCount][OrgY]=y;
	Organization[OrgsCount][OrgZ]=z;
	Organization[OrgsCount][Interior]=interior;
	Organization[OrgsCount][OWeapons][0]=wp1;
	Organization[OrgsCount][Ammo][0]=a1;
	Organization[OrgsCount][OWeapons][1]=wp2;
	Organization[OrgsCount][Ammo][1]=a2;
	Organization[OrgsCount][Color]=hexToDec(color);
	Organization[OrgsCount][Type]=type;
	format(string,sizeof(string),"%s",name);
	CreateDynamic3DTextLabel(string,0xFFFFFFFF,x,y,z+0.2,12);
	Organization[OrgsCount][CP]=CreateDynamicCP(x,y,z,1.0,0,interior,-1,20.0);
	if(!fexist("Organizations.ini"))
	{
		Organization[OrgsCount][Drugs]=0;
		Organization[OrgsCount][Money]=0;
		Organization[OrgsCount][Wage]=200;
		Organization[OrgsCount][FStyle]=4;
		Organization[OrgsCount][Members]=0;
		Organization[OrgsCount][Protection]=0;
    	format(Organization[OrgsCount][Turf],25,"None");
 		format(Organization[OrgsCount][Leader],25,"None");
		format(Organization[OrgsCount][Member1],25,"None");
		format(Organization[OrgsCount][Member2],25,"None");
		format(Organization[OrgsCount][Member3],25,"None");
		format(Organization[OrgsCount][Member4],25,"None");
		format(Organization[OrgsCount][Member5],25,"None");
		format(Organization[OrgsCount][Member6],25,"None");
		format(Organization[OrgsCount][Member7],25,"None");
	}
	if(fexist("Organizations.ini"))
	{
 		format(string,128,"%s:Wage",GetOrgName(OrgsCount));
	    Organization[OrgsCount][Wage]=INI_Int("Organizations.ini",string);
 		format(string,128,"%s:Drugs",GetOrgName(OrgsCount));
		Organization[OrgsCount][Drugs]=INI_Int("Organizations.ini",string);
 		format(string,128,"%s:Money",GetOrgName(OrgsCount));
		Organization[OrgsCount][Money]=INI_Int("Organizations.ini",string);
 		format(string,128,"%s:FStyle",GetOrgName(OrgsCount));
		Organization[OrgsCount][FStyle]=INI_Int("Organizations.ini",string);
 		format(string,128,"%s:Members",GetOrgName(OrgsCount));
		Organization[OrgsCount][Members]=INI_Int("Organizations.ini",string);
 		format(string,128,"%s:Protection",GetOrgName(OrgsCount));
		Organization[OrgsCount][Protection]=INI_Int("Organizations.ini",string);
		format(string,128,"%s:Turf",GetOrgName(OrgsCount));
    	format(Organization[OrgsCount][Turf],25,INI_Get("Organizations.ini",string));
 		format(string,128,"%s:Leader",GetOrgName(OrgsCount));
 		format(Organization[OrgsCount][Leader],25,INI_Get("Organizations.ini",string));
 		format(string,128,"%s:Member1",GetOrgName(OrgsCount));
		format(Organization[OrgsCount][Member1],25,INI_Get("Organizations.ini",string));
 		format(string,128,"%s:Member2",GetOrgName(OrgsCount));
		format(Organization[OrgsCount][Member2],25,INI_Get("Organizations.ini",string));
 		format(string,128,"%s:Member3",GetOrgName(OrgsCount));
		format(Organization[OrgsCount][Member3],25,INI_Get("Organizations.ini",string));
 		format(string,128,"%s:Member4",GetOrgName(OrgsCount));
		format(Organization[OrgsCount][Member4],25,INI_Get("Organizations.ini",string));
 		format(string,128,"%s:Member5",GetOrgName(OrgsCount));
		format(Organization[OrgsCount][Member5],25,INI_Get("Organizations.ini",string));
 		format(string,128,"%s:Member6",GetOrgName(OrgsCount));
		format(Organization[OrgsCount][Member6],25,INI_Get("Organizations.ini",string));
 		format(string,128,"%s:Member7",GetOrgName(OrgsCount));
		format(Organization[OrgsCount][Member7],25,INI_Get("Organizations.ini",string));
		if(Organization[OrgsCount][Protection]>0)
		{Business[Organization[OrgsCount][Protection]][bProtected]=OrgsCount;}
	}
	return 1;
}
//==============================================================================
stock SaveOrg()
{
	new string[128];
 	INI_Create("Organizations.ini");
	for (new i=1;i<OrgsCount+1;i++)
	{
 		format(string,128,"%s:Turf",GetOrgName(i));
 		INI_Set("Organizations.ini",string,Organization[i][Turf]);
 		format(string,128,"%s:Wage",GetOrgName(i));
		INI_IntSet("Organizations.ini",string,Organization[i][Wage]);
 		format(string,128,"%s:Leader",GetOrgName(i));
		INI_Set("Organizations.ini",string,Organization[i][Leader]);
 		format(string,128,"%s:Money",GetOrgName(i));
		INI_IntSet("Organizations.ini",string,Organization[i][Money]);
 		format(string,128,"%s:Drugs",GetOrgName(i));
		INI_IntSet("Organizations.ini",string,Organization[i][Drugs]);
 		format(string,128,"%s:Member1",GetOrgName(i));
		INI_Set("Organizations.ini",string,Organization[i][Member1]);
 		format(string,128,"%s:Member2",GetOrgName(i));
		INI_Set("Organizations.ini",string,Organization[i][Member2]);
 		format(string,128,"%s:Member3",GetOrgName(i));
		INI_Set("Organizations.ini",string,Organization[i][Member3]);
 		format(string,128,"%s:Member4",GetOrgName(i));
		INI_Set("Organizations.ini",string,Organization[i][Member4]);
 		format(string,128,"%s:Member5",GetOrgName(i));
		INI_Set("Organizations.ini",string,Organization[i][Member5]);
 		format(string,128,"%s:Member6",GetOrgName(i));
		INI_Set("Organizations.ini",string,Organization[i][Member6]);
 		format(string,128,"%s:Member7",GetOrgName(i));
		INI_Set("Organizations.ini",string,Organization[i][Member7]);
 		format(string,128,"%s:FStyle",GetOrgName(i));
		INI_IntSet("Organizations.ini",string,Organization[i][FStyle]);
 		format(string,128,"%s:Members",GetOrgName(i));
		INI_IntSet("Organizations.ini",string,Organization[i][Members]);
 		format(string,128,"%s:Protection",GetOrgName(i));
		INI_IntSet("Organizations.ini",string,Organization[i][Protection]);
	}
	for (new i=1;i<BusinessCount+1;i++)
	{
		format(string,sizeof(string),"%d",i);
		INI_Set("Business.ini",string,Business[i][bOwner]);
	}
	for (new i=1;i<PropertyCount+1;i++)
	{
		format(string,sizeof(string),"%d",i);
		INI_Set("Property.ini",string,Property[i][pOwner]);
	}
    return 1;
}
//==============================================================================
stock GiveOrgFeatures(playerid)
{
    new org=PlayerOrg[playerid];
	if (PlayerLeader[playerid]==1&&Suited[playerid]==0)
	{
		Suited[playerid]=1;
		SetPlayerArmourEx(playerid,99);
 		SetPlayerSkin(playerid,Organization[org][Lsk]);
		SetPlayerFightingStyle(playerid,Organization[PlayerOrg[playerid]][FStyle]);
		SendClientMessage(playerid,-1,"You have changed to your organization's 3rd skin");
		GivePlayerWeaponEx(playerid,Organization[org][OWeapons][0],Organization[org][Ammo][0]);
    	GivePlayerWeaponEx(playerid,Organization[org][OWeapons][1],Organization[org][Ammo][1]);
    	SendClientMessage(playerid,ORANGE,"You have armed yourself with your organization weapons");
	}
    if(PlayerLeader[playerid]==0)
    {
        if(Suited[playerid]==0)
        {
			Suited[playerid]=1;
  			SetPlayerSkin(playerid,Organization[org][OSkin]);
			SendClientMessage(playerid,-1,"You have changed to your organization's 1st skin");
			if(Rank[playerid]>1)
			{
    			SetPlayerArmourEx(playerid,99);
    			GivePlayerWeaponEx(playerid,Organization[org][OWeapons][0],Organization[org][Ammo][0]);
    			GivePlayerWeaponEx(playerid,Organization[org][OWeapons][1],Organization[org][Ammo][1]);
    			SendClientMessage(playerid,ORANGE,"You have armed yourself with your organization weapons");
			}
		}
		else if(Suited[playerid]==1)
		{
 			Suited[playerid]=2;
        	SetPlayerSkin(playerid,Organization[org][Skin1]);
			SendClientMessage(playerid,-1,"You have changed to your organization's 2nd skin");
		}
		else if(Suited[playerid]==2)
		{
 			Suited[playerid]=1;
        	SetPlayerSkin(playerid,Organization[org][OSkin]);
		}
		SetPlayerFightingStyle(playerid,Organization[PlayerOrg[playerid]][FStyle]);
	}
    return 1;
}
//==============================================================================
stock GetOrgName(orgid)
{
    new name[40];
    format(name,sizeof(name),"%s",Organization[orgid][Name]);
    if (orgid==0) format(name,sizeof(name),"None");
    return name;
}
//==============================================================================
stock ResetPlayerOrg(playerid)
{
    if (PlayerOrg[playerid]==0)return 1;
	if(PlayerLeader[playerid]==0)
	{
    	if(strcmp(Organization[PlayerOrg[playerid]][Member1],PlayerName(playerid),false)==0)
		{format(Organization[PlayerOrg[playerid]][Member1],25,"None");}
		else if(strcmp(Organization[PlayerOrg[playerid]][Member2],PlayerName(playerid),false)==0)
		{format(Organization[PlayerOrg[playerid]][Member2],25,"None");}
		else if(strcmp(Organization[PlayerOrg[playerid]][Member3],PlayerName(playerid),false)==0)
		{format(Organization[PlayerOrg[playerid]][Member3],25,"None");}
		else if(strcmp(Organization[PlayerOrg[playerid]][Member4],PlayerName(playerid),false)==0)
		{format(Organization[PlayerOrg[playerid]][Member4],25,"None");}
		else if(strcmp(Organization[PlayerOrg[playerid]][Member5],PlayerName(playerid),false)==0)
		{format(Organization[PlayerOrg[playerid]][Member5],25,"None");}
		else if(strcmp(Organization[PlayerOrg[playerid]][Member6],PlayerName(playerid),false)==0)
		{format(Organization[PlayerOrg[playerid]][Member6],25,"None");}
		else if(strcmp(Organization[PlayerOrg[playerid]][Member7],PlayerName(playerid),false)==0)
		{format(Organization[PlayerOrg[playerid]][Member7],25,"None");}
		Organization[PlayerOrg[playerid]][Members]=Organization[PlayerOrg[playerid]][Members]-1;
	}
	else if(PlayerLeader[playerid]==1)
	{
		Organization[PlayerOrg[playerid]][Members]=0;
		format(Organization[PlayerOrg[playerid]][Leader],25,"None");
		format(Organization[PlayerOrg[playerid]][Member1],25,"None");
		format(Organization[PlayerOrg[playerid]][Member2],25,"None");
		format(Organization[PlayerOrg[playerid]][Member3],25,"None");
		format(Organization[PlayerOrg[playerid]][Member4],25,"None");
		format(Organization[PlayerOrg[playerid]][Member5],25,"None");
		format(Organization[PlayerOrg[playerid]][Member6],25,"None");
		format(Organization[PlayerOrg[playerid]][Member7],25,"None");
	}
    Rank[playerid]=0;
    Suited[playerid]=0;
    PlayerOrg[playerid]=0;
    Requesting[playerid]=0;
    PlayerLeader[playerid]=0;
    SetPlayerColor(playerid,-1);
    SetPlayerSkin(playerid,Skin[playerid]);
	SetPlayerAmmo(playerid,Organization[playerid][OWeapons][0],0);
	SetPlayerAmmo(playerid,Organization[playerid][OWeapons][1],0);
	return 1;
}
//==============================================================================
stock GetOrgID(name[])
{
    if (strlen(name) <=0) return 0;
    for (new i=1;i<OrgsCount+1;i++) {
        if (strcmp(name,Organization[i][Name],true)==0) return i;
    }
    return 0;
}
//==============================================================================
stock CreateOrgVehicle(org[40],model,Float:x,Float:y,Float:z,Float:rot,clr1,clr2)
{
    if (!DoesOrgExist(org)) return printf("You are attempting to create org. vehicles for an org. which does not exist");
    new orgid=GetOrgID(org);
    new freeslot=Organization[orgid][VehiclesCreated];
    if (freeslot >=MAX_ORG_VEHICLES) return printf("ERROR: %s cannot handle more vehicles! Aborted",org);
    Organization[orgid][Vehicles][freeslot]=AddStaticVehicleEx(model,x,y,z,rot,clr1,clr2,900);
    Organization[orgid][VehiclesCreated]++;
    new string[10];
    format(string,10,"Org (%d)",orgid);
	SetVehicleNumberPlate(Organization[orgid][Vehicles][freeslot],string);
    return 1;
}
//==============================================================================
stock IsLeaderOnline(org)
{
    for (new i=0; i < MAX_PLAYERS; i++)
	{
        if (IsPlayerConnectedEx(i))
		{
            if (PlayerOrg[i]==org && PlayerLeader[i]==1) return 1;
        }
    }
    return 0;
}
//==============================================================================
stock DoesOrgExist(orgname[40])
{
    for (new i=1;i<OrgsCount+1;i++) {
        if (strcmp(Organization[i][Name],orgname,true)==0) return 1;
    }
    return 0;
}
//==============================================================================
stock CreateOrganizationZone(orgname[40],Float:minx,Float:miny,Float:maxx,Float:maxy,color)
{
    if (!DoesOrgExist(orgname)) return printf("ERROR: You are attempting to create a gangzone for '%s' which does not exist",orgname);
    new orgid=GetOrgID(orgname);
    Organization[orgid][ZoneCreated]++;
    if (Organization[orgid][ZoneCreated] >=MAX_Zone_PER_ORG) return printf("ERROR: You are attempting to create more than %d Zone for %s",MAX_Zone_PER_ORG,orgname);
    new id=Organization[orgid][ZoneCreated];
    Organization[orgid][ZoneMinX][id]=minx;
    Organization[orgid][ZoneMinY][id]=miny;
    Organization[orgid][ZoneMaxX][id]=maxx;
    Organization[orgid][ZoneMaxY][id]=maxy;
    Organization[orgid][ZoneColor][id]=(color);
    Organization[orgid][OrgZones][id]=GangZoneCreate(minx,miny,maxx,maxy);
    GangZoneShowForAll(Organization[orgid][OrgZones][id],Organization[orgid][ZoneColor][id]);
    ZoneCount++;
    return ZoneCount;
}
//==============================================================================
stock SetOrgTurf(playerid)
{
	new Float:x,Float:y,Float:z,zone[38];
 	GetPlayerPos(playerid,x,y,z);
  	for(new i=0; i !=sizeof(gSAZones); i++ )
   	{
    	if(x >=gSAZones[i][SAZONE_AREA][0] && x <=gSAZones[i][SAZONE_AREA][3] && y >=gSAZones[i][SAZONE_AREA][1] && y <=gSAZones[i][SAZONE_AREA][4] && z >=gSAZones[i][SAZONE_AREA][2] && z <=gSAZones[i][SAZONE_AREA][5])
     	{
   			format(zone,38,gSAZones[i][SAZONE_NAME],0);
    		format(Organization[PlayerOrg[playerid]][Turf],50,zone);
    		for(new a=0; a !=sizeof(gSAZones); a++ )
   			{
   	    		if(strcmp(zone,gSAZones[a][SAZONE_NAME])==0)
    			{
    			    CreateOrganizationZone(GetOrgName(PlayerOrg[playerid]),gSAZones[a][SAZONE_AREA][0],gSAZones[a][SAZONE_AREA][1],gSAZones[a][SAZONE_AREA][3],gSAZones[a][SAZONE_AREA][4],Organization[PlayerOrg[playerid]][Color]);
				}
			}
			return 1;
		}
  	}
  	return 0;
}
//==============================================================================
stock TURFS()
{
	for(new i=1;i<OrgsCount+1;i++)
	{
	    if(strcmp(Organization[i][Turf],"None") !=0)
	    {
  			for(new a=0; a !=sizeof(gSAZones); a++ )
   			{
    			if(strcmp(Organization[i][Turf],gSAZones[a][SAZONE_NAME])==0)
				{
  					CreateOrganizationZone(GetOrgName(i),gSAZones[a][SAZONE_AREA][0],gSAZones[a][SAZONE_AREA][1],gSAZones[a][SAZONE_AREA][3],gSAZones[a][SAZONE_AREA][4],Organization[i][Color]);
				}
			}
		}
	}
  	return 1;
}
//==============================================================================
stock hexToDec(hex) { new output[11]; format(output,11,"%i",hex); return strval(output); }
stock IsPlayerInArea(playerid,Float:MinX,Float:MinY,Float:MaxX,Float:MaxY)
{
    new Float:AX,Float:AY,Float:AZ;
    GetPlayerPos(playerid,AX,AY,AZ);
    if (AX > MinX && AX < MaxX && AY > MinY && AY < MaxY) return 1;
    else return 0;
}
//==============================================================================
stock IsPlayerInOrgZone(playerid,orgname[40])
{
    new orgid=GetOrgID(orgname);
    if (DoesOrgExist(orgname))
	{
        for (new i=1;i<ZoneCount+1;i++)
		{
            if (Organization[orgid][ZoneMinX][i] !=0.0)
			{
  				if (IsPlayerInArea(playerid,Organization[orgid][ZoneMinX][i],Organization[orgid][ZoneMinY][i],Organization[orgid][ZoneMaxX][i],Organization[orgid][ZoneMaxY][i]))
				{
   					return 1;
       			}
            }
        }
    }
    return 0;
}
//==============================================================================
stock SendClientMessageToOrg(orgname[40],clr,msg[])
{
    if (!DoesOrgExist(orgname)) return 0;
	for (new a=0;a<MAX_PLAYERS;a++)
	{
        if (IsPlayerConnectedEx(a))
		{
            if (PlayerOrg[a]==GetOrgID(orgname))
			{
                SendClientMessage(a,clr,msg);
            }
        }
    }
    return 1;
}
//==============================================================================
stock PlayerOrgType(playerid)return Organization[PlayerOrg[playerid]][Type];
//==============================================================================
stock CagePlayer(playerid)
{
	new string[128];
	if(GetPlayerWantedLevel(playerid)==1) {Jailed[playerid]=2;}
    if(GetPlayerWantedLevel(playerid)==2) {Jailed[playerid]=4;}
    if(GetPlayerWantedLevel(playerid)==3) {Jailed[playerid]=6;}
   	if(GetPlayerWantedLevel(playerid)==4) {Jailed[playerid]=8;}
    if(GetPlayerWantedLevel(playerid)==5) {Jailed[playerid]=10;}
    if(GetPlayerWantedLevel(playerid)==6) {Jailed[playerid]=12;}
    Suited[playerid]=0;
    SetPlayerSkin(playerid,177);
    SetPlayerInterior(playerid,6);
    PlayerAwards[playerid][Jail]++;
    SetPlayerWantedLevel(playerid,0);
	format(Reason[playerid],25,"None");
    SetPlayerPos(playerid,263.7495,77.5508,1001.0391);
	format(string,128,"You have been jailed for %d minute(s)",Jailed[playerid]);
	SendClientMessage(playerid,LRED,string);
	if(PlayerAwards[playerid][Jail]==20)
	{
   		GivePlayerMoneyEx(playerid,500);
		GamerScore[playerid]=GamerScore[playerid]+90;
  		SendClientMessage(playerid,YELLOW,"Achievement Unlocked: {FFFFFF}Public Enemy!");
		SendClientMessage(playerid,LGREEN,"BONUS: $500 || +90 Gamer Score");
	}
    return 1;
}
//==============================================================================
stock UnCagePlayer(playerid)
{
	Jailed[playerid]=0;
	SetPlayerInterior(playerid,6);
	SetPlayerSkin(playerid,Skin[playerid]);
	SetPlayerPos(playerid,268.4312,77.6008,1001.0391);
	return 1;
}
//==============================================================================
stock IsATowTruck(carid)
{
	if(GetVehicleModel(carid)==485 || GetVehicleModel(carid)==525 || GetVehicleModel(carid)==583 || GetVehicleModel(carid)==574)
	{
		return 1;
	}
	return 0;
}
//==============================================================================
stock ConnectTextdraw(string[])
{
   	if(textdraw==0)
   	{
		textdraw=1;
		format(t1,40,"%s",string);
   		TextDrawSetString(Textdraw1,t1);
	}
   	else if(textdraw==1)
   	{
		textdraw=2;
		format(t2,40,"%s",string);
   		TextDrawSetString(Textdraw2,t2);
	}
   	else if(textdraw==2)
   	{
		textdraw=3;
		format(t3,40,"%s",string);
   		TextDrawSetString(Textdraw3,t3);
	}
   	else if(textdraw==3)
   	{
		textdraw=4;
		format(t4,40,"%s",string);
   		TextDrawSetString(Textdraw4,t4);
	}
   	else if(textdraw==4)
   	{
		textdraw=5;
		format(t5,40,"%s",string);
   		TextDrawSetString(Textdraw5,t5);
	}
   	else if(textdraw==5)
   	{
		textdraw=6;
		format(t1,40,"%s",string);
   		TextDrawSetString(Textdraw1,t2);
   		TextDrawSetString(Textdraw2,t3);
   		TextDrawSetString(Textdraw3,t4);
   		TextDrawSetString(Textdraw4,t5);
   		TextDrawSetString(Textdraw5,t1);
	}
   	else if(textdraw==6)
   	{
		textdraw=7;
		format(t2,40,"%s",string);
   		TextDrawSetString(Textdraw1,t3);
   		TextDrawSetString(Textdraw2,t4);
   		TextDrawSetString(Textdraw3,t5);
   		TextDrawSetString(Textdraw4,t1);
   		TextDrawSetString(Textdraw5,t2);
	}
   	else if(textdraw==7)
   	{
		textdraw=8;
		format(t3,40,"%s",string);
   		TextDrawSetString(Textdraw1,t4);
   		TextDrawSetString(Textdraw2,t5);
   		TextDrawSetString(Textdraw3,t1);
   		TextDrawSetString(Textdraw4,t2);
   		TextDrawSetString(Textdraw5,t3);
	}
   	else if(textdraw==8)
   	{
		textdraw=9;
		format(t4,40,"%s",string);
   		TextDrawSetString(Textdraw1,t5);
   		TextDrawSetString(Textdraw2,t1);
   		TextDrawSetString(Textdraw3,t2);
   		TextDrawSetString(Textdraw4,t3);
   		TextDrawSetString(Textdraw5,t4);
	}
   	else if(textdraw==9)
   	{
		textdraw=5;
		format(t5,40,"%s",string);
   		TextDrawSetString(Textdraw1,t1);
   		TextDrawSetString(Textdraw2,t2);
   		TextDrawSetString(Textdraw3,t3);
   		TextDrawSetString(Textdraw4,t4);
   		TextDrawSetString(Textdraw5,t5);
	}
	return 1;
}
//==============================================================================
stock CreateBusiness(name[32],Float:x,Float:y,Float:z,interior,cost,profit)
{
	BusinessCount++;
	if (BusinessCount >=200) return printf("You have exceeded the MAX_BUS Limit");
	new id=BusinessCount,string[100];
	Business[id][bX]=x;
	Business[id][bY]=y;
	Business[id][bZ]=z;
	Business[id][bCost]=cost;
	Business[id][bName]=name;
	Business[id][bProfit]=profit;
	format(string,sizeof(string),"%s",name);
	Create3DTextLabel(string,0xFFFFFFFF,x,y,z,10.0,0);
 	Business[id][bCheckpoint]=CreateDynamicCP(x,y,z,1,0,interior,-1,10.0);
 	INI_Create("Business.ini");
 	if(fexist("Business.ini"))
 	{
 		new part[24];
		format(part,sizeof(part),"%d",id);
		format(Business[id][bOwner],25,INI_Get("Business.ini",part));
 		if(strcmp(Business[id][bOwner]," ")==0){format(Business[id][bOwner],25,"None");}
	}
	return 1;
}
//==============================================================================
stock CreateProperty(Float:x,Float:y,Float:z,cost)
{
    new part[24];
	PropertyCount++;
    new labelstring[40];
	if (PropertyCount >=200) return printf("You have exceeded the MAX_PROPS Limit");
	new id=PropertyCount;
	Property[id][prX]=x;
	Property[id][prY]=y;
	Property[id][prZ]=z;
	Property[id][pCost]=cost;
 	INI_Create("Property.ini");
	if(fexist("Property.ini"))
	{
 		format(part,sizeof(part),"%d",id);
 		format(Property[id][pOwner],25,INI_Get("Property.ini",part));
 		if(strcmp(Property[id][pOwner]," ")==0){format(Property[id][pOwner],25,"None");}
  		if(strcmp(Property[id][pOwner],"None")==0)
		{
    	    format(labelstring,sizeof(labelstring),"$%i",Property[id][pCost]);
			Property[id][pPickup]=CreateDynamicPickup(1273,1,Property[id][prX],Property[id][prY],Property[id][prZ],-1);
  			Property[id][pMapicon]=CreateDynamicMapIcon(Property[id][prX],Property[id][prY],Property[id][prZ],31,0,-1,-1,-1,250.0);
 			Property[id][pLabel]=CreateDynamic3DTextLabel(labelstring,0xFFFFFFFF,Property[id][prX],Property[id][prY],Property[id][prZ],6.0);
		}
		if(strcmp(Property[id][pOwner],"None") !=0)
		{
			format(labelstring,sizeof(labelstring),"Owner: %s",Property[id][pOwner]);
			Property[id][pPickup]=CreateDynamicPickup(1272,1,Property[id][prX],Property[id][prY],Property[id][prZ],-1);
 			Property[id][pLabel]=CreateDynamic3DTextLabel(labelstring,0xFFFFFFFF,Property[id][prX],Property[id][prY],Property[id][prZ],6.0);
		}
	}
	return 1;
}
//==============================================================================
stock SetPlayerArmourEx(playerid,Float:AP)
{
 	if(AP>99.0)AP=99.0;
	Armor[playerid]=AP;
	return SetPlayerArmour(playerid,AP);
}
//==============================================================================
stock ResetPlayerWeaponsEx(playerid)
{
	for(new i=0;i<47;i++){Weapons[playerid][i]=false;}
	return ResetPlayerWeapons(playerid);
}
//==============================================================================4
stock GivePlayerWeaponEx(playerid,weaponid,ammo)
{
	Weapons[playerid][weaponid]=true;
    return GivePlayerWeapon(playerid,weaponid,ammo);
}
//==============================================================================
stock IsAtAmmunation(playerid)
{
	if(IsPlayerInRangeOfPoint(playerid,20,295.1409,-37.8394,1001.5156) || IsPlayerInRangeOfPoint(playerid,20,286.800995,-82.547600,1001.539978) ||
	IsPlayerInRangeOfPoint(playerid,20,296.919983,-108.07199,1001.569946) || IsPlayerInRangeOfPoint(playerid,20,314.820984,-141.43199,999.661987) ||
	IsPlayerInRangeOfPoint(playerid,20,316.524994,-167.706985,999.661987))
	{ return 1; }
	return 0;
}
//==============================================================================
stock GivePlayerMoneyEx(playerid,amount)
{
	ResetPlayerMoney(playerid);
    SetPVarInt(playerid,"cash",GetPVarInt(playerid,"cash") + amount);
    if(GetPVarInt(playerid,"cash") > GetPVarInt(playerid,"maxcash")) SetPVarInt(playerid,"maxcash",GetPVarInt(playerid,"cash"));
	return GivePlayerMoney(playerid,GetPVarInt(playerid,"cash"));
}
//==============================================================================
stock SetPlayerMoneyEx(playerid,amount)
{
	ResetPlayerMoney(playerid);
    SetPVarInt(playerid,"cash",amount);
    if(GetPVarInt(playerid,"cash") > GetPVarInt(playerid,"maxcash")) SetPVarInt(playerid,"maxcash",GetPVarInt(playerid,"cash"));
	return GivePlayerMoney(playerid,GetPVarInt(playerid,"cash"));
}
//==============================================================================
stock GetPlayerMoneyEx(playerid)return GetPVarInt(playerid,"cash");
//==============================================================================
stock ApplyPlayerAnimation(playerid,animlib[],animname[],Float:fDelta,loop,lockx,locky,freeze,time,forcesync=0)
{
    ApplyAnimation(playerid,animlib,"null",fDelta,loop,lockx,locky,freeze,time,forcesync);
    return ApplyAnimation(playerid,animlib,animname,fDelta,loop,lockx,locky,freeze,time,forcesync);
}
//==============================================================================
stock udb_hash(buf[])
{
    new length=strlen(buf);
    new s1=1;
    new s2=0;
    new n;
    for (n=0; n<length; n++)
    {
       s1=(s1 + buf[n]) % 65521;
       s2=(s2 + s1)     % 65521;
    }
    return (s2 << 16) + s1;
}
//==============================================================================
stock IsNumeric(const str[])
{
    for(new i,len=strlen(str); i < len; i++)
    {
        if(!('0' <=str[i] <='9')) return 0;
    }
    return 1;
}
//==============================================================================
stock SendNearbyMessage(playerid,Float:radius,string[],col)
{
	new Float:x,Float:y,Float:z;
	GetPlayerPos(playerid,x,y,z);
	new Float:ix,Float:iy,Float:iz;
	new Float:cx,Float:cy,Float:cz;
	for(new i=0;i<MAX_PLAYERS;i++)
	{
	    if(IsPlayerConnectedEx(i))
	    {
	        if(GetPlayerInterior(playerid)==GetPlayerInterior(i) && GetPlayerVirtualWorld(playerid)==GetPlayerVirtualWorld(i))
	        {
				GetPlayerPos(i,ix,iy,iz);
				cx=(x - ix);
				cy=(y - iy);
				cz=(z - iz);
				if(((cx < radius/16) && (cx > -radius/16)) && ((cy < radius/16) && (cy > -radius/16)) && ((cz < radius/16) && (cz > -radius/16)))
				{
				    SendClientMessage(i,col,string);
				}
				else if(((cx < radius/8) && (cx > -radius/8)) && ((cy < radius/8) && (cy > -radius/8)) && ((cz < radius/8) && (cz > -radius/8)))
				{
				    SendClientMessage(i,col,string);
				}
				else if(((cx < radius/4) && (cx > -radius/4)) && ((cy < radius/4) && (cy > -radius/4)) && ((cz < radius/4) && (cz > -radius/4)))
				{
				    SendClientMessage(i,col,string);
				}
				else if(((cx < radius/2) && (cx > -radius/2)) && ((cy < radius/2) && (cy > -radius/2)) && ((cz < radius/2) && (cz > -radius/2)))
				{
				    SendClientMessage(i,col,string);
				}
				else if(((cx < radius) && (cx > -radius)) && ((cy < radius) && (cy > -radius)) && ((cz < radius) && (cz > -radius)))
				{
				    SendClientMessage(i,col,string);
				}
			}
	    }
	}
	return 1;
}
//==============================================================================
stock INI_Create(filename[])
{
	if (fexist(filename)) return 0;
	new File:fhnd;
	fhnd=fopen(filename,io_write);
	if (fhnd)
	{
		fclose(fhnd);
		return 1;
	}
	return 0;
}
//==============================================================================
stock INI_Set(filename[],key[],value[])
{
	new key_length=strlen(key);
	new value_length=strlen(value);
	if (key_length==0 || key_length+value_length+2>255) return 0;
	new File:fohnd,File:fwhnd;
	new tmpres[255];
	new bool:wasset=false;
	format(tmpres,sizeof(tmpres),"%s.part",filename);
	fremove(tmpres);
	fohnd=fopen(filename,io_read);
	if (!fohnd) return 0;
	fwhnd=fopen(tmpres,io_write);
	if (!fwhnd)
	{
		fclose(fohnd);
		return 0;
	}
	while (fread(fohnd,tmpres))
	{
		if (!wasset&& tmpres[key_length]=='='&& !strcmp(tmpres,key,true,key_length))
		{
				format(tmpres,sizeof(tmpres),"%s=%s",key,value);
				wasset=true;
		}
		else
		{
			INI_StripLine(tmpres);
		}
		fwrite(fwhnd,tmpres);
		fwrite(fwhnd,"\r\n");
	}
	if (!wasset)
	{
		format(tmpres,sizeof(tmpres),"%s=%s",key,value);
		fwrite(fwhnd,tmpres);
		fwrite(fwhnd,"\r\n");
	}
	fclose(fohnd);
	fclose(fwhnd);
	format(tmpres,sizeof(tmpres),"%s.part",filename);
	if (INI_Rename(tmpres,filename))
	{
		return fremove(tmpres);
	}
	return 0;
}
//==============================================================================
stock INI_IntSet(filename[],key[],value)
{
   new valuestring[255];
   format(valuestring,255,"%d",value);
   return INI_Set(filename,key,valuestring);
}
//==============================================================================
stock INI_Int(filename[],key[])
{
   return strval(INI_Get(filename,key));
}
//==============================================================================
stock INI_Get(filename[],key[])
{
	new tmpres[255];
	new key_length=strlen(key);
	if (key_length==0 || key_length+2>255) return tmpres;
	new File:fohnd;
	fohnd=fopen(filename,io_read);
	if (!fohnd) return tmpres;
	while (fread(fohnd,tmpres))
	{
		if (tmpres[key_length]=='='&& !strcmp(tmpres,key,true,key_length))
		{
			INI_StripLine(tmpres);
			strmid(tmpres,tmpres,key_length + 1,strlen(tmpres),255);
			fclose(fohnd);
			return tmpres;
		}
	}
	fclose(fohnd);
	return tmpres;
}
//==============================================================================
stock INI_Rename(oldname[],newname[])
{
	new File:ohnd,File:nhnd;
	if (!fexist(oldname)) return 0;
	ohnd=fopen(oldname,io_read);
	if (!ohnd) return 0;
	nhnd=fopen(newname,io_write);
	if (!nhnd)
	{
		fclose(ohnd);
		return 0;
	}
	new tmpres[255];
	while (fread(ohnd,tmpres))
	{
		INI_StripLine(tmpres);
		format(tmpres,sizeof(tmpres),"%s\r\n",tmpres);
		fwrite(nhnd,tmpres);
	}
	fclose(ohnd);
	fclose(nhnd);
	fremove(oldname);
	return 1;
}
//==============================================================================
stock INI_StripLine(string[])
{
	new len=strlen(string);
	if (string[0]==0) return ;
	if ((string[len - 1]=='\n') || (string[len - 1]=='\r'))
	{
		string[len - 1]=0;
		if (string[0]==0) return ;
		if ((string[len - 2]=='\n') || (string[len - 2]=='\r')) string[len - 2]=0;
	}
}
//==============================================================================
