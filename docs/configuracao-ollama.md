# ⚙️ Configuração do Ollama e do Modelo de IA

## 1. Instalação

Baixe e instale o Ollama em **https://ollama.com/download**.
Após instalar, o serviço fica disponível localmente em:

```
http://localhost:11434
```

## 2. Modelos recomendados

| Modelo | Comando | Indicação |
|--------|---------|-----------|
| `llama3.1:8b` | `ollama pull llama3.1:8b` | **Padrão** — melhor qualidade de resposta |
| `mistral:7b`  | `ollama pull mistral:7b`  | Alternativa mais leve / rápida |

Verifique os modelos instalados:

```bash
ollama list
```

## 3. Endpoint utilizado no projeto

O workflow chama a **API de geração** do Ollama:

```
POST http://localhost:11434/api/generate
```

Corpo (JSON) enviado pelo nó **HTTP Request** do n8n:

```json
{
  "model": "llama3.1:8b",
  "system": "<prompt de sistema>",
  "prompt": "Informações da empresa:\n<base de conhecimento>\n\nPergunta do cliente: <mensagem>",
  "stream": false,
  "options": { "temperature": 0.3 }
}
```

> `stream: false` → o Ollama devolve a resposta completa de uma vez (mais simples de tratar no n8n).
> `temperature: 0.3` → respostas mais objetivas e menos "criativas", ideal para atendimento.

A resposta do Ollama chega no campo `response`, que o nó **Code** limpa e repassa como `{ "resposta": "..." }`.

## 4. Prompt de sistema (system prompt)

```
Você é um atendente virtual de uma pequena empresa.
Responda sempre de forma educada, profissional e objetiva.
Ajude clientes com dúvidas sobre horários, serviços, preços,
localização e informações gerais.
Use APENAS as informações fornecidas no contexto da empresa.
Nunca invente informações.
Caso não saiba a resposta, informe que um atendente humano irá auxiliar.
Responda em português do Brasil, em no máximo 3 frases.
```

Esse prompt reduz "alucinações" ao instruir o modelo a usar **somente** a base de conhecimento fornecida.

## 5. Trocar de modelo

Para usar o `mistral:7b` em vez do `llama3.1:8b`:

1. Baixe: `ollama pull mistral:7b`
2. No n8n, abra o nó **Base de Conhecimento** e altere o campo `model` para `mistral:7b`.
3. Salve o workflow.

## 6. Teste direto (sem n8n)

Você pode validar o Ollama isoladamente:

```bash
curl http://localhost:11434/api/generate -d "{ \"model\": \"llama3.1:8b\", \"prompt\": \"Diga apenas OK\", \"stream\": false }"
```
