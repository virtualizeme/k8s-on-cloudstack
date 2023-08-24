#!/bin/bash
# Stworzyl sebastian test git
# Pobierz bieżący katalog roboczy
current_dir=$(pwd)

# Ustaw zmienną środowiskową KUBECONFIG
export KUBECONFIG="$current_dir/kube.conf"

# uruchomienie lokalnego proxy do webUI K8S
kubectl proxy > /dev/null 2>&1 &

# Wskazanie pliku kube.conf w bieżącym katalogu
file_path="$current_dir/kube.conf"

# Pobranie wartości nazwy użytkownika z pliku konfiguracyjnego kube.conf
user_value=$(grep 'user:' "$file_path" | awk '{print $2}')

# stworzenie konta serwisowego K8S z wykorzystaniem nazwy konta pobranego z pliku kube.conf
kubectl -n kube-system create serviceaccount "$user_value"

# zbindowanie serwisowego uzytkownika z klastrem i uprawnieniami do zarzadzania tym klastrem
kubectl create clusterrolebinding add-on-cluster-admin --clusterrole=cluster-admin --serviceaccount=kube-system:"$user_value"

# stworzenie pliku YAML do wygenerowania tokena
cat <<EOL > token.yaml
apiVersion: v1
kind: Secret
metadata:
  name: token
  namespace: kube-system
  annotations:
    kubernetes.io/service-account.name: $user_value
type: kubernetes.io/service-account-token
EOL

# zastosowanie pliku YAML w klastrze
kubectl apply -f token.yaml

# wyswietlenie tokena oraz adresu proxy webUI K8s oraz zapisanie do pliku w razie fuckup'u ;)
kubectl describe secrets token -n kube-system > token.txt

echo >> token.txt
echo >> token.txt

echo "Twoje webUI K8S to: http://localhost:8001/api/v1/namespaces/kubernetes-dashboard/services/https:kubernetes-dashboard:/proxy/" >> token.txt