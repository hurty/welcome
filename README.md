# Test technique WTTJ

## Installation

- Installer les dépendances : `mix deps.get`
- Vérifier les credentials pour Postgres : `config/dev.exs`
- Initialiser la BD : `mix ecto.setup`. (Des données sont déjà insérées dans les seeds !)
- Installer les dépendances pour les assets : `cd assets && npm install`
- Démarrer le serveur : `mix phx.server`

## Organisation de l'application

### Modélisation backend

L'application a été modélisée au sein d'un contexte `ATS` avec les schémas suivants :

- _JobOffer_ : une offre d'emploi (non persisté car on n'a qu'un seul board ici).
- _Applicant_ : un candidat.
- _Application_ : une candidature précise d'un Applicant à une JobOffer (== les cartes dans le board).
- _Stage_ : étape dans le pipeline de recrutement (== les colonnes du board)

### Ordonnancement des cartes

Chaque _Application_ est persistée en base avec une référence de son _Stage_ parent ainsi que son positionnement dans ce _Stage_.

Pour le réordonnancement de ces _Application_ en base, j'ai introduit un module _Position_ qui essaye d'être le plus générique possible et qui pourra s'appliquer à d'autres schémas plus tard (par exemple pour réordonner les colonnes).

### Drag and Drop

J'ai utilisé la bibliothèque `react-beautiful-dnd` d'Atlassian qui permet d'avoir un haut niveau d'abstraction pour tout ce qui est drag and drop.

### Synchronisation client/serveur

Je n'ai pas écrit d'API REST dans le cadre de ce test car toutes les données nécessaires peuvent transiter via la connexion websocket déjà ouverte.

Nous avons les messages suivants :

- `get_job_offer` : demande les données initiales au chargement de l'appli React.
- `update_application` : met à jour la candidature (dans le cadre de ce test seulement la position)
- `update_application_position` : message broadcasté à tous les clients connectés quand la position d'une carte a changé. A noter que le client qui est à l'origine du déplacement de carte ne refait pas de réordonnancement.

Les payloads des messages sont encodés en JSON en implémentant le protocole Jason.Encoder pour chacun des schémas.

L'authentification et l'autorisation de l'utilisateur n'a pas été nécessaire dans le cadre de ce test.

Je reste disponible pour en discuter.

Pierre
