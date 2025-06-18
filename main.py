import hvac
import sqlite3
import os

# Connexion à Vault (attention, token en dev uniquement)
client = hvac.Client(
    url=os.getenv("VAULT_ADDR"),
    token=os.getenv("VAULT_TOKEN")
)

# Lire le chemin de la DB depuis Vault
read_response = client.secrets.kv.v2.read_secret_version(
    path="sqlite",
    mount_point="db"
)
db_path = read_response['data']['data']['path']

# Connexion SQLite
conn = sqlite3.connect(db_path)
cur = conn.cursor()

# Lire et afficher les données
cur.execute("SELECT * FROM livre")
rows = cur.fetchall()

print("Liste des livres :")
for row in rows:
    print(f"{row[0]} - {row[1]}")

cur.close()
conn.close()

