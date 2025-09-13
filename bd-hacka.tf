resource "kubernetes_secret" "secrets-mongodb" {
  metadata {
    name = "secrets-mongodb"
  }

  type = "Opaque"

  data = {
    MONGO_INITDB_ROOT_USERNAME  = var.db_hacka_username
    MONGO_INITDB_ROOT_PASSWORD  = var.db_hacka_password
    MONGO_INITDB_DATABASE       = var.db_hacka_name
  }

  lifecycle {
    prevent_destroy = false
  }
}


# Deployment do MongoDB
resource "kubernetes_deployment" "mongodb-deployment" {
  metadata {
    name = "mongodb"
  }
  spec {
    replicas = 1
    selector {
      match_labels = {
        app = "mongodb"
      }
    }
    template {
      metadata {
        labels = {
          app = "mongodb"
        }
      }
      spec {
        container {
          name  = "mongodb"
          image = "mongo:latest"
          port {
            container_port = 27017
          }
          env_from {
            secret_ref {
              name = kubernetes_secret.secrets-mongodb.metadata[0].name
            }
          }
          args = ["--auth"]
          # port {
          #   container_port = 15672
          # }
        }
      }
    }
  }
}

# Serviço do MongoDB
resource "kubernetes_service" "mongodb-service" {
  metadata {
    name = "mongodb"
  }
  spec {
    selector = {
      app = "mongodb"
    }
    port {
      name        = "service"
      protocol    = "TCP"
      port        = 27017
      target_port = 27017
    }
    # port {
    #   name        = "web"
    #   protocol    = "TCP"
    #   port        = 15672
    #   target_port = 15672
    # }
  }
}