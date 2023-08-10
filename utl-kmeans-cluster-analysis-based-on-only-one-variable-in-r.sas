%let pgm=utl-kmeans-cluster-analysis-based-on-only-one-variable-in-r;

kmeans cluster analysis based on only one variable in r

github
https://tinyurl.com/5juwefbk
https://github.com/rogerjdeangelis/utl-kmeans-cluster-analysis-based-on-only-one-variable-in-r

https://tinyurl.com/tkwhxcea
https://stackoverflow.com/questions/76869778/can-i-do-a-k-means-cluster-analysis-based-on-only-one-variable-in-r

Solution by
https://stackoverflow.com/users/9462095/andre-wildberg
/*                   _
(_)_ __  _ __  _   _| |_
| | `_ \| `_ \| | | | __|
| | | | | |_) | |_| | |_
|_|_| |_| .__/ \__,_|\__|
        |_|
*/
options validvarname=upcase;

libname sd1 "d:/sd1";

data sd1.have ;informat
STATION $1.
INDEX 8.
;input
STATION INDEX;
y=1;
cards4;
A 6.3
B 6.8
C 7.2
D 5.1
E 6.1
;;;;
run;quit;


/**************************************************************************************************************************/
/*                                                                                                                        */
/*  SD1.HAVE total obs=5                                                                                                  */
/*                                                                                                                        */
/*  Obs    STATION    INDEX    Y                                                                                          */
/*                                                                                                                        */
/*   1        A        6.3     1                                                                                          */
/*   2        B        6.8     1                                                                                          */
/*   3        C        7.2     1                                                                                          */
/*   4        D        5.1     1                                                                                          */
/*   5        E        6.1     1                                                                                          */
/*                                                                                                                        */
/**************************************************************************************************************************/

/*           _               _
  ___  _   _| |_ _ __  _   _| |_
 / _ \| | | | __| `_ \| | | | __|
| (_) | |_| | |_| |_) | |_| | |_
 \___/ \__,_|\__| .__/ \__,_|\__|
                |_|
*/

/**************************************************************************************************************************/
/*                                                                                                                        */
/*  The WPS System                     5        6        7        8                                                       */
/*                                   --+--------+--------+--------+--                                                     */
/*    STATION INDEX Y CLUSTER      2 +                              + 2                                                   */
/*                                   |cluster1 cluster3             |                                                     */
/*  1       A   6.3 1       3        |  =        ===                |                                                     */
/*  2       B   6.8 1       1      1 +  D        EA    B  C         + 1                                                   */
/*  3       C   7.2 1       1        |                 ====         |                                                     */
/*  4       D   5.1 1       2        |                 cluster2     |                                                     */
/*  5       E   6.1 1       3      0 +                              + 0                                                   */
/*                                   --+--------+--------+--------+--                                                     */
/*                                     5        6        7        8                                                       */
/*                                                                                                                        */
/**************************************************************************************************************************/

/*
 _ __  _ __ ___   ___ ___  ___ ___
| `_ \| `__/ _ \ / __/ _ \/ __/ __|
| |_) | | | (_) | (_|  __/\__ \__ \
| .__/|_|  \___/ \___\___||___/___/
|_|
*/

%utl_submit_wps64('
libname sd1 "d:/sd1";
proc r;
export data=sd1.have r=have;
submit;
cbind(have, cluster = kmeans(have$INDEX, 3)$cluster);
have;
endsubmit;
import data=sd1.want r=have;
proc print data=want;
run;quit;
');

options ps=22 ls=64;
proc plot data=sd1.have(rename=y=y123456789012345678901234567890);
 plot y123456789012345678901234567890*index=station/box;
run;quit;
options ps=66 ls=255;

/*              _
  ___ _ __   __| |
 / _ \ `_ \ / _` |
|  __/ | | | (_| |
 \___|_| |_|\__,_|

*/
