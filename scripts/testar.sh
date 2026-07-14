#!/usr/bin/env bash
# Teste rápido do Assistente de Atendimento (bash/cURL)
# Uso: bash testar.sh   (com n8n e Ollama rodando)

URL="http://localhost:5678/webhook/atendimento"

perguntas=(
  "Qual o horário de atendimento?"
  "Vocês fazem clareamento? Quanto custa?"
  "Quais formas de pagamento vocês aceitam?"
  "Quero marcar uma consulta."
)

for p in "${perguntas[@]}"; do
  echo ""
  echo "> $p"
  curl -s -X POST "$URL" \
    -H "Content-Type: application/json" \
    -d "{ \"mensagem\": \"$p\" }"
  echo ""
done
