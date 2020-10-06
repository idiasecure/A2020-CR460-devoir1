Remise de devoir 1 en plusieurs modules :

variables.tf : contient les variables pour identifier le projet et la zone de traitement

data.tf : un fichier pour calculer le réseau par défaut et le projet par défaut, ce dernier via une variable

output.tf : pour obtenir directement l'adresse ip du serveur web.

provider.tf : contient les informations du fournisseur cloud

compute.tf : contient les informations des 4 instances demandées
#### Instances
* une instance nommée "canard"
* une instance nommée "mouton"
* une instance nommée "cheval"
* une instance nommée "fermier"

network.tf : contient les informations des réseaux
* Le réseau principal nommé "devoir1"
* un sous-réseau "prod-interne" "10.0.3.0/24"
* un sous-réseau "prod-dmz" "172.16.3.0/24"
* un sous-réseau "prod-traitement" "10.0.2.0/24"
* un sous-réseau "traitement" "10.0.4.0/24"

firewall.tf :  contient les informations des règles de parefeux
* Une règle de pare-feu pour autoriser le trafic web sur les instances ciblées "public-web"
* Une règle de pare-feu pour autoriser le trafic  vers les instances ciblées "traitement" sur les ports TCP "2846", "5462" , seulement à partir des instances sur le sous-réseau "prod-interne"
* Une règle de pare-feu pour autoriser la connexion ssh de l'internet vers les instances internes (ex. "mouton")
