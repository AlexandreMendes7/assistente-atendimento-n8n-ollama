# Teste rápido do Assistente de Atendimento (PowerShell)
# Uso: .\testar.ps1  (com n8n e Ollama rodando)

$url = "http://localhost:5678/webhook/atendimento"

$perguntas = @(
    "Qual o horário de atendimento?",
    "Vocês fazem clareamento? Quanto custa?",
    "Quais formas de pagamento vocês aceitam?",
    "Quero marcar uma consulta."
)

foreach ($p in $perguntas) {
    Write-Host "`n> $p" -ForegroundColor Cyan
    $body = @{ mensagem = $p } | ConvertTo-Json
    try {
        $resp = Invoke-RestMethod -Uri $url -Method Post -ContentType "application/json" -Body $body
        Write-Host "  $($resp.resposta)" -ForegroundColor Green
    } catch {
        Write-Host "  ERRO: $($_.Exception.Message)" -ForegroundColor Red
    }
}
