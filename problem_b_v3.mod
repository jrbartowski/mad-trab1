set PLANETAS;
param POSICAO_X {PLANETAS};
param POSICAO_Y {PLANETAS};
param PROCURA{PLANETAS,PLANETAS};

# DISTÂNCIA EUCLIDIANA
param DISTANCIA{i in PLANETAS,j in PLANETAS} := 
sqrt((POSICAO_X[j]-POSICAO_X[i])*(POSICAO_X[j]-POSICAO_X[i])+
(POSICAO_Y[j]-POSICAO_Y[i])*(POSICAO_Y[j]-POSICAO_Y[i]));

# O QUE OS OUTROS PLANETAS PRECISAM DO PLANETA I
param PRODUCAO{i in PLANETAS} := sum{j in PLANETAS} PROCURA[j,i];

# O QUE O PLANETA I PRECISA DOS OUTROS PLANETAS
param PROCURA_PLANETA{i in PLANETAS} := sum{j in PLANETAS} PROCURA[i,j];

# TROCAS ENTRE PLANETAS TÊM DE SER SUPERIORES A 0
var ENVIAR {i in PLANETAS,j in PLANETAS} >= 0;
 
# PLANETA I NÃO PODE ENVIAR PARA SI PRÓPRIO
subject to zero{i in PLANETAS}: ENVIAR[i,i] = 0;

# ESTADO DO PLANETA I = SOMATÓRIO DO QUE RECEBE - SOMATÓRIO DO QUE ENVIA
# ESTADO DO PLANETA I > 0 ENTÃO O ESTADO = PROCURA
# ESTADO DO PLANETA I < 0 ENTÃO O ESTADO = PRODUÇÃO

subject to MAX_ENVIAR {i in PLANETAS} : sum {j in PLANETAS} ENVIAR[i,j] = 
PRODUCAO[i] - PROCURA_PLANETA[i];

minimize cost: sum {i in PLANETAS,j in PLANETAS} ENVIAR[i,j]*DISTANCIA[i,j];

data;

set PLANETAS := 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25;

param POSICAO_X :=
1 69
2 18
3 14
4 29
5 84
6 81
7 83
8 95
9 56
10 36
11 31
12 82
13 55
14 25
15 61
16 23
17 19
18 72
19 4
20 81
21 89
22 60
23 58
24 34
25 11;


param POSICAO_Y :=
1 85
2 23
3 22
4 43
5 61
6 81
7 75
8 80
9 43
10 43
11 11
12 80
13 75
14 46
15 39
16 23
17 37
18 94
19 14
20 84
21 81
22 72
23 59
24 29
25 22;

param PROCURA : 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 :=
1 0       83      112     358     24      103     35      29      72      18      108     25      76      38      376     144     22      25      16      193     125     129     269     88      605
2 102     0       193     243     141     145     106     66      327     133     92      134     86      162     1800    657     74      156     235     360     333     296     833     124     958
3 24      178     0       218     142     72      188     270     341     143     375     294     213     131     560     153     65      98      223     724     546     368     709     120     934
4 37      352     428     0       247     217     408     211     629     463     499     212     178     537     1180    454     211     424     375     403     507     886     633     507     628
5 75      215     164     859     0       54      24      39      169     25      38      19      57      69      319     247     20      67      17      267     914     412     143     398     466
6 34      375     367     404     10      0       26      28      171     12      241     62      24      82      469     62      16      14      29      259     136     113     189     236     383
7 29      213     638     526     28      17      0       49      115     8       69      20      16      53      188     37      17      23      47      222     131     421     182     110     260
8 43      64      291     353     29      29      20      0       208     38      95      18      80      101     150     233     25      50      30      115     362     263     217     142     444
9 34      381     357     914     31      36      19      30      0       185     265     274     254     665     141     259     173     157     253     448     356     1165    526     343     663
10 24      135     440     896     27      21      17      17      394     0       72      23      55      70      261     54      11      19      20      213     366     253     247     113     252
11 20      326     291     670     29      45      15      11      182     36      0       40      143     51      471     117     67      71      110     435     410     247     461     357     949
12 24      501     470     377     28      32      23      15      292     22      94      0       26      105     632     128     42      128     22      345     280     183     174     152     260
13 41      467     131     682     26      10      20      24      277     15      77      50      0       88      204     133     51      49      40      243     441     572     254     179     357
14 25      327     243     644     19      25      17      27      290     12      134     17      46      0       126     151     115     60      82      591     255     367     261     88      363
15 19      222     165     1213    24      21      20      29      466     15      126     25      52      117     0       1351    338     201     214     706     374     411     1091    209     1214
16 23      124     210     384     13      80      16      38      222     26      48      21      43      88      500     0       89      487     161     169     713     352     611     411     276
17 15      105     195     311     17      27      18      52      386     8       105     26      30      34      608     235     0       47      10      341     148     279     389     146     126
18 40      153     423     811     29      28      20      26      626     17      35      81      29      68      300     173     11      0       51      410     189     397     224     257     278
19 31      258     610     604     32      30      21      30      417     13      222     37      33      82      530     166     12      15      0       151     108     195     120     139     448
20 22      274     271     902     19      29      30      51      559     25      129     19      65      45      673     144     19      48      45      0       922     468     468     788     1026
21 18      142     356     774     14      31      44      51      348     35      139     12      25      127     324     93      13      31      12      548     0       653     318     183     1096
22 33      294     168     291     36      41      19      31      285     10      281     93      51      46      1015    300     12      67      9       591     697     0       1503    584     1138
23 44      294     135     1223    8       27      48      29      153     21      40      35      35      35      824     111     6       51      37      607     639     554     0       432     658
24 19      329     447     1153    27      51      15      43      682     19      186     35      16      129     252     157     25      36      28      470     371     640     269     0       942
25 40      371     217     198     10      18      40      26      352     26      197     25      104     149     624     165     17      48      25      666     795     469     357     659     0;

end;

