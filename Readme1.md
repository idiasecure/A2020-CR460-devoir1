#### Remise de devoir 1 en plusieurs modules :

#### variables.tf :
contient les variables pour identifier le projet et la zone de traitement

#### data.tf :
un fichier pour calculer le réseau par défaut et le projet par défaut, ce dernier via une variable

#### output.tf :
pour obtenir directement l'adresse ip du serveur web.

#### provider.tf :
contient les informations du fournisseur cloud

#### compute.tf :
contient les informations des 4 instances demandées : "canard", "mouton", "cheval" ,"fermier"

#### network.tf :
contient les informations des réseaux : réseau principal "devoir1" et sous-réseaux "prod-interne", "prod-dmz", "prod-traitement", "traitement"

#### firewall.tf :  
contient les informations des 3 règles de pare-feu
