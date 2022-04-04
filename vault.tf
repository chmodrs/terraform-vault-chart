resource "helm_release" "vault" {
  name         = "vault"
  repository   = "https://helm.releases.hashicorp.com"
  chart        = "vault"
  namespace    = "vault"
  wait         = "false"
  reuse_values = "false"
  replace      = "false"


  set {
    name  = "global.imagePullSecrets[0].name"
    value = "unjregistry"
  }

  set {
    name  = "server.image.repository"
    value = "vault"
  }

  set {
    name  = "server.image.tag"
    value = "1.7.2"
  }

  set {
    name  = "injector.image.repository"
    value = "vault-k8s"
  }

  set {
    name  = "injector.image.tag"
    value = "0.10.0"
  }

  set {
    name  = "injector.agentImage.repository"
    value = "vault"
  }

  set {
    name  = "injector.agentImage.tag"
    value = "1.7.2"
  }

  set {
    name  = "injector.logLevel"
    value = "trace"
  }

  set {
    name  = "server.logLevel"
    value = "trace"
  }

  set {
    name  = "server.resources.requests.memory"
    value = "256Mi"
  }

  set {
    name  = "server.resources.requests.cpu"
    value = "250m"
  }

  set {
    name  = "server.resources.limits.memory"
    value = "256Mi"
  }

  set {
    name  = "server.resources.limits.cpu"
    value = "250m"
  }

  set {
    name  = "server.dataStorage.enabled"
    value = "false"
  }

  set {
    name  = "server.auditStorage.enabled"
    value = "false"
  }

  set {
    name  = "server.auditStorage.size"
    value = "1Gi"
  }

  set {
    name  = "server.auditStorage.mountPath"
    value = "/vault/audit"
  }

  set {
    name  = "server.auditStorage.storageClass"
    value = "efs-sc"
  }

  set {
    name  = "server.auditStorage.accessMode"
    value = "ReadWriteMany"
  }

  set {
    name  = "server.standalone.config"
    value = <<-EOF
      ui = true

      listener "tcp" {
        tls_disable = 1
        address = "[::]:8200"
        cluster_address = "[::]:8201"
      }
      storage "s3" {
        access_key = "VAULT_ACCESS_KEY"
        secret_key = "VAULT_SECRET_KEY"
        bucket     = "VAULT_BUCKET"
        region     = "sa-east-1"
        kms_key_id = "VAULT_KMS_ID"
      }
      plugins_directory = "/vault/plugins"
      
      seal "awskms"{
        region = "sa-east-1"
        access_key = "VAULT_ACCESS_KEY"
        secret_key = "VAULT_SECRET_KEY"
        kms_key_id = "VAULT_KMS_ID"
      }
      EOF
  }
}
