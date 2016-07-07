#### Ragnarson Internship — Dzień 3. i 4.

Program ma zarządzać stanem magazynu i koszykiem klienta w sklepie. Implementacja ma korzystać z klas i ogólnie być zorientowana obiektowo.

Wymagania funkcjonalne:

- Produkt posiada dane o swojej nazwie, cenie i stawce VAT.
- Klient może dodawać przedmioty do koszyka.
- Klient może usuwać przedmioty do koszyka.
- Klient może zobaczyć listę przedmiotów w koszyku.
- Klient może zobaczyć sumę wartości netto i brutto przedmiotów w koszyku.
- Magazyn zna liczbę sztuk przedmiotów w magazynie.
- Program informuje o braku przedmiotów w magazynie podczas próby dodania przedmiotu do koszyka.

Uwagi:

- ~~Cały czas brakuje kontroli stanu magazynowego.~~ Naprawione w `2f9e8ca`, `a3acced` i `4a88e94`.
- ~~Aktualnie `Catalog` jest wszechobecny i się panoszy po klasach.~~ Naprawione w `a4fe670` i `1f9eeff`.
- `VAT` wygląda jakby ktoś chciał zamordować interpreter. :skull: Nie wiem, czy może to tak zostać.
- Specyfikacja `CartItem` powtarza testy metod odziedziczonych z `InventoryItem`. Jaka jest dobra praktyka by je zdeduplikować?
- Specyfikacja `Cart` wykorzystuje wiele instancji innych klas. Kiedy warto korzystać z faktycznych klas, a kiedy z mocków?
