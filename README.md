# 🔐 Vault + SQLite Demo (Python)

Ce projet est une démo simple en Python qui :
- Lit un **chemin de base SQLite** stocké dans **HashiCorp Vault (kv v2)**
- Affiche le contenu d'une table `livre`
- Utilise un environnement Python virtuel (`venv`) pour l'isolation

---

## 🚀 Objectif pédagogique

- Découvrir le fonctionnement de **HashiCorp Vault** avec une application Python
- Utiliser un secret Vault pour rendre une connexion base de données dynamique
- Préparer un projet Python propre, portable et reproductible

---

## 🧰 Prérequis

Avant de commencer, assure-toi d'avoir installé sur ta machine Linux :

| Outil        | Installation (Debian/Ubuntu)                |
|--------------|---------------------------------------------|
| Python 3.10+ | `sudo apt install python3 python3-venv -y` |
| Pip          | `sudo apt install python3-pip -y`          |
| SQLite       | `sudo apt install sqlite3 -y`              |
| Vault        | `sudo apt install vault -y`                |
| Git          | `sudo apt install git -y`                  |

---

## 📦 Installation & premier lancement

### 1. Cloner le projet depuis GitHub

```bash
git clone https://github.com/<ton-utilisateur>/vault-sqlite-demo.git
cd vault-sqlite-demo
```

### 2. Lancer le script de setup

```bash
chmod +x setup.sh
./setup.sh
```

Ce script `setup.sh` :

- Crée et active un environnement virtuel Python (`venv`)
- Installe les dépendances avec `pip`
- Lance Vault en mode développement
- Crée la base SQLite locale `testvault.db`
- Enregistre le chemin de la base dans Vault (`db/sqlite`)
- Exécute le script `main.py`

---

## 🧾 Résultat attendu

```bash
Liste des livres :
1 - Le Petit Prince
2 - 1984
3 - Python pour les Nuls
```

---

## 🗂️ Arborescence du projet

```
vault-sqlite-demo/
├── main.py
├── init_db.sh
├── setup.sh
├── requirements.txt
├── .gitignore
└── README.md
```

---

## ⚠️ Remarques Vault

- Vault est lancé en mode `-dev`, donc en mémoire uniquement
- À chaque redémarrage de Vault, les secrets et la configuration sont effacés
- `setup.sh` remet tout en place à chaque exécution

---

## 🚫 Ce que ce projet NE fait PAS

- Authentification avancée Vault (AppRole, Token dynamique, Policies, etc.)
- Connexion à des bases de données distantes (MySQL, PostgreSQL)
- Gestion fine des accès Vault

---

## ✅ Pour résumer

```bash
git clone https://github.com/<ton-utilisateur>/vault-sqlite-demo.git
cd vault-sqlite-demo
chmod +x setup.sh
./setup.sh
```
