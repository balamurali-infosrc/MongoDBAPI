output "mongodb_primary_connection_string" {
  value     = azurerm_cosmosdb_account.mongo.primary_mongodb_connection_string
  sensitive = true
}

output "mongodb_endpoint" {
  value = azurerm_cosmosdb_account.mongo.endpoint
}
