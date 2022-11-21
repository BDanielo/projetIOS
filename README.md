# projetIOS
**Description rapide :**

Notre application permet à un commerçant de gérer son stock de marchandise pour un ou plusieurs magasins.
Sur la première page, l'utilisateur aurait accès à une liste de ses dépôts (magasins ou types de stockages), qu'il pourra sélectionner pour accéder à une liste de produits, comportant chacun des informations détaillées.
L'application sera donc composée de 4 vues, et d'une base de données comportant 2 tables.


**Bases de données : **

- Dépôts (Magasins/ type de stock)     [Id, Nom]
- Articles ()                 [Id Dépôt, Id Catégorie, Nom, Qte, Descriptions]
- Catégories (Surgelés, vêtements… ) [Id, Nom, D0esc]

**Vues : **

- Listes des dépôts
- Listes des articles du depots
- Listes des catégories
- Infos de l’article

**Fonctionnalités secondaires (Implémentées si assez de temps) : **

- Map des dépôts
- Gestion des péremptions
- Notif manque de stock reappro
- Gestion des emplacements ?
- Scan des code barre produit pour ajout au stock / enlever de stock
