# k8s-on-cloudstack
## skrypty pomocnicze dla k8s oraz instrukcja jak uruchomic modul k8s na cloudstack

- zeby uruchomic wbudowany modul w Apache Cloudstack w webUI panelu administratorskim w zakladce `Global Settings` w wyszukiwarce poszukujemy parametru `cloud.kubernetes.service.enabled` i ustawiamy go na `true`
- nastepnie wykonujemy restart serwera Cloudstack Management Server, logujac sie do hosta na ktorym dziala usluga Cloudstack i wykonujac polecenie w CLI `sudo systemctl restart cloudstack-management-service` lub `service cloudstack-management restart`
- po ponownym zalogowaniu do webUI cloudstacka w zakladce `Images` pojawi sie nowa opcja `Kubernetes ISO` oraz w zakladce `Compute` pojawi sie opcja `Kubernetes`
- chcac uruchomic swoj pierwszy klaster K8s musimy dokonac importu w Cloudstack webUI przygotowanego odpowiednio ISO obrazu wezla K8s. Przechodzimy do zakladki `Images` kllikamy w `Kubernetes ISO` w formularzu podajemy niezbedne dane, zwroc uwage zeby w `semantic version` nie wpisac byle jakiej nazwy tylko wersje iso ktora pobrales, `name` dowolne
- w miejsce `url` kopiujesz link do wersji iso z tego linku `http://download.cloudstack.org/cks/`
- podajesz ilosc CPU i RAM dla wezlow, po poprawnym pobraniu pliku zostanie przeprowadzone tworzenie `basic template` dla K8s
### od tej chwili mozesz tworzyc wlasne klastry K8s w Apache Cloudstack
