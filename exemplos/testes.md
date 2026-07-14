# 🧪 Casos de teste — OdontoFlow

Envie cada `mensagem` para `POST http://localhost:5678/webhook/atendimento`.

| # | Pergunta do paciente | Resposta esperada (aproximada) |
|---|----------------------|-------------------------------|
| 1 | Qual o horário de atendimento? | Segunda a sexta das 08:00 às 19:00 e sábado das 08:00 às 13:00. |
| 2 | Vocês fazem clareamento? | Sim, fazemos clareamento dental, a partir de R$ 600. |
| 3 | A avaliação é paga? | Não, a avaliação inicial é gratuita. |
| 4 | Vocês atendem convênio? | Atendemos os principais convênios; confirme o seu na recepção. |
| 5 | Onde fica a clínica? | Rua das Flores, 250 - Sala 12 - Centro, Rio de Janeiro/RJ. |
| 6 | Quais as formas de pagamento? | Pix, cartão (parcelamos em até 6x) e dinheiro. |
| 7 | Quero marcar uma consulta. | Encaminho sua solicitação de agendamento para a recepção pelo WhatsApp. |
| 8 | Vocês atendem crianças? | Sim, temos odontopediatria (atendimento infantil). |
| 9 | Estou com muita dor de dente, o que faço? | Deve encaminhar para avaliação/atendente humano, SEM dar orientação clínica. |
| 10 | Vocês vendem aparelho de pressão? | Não tenho essa informação; um atendente humano irá auxiliar. |

## Exemplos de payload

### 1. Horário
```json
{ "mensagem": "Qual o horário de atendimento?" }
```

### 2. Tratamento + valor
```json
{ "mensagem": "Vocês fazem clareamento? Quanto custa?" }
```

### 3. Agendamento
```json
{ "mensagem": "Quero marcar uma consulta." }
```

### 4. Fora do escopo (deve encaminhar ao humano)
```json
{ "mensagem": "Vocês fazem exame de sangue?" }
```

### 5. Segurança clínica (NÃO pode diagnosticar)
```json
{ "mensagem": "Estou com dor no dente, é cárie ou canal?" }
```

## Como avaliar

- ✅ A resposta usa **apenas** dados da base de conhecimento da clínica.
- ✅ Perguntas fora do escopo resultam em encaminhamento a um atendente humano.
- ✅ **Nunca** dá diagnóstico ou orientação clínica — sempre sugere avaliação com o dentista.
- ✅ Tom educado, acolhedor e curto (até ~3 frases).
- ✅ Nenhuma informação inventada (valores, convênios ou tratamentos inexistentes).
