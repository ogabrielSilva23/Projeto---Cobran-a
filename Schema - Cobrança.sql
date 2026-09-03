-- Schema: Cobrança e Recuperação de Crédito
-- Projeto de portfólio — Gabriel

CREATE TABLE IF NOT EXISTS clientes (
    cliente_id      INTEGER PRIMARY KEY,
    nome            TEXT,
    idade           INTEGER,
    regiao          TEXT,
    renda_mensal    REAL,
    score_credito   INTEGER   -- 0 a 1000, tipo bureau de crédito
);

CREATE TABLE IF NOT EXISTS contratos (
    contrato_id     INTEGER PRIMARY KEY,
    cliente_id      INTEGER,
    produto         TEXT,      -- ex: 'Cartão de Crédito', 'Empréstimo Pessoal', 'CDC Veículo'
    data_contrato   TEXT,
    valor_original  REAL,
    num_parcelas    INTEGER,
    valor_parcela   REAL,
    FOREIGN KEY (cliente_id) REFERENCES clientes(cliente_id)
);

CREATE TABLE IF NOT EXISTS parcelas_atraso (
    parcela_id      INTEGER PRIMARY KEY,
    contrato_id     INTEGER,
    num_parcela     INTEGER,
    data_vencimento TEXT,
    valor           REAL,
    dias_atraso     INTEGER,
    faixa_atraso    TEXT,      -- 'Em dia', '1-15', '16-30', '31-60', '61-90', '90+'
    status          TEXT,      -- 'Pago', 'Em aberto'
    FOREIGN KEY (contrato_id) REFERENCES contratos(contrato_id)
);

CREATE TABLE IF NOT EXISTS acoes_cobranca (
    acao_id         INTEGER PRIMARY KEY,
    parcela_id      INTEGER,
    data_acao       TEXT,
    canal           TEXT,      -- 'Ligação', 'SMS', 'WhatsApp', 'Carta', 'Negativação'
    custo           REAL,
    resultou_pagamento INTEGER, -- 0 ou 1
    FOREIGN KEY (parcela_id) REFERENCES parcelas_atraso(parcela_id)
);

CREATE TABLE IF NOT EXISTS pagamentos (
    pagamento_id    INTEGER PRIMARY KEY,
    parcela_id      INTEGER,
    data_pagamento  TEXT,
    valor_pago      REAL,
    forma_pagamento TEXT,      -- 'PIX', 'Boleto', 'Cartão', 'Acordo'
    FOREIGN KEY (parcela_id) REFERENCES parcelas_atraso(parcela_id)
);