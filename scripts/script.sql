CREATE DATABASE lesProject;

use lesProject;

CREATE TABLE tb_estado
(
 est_id INT NOT NULL AUTO_INCREMENT,
 est_nome VARCHAR(100) NOT NULL,
 est_sigla CHAR(2) NOT NULL,
 est_ativo BOOLEAN NOT NULL,
 est_dataHoraCriacao DATETIME NOT NULL,
 PRIMARY KEY (est_id)
)ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE tb_cidade
(
 cid_id INT NOT NULL AUTO_INCREMENT,
 cid_nome VARCHAR(100) NOT NULL,
 cid_ativo BOOLEAN NOT NULL,
 cid_dataHoraCriacao DATETIME NOT NULL,
 cid_est_id INT NOT NULL,
 PRIMARY KEY (cid_id),
 FOREIGN KEY(cid_est_id) REFERENCES tb_estado(est_id)
)ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE tb_imagem
( 
 ima_id INT NOT NULL AUTO_INCREMENT,
 ima_ativo BOOLEAN NOT NULL,
 ima_dataHoraCriacao DATETIME NOT NULL,
 ima_nome VARCHAR(100) NOT NULL,
 ima_descricao VARCHAR(100) NOT NULL,
 PRIMARY KEY (ima_id)
)ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE tb_usuario
( 
 usu_id INT NOT NULL AUTO_INCREMENT,
 usu_ativo BOOLEAN NOT NULL,
 usu_dataHoraCriacao DATETIME NOT NULL,
 usu_email VARCHAR(100) NOT NULL,
 usu_senha VARCHAR(100) NOT NULL,
 usu_ima_id INT,
 PRIMARY KEY (usu_id),
 FOREIGN KEY(usu_ima_id) REFERENCES tb_imagem(ima_id)
)ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE tb_cupomTroca
(
  cut_id INT NOT NULL AUTO_INCREMENT,
  cut_ativo BOOLEAN NOT NULL,
  cut_dataHoraCriacao DATETIME NOT NULL,
  cut_valor NUMBER(4,2) NOT NULL,
  cut_usu_id INT NOT NULL,
  PRIMARY KEY (cut_id),
  FOREIGN KEY (cut_usu_id) REFERENCES tb_usuario(usu_id)
)ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE tb_carrinho
(
  car_id INT NOT NULL AUTO_INCREMENT,
  car_subTotal NUMBER(4,2) DEFAULT NULL,
  car_validade DATETIME DEFAULT NULL,
  car_ativo BOOLEAN NOT NULL,
  car_dataHoraCriacao DATETIME NOT NULL,
  PRIMARY KEY (car_id)
)ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE tb_cliente
( 
 cli_id INT NOT NULL AUTO_INCREMENT,
 cli_nome VARCHAR(100) NOT NULL,
 cli_numeroTelefone VARCHAR(12) NOT NULL,
 cli_numeroDocumento VARCHAR(14) NOT NULL,
 cli_dataNascimento DATE NOT NULL,
 cli_ativo BOOLEAN NOT NULL,
 cli_dataHoraCriacao DATETIME NOT NULL,
 cli_usu_id INT NOT NULL,
 cli_car_id INT NOT NULL,
 PRIMARY KEY (cli_id),
 FOREIGN KEY(cli_usu_id) REFERENCES tb_usuario(usu_id),
 FOREIGN KEY(cli_car_id) REFERENCES tb_carrinho(car_id)
)ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE tb_endereco
( 
 end_id INT NOT NULL AUTO_INCREMENT,
 end_logradouro VARCHAR(100) NOT NULL,
 end_bairro VARCHAR(100) NOT NULL,
 end_cep VARCHAR(9) NOT NULL,
 end_numero INT(4) NOT NULL,
 end_complemento VARCHAR(100),
 end_referencia VARCHAR(100),
 end_favorito BOOLEAN NOT NULL,
 end_ativo BOOLEAN NOT NULL,
 end_dataHoraCriacao DATETIME NOT NULL,
 end_cid_id INT NOT NULL,
 end_cli_id INT NOT NULL,
 PRIMARY KEY (end_id),
 FOREIGN KEY(end_cid_id) REFERENCES tb_cidade(cid_id),
 FOREIGN KEY(end_cli_id) REFERENCES tb_cliente(cli_id)
)ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE tb_frete
( 
  fre_id INT NOT NULL AUTO_INCREMENT,
  fre_valor NUMBER(4,2),
  fre_previsao INT NOT NULL,
  fre_end_id INT NOT NULL,
  PRIMARY KEY (fre_id),
  FOREIGN KEY(fre_end_id) REFERENCES tb_endereco(end_id),
)ENGINE=InnoDB DEFAULT CHARSET=utf8;

/****************************************/
CREATE TABLE tb_produto
(
  pro_id INT NOT NULL AUTO_INCREMENT,
  pro_nome VARCHAR(100) NOT NULL,
  pro_preco NUMBER(4,2) NOT NULL.
  pro_descricao VARCHAR(400) NOT NULL,
  pro_ativo BOOLEAN NOT NULL,
  pro_dataHoraCriacao DATETIME NOT NULL,
  pro_ima_id INT DEFAULT NULL, 
  PRIMARY KEY (pro_id),
  FOREIGN KEY(pro_ima_id) REFERENCES tb_imagem(ima_id)
)ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE tb_pagamentoCupom
(
  pcu_id INT NOT NULL AUTO_INCREMENT,
  pcu_valorTotalCupom NUMBER(4,2) NOT NULL,
  PRIMARY KEY (pcu_id)
)ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE tb_cupom
(
  cup_id INT NOT NULL AUTO_INCREMENT,
  cup_valor NUMBER(4,2) NOT NULL,
  cup_ativo BOOLEAN NOT NULL,
  cup_dataHoraCriacao DATETIME NOT NULL,
  cup_pcu_id INT NOT NULL,
  PRIMARY KEY (cup_id),
  FOREIGN KEY(cup_pcu_id) REFERENCES tb_pagamentoCupom(pcu_id)
)ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE tb_cartaoCredito
(
  pca_id INT NOT NULL AUTO_INCREMENT,
  pca_ativo BOOLEAN NOT NULL,
  pca_dataHoraCriacao DATETIME NOT NULL,
  pca_numero VARCHAR(20) NOT NULL,
  pca_codigo VARCHAR(5) NOT NULL,
  pca_nomeImpresso VARCHAR(100) NOT NULL,
  pca_favorito BOOLEAN NOT NULL,
  pca_cli_id INT NOT NULL,
  PRIMARY KEY (pca_id),
  FOREIGN KEY(pca_cli_id) REFERENCES tb_cliente(cli_id)
)ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE tb_pagamentoCartao
(
  pca_id INT NOT NULL AUTO_INCREMENT,
  pca_valorTotalCartao NUMBER(4,2) NOT NULL,
  pca_cre_id INT NOT NULL,
  PRIMARY KEY (pca_id),
  FOREIGN KEY(pca_cre_id) REFERENCES tb_cartaoCredito(pca_id)
)ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE tb_formaPagamento
(
  fpag_id INT NOT NULL AUTO_INCREMENT,
  fpag_valorTotal NUMBER(4,2) NOT NULL,
  fpag_pcu_id INT DEFAULT NULL,
  fpag_pca_id INT DEFAULT NULL,
  PRIMARY KEY (fpag_id),
  FOREIGN KEY(fpag_pcu_id) REFERENCES tb_pagamentoCupom(pcu_id),
  FOREIGN KEY(fpag_pca_id) REFERENCES tb_pagamentoCartao(pca_id)
)ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE tb_pedido
(
  ped_id INT NOT NULL AUTO_INCREMENT,
  ped_valor NUMBER(4,2) NOT NULL,
  ped_statusPedido VARCHAR(20) NOT NULL,
  ped_ativo BOOLEAN NOT NULL,
  ped_dataHoraCriacao DATETIME NOT NULL,
  ped_fpag_id INT NOT NULL,
  ped_fre_id INT NOT NULL,
  ped_cli_id INT NOT NULL,
  PRIMARY KEY (ped_id),
  FOREIGN KEY(ped_fpag_id) REFERENCES tb_formaPagamento(fpag_id),
  FOREIGN KEY(ped_fre_id) REFERENCES tb_frete(fre_id),
  FOREIGN KEY(ped_cli_id) REFERENCES tb_cliente(cli_id),
)ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE tb_troca
(
  tro_id INT NOT NULL AUTO_INCREMENT,
  tro_dataHoraCriacao DATETIME NOT NULL,
  tro_ped_id INT NOT NULL,
  tro_cli_id INT NOT NULL,
  tro_statusTroca VARCHAR(20),
  PRIMARY KEY (tro_id),
  FOREIGN KEY(tro_ped_id) REFERENCES tb_pedido(ped_id),
  FOREIGN KEY(tro_cli_id) REFERENCES tb_cliente(cli_id)
)ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE tb_itemPedido
(
  iped_id INT NOT NULL AUTO_INCREMENT, 
  iped_quantidade INT NOT NULL,
  iped_pro_id INT NOT NULL,
  iped_ped_id INT NOT NULL,
  PRIMARY KEY (iped_id),
  FOREIGN KEY(iped_pro_id) REFERENCES tb_produto(pro_id),
  FOREIGN KEY(iped_ped_id) REFERENCES tb_pedido(ped_id)
)ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE tb_itemTroca
(
  itro_id INT NOT NULL AUTO_INCREMENT, 
  itro_quantidade INT NOT NULL,
  itro_pro_id INT NOT NULL,
  itro_tro_id INT NOT NULL,
  PRIMARY KEY (itro_id),
  FOREIGN KEY(itro_pro_id) REFERENCES tb_produto(pro_id),
  FOREIGN KEY(itro_tro_id) REFERENCES tb_troca(ped_id)
)ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE tb_itemCarrinho
(
  icar_id INT NOT NULL AUTO_INCREMENT,
  icar_quantidade INT NOT NULL,
  icar_car_id INT NOT NULL,
  icar_pro_id INT NOT NULL,
  PRIMARY KEY (icar_id),
  FOREIGN KEY(icar_pro_id) REFERENCES tb_produto(pro_id),
  FOREIGN KEY(icar_car_id) REFERENCES tb_carrinho(car_id)
)ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE tb_inativacao
(
  ina_id INT NOT NULL AUTO_INCREMENT,
  ina_ativo BOOLEAN NOT NULL,
  ina_dataCriacao DATETIME NOT NULL,
  ina_descricao VARCHAR(400) NOT NULL,
  ina_statusInativacao VARCHAR(20) NOT NULL, 
  ina_pro_id INT NOT NULL,
  PRIMARY KEY (ina_id),
  FOREIGN KEY(ina_pro_id) REFERENCES tb_produto(pro_id)
)

CREATE TABLE tb_ativacao 
(
  ati_id INT NOT NULL AUTO_INCREMENT,
  ati_ativo BOOLEAN NOT NULL,
  ati_dataCriacao DATETIME NOT NULL,
  ati_descricao VARCHAR(400) NOT NULL,
  ati_statusAtivacao VARCHAR(20) NOT NULL, 
  ati_pro_id INT NOT NULL,
  PRIMARY KEY (ati_id),
  FOREIGN KEY(ati_pro_id) REFERENCES tb_produto(pro_id)
)