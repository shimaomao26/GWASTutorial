# AWK

## AWK Introduction
'awk' is one of the most powerful text processing tools for tabular text files.

## AWK syntax

```
awk OPTION 'CONDITION {PROCESS}' FILENAME
```

Some special variable in awk:

- $0 : all columns
- $n : column n. For example, $1 means the first column. $4 means column 4.
- NR : Row number.

## Examples

Using the sample sumstats, we will demonstate some simple but useful one-liners.

```
# sample sumstats
head ../02_Linux_basics/sumstats.txt 
CHROM	POS	ID	REF	ALT	A1	TEST	OBS_CT	OR	LOG(OR)_SE	Z_STAT	P	ERRCODE
1	319	17	2	1	1	ADD	10000	1.04326	0.0495816	0.854176	0.393008	.
1	319	22	1	2	2	ADD	10000	1.03347	0.0493972	0.666451	0.505123	.
1	418	23	1	2	2	ADD	10000	1.02668	0.0498185	0.528492	0.597158	.
1	537	30	1	2	2	ADD	10000	1.01341	0.0498496	0.267238	0.789286	.
1	546	31	2	1	1	ADD	10000	1.02051	0.0336786	0.60284	0.546615	.
1	575	33	2	1	1	ADD	10000	1.09795	0.0818305	1.14199	0.25346	.
1	752	44	2	1	1	ADD	10000	1.02038	0.0494069	0.408395	0.682984	.
1	913	50	2	1	1	ADD	10000	1.07852	0.0493585	1.53144	0.12566	.
1	1356	77	2	1	1	ADD	10000	0.947521	0.0339805	-1.5864	0.112649	.
```

### Example 1

Select variants on chromosome 3 (keeping the headers):

```
awk 'NR==1 ||  $1==3 {print $0}' ../02_Linux_basics/sumstats.txt | head

#CHROM	POS	ID	REF	ALT	A1	FIRTH?	TEST	OBS_CT	OR	LOG(OR)_SE	Z_STAT	P	ERRCODE
3	61044	3:61044:T:C	T	C	T	N	ADD	503	0.810526	0.288578	-0.727953	0.466643	.
3	62226	3:62226:C:T	C	T	C	N	ADD	503	0.939718	0.134814	-0.461196	0.644658	.
3	62309	3:62309:T:G	T	G	G	N	ADD	503	0.90072	0.299241	-0.34942	0.726774	.
3	62614	3:62614:G:C	G	C	G	N	ADD	503	0.939205	0.135404	-0.463216	0.64321	.
3	62759	3:62759:A:C	A	C	C	N	ADD	503	1.01424	0.137312	0.102945	0.918006	.
3	65982	3:65982:G:A	G	A	A	N	ADD	503	1.01851	0.286774	0.0639417	0.949017	.
3	67279	3:67279:G:A	G	A	A	N	ADD	503	0.925448	0.28266	-0.274102	0.784006	.
3	68204	3:68204:G:C	G	C	C	N	ADD	503	0.946799	0.138547	-0.394582	0.693152	.
3	68426	3:68426:C:T	C	T	T	N	ADD	503	0.936078	0.13846	-0.477083	0.633303	.

```

The `NR` here means row number. The condition here `NR==1 || $1==3` means if it is the first row or the first column is equal to 3, conduct the process `print $0`, which mean print all columns. 

### Example 2

Select significant variants:

```
awk 'NR==1 ||  $13 <5e-8 {print $0}' ../02_Linux_basics/sumstats.txt | head
#CHROM	POS	ID	REF	ALT	A1	FIRTH?	TEST	OBS_CT	OR	LOG(OR)_SE	Z_STAT	P	ERRCODE
2	55554956	2:55554956:C:A	C	A	A	N	ADD	503	0.385763	0.159528	-5.97095	2.35876e-09	.
2	55555726	2:55555726:T:C	T	C	C	N	ADD	503	0.390696	0.15863	-5.92465	3.12972e-09	.
2	55574452	2:55574452:G:C	G	C	C	N	ADD	503	0.38159	0.159864	-6.02642	1.67629e-09	.
2	55578761	2:55578761:C:T	C	T	T	N	ADD	503	0.390696	0.15863	-5.92465	3.12972e-09	.
2	55582635	2:55582635:T:C	T	C	C	N	ADD	503	0.390696	0.15863	-5.92465	3.12972e-09	.
2	55585577	2:55585577:A:T	A	T	T	N	ADD	503	0.390696	0.15863	-5.92465	3.12972e-09	.
2	55587807	2:55587807:G:T	G	T	T	N	ADD	503	0.389981	0.158203	-5.95222	2.64529e-09	.
2	55598053	2:55598053:T:C	T	C	C	N	ADD	503	0.389981	0.158203	-5.95222	2.64529e-09	.
2	55602809	2:55602809:G:A	G	A	G	N	ADD	503	0.389981	0.158203	-5.95222	2.64529e-09	.

```

### Example 3

Create a bed-like format for annotation:

```
awk 'NR>1 {print $1,$2,$2,$4,$5}' ../02_Linux_basics/sumstats.txt | head
1 13273 13273 G C
1 14599 14599 T A
1 14604 14604 A G
1 14930 14930 A G
1 69897 69897 T C
1 86331 86331 A G
1 91581 91581 G A
1 122872 122872 T G
1 135163 135163 C T
1 233473 233473 C G
```