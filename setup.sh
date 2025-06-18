#!/bin/bash

echo "🔄 Initialisation complète du projet Vault + SQLite"

# === Étape 1 : Créer le venv ===
if [ ! -d "venv" ]; then
    echo "📦 Création de l'environnement virtuel Python..."
    python3 -m venv venv
else
    echo "✅ Environnement virtuel déjà présent"
fi

# Activer le venv
source venv/bin/activate

# === Étape 2 : Installer les dépendances ===
echo "📚 Installation des dépendances Python..."
pip install --upgrade pip
pip install -r requirements.txt

# === Étape 3 : Vérification de sqlite/Vault installés ===
if ! command -v sqlite3 &> /dev/null
then
    echo "❌ sqlite3 n'est pas installé. Please run: sudo apt install sqlite3"
    exit 1
fi

if ! command -v vault &> /dev/null
then
    echo "❌ Vault n'est pas installé. Please run: sudo apt install vault"
    exit 1
fi

# === Étape 4 : Lancer Vault DEV en arrière-plan ===
echo "🚀 Lancement de Vault en mode développement (background)..."
vault server -dev > vault.log 2>&1 &
VAULT_PID=$!
sleep 2  # attendre que Vault démarre

# === Étape 5 : Extraire le token root depuis le log ===
echo "🎫 Récupération du root token Vault..."
ROOT_TOKEN=$(grep 'Root Token:' vault.log | awk '{print $NF}')
export VAULT_TOKEN=$ROOT_TOKEN
export VAULT_ADDR='http://127.0.0.1:8200'

echo "🔐 VAULT_TOKEN=$VAULT_TOKEN"
echo "🔐 VAULT_ADDR=$VAULT_ADDR"

# === Étape 6 : Activer moteur kv v2 ===
echo "🔧 Configuration de Vault (secrets engine kv v2)..."
vault secrets disable db 2>/dev/null  # au cas où déjà présent
vault secrets enable -path=db -version=2 kv

# === Étape 7 : Créer base SQLite ===
echo "🗄️ Création de la base testvault.db..."
rm -f testvault.db

sqlite3 testvault.db <<EOF
CREATE TABLE livre (
    id INTEGER PRIMARY KEY,
    titre TEXT NOT NULL
);

INSERT INTO livre (titre) VALUES 
('Le Petit Prince'), 
('1984'), 
('Python pour les Nuls');
EOF

# === Étape 8 : Enregistrer le chemin dans Vault ===
ABS_PATH="$(realpath testvault.db)"
vault kv put db/sqlite path="$ABS_PATH"

# === Étape 9 : Exécuter le script Python ===
echo "⚙️ Lancement de l'application Python..."

python main.py

# === Étape 10 : Nettoyage ===
echo "🧼 Arrêt de Vault (PID $VAULT_PID)..."
kill $VAULT_PID
rm vault.log

echo "✅ Terminé !"


