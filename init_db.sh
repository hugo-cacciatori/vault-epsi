#!/bin/bash

echo "Création de la base de données testvault.db..."

# Supprimer l'ancienne base si elle existe
if [ -f "testvault.db" ]; then
  echo "⚠️ Suppression de l'ancienne base testvault.db..."
  rm testvault.db
fi

# Recréer la base
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

echo "✅ Base testvault.db créée avec succès !"

