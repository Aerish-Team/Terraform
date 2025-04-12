# Terraform

```
subscription_id = "..." # Your subscription ID

# Aerish Read Server Container
ghcr_pat = "..." # PAT of ghcr package (read only) Aerish-Get-Container

# Database admin password
database_admin_password = "..."

# Global API Key
cloudflare_api_key = "..."

aerish_version_api = "1.0.1.3"
aerish_version_admin = "1.0.0.8"
aerish_version_reports = "1.0.0.8"
aerish_version_eportal = "1.0.0.8"
```

Db connection string ``Server=tcp:aerish-q-db-server.database.windows.net,1433;Initial Catalog=aerish-q-db;Persist Security Info=False;User ID=sqladmin;Password={your_password};MultipleActiveResultSets=False;Encrypt=True;TrustServerCertificate=False;Connection Timeout=30;``