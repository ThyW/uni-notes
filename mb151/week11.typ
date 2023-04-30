#import "../includes/mathfns.typ"

#let p = $cal(P)$
#let q = $cal(Q)$
#let vecPA = mathfns.vecNotation([$P A$])
#let vecAB = mathfns.vecNotation([$A B$])
#let z = mathfns.above("z")
#let scalarAiVi = mathfns.scalarSucin([z#sub[i], v#sub[i]])
#let epsn = [$epsilon_n$]

= Euklidovská geometria
- *vzdialenosť dvoch bodov*: veľkosť príslušného vektoru
- *Bodový euklidovsý priestor* $#epsn$ je afinný priestor $cal(A)_n$, ktorého zameraním je štandardný euklidovský priestor $RR^n$ so skalárnym súčinom $ angle.l x , y angle.r = x times y^T. $
- *Kártézska súradná sústava* je afinná súradnicová sústava $(A_0; alpha)$ s ortonormálnou bázou $alpha$.\
- *Vzdialenosť bodov* $A, B in #epsn$ je $#mathfns.vecSize(vecAB)$, značíme ako $rho (A B)$.\
- *Euklidovské podpriestory* v $epsn$ sú afinné podpriestory.\

- V *každej kartézskej súradnicovej sústave* $(A_0; epsilon)$ majú body $ A = A_0 + a_1e_1 + dots + a_(n)e_n \ B = A_0 + b_1e_1 + dots + b_(n)e_n $ *vzdialenosť* $ root(#none, sum^(n)_(i=1)(a_i - b_i)^2). $

- *Vzdialenosť* rovín $#p$ a $#q$ je definovaná ako $rho(#p, #q) = min{rho(A, B) | A in #p, B in #q}$

== Príklad
Vzdialenosť bodu od kolmice:
- *idea*: spustíme kolmicu z bodu $A$ do roviny $alpha$
+ $P$ je bod základný bod podpriestoru
+ hľadáme pre vektor $z = vecPA = (1, 0, 1)$ vektor $z_p = a dot v_1 + b dot v_2$, tak aby $z' = z - z_p$ bol kolmý k zameraniu roviny $alpha$, číže ku vektorom $v_1, v_2$

$ 0 &= angle.l z', v_1 angle.r &= angle.l z, v_1 angle.r - a dot angle.l v_1, v_1 angle.r - b dot angle.l v_2, v_1 angle.r \
  0 &= angle.l z', v_2 angle.r &= angle.l z, v_2 angle.r - a dot angle.l v_1, v_2 angle.r - b dot angle.l v_2, v_2 angle.r \
$
+ následne dostaneme sústavu pre $(a, b)$

- alternatívne riešenie
+ spočítame kolmú projekciu $z$ na priamku (jedno dimenzionálny podpriestor) so smerovým vektorom $u = (1, -1, 1)$ ($u$ je kolmé na $alpha$)
+ pre $z$ hľadáme $#z _p = a dot u$, aby $z'' = z - #z _p$, ktorý je kolmý k $u$
$ 0 = angle.l z'', u angle.r = angle.l z, u angle.r - a dot angle.l u, u angle.r $
#pagebreak()

== Ortogonálny doplnok
- vieme použiť vždy pri riešení vzdialenosti bodu od podpriestoru
- $z_p = a_1 dot v_1 + dots + a_(n)v_n)$, aby $z' = z - z_p$ bol kolmý k vektorom $v_1, dots, v_n$
  - tým pádom riešime $n$ rovníc $#scalarAiVi$ o neznámych $a_1, dots, a_n$
- pre $U$: podpriestor štandardného euklidovského priestoru $RR^n$ definujeme: $ U^bot = { v in RR^n | forall u in U : u bot v } $
- platí $U sect U^bot = {0}$
- $U$ je dané bázou, $U^dot$ sa spočíta maticou (homogénna matica)
- $dim U + dim U^bot = n$
- $(U^bot)^bot = U$
- ak $(u_1 dots u_k)$ je ortogonálna báza $U$ a $(u_(k+1) dots u_n)$ je ortogonálna báza $U^bot$ potom $(u_1 dots u_n)$ je ortogonálna báza $RR^n$
#pagebreak()

== Vzdialenosť podpriestorov
- opäť to bude kolmica
- pre podpriestory $#p$ a $#q$ v $#epsn$ potom sú body $P in #p$ a $Q in #q$, ktoré minimalizujú vzdialenosť bodov $A in #p$ a $B in #q$
  - vzdialenosť bodov $P$ a $Q$ je rovná veľkosti kolmého priemetu vektoru $#vecAB$ do $(Z(#p) + Z(#q))^bot$ pre ľubovoľné body $A in #p$ a $B in #q$

=== Príklad
- určite vzdialenosť priamiek v $epsilon_3$
  - $p: [1, -1, 0](A) + t(-1, 2, 3)(v_1)$
  - $q: [2, 5, -1](B) + s(-1, -2, 1)(v_2).$
#let zv = mathfns.scalarSucin([$z, v$])
#let vv = mathfns.scalarSucin([$v, v$])
+ vektor $vecAB$
+ $v = #mathfns.scalarSucin([((-1, 2, 3), (-1, -2, 1))])^bot = #mathfns.scalarSucin([(4, -1, 2)]) = (4, -1, 2)$
+ hľadáme $z_p = a dot.c v$ tak, že $#mathfns.scalarSucin([$z - a v, v$]) = 0$
  - teda $#zv - a #vv = 0$
  - preto $a = #zv / #vv$
+ $rho(p, q) = |a| dot.c #mathfns.vecSize([$v$])$
#pagebreak()

#let vsu = mathfns.vecSize([$u$])
#let vsv = mathfns.vecSize([$v$])
#let vsv1 = mathfns.vecSize([$v_1$])
#let scalauv = mathfns.scalarSucin([$u, v$])
#let scalau = mathfns.scalarSucin([$u$])
#let scalav = mathfns.scalarSucin([$v$])
#let scalav1 = mathfns.scalarSucin([$v_1$])

== Odchýlka podpriestorov
- odchýlka $ cos phi(u, v) = #mathfns.scalarSucin([$u , v$]) / (#mathfns.vecSize([$u$]) dot.c #mathfns.vecSize([$v$])) $
  - $0 <= phi (u, v) <= pi$
- *všeobecne*
  - pre podpriestory $U_1, U_2$ je odchýlka $alpha in RR; alpha = phi (U_1, U_2) in [0, pi / 2]$ spĺňajúca:
    + ak dimenzia $dim U_1 = dim U_2 = 1, U_1 = #vsu, U_2 = #vsv)$, tak $ cos alpha = |#scalauv| / (#vsu #vsv )) $
    + ak sú dimenzie $U_1, U_2$ kladné a $U_1 sect U_2 = {0}$, tak $ alpha = min {phi(#scalau, #scalav) | 0 != u in U_1, 0 != v in U_2} $
    + ak $U_1 subset.eq U_2$ alebo $U_2 subset.eq U_1$, $alpha = 0$
    + ak $U_1 sect U_2 != {0}$ a $U_1 != U_1 sect U_2 != U_2$, tak $ alpha = phi(U_1 sect (U_1 sect U_2)^bot, U_2 sect (U_1 sect U_2)^bot) $
#let q1 = [$cal(Q_1)$]
#let q2 = [$cal(Q_2)$]
- *odchylka podpriestorov* $#q1$, $#q2$ v euklidovskom podpriestore #epsn sa definuje ako odchýlka ich zameraní $Z(#q1)$, $Z(#q2)$

=== Odchýlka priamky a podpriestoru
- odchýlka $v$ a kolmej projekcie $v$ do $U$
  - $v_1 in U, v_2 in U^bot$; $v = v_1 + v_2$
  - $ cos phi (#vsv), U) = cos phi (#scalav, #scalav1) = #vsv1 / #vsv $

== Objem rovnobežnostenu a štvorstenu
- rovnako ako v rovine počítame pomocou determinantu
- počítame objem rovnobežnostenu daného 3 vektormi
$ det mat(delim: "||",
         a, b, c;
         d, e, f;
         g, h, i;) $
- $u_1 dots u_k$ sú ľubovoľné vektory v zameraní $RR^n$, $A in cal(A_n)$ je ľubovoľný bod
- rovnobežnosten $P_k$ je množina bodov $ P_k(A; u_1 dots u_k) subset.eq cal(A_n) \ 
  = {A + c_1 u_1 + dots + c_k u_k | 0 <= c_i < 1, i = 1, dots , k }. $
