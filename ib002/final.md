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
