resource "azurerm_resource_group" "rg" {
  name     = var.resource_group_name
  location = var.location
}

resource "azurerm_cosmosdb_account" "mongo" {
  name                = "cosmos-mongo-acct-demo"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  offer_type = "Standard"
  kind       = "MongoDB"

  capabilities {
    name = "EnableMongo"
  }

  consistency_policy {
    consistency_level = "Session"
  }

  geo_location {
    location          = azurerm_resource_group.rg.location
    failover_priority = 0
  }
}

resource "azurerm_cosmosdb_mongo_database" "db" {
  name                = "mydb"
  resource_group_name = azurerm_resource_group.rg.name
  account_name        = azurerm_cosmosdb_account.mongo.name
}

resource "azurerm_cosmosdb_mongo_collection" "collection" {
  name                = "example-coll"
  resource_group_name = azurerm_resource_group.rg.name
  account_name        = azurerm_cosmosdb_account.mongo.name
  database_name       = azurerm_cosmosdb_mongo_database.db.name

  default_ttl_seconds = -1

  index {
    keys   = ["_id"]
    unique = false
  }
}

# Refer
# index {
#   keys   = ["email"]
#   unique = true
# }

# resource "azurerm_cosmosdb_mongo_collection" "collection" {
#   name                = "employee"
#   resource_group_name = azurerm_resource_group.rg.name
#   account_name        = azurerm_cosmosdb_account.mongo.name
#   database_name       = azurerm_cosmosdb_mongo_database.db.name

# #   shard_key = "employeeId"
# }
