# 1. Zložitosť a korektnosť iteratívnych algoritmov

## Časová zložitosť
- **ČZ** -> súčet cien všetkých vykonaných operácii 
- **časová zložitosť algoritmu** -> funkcia dĺžky vstupu
- **zložitosť** -> časová zložitosť v najhoršom prípade

## Priestorová zložitosť
- funkcia dĺžky vstupu, sleduje koľko pamäti potrebujeme

## Insertsort
- "ukladanie kariet"
- držím si zoradenú a nezoradenú časť
  - prechádzam postupne, zmenšujem nezoradenú časť a na správne miesto v zoradenej časti vkladám aktuálny prvok v nezoradenej časti
  - porovnávam vždy dva prvky vedľa seba a prípadne ich vymieňam podla potreby, pokračujem kým prvok nezaradím na správne miesto
- 2 cykly
- zložitosť: $O(n)$

## Asymptotická notácia
- $f \in O(g)$ (veľké O) -> $C \cdot g(n)$ je **horná hranica** pre $f(n)$
- $f \in \Omega(g)$ (omega) -> $C \cdot g(n)$ je **dolná hranica** pre $f(n)$
- $f \in \Theta(g)$ (théta) -> $C_1 \cdot g(n)$ je **horná hranica** pre $f(n)$ a $C_2 \cdot g(n)$ je **dolná hranica** pre $f(n)$
- funkcie sú $N -> N$

## Korektnosť algoritmov
- **vstupné podmienky** -> vymedzuje, pre ktoré vstupy je algoritmus definovaný
- **výstupné podmienky** -> pre každý vstup spĺňajúci *vstupnú podmienku*, určuje ako má výsledok vyzerať
- **totálna korektnosť** -> pre každý vstup čo splňuje *vstupnú podmienku* *skončí výpočet* s *korektným výsledkom*
- **úplnosť** -> pre každý vstup spĺňajúci *vstupnú podmienku* *výpočet skončí*
- **čiastočná korektnosť** -> pre každý vstup čo splňuje *vstupnú podmienku* a *výpočet na ňom skončí*, výstup *splňuje výstupnú podmienku*

## Dôkaz korektnosti
- analýza efektu operácií
- **efekt cyklu**
  - pri *vnorených cykloch* ideme od toho čo je *najhlbšie*
  - **invariant** - tvrdenie, čo platí *pred* a *po* každej *iterácií* cyklu

# 2. Zložitosť a korektnosť rekurzívnych algoritmov

## 'Divide and conquer' 
- rozkladanie problému na menšie(jednoduchšie) problémy
- *rozdeľ*, *vyrieš*, *skombinuj*

## Dôkaz korektnosti
- matematická indukcia
- báza rekurzie je báza indukcie

## Zložitosť
- vyjadrujeme pomocou *rekurentnej rovnice*

## Riešenie rekurentnej rovnice
- **substitučná metóda** - "*uhádnutie*" a dokázanie *indukciou*
- **metóda rekurzívneho stromu** - *strom rekurzívnych volaní*, kde *vrcholy* sú *zložitosti jednotlivých volaní*; *súčet ohodnotení vrcholov* je výsledok
- **kuchařkova veta/Master theorem** - *vzorec* pre riešenie rovnice typu $T(n) = a \cdot T(n/b) + n^c$

## Master theorem
- pre rekurentnú rovnicu na *nezáporných* číslach
$$T(n) = a \cdot T(n/b) + f(n)$$
kde $f(n) \in \Theta(n^c)$, platí:
$$
T(n) \in \left\{
\begin{array}{ll}
  \Theta(n^c) & a < b^c \\
  \Theta(n^c \log n) & a = b^c \\
  \Theta(n^{\log_b a}) & a > b^c \\
\end{array}
\right.
$$

# 3. Triediace algoritmy: I. časť

## Triediace algoritmy
- triedenie podľa **kľúča** 
- **stabilita** - ak algoritmus zachováva *vzájomné poradie* položiek s rovnakým kľúčom
- priestorová zložitosť je nutne *lineárna*($\Omega(n)$), lebo veľkosť vstupu
- **extrasekvenčná priestorová zložitosť** - priestorová zložitosť, do ktorej nepočítame pamäť obsadenú vstupnou postupnosťou
- ak `EPZ` je konštantná, hovoríme o **in situ** (in place) algoritme

## Mergesort / Triedenie zlievaním
- *rozdeľ* na dve rovnako veľké podpostupnosti, *zoraď* rekurzívne obe postupnosti, *spoj* výsledok
- procedúra `merge`, dostane vstup `Postupnosť(A), left, mid, right` a po skončení bude `A[left..right]` zoradené
- zložitosť: $O(n \log n)$
```lua
function Merge(A, left, mid, right)
  aux = { } -- empty collection of `right - left` elements
  for k in (left..right + 1) do
    aux[k] = A[k]
  end
  i = left
  j = mid + 1
  for k in (left..right + 1) do
    if i < mid and (j > right or aux[i] <= aux[j]) then
      A[k] = aux[i]
      i += 1
    else
      A[k] = aux[j]
      j += 1
    end
  end
end
```

- procedúra merge_sort:
```lua
function MergeSort(A, left, right)
  if left < right then
    mid = (left + right) // 2
    MergeSort(A, left, mid)
    MergeSort(A, mid + 1, right)
    Merge(A, left, mid, right)
  end
end
```

## Quicksort / Triedenie rozdeľovaním
- *rozdeľ* postupnosť na dve postupnosti, tak aby všetky prvky v prvej boli nanajvýš menšie alebo rovné ako prvky druhej postupnosti, *zoraď* obe postupnosti rekurzívne, *spoj* postupnosti zreťazením
- princípy
  - **pivot**
  - postupnosti prvkov *menších* a *väčších* ako *pivot*

```lua
function QuickSort(A, left, right)
  if left < right then
    m = Partition(A, left, right)
    QuickSort(A, left, m - 1)
    QuickSort(A, m + 1, right)
  end
end

function Partition(A, left, right)
  pivot = A[right]
  i = left - 1
  for j in (left..right) do
    if A[j] <= pivot then
      i += 1
      swap(A[i], A[j])
    end
  end
  return i
end
```
- **najhoršie**: $T(n) \in \Theta(n^2)$
- **priemerne**: $T(n) \in \Theta(n \log n)$
- **je nestabilný**
- ak ako pivot použijeme **medián** postupnosti, bude zložitosť aj v najhoršom prípade $T(n) \in \Theta(n \log n)$, avšak v realite je často pomalší, ako algoritmus čo si pivota volí inak
- Hoare partition: iný spôsob "prehadzovania" prvkov a tvorenia dvoch postupností
  - idem od začiatku a konca a "prehadzujem" až kým sa neskrížim

## Zložitosť problému triedenia
- **všetky algoritmy, založené na porovnávaní prvkov je** $\Omega(n \log n)$

# 4. Triediace algoritmy: II. časť

## Heap sort/Triedenie haldou

### Strom
- acyklický graf
- **koreňový strom**: strom s vyznačeným vrcholom $r$ nazývame koreňovým
  - *rodič*, *deti/synovia*, *súrodenci*, *následník*
  - koreň nemá rodiča
  - **list**: vrchol čo nemá potomkov
  - **hĺbka stromu** -> najdlhšia cesta(počet hrán, ktoré musím prejsť) z koreňa do nejakého listu
  - **hĺbka vrcholu** -> cesta od koreňa do najvzdialenejšieho listu
  - **výška vrcholu** -> cesta z vrcholu do najvzdialenejšieho listu
  - **hladina** -> všetky vrcholy s rovnakou výškou
  - **arita** -> najväčší počet následníkov nejakého vrcholu stromu

### Heap / halda
- **stromová dátová štruktúra** (koreňový strom)
- spĺňa **vlastnosť haldy**
  - pre každý uzol `v` platí, že pre každého z jeho synov `w` platí: $v >= w$ 
  - koreň potom obsahuje najväčší kľúč v strome
- **binárna halda**: *úplný binárny strom*
  - pre každú hladinu platí, že je plná, až na poslednú, ktorá nemusí byť plná ale musí byť zaplnená z ľava
- **reprezentujeme ako list**
  - `parent i = (i - 1) // 2`
  - `leftChild i = 2i + 1`
  - `rightChild i = 2i + 2`
- **budovanie haldy**: 
  - na každý uzol aplikujeme operáciu *heapify*
  - zložitosť `Heapify`: $O(h)$ kde $h$ je hĺbka stromu s koreňom i
  - zložitosť `BuildHeap`: $O(n)$

```lua
function Heapify(A, i)
  largest = i
  if Left(i) <= A.size and A[Left(i)] > A[i] then
    largest = left(i)
  end

  if Right(i) <= A.size and A[Right(i)] > A[largest] then
    largest = right(i)
  end

  if largest ~= i then
    Swap(A[i], A[largest])
    Heapif(A, largest)
  end
end

function BuildHeap(A)
  for i in (A.size // 2 .. 0) do
    Heapify(A, i)
  end
end
```

### Heap sort
- zložitosť: $O(n \log n)$

```lua
function HeapSort(A)
  BuildHeap(A)
  for i in (A.size .. 1) do
    Swap(A[i], A[0]) -- move largest element to the end of the list
    A.size -= 1
    Heapify (A, 0)
end
```

## Prioritná fronta / Priority Queue
- dátová štruktúra pre reprezentáciu množiny prvkov, nad ktorý mi je definované usporiadanie
- **umožňuje**:
  - `insert(S, x)` - pridaj nový prvok
  - `maximum(S)` - vráti najväčší prvok
  - `extract_max(S)` - vymaž a vráti najväčší prvok
  - `increase_key(S, x, k)` - nahradí `S[x]` za prvok `k` ak $k >= S[x]$
- **implementované ako binárna halda**

## Triediace algoritmy v lineárnom čase

### Counting sort
- **vstupná podmienka**: vstup obsahuje len celé čísla z intervalu od $0$ po $k$, kde $k$ je pevne dané prirodzené číslo
- pre hodnoty $0$ až $k$ spočítame koľko krát sa vo vstupe nachádzajú a `C[i] = počet čísel i`
- potom prejdeme opäť $0$ až $k$ a do výstupu pridáme počet $m$ krát $i$
- dá sa "stabilizovať", ak si predpočítame, na ktorej poslednej pozícií sa daný prvok $i$ nachádza
  - pamätám si, koľko prvkov ide posledným číslom $i$
  - prechádzam vstup od konca a ukladám na správne miesta

### Radix sort
- podla číslic (MSD, LSD - most/least significant digit)
- musí byť **stabilný**
- zložitosť: $O(n + k)$

### Bucket sort
- rozdelíme vstup na rovnako veľké "koše"
- zoradíme jednotlivé prvky v košoch

# 5. Binárne vyhľadávacie stromy

## Vyhľadávací strom
- **operácie**
  - `search(T, x)`
  - `minimum(T)`
  - `maximum(T)`
  - `predecessor(T, x)`
  - `successor(T, x)`
  - `insert(T, x)`
  - `delete(T, x)`

### Binárny vyhľadávací strom
- koreňový strom
- v každom uzle mám jeden objekt
  - má **kľúč**
    - určuje usporiadanie
  - **ukazatele**: *left*, *right*, *parent*
  - prípadne ďalšie data
- pre každý uzol `x` v BVS platí, že
  - všetky uzly v <ins>ľavom</ins> podstrome sú menšie alebo rovné ako `x`
  - všetky uzly v <ins>pravom</ins> podstrome sú väčšie alebo rovné ako `x`

### Operácie na BVS
- prechádzanie stromu rekurzívne
  - `preorder` -> root, left, right
  - `inorder` -> left, root, right
  - `postorder` -> left, right, root
- `search`
  - v každom uzle porovnám kľúč s tým ktorý hľadám a rozhodnem sa či ísť do prava alebo ľava
- `max, min`
  - cesta z koreňa úplne do prava alebo do ľava
- `predecessor, successor`
  - `pre` -> najväčšie z menších 
    - `if x.left is None` -> potom to je rodič `x`
  - `succ` -> najmenšie z väčších
    - `if x.right is None` -> idem smerom ku koreňu a hľadám prvý uzol, ktorý je ľavým synom svojho otca
- `insert`
  - prechádzame rovnako ako `search` a ak dôjdeme na `None`, tam dám nový prvok
  - nesmiem zabudnúť správne nastaviť rodičov
- `delete`
  - **prvý prípad** -> nemá žiadneho syna
    - vtedy mi stačí uzol vymazať
  - **druhý prípad** -> má jedného syna
    - vymením syna s otcom a otca dám preč
  - **tretí prípad** -> má dvoch synov
    - musím nájsť nasledovníka a toho vymeniť s vymazávaným uzlom
  - pomocná funkcia `transplant(T, u, v)` nahradí uzol `u` uzlom `v`
- **zložitosť** je vždy v najhoršom prípade: $O(n)$
- ak použijem **vyvážený vyhľadávací strom** tak všetky operácie budú mať zložitosť $O(\log n)$

## Modifikácia dátových štruktúr
- **intervalové stromy**
  - kľúč je interval
  - `search` hľadá interval, ktorý sa prekrýva s daným intervalom

# 6. Červeno-čierne stromy

## Vlastnosti
1. platí vlastnosť binárnych vyhľadávacích stromov
2. každý uzol má buď červenú alebo čiernu farbu
3. koreň musí mať čiernu farbu
4. každý vnútorný uzol musí mať dvoch synov, listy nesú hodnoty `nil` a sú čierne
5. každý červený uzol má ako otca uzol čiernej farby
6. na každej ceste z nejakého uzla do listov je rovnaký počet čiernych uzlov

- **čierna výška** -> `bh(x)` je počet čiernych uzlov na ceste z `x` do listu
  - farbu `x` do výšky nezapočítavám
- každý uzol RB-Stromu s výškou $h$ má **čiernu výšku** aspoň $h/2$
  - toto plynie z vlastnosti 6, v najhoršom prípade bude každý druhý uzol na ceste červený
- v RB-Strome má každý podstrom s koreňom `x` aspoň $2^{bh(x)} - 1$ vnútorných uzlov
- RB-Strom s $n$ vnútornými uzlami má výšku najviac $2 \log_2 (n + 1)$

## Operácie
- všetky operácie okrem `insert` a `delete` sú implementované rovnako ako v BVS

### Rotácia
- "korálky na šnúrke"
- dĺžka ciest sa môže meniť
- nesmiem zabudnúť preusporiadať podstromy

### Insert
- pridávam na rovnaké miesto ako v BVS
- zafarbím na *červeno* -> môže pokaziť vlastnosti, musím následne urobiť korekcie
- **prípad 1**
  - otec aj strýc nového uzlu sú *červení*, starý otec je čierny
  - **úprava** -> otec aj strýc budú čierny, starý otec bude červený
    - ak nastane problém, že prastarý otec je tiež červený, **opakujem rekurzívne** toto riešenie aplikované na *starého otca*
- **prípad 2**
  - nový uzol je *pravý* syn otca, otec je *červený*(ľavý syn starého otca) a strýc aj starý otec sú *čierni*
  - **úprava** -> urob *ľavú rotáciu otca*(dostanem oba červené vrcholy do jednej roviny) a pokračuj **prípadom 3**
- **prípad 3**
  - nový uzol je *ľavým* synom *červeného otca*(ľavý syn starého otca), starý otec aj strýc sú *čierni*
  - **úprava** -> *pravá rotácia* starého otca a vymeň farbu otca a starého otca(otec je teraz otcom starého otca)
- **prípady fungujú aj z opačnej strany, len treba vymeniť rotácie**
- zložitosť -> $O(h) \rightarrow O(\log n)$

### Delete
- uzol odstraňujeme rovnako ako s BVS
- môžeme odstrániť *čierny* uzol, preto musíme niekedy opravovať
- **prípad 1** -> odstránený uzol nemá synov
  - ak je *červený* nahraď ho(nahradí ho čierny `Nil`)
  - ak je *čierny*, nahraď ho `Nil`
    - list ktorý bude nahrádzať odstránený list môže mať 2 farby
    - problém dvoch farieb vyriešime na konci, poznamenám si tam teraz, že tam nejaký problém je
- **prípad 2** -> odstránený uzol má jedného syna
  - uzol je *čierny*, jeho syn je *červený*, *odstránime uzol* a *nahradíme ho jeho synom*
  - syn teraz môže mať dve farby -> *vyriešime korekciou* na konci
- **prípad 3** -> odstránený uzol má dvoch synov
  - na pozíciu odstráneného uzlu dáme jeho následníka, jeho farba bude rovnaká ako odstráneného uzla
  - ak mal *následník čiernu farbu*, *čiernu farbu dostane* jeho *pravý* syn
    - ak mal syn 2 farby, riešime to korekciou

#### Korekcia dvoch farieb

##### 1. Bazálny prípad uzol má čiernu a červenú farbu
- nafarbi ho na čierno

##### 2. Uzol má dve čierne farby
- musíme si ku nemu presunúť nejaký iný uzol, a ten nafarbiť na čierno
- **prípad 1** -> uzol má *2 čierne* a brat má *červenú*
  - rotácia okolo otca uzlu, smerom ku uzlu, *vymeň farbu otca a brata* a pokračuj nejakým ďalším prípadom
- **prípad 2** -> uzol má *2 čierne*, brat a jeho deti majú *čiernu* farbu
  - *extra čiernu* farbu presunieme do *otca* uzlu, brata nastavíme na *červenú*
  - tým pádom má otec navyše čiernu farbu
    1. otec je červený -> bazálny prípad
    2. otec je čierny ale je koreň -> extra farbu vymažem
    3. otec je čierny a nie je koreň -> rekurzívne riešime problém dvoch farieb smerom hore
- **prípad 3** -> uzol má *2 čierne*, *brat a jeho pravý syn sú čierni* a *ľavý syn je červený*
  - rotuj brata, tak aby sa brat a jeho deti dostali do jednej línie, a jeho *červený* syn sa stane bratovým otcom a s bratom si *vymenia* farby
- **prípad 4** -> uzol má *2 čierne*, brat je *čierny* a jeho pravý syn je *červený*
  - urob rotáciu okolo *otca* tak aby sa *priblížil ku uzlu s dvoma farbami*
  - *brat dostane* farbu *otca*
  - otec bude *čierny*
  - červený *syn brata* sa stane *čierny*
- zložitosť: $O(h) \rightarrow O(\log n)$

## Rank prvku
- číslo $x \in A$ má rank $i$ práve vtedy keď v $A$ je práve $i - 1$ prvkov menších ako je $x$
- rozšírime strom a každému uzlu pridáme atribút `size`
  - počet uzlov v podstrome s koreňom v danom prvku, aj s danými prvkom
  - `x.size = x.left.size + x.right.size + 1`

# 7. B-Stromy

## Vlastnosti
- zobecnené BVS
- všetky listy majú rovnakú hĺbku
- uzly môžu mať viac kľúčov
  - ak ma uzol $k$ kľúčov tak má $k + 1$ následníkov
- kľúče sú v jednotlivých uzloch usporiadané
- dva ukazatele vždy určujú nasledujúce uzly, kde sú vždy prvky menšie a väčšie ako daný kľúč
- **minimálny stupeň** -> prirodzené číslo $t$ ktoré definuje hornú a dolnú hranicu na počet kľúčov v uložených v uzloch
- každý uzol(okrem koreňa) musí obsahovať aspoň $t-1$ kľúčov
- každý uzol môže obsahovať najviac $2t - 1$ kľúčov
  - každý vnútorný uzol môže mať najviac $2t$ následníkov
- každý uzol ktorý má presne $2t - 1$ kľúčov sa nazýva plný
- počet následníkov vnútorného uzlu je o 1 väčší ako počet kľúčov, ktoré obsahuje
- `2-3-4` strom, stupeň 2
- výška stromu -> $h <= \log_t \frac{n + 1}{2}$

### Atribúty uzlov
- `x.n` - počet kľúčov
- `x.key_1, x.key_2, ..., x.key_x.n` - kľúče
- `x.leaf` - je uzol list?
- `x.c_1, ... x.c_n+1` - ukazatele na synov

## Operácie
- `disk_read`, `disk_write` - potrebujeme aktuálny list  načítať do pamäti
  - každý uzol chceme *načítať najviac raz*
- `search`
  - $O(th) = O(t \log_t n)$

### Insert
- podobne ako u BVS
- ak sa do listu kľúč nezmestí, list rozdelíme na 2
  - zvýši sa počet následníkov otca, ak prekročí maximálny počet následníkov, rekurzívne pokračujeme ďalej
  - tento proces sa pri najhoršom zastaví až v koreni
  - tým pádom prejdem každý uzol 2 krát -> **ZLÉ**
  - vieme tomu predísť tak, že každý plný uzol už vopred rozdelím
- operácia rozdelenia: `split`

### Delete
- ak sa kľúč nachádza v liste, odstránime ho
- ak sa kľúč nachádza v uzle, odstránime ho a nahradím ho následníkom alebo predchodcom, ktorí sú v liste, preto sa *mazanie vždy realizuje z listu*
- môže nastať situácia keď odstraňujeme kľúč z uzla ktorý má $t - 1$ kľúčov
  - pokúsim sa "požičať" si kľúče od nejakého svojho brata
    - ak má, rozdelím seba a brata na polovicu aby sme obaja mali polovicu spoločných kľúčov
    - ak nie, odstráň kľúče a spoj ich do jedného uzlu
- zložitosť: $O(th) = O(t \log_t n)$

# 8. BFS prehľadávanie grafov

## Reprezentácia grafu v PC
- **zoznam následníkov**
  - vhodné pre riedke grafy
  - časová zložitosť výpisu všetkých susedov je $\Theta(\deg(u))$
  - časová zložitosť overenia $(u, v) \in E$ je $\Theta(\deg(u))$
- **matica susednosti**
  - vhodná pre husté grafy
  - časová zložitosť výpisu všetkých susedov vrcholu je $\Theta(V)$
  - časová zložitosť overenia $(u, v) \in E$ je $\Theta(1)$

## Prieskum grafu
- pre daný graf $G$ a jeho vrchol $s$ chceme:
  - navštíviť všetky vrcholy, ktoré sa dajú dosiahnuť z vrcholu $s$
  - prieskum chceme realizovať čo najefektívnejšie $O(V + E)$
- BFS a DFS

## BFS
- postupujem po "vrstvách", začiatok je v $L_0$
- používame frontu
- počet iterácií = počet dosažiteľných vrcholov zo štartu
- zložitosť $O(V + E)$

### Rozšírenie
- `u.color`
  - biela - ak ešte vrchol nebol objavený
  - šedá - ak ešte vrchol nebol spracovaný, ale už je vo fronte
  - čierna - ak je vrchol spracovaný
- `u.pi` - ukazateľ na vrchol, z ktorého bol daný vrchol $v$ objavený 
  - určuje graf predchodcov - **BFS strom**
  - BFS strom nie je určený jednoznačne - záleží na poradí ako skúmame následníkov vrcholu
    - viacero typov hrán $(u, v)$:
    - *stromová hrana*: ak `v.d = u.d + 1` a hrana patrí do BFS stromu
    - *dopredná hrana*: ak `v.d = u.d + 1` a hrana **ne**patrí do BFS stromu
    - *priečna hrana*: ak `v.d == u.d`
    - *spätná hrana*: ak `v.d < u.d`
  - dĺžka cesty je počet hrán cesty
  - dĺžka najkratšej cesty značíme $\delta(u, v)$
  - po skončení BFS platí pre každý vrchol z $V$, že $v.d = \delta(s, v)$
  - po skončení BFS platí pre každý vrchol z $V_{\pi}$, že obsahuje jedinú cestu z $s$ do $v$ a tá je súčasne najkratšou cestou
    
- `u.d`
  - *vrstva* do ktorej $v$ patrí
  - *dĺžka cesty* z $s$ do $v$

```lua
function BFS(G, s)
  (V, E) = G
  for u in V do
    u.color = white
    u.d = infinity
    u.pi = nil
  s.visited = gray
  s.d = 0
  Q = { } -- initialize an empty queue
  enqueue(Q, s)
  while Q do
    u = dequeue(Q)
    for (u, v) in E do
      if v.color == white then
        v.visited = gray
        v.d = u.d + 1
        v.pi = u
        enqueue(Q, v)
      end
    end
    u.color = black
  end
end
```

## Testovanie bipartitnosti grafov
- bipartitný graf neobsahuje cyklus nepárnej dĺžky

### Pomocou BFS
- **prípad 1**
  - vrcholy, čo ležia na *párnych* vrstvách označíme ako červené
  - vrcholy, čo ležia na *nepárnych* vrstvách označíme ako modré
  - nemôžu existovať dva vrcholy v rovnakej *vrstve*(červená, modrá) spojené hranou
  - ak platí, je graf bipartitný
- **prípad 2**
  - ak sú dva vrcholy patriace do rovnakej vrstvy, tak spolu s ich predchodcom tvoria cyklus *nepárnej* dĺžky a teda graf nie je bipartitný

# 9. DFS, prieskum grafu do hĺbky

## DFS
- používa zásobník
- **atribúty vrcholov**
  - `v.color` - rovnako ako v BFS
  - `v.pi` - predchodca, rovnako ako v BFS
  - `v.d` - "čas" kedy bol daný vrchol objavený
  - `v.f` - "čas" kedy bol prieskum daného vrcholu ukončený

```lua
function Dfs((V, E))
  for u in V do
    u.color = white
    u.pi = nil
    u.d = nil, u.f = nil
  end
  Time = 0
  for u in V do
    if u.color == white then
      Visit((V,E), u)
    end
  end
end

function Visit((V, E), u)
  Time += 1
  u.d = Time
  u.color = gray

  for (u, v) in E do
    if v.color == white then
      v.pi = u
      Visit((V, E), v)
    end
  u.color = black
  Time += 1
  u.f = Time
end
$
```

- zložitosť: $O(V + E)$

## DFS strom
- analogicky ako v BFS
  - graf nemusí byť súvislý, preto ho voláme často **DFS Les**
- na rozdiel od BFS, to nie je strom najkratších ciest

## Časové značky
- **usporiadanie vrcholov**
  - podľa `v.d` -> **preorder**
  - podľa `v.f` -> **postorder**
  - podľa `v.f` ale od najväčšieho po najmenšie -> **reverse postorder**
- **dosažiteľnosť**
  - $v$ sa dá dosiahnuť $u$ ak: `u.d < v.d < v.f < u.f`

- **intervaly**
  - [`u.d`, `u.f`] a [`v.d`, `v.f`] sú disjunktné
    - $u$ nie je následníkom $v$ a naopak
  - [`u.d`, `u.f`] je celý obsiahnutý vo [`v.d`, `v.f`]
    - $u$ je následník $v$ v DFS strome

- **hrany**
  - *stromové hrany* - hrana po ktorej bol v prieskume objavený jej koncový vrchol v DFS strome
    - interval následníka je plne vnorený do intervalu predchodcu, hrana vychádza z predchodcu
  - *spätné hrany* - hrana vedúca z následníka do predchodcu v DFS strome
    - interval následníka je plne vnorený do intervalu predchodcu, ale hrana vychádza z následníka
  - *popredné hrany* - vedie z predchodcu do následníka v DFS strome
    - interval následníka je plne vnorený do intervalu predchodcu, hrana vychádza z predchodcu ale `následník.pi != predchodca`
  - *priečne hrany* - všetky ostatné
    - `u.f < v.d`
  - **neorientovaný graf**
    - len *stromové* a *spätné* hrany
- **graf G je acyklický práve vtedy keď DFS neoznačí žiadnu hranu ako spätnú**
- **DFS NEnájde všetky CYKLY grafu**
- dá sa implementovať aj *iteratívne* pomocou zásobníka -> **neodporúča sa**

## Topologické usporiadanie
- očíslovanie vrcholov od $1$ po $n$, že každá hrana vedie z vrcholu s nižším číslom do vrcholu s vyšším číslom
- orientovaný graf má topologické usporiadanie práve ak nie je acyklický
- algoritmus na topologické usporiadanie
  - aplikuj DFS na graf
  - ak prieskum nájde spätnú hranu -> graf má cyklus a nedá sa topologicky usporiadať
  - inak vypíš vrcholy v *reverse postorder* usporiadaní

## Silne súvislé komponenty
- silne súvislá komponenta - najväčšia množina vrcholov tak, že pre každé dva vrcholy platí, že sú navzájom dosiahnuteľné
- ak je graf **ne**orientovaný -> BFS alebo DFS
- ak je graf **orientovaný**
  - nájdem dosiahnuteľné vrcholy z nejakého vrcholu $u$
  - potom nájdem všetky vrcholy z ktorých je dosiahnuteľné $u$ -> transponujem graf(otočenie orientácii hrán)
  - prienik týchto dvoch množín je silne súvislá komponenta
  - celková zložitosť je $O(V \cdot E)$
- lepší algoritmus -> *Kosaraju-Sharir*
  - DFS - získame prvok s `v.f` najväčším
  - transponujeme a z tohto vrcholu púšťame DFS a všetky nájdené vrcholy odstránime a vzniká komponenta
  - opakujem s prvkom ktorý ma najväčšiu `v.f`

# 10. Najkratšie cesty - algoritmus Bellmana a Forda

## Najkratšie cesty
- cesta postupnosť vrcholov medzi nimi sú hrany
- jednoduchá cesta - žiadne vrcholy sa neopakujú
- dĺžka cesty - každá hrana je ohodnotená, súčet hodnôt hrán
- **najkratšia cesta** - ak neexistuje žiadna kratšia $\delta(u, v)$
  - ak medzi vrcholmi cesta neexistuje - tak je dĺžka cesty `inf`
  - ak medzi vrcholmi existuje cyklus zápornej dĺžky - tak je dĺžka cesty `-inf`

### Riešenie najkratšej cesty
- z daného vrcholu do všetkých ostatných
  - SSSP - "Single source shortest path"
- zo všetkých vrcholov do daného
  - pre neorientované grafy je to totožné s SSSP
  - pre orientované je to redukcia na SSSP transponovaním
- medzi danou dvojicou vrcholov
  - špeciálny prípad SSSP
  - nie sú známe asymptoticky rýchlejšie algoritmy ako SSSP
- medzi všetkými dvojicami vrcholov
  - riešenie opakovanou aplikáciou algoritmu SSSP
  - sú aj efektívnejšie riešenia

## SSSP
- neohodnotený graf - **BFS/DFS**
- acyklický graf - **relaxácia hrán, ktorá rešpektuje topologické usporiadanie**
- graf s nezáporným ohodnotením hrán - **Dijkstra**
- obecný graf - **Bellman Ford**

### Predpoklady a princípy na riešenie SSSP
- najkratšia cesta je **jednoduchá**
- každá podcesta najkratšej cesty je **tiež** najkratšou cestou
- atribúty
  - `v.d` - vzdialenosť od začiatku
  - `v.pi` - predchodca na najkratšej ceste
- relaxácia hrán - ak existuje medzi dvoma vrcholmi kratšia cesta, použi tú

## Algoritmus Bellmana a Forda
- graf pre obecné orientované grafy
- môže mať aj hrany zápornej dĺžky

```lua
function BellmanFord((V, E), s)
  InitSSSP((V, E), s)
  for i in 1..V.size - 1 do
    for (u, v) in E do
      if v.d > u.d + w(u, v) do
        v.d = u.d + w(u, v)
        v.pi = u
      end
    end
  end
  for i in 1..V.size - 1 do
    for (u, v) in E do
      if v.d > u.d + w(u, v) do
        return False
      end
    end
  end
  return True
end
```

- zložitosť $O(VE)$

### Zlepšenie
- ak vieme, že graf je acyklický, môžeme použiť nasledujúci efektívnejší algoritmus

```lua
function Dag((V, E), s)
  TS = TOPO(V, E)
  InitSSSP(V, E, s)
  for u in TS do
    for (u, v) in E do
      if v.d > u.d + w(u, v) do
        Relax(u, v)
      end
    end
  end
end
```

- zložitosť $\Theta(V + E)$

# 11. Najkratšie cesty, Dijkstra

## Dijkstra
- vstup: graf s nezáporným ohodnotením hrán
- rieši problém SSSP
- rieši problém **prioritnou frontou**, prioritu určuje `u.d`

```lua
function Dijkstra((V, E), s)
  InitSSSP((V, E), s)
  Q = { } -- prioritná fronta
  S = { } -- vrcholy ktoré boli z fronty odobrané
  Insert(Q, s)
  while Q do
    u = ExtractMin(Q)
    Add(S, u)
    for (u, v) in E do
      if v.d == inf then
        Insert(Q, v)
      end
      if v.d > u.d + w(u, v) then
        Relax(u, v)
        DescreaseKey(Q, v, v.d)
      end
    end
  end
end
```

- zložitosť záleží od implementácie prioritnej fronty
  - pri použití fibonacciho haldy môže byť $O(V \log V + E)$

## Najkratšia cesta medzi dvoma vrcholmi
- optimalizácia Dijkstra pre hľadanie najkratšej cesty medzi dvoma vrcholmi
  - výpočet skončíme po odobratí hľadaného vrcholu z fronty
  - "bidirectional search"
    - súčasne hľadáme pustíme Dijkstra z oboch vrcholov
    - zastaneme ak vyberieme nejaký vrchol z oboch front naraz
    - po ukončení nájdeme vrchol z minimálnou hodnotou `x.da + x.db`
    - prehľadaním predchodcov vrcholu nájdeme najkratšiu cestu
  - heuristika A*
    - myšlienka - ak cesta cez nejaký vrchol nevedie, načo ju počítať
    - používame *potenciál* - $h: V \rightarrow R$
    - kľúč vo fronte je určený `v.d + h(v)`

# 12. Hašovacie tabuľky

## Slovník
- `insert`, `search`, `delete`
- zložitosť operácii
  - V najhoršom prípade $\Theta(n)$
  - V očakávanom prípade $\O(1)$

### Priame adresovanie
- každý objekt má unikátny kľúč z univerza $U  = {0, ..., m - 1}$
- tabuľka T
  - ak tabuľka objekt obsahuje - `T[k] = objekt`
  - ak tabuľka objekt neobsahuje - `T[k] = None`
- problémy:
  - veľkosť tabuľky
  - hustota objektov
  - objekty s rovnakým kľúčom

## Hašovacia tabuľka
- hašovacia funkcia - $h: U -> {0, ..., m - 1}$
- hašovacia tabuľka: `T[h(k)] = x`
- $|U| >> m$ - univerzum môže byť nepomerne väčšie ako $m$
- problém kolízií
  - chaining
  - open hashing
  - výber hašovacej funkcie ktorá *minimalizuje* počet kolízii a má *efektívny* výpočet

## Hašovacie funkcie
- optimalizácia - náhodne vyberaj jednu z preddefinovaných hašovacích funkcií
- takáto množina hašovacích funkcií je potom:
  - *uniformná* - ak pre každú funkciu z množiny je pravdepodobnosť zahašovania kľúča na každú z pozícií tabuľky rovnaká
  - *univerzálna* - pre každú dvojicu kľúčov je pravdepodobnosť kolízie čo najmenšia
  - *takmer univerzálna* - pre každú dvojicu kľúčov je pravdepodobnosť kolízie čo najmenšia
  - *r-uniformná* - pre každú množinu $r$ vzájomne rôznych kľúčov je pravdepodobnosť kolízie rovnaká

## Zreťazené hashovanie
- miesto prvku uloženého na `T[h(k)]` tam je zoznam prvkov, ktoré sú na danú pozíciu zahashované
- `insert` - konštantné
- `search`, `delete` - musím prejsť celý zoznam, teda *lineárne*
- v očakávanom prípade - záleží od hashovacej funkcie

### Typy hashovacích funkcií pri zreťazenom hashovaní
- delenie 
  - `h(k) = k mod m`
  - rýchlosť
  - závislosť na `m`
  - dobrá voľba `m` je prvočíslo
- binárne násobenie
  - hashujeme w-bitové čísla na p-bitové čísla
  - `h_A(k) = floor(m * (k * A mod 1))` pre A z $0 < A < 1$
- násobenie
  - dve čísla $a \in {1, 2, ..., p - 1}$ a $b \in {0, 1, ..., p - 1}$ z intervalu
  - $p$ je prvočíslo, ktoré je väčšie ako hoci aký kľúč
  - `h(k) = (((ak + b) mod p) mod m)

## Otvorená adresácia
- všetky objekty idú priamo do tabuľky
- pre každý objekt mám usporiadanú postupnosť hashovacích funkcií
- postupne skúšam funkcie podla poradia
- `delete` - nevymažem, iba si miesto označím ako `Deleted`

### Typy hashovacích funkcií pri otvorenej adresacií
- **lineárna**
  - `h(k, i) = (h'(k) + i) mod m`
  - problém zhlukovania
- **kvadratická**
  - `h(k, i) = (h'(k) + c_1i + c_2i^2) mod m`
  - obvykle lepšia než lineárna
- **dvojité hashovanie**
  - `h(k, i) = (h'(k) + ih''(k)) mod m`
  - `h''(k)` nemsie byť súdeliteľná s `m`(veľkosťou tabuľky)

## Kukučie hashovanie
- využíva 2 funkcie a 2 tabuľky
- `delete` a `search` - konštantné
- `insert`
  - najprv skusim vložiť objekt na h(k)
  - ak už je pozícia obsadená, prehodím objekt na tejto pozícii na alternatívne miesto v druhej tabuľke
  - opakujem dokaiľ sa miesto neuvoľní alebo sa proces nezacyklí

## Perfektné hashovanie
- $O(1)$ aj v najhoršom prípade
- **prvá úroveň**
  - zreťazené hashovanie
  - velkosť tabulky je lineárna voči počtu kľúčov
- **druhá úroveň**
  - miesto zoznamu - dalsia hashovacia tabulka
  - velkost $m_j$ tabulky je kvadratická voči počtu kľúčov zahašovaných na pozícii $j$
