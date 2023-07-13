// +-----------------------------------------+
// | Desenvolvedor: MARCOS                   |
// | Atualização:  13/07/2023                |
// | Programa:  PREFEITURA DE AÇUCENA        |
// +-----------------------------------------+ 
{---SB 6.0 / BARRA_TP_aviso 1.0 -----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------Max char line 3500} TD_plugin:=0;x:=0; for i := 0 to 99 do begin if substr(RetornaNomeArqEntrada(0),i,1) <> '.' then begin x:= x+1; end else begin break; end; end; x:= x; if substr(RetornaNomeArqEntrada(0),x-1,1) = 'T' then x:= x-1; validaNome := substr(RetornaNomeArqEntrada(0),x-10,10); validaNomeDia := 0; validaNomeMes := 0; validaNomeAno := 0; validaNomeHor := 0; ValidaNomeMin := 0; if (StrTofloat(substr(validaNome,1,2)) > 0) and (StrTofloat(substr(validaNome,1,2)) < 32) then validaNomeDia := 1; if (StrTofloat(substr(validaNome,3,2)) > 0) and (StrTofloat(substr(validaNome,3,2)) < 13) then validaNomeMes := 1; if (StrTofloat(substr(validaNome,5,2)) > 20) and (StrTofloat(substr(validaNome,5,2)) < 30) then validaNomeAno := 1; if (StrTofloat(substr(validaNome,7,2)) >= 0) and (StrTofloat(substr(validaNome,7,2)) < 24) then validaNomeHor := 1; if (StrTofloat(substr(validaNome,9,2)) >= 0) and (StrTofloat(substr(validaNome,9,2)) < 60) then ValidaNomeMin := 1; if (validaNomeDia = 0 ) or (validaNomeMes = 0) or (validaNomeAno = 0) or (validaNomeHor = 0) or (ValidaNomeMin = 0) then abort ('ATENCAO: Nome de arquivo com formatacao INVALIDA! Formatacao correta (DDMMAAHHMM)'); TD_nomeDoArquivo := substr(RetornaNomeArqEntrada(0),1,x); fls_cx:= 0; n_arq:='';{----Pré-Configurações---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------}


{---Configurações--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------}
    TD_cliente                    := 'P.M. AÇUCENA - CLIENTE'; //Nome parcialmente completo
    TD_tipoImpresso               := 2;      // 1 = Carnes | 2 = Carta/Boletos |
    TD_qtdPorFolha                := 1;      //Quantidade de impresso por folha
    TD_paginaExtra                := 0;      //Quantidade de paginas nao inclusa no visual (contra-capa/encarte/etc)
    TD_folhasPorCaixa             := 1000;   //Quantidade de Folhar por caixa (carnes = 1500 caixa grande / 500 caixa pequena| Envelope 1000 A4 Caixa grande)
    TD_relatorios                 := 0;      // Desativar Relatorio = 0 | Ativar Relatorios = 1 
    TD_seguranca                  := 0;      // Desativa Barra de segurança = 0 | Ativa Barra de segurança = 1
{---Configurações de segurança-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------}
    marcaDaguaNome                := 'P.M.A'; //Marca dagua prefixo do cliente 
    tamanhoBarraSegurancaRandom   := 98;     //Numero maximo de codigo de segurança gerado com base no tamanhdo da marcadagua+1
    tamanhoBarraSegurancaLooping  := 110;    //Tamanho que da barra
    tamanhomarcaDeSeguranca       := 9999;   //Limite randomico do codigo de segurança
{---Plugin Inicio--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------}



{---Plugins Fim-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
----Relatorios 4.0-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------}
If TD_relatorios <> 0 then begin If (TD_relatorios= 1) then begin TD_resumo:= CreateFileLog('Resumo_'+TD_cliente+'_dt'+SubStr(StrNumeric(FormatTime(SYS_TIME,'HH:MM'),4),1,4)+'_'+RetornaNomeArqEntrada(0)); TD_conteudoResumo:=TD_cliente; WritelnFileLog(TD_resumo,TD_conteudoResumo); TD_registro:= CreateFileLog('Arquivo_Relatorio&Etiqueta_'+TD_cliente+'_'+SubStr(StrNumeric(FormatTime(SYS_TIME,'HH:MM'),4),1,4)+'_'+RetornaNomeArqEntrada(0)); TD_conteudoRegistro:='0;'+TD_cliente+';'++';'+FormatDate(SYS_DATE,'DD/MM/AAAA')+';'+SubStr(StrNumeric(FormatTime(SYS_TIME,'HH:MM'),4),1,2)+':'+SubStr(StrNumeric(FormatTime(SYS_TIME,'HH:MM'),4),3,2); WritelnFileLog(TD_registro,TD_conteudoRegistro); end; If TD_relatorios > 1 then begin    abort('RELATORIO - VALOR INFORMADO INVALIDO'); end; numeroDeCliente:=0; numeroDoLote:=0; end; {VAL.ANT.MRKISI} If TD_tipoImpresso > 2 then begin abort('ATENÇÃO - TIPO DE IMPRESSO INVALIDO'); end; If TD_qtdPorFolha < 1 then begin abort('ATENÇÃO - QUANTIDADE DE IMPRESSO POR FOLHA INVALIDO'); end; If fls_cx > 0 then begin abort('ATENÇÃO - SCRIPT PADRAO INVALIDO, VERSAO DESATUALIZADA INFERIOR A 5.0'); end; If n_arq <>'' then begin abort('ATENÇÃO - SCRIPT BARRA_TP_aviso 1.0 INVALIDO, VERSAO DESATUALIZADA INFERIOR A 2.0'); end; TP_numPage:=1; TP_aviso:=1; TD_idExtra:=''; TD_idCodigoBanco:=''; TD_idNumeroBanco:=''; barraSeg:=''; posicaoBarraSeg:='';
{---Variaveis Global Ini-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------}
While ReadLn(S) <> EOF do  Begin
		{---Variaveis comuns Ini---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------}  
		AVISO        := FormatNumeric(TP_aviso,'000.000'); //Aviso gerado pelo script, convertido p String.
		PROPRIETARIO := GetString(S,1,50);
		CODIGO       := GetString(S,163,6);
		END_ENTREG_1 := TrimStr(GetString(S,184,50))+'  '+FormatNumeric(GetNumeric(S,234,6),'######')+'  '+TrimStr(GetString(S,240,16));
		END_ENTREG_2 := GetString(S,256,30);
		END_ENTREG_3 := FormatNumeric(GetNumeric(S,313,8),'00000-000')+'  '+TrimStr(GetString(S,286,25))+'  '+TrimStr(GetString(S,311,2));
		PARC         := GetString(S,2904,2);
		CODIGO       := GetString(S,163,6);
		INSCRICAO    := GetString(S,169,15);
		DESCRICAO_IMO:= TrimStr(GetString(S,61,50));
		NUM_IMO      := TrimStr(GetString(S,111,6));
		COMPL_IMO    := TrimStr(GetString(S,117,16));
		BAIRR_IMO    := TrimStr(GetString(S,133,30));
		LOGR_ENT     := TrimStr(GetString(S,184,50));
		NUM_ENT      := TrimStr(GetString(S,234,6));
		COMPL_ENT    := TrimStr(GetString(S,240,16));
		BAIRR_ENT    := TrimStr(GetString(S,256,30));
		CID_ENT      := TrimStr(GetString(S,286,25));
		UF_ENT       := TrimStr(GetString(S,311,2));
		CEP_ENT      := FormatNumeric(GetNumeric(S,313,8),'00000-000');
		IPTU         := GetString(S,839,12);
		IPTU_VL      := GetFloat(S,851,16);
		EXPEDIENTE   := GetString(S,871,12);
		EXPED_VL     := GetFloat(S,883,14);
		DESC_TRIB1   := GetString(S,897,12);
		VL_TRIB1     := GetFloat(S,909,14);
		AREA_TERRE   := GetFloat(S,322,10);
		VL_TERREN    := GetFloat(S,364,16);
		VL_M2_TERR   := GetFloat(S,340,16);
		AREA_EDIFI   := GetFloat(S,380,8);
		VL_CONSTRU   := GetFloat(S,412,16);
		VL_M2_CONS   := GetFloat(S,388,16);
		VL_IMOVEL    := GetFloat(S,428,16);
		TOTAL        := GetFloat(S,1157,14);
		VALOR_UNICA  := GetFloat(S,1193,14);
		VENCTO_UNI   := Getdate(S,1223,10);
		BARRA_UNI    := GetString(S,1233,44);
		LINHA_UNI    := GetString(S,1277,55);
		COD_PARC     := GetString(S,1171,8);		
		COD_PARC1    := GetString(S,1594,8);
		VALOR_PARC1  := GetFloat(S,1602,14);
		VENCTO_PC1   := Getdate(S,1616,10);
		BARRA_PC1    := GetString(S,1626,44);
		LINHA_PC1    := GetString(S,1670,55);		
		COD_PARC2    := GetString(S,1725,8);
		VALOR_PARC2  := GetFloat(S,1733,14);
		VENCTO_PC2   := Getdate(S,1747,10);
		BARRA_PC2    := GetString(S,1757,44);
		LINHA_PC2    := GetString(S,1801,55);		
		COD_PARC3    := GetString(S,1856,8);
		VALOR_PARC3  := GetFloat(S,1864,14);
		VENCTO_PC3   := Getdate(S,1878,10);
		BARRA_PC3    := GetString(S,1888,44);
		LINHA_PC3    := GetString(S,1932,55);
		parcela      := 0;
		BLOCO        := 131;
		MENSAGEM_UNIC:= TrimStr(GetString(S,550,50));
		if getstring(s,2936,6) = 'débito' then begin
			MENSAGEM     := TrimStr(GetString(S,2906,50));
		end else begin
			MENSAGEM     := '';
		end;
		{verifica a quantidade de parcelas tem dentro do arquivo utilizando a variavel de 
		data de vencimento, pois dentro do arquivo não existe a quantidade de parcelas }		
		for i := 0 to 99 do begin
			if getstring(s,1616+(i*BLOCO),10) <> '00/00/0000' then begin
			parcela:= parcela+1;
			end else begin
			break;
			end;
		end;		
		{---Variaveis comuns Fim---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------}  
		{---Configurações Referencia do contribuinte no Registro | Barra de TD_registro 3.0 ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------}
        TD_idArquivo        := GetString(S,163,6);    //Identificação do arquivo maximo ate 12 numeros
        TD_idNumeroBanco    := GetString(S,1223,10);    //Referencia do Banco
        TD_idCodigoBanco    := GetString(S,1171,8);    //Referencia do contribuinte para com o banco (ex: nossonumero)
        //TD_idExtra          := GetString(S,0,0);   //Identificação extra 
		{--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------}  
		barraDeControle:=''; ctbs:= '0'; ctbi:= '0'; ctbf:= '0'; ctbn:= '0'; ctb := '99'; if ctb = '99' then begin ctbs := '1'; end; ctb2:=random(999)+1; if ctb2 >= 1 then begin ctbi:='1'; end; ctb3:=IntToFloat(random(999))+1.1; if ctb3 >= 1.1 then begin ctbf:='1'; end; ctb4:=IntToNumeric(random(999))+1.0; if ctb4 >= 1.0 then begin ctbn:='1'; end; barraDeControle:=ctbs+ctbi+ctbf+ctbn+StrNumeric(TD_idArquivo,12); barraDeControle := barraDeControle; TP_numPage:=0; if TD_seguranca = 1 then begin maximoRandom := tamanhoBarraSegurancaRandom; posicaoRandom1 := Random(maximoRandom); if posicaoRandom1 = 0 then begin posicaoRandom1:= 1; end; posicaoRandom2 := Random(maximoRandom); if posicaoRandom2 = 0 then begin posicaoRandom2:= 1; end; posicaoRandom3 := Random(maximoRandom); if posicaoRandom3 = 0 then begin posicaoRandom3:= 1; end; posicaoRandom4 := Random(maximoRandom); if posicaoRandom4 = 0 then begin posicaoRandom4:= 1; end; If (posicaoRandom1 = posicaoRandom2) or (posicaoRandom1 = posicaoRandom3) or (posicaoRandom1 = posicaoRandom4) then begin posicaoRandom1 := posicaoRandom1 + 1; end; If (posicaoRandom2 = posicaoRandom1) or (posicaoRandom2 = posicaoRandom3) or (posicaoRandom2 = posicaoRandom4) then begin posicaoRandom2 := posicaoRandom2 + 1; end; If (posicaoRandom3 = posicaoRandom2) or (posicaoRandom3 = posicaoRandom1) or (posicaoRandom3 = posicaoRandom4) then begin posicaoRandom3 := posicaoRandom3 + 1; end; If (posicaoRandom4 = posicaoRandom2) or (posicaoRandom4 = posicaoRandom1) or (posicaoRandom4 = posicaoRandom3) then begin posicaoRandom4 := posicaoRandom4 + 1; end; marcaDeSeguranca1 := FormatNumeric(Random(tamanhomarcaDeSeguranca),'0000'); marcaDeSeguranca2 := FormatNumeric(Random(tamanhomarcaDeSeguranca),'0000'); marcaDeSeguranca3 := FormatNumeric(Random(tamanhomarcaDeSeguranca),'0000'); marcaDeSeguranca4 := FormatNumeric(Random(tamanhomarcaDeSeguranca),'0000'); barraSeg := ''; for i := 1 to tamanhoBarraSegurancaLooping do begin if i = posicaoRandom1 then begin composicaoBarraSeg := marcaDeSeguranca1 + ' '; end else begin if i = posicaoRandom2 then begin composicaoBarraSeg := marcaDeSeguranca2 + ' '; end else begin if i = posicaoRandom3 then begin composicaoBarraSeg := marcaDeSeguranca3 + ' '; end else begin if i = posicaoRandom4 then begin composicaoBarraSeg := marcaDeSeguranca4 + ' '; end else begin composicaoBarraSeg := marcaDaguaNome + ' '; end; end; end; end; barraSeg := barraSeg + composicaoBarraSeg; end; posicaoBarraSeg := FormatFloat(posicaoRandom1,'9')+'='+marcaDeSeguranca1+'_'+FormatFloat(posicaoRandom2,'9')+'='+marcaDeSeguranca2+'_'+FormatFloat(posicaoRandom3,'9')+'='+marcaDeSeguranca3+'_'+FormatFloat(posicaoRandom4,'9')+'='+marcaDeSeguranca4; end;
		{--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------}
			{Pagina 1 }
			BeginPage(PAGE1);
			ClearFields(PAGE1,REC1); 	
				PAGE1.REC1.NOME          := PROPRIETARIO;
				PAGE1.REC1.CODIGO        := CODIGO;
				PAGE1.REC1.END_ENTREG[1] := END_ENTREG_1;
				PAGE1.REC1.END_ENTREG[2] := END_ENTREG_2;
				PAGE1.REC1.END_ENTREG[3] := END_ENTREG_3;
				PAGE1.REC1.BARRA         := barraDeControle;
				PAGE1.REC1.AVS           := AVISO;
				PAGE1.REC1.N_ARQUIV      := TD_nomeDoArquivo;
			WriteRecord(PAGE1,REC1);
			EndPage(PAGE1);
			TP_numPage:=TP_numPage+1;

		{parcela 3 }
		if parcela = 03 then begin  		
			BeginPage(PAGE2);
			ClearFields(PAGE2,REC1);     
				PAGE2.REC1.PARC         := PARC;
				PAGE2.REC1.CODIGO       := CODIGO;
				PAGE2.REC1.INSCRICAO    := INSCRICAO;
				PAGE2.REC1.NOME         := PROPRIETARIO;
				PAGE2.REC1.DESC_IMO     := DESCRICAO_IMO;
				PAGE2.REC1.NUM_IMO      := NUM_IMO;
				PAGE2.REC1.COMPL_IMO    := COMPL_IMO;
				PAGE2.REC1.BAIRR_IMO    := BAIRR_IMO;
				PAGE2.REC1.LOGR_ENT     := LOGR_ENT;
				PAGE2.REC1.NUM_ENT      := NUM_ENT;
				PAGE2.REC1.COMPL_ENT    := COMPL_ENT;
				PAGE2.REC1.BAIRR_ENT    := BAIRR_ENT;
				PAGE2.REC1.CID_ENT      := CID_ENT;
				PAGE2.REC1.UF_ENT       := UF_ENT;
				PAGE2.REC1.CEP_ENT      := CEP_ENT;
				PAGE2.REC1.IPTU         := IPTU;
				PAGE2.REC1.IPTU_VL      := IPTU_VL;
				PAGE2.REC1.EXPEDIENTE   := EXPEDIENTE;
				PAGE2.REC1.EXPED_VL     := EXPED_VL;
				PAGE2.REC1.DESC_TRIB1   := DESC_TRIB1;
				PAGE2.REC1.VL_TRIB1     := VL_TRIB1;
				PAGE2.REC1.AREA_TERRE   := AREA_TERRE;
				PAGE2.REC1.VL_TERREN    := VL_TERREN;
				PAGE2.REC1.VL_M2_TERR   := VL_M2_TERR;
				PAGE2.REC1.AREA_EDIFI   := AREA_EDIFI;
				PAGE2.REC1.VL_CONSTRU   := VL_CONSTRU;
				PAGE2.REC1.VL_M2_CONS   := VL_M2_CONS;
				PAGE2.REC1.VL_IMOVEL    := VL_IMOVEL;
				PAGE2.REC1.TOTAL        := TOTAL;
				PAGE2.REC1.CODIGO       := CODIGO;
				PAGE2.REC1.INSCRICAO    := INSCRICAO;
				PAGE2.REC1.NOME         := PROPRIETARIO;
				PAGE2.REC1.MSG          := MENSAGEM;
				PAGE2.REC1.MSG_UNICA    := MENSAGEM_UNIC;
				PAGE2.REC1.VL_UNICA     := FormatFloat((VALOR_UNICA),'9.999,99');
				PAGE2.REC1.VENCTO_UNI   := FormatDate((VENCTO_UNI),'DD/MM/AAAA');
				PAGE2.REC1.BARRA_UNI    := BARRA_UNI;
				PAGE2.REC1.LINHA_UNI    := LINHA_UNI;
				PAGE2.REC1.COD_PARC     := COD_PARC;
				PAGE2.REC1.COD_PARC1    := COD_PARC1;
				PAGE2.REC1.VL_PARC1     := FormatFloat((VALOR_PARC1),'9.999,99');
				PAGE2.REC1.VENCTO_PC1   := FormatDate((VENCTO_PC1),'DD/MM/AAAA');
				PAGE2.REC1.BARRA_PC1    := BARRA_PC1;
				PAGE2.REC1.LINHA_PC1    := LINHA_PC1;
				PAGE2.REC1.COD_PARC2    := COD_PARC2;
				PAGE2.REC1.VLPARC2      := FormatFloat((VALOR_PARC2),'9.999,99');
				PAGE2.REC1.VENCT_PC2    := FormatDate((VENCTO_PC2),'DD/MM/AAAA');
				PAGE2.REC1.BARRA_PC2    := BARRA_PC2;
				PAGE2.REC1.LINHA_PC2    :=LINHA_PC2 ;
				PAGE2.REC1.COD_PARC3    := COD_PARC3;
				PAGE2.REC1.VLPARC_PC3   := FormatFloat((VALOR_PARC3),'9.999,99');
				PAGE2.REC1.VENCTO_PC3   := FormatDate((VENCTO_PC3),'DD/MM/AAAA');
				PAGE2.REC1.BARRA_PC3    := BARRA_PC3;
				PAGE2.REC1.LINHA_PC3    := LINHA_PC3;			
				PAGE2.REC1.AVS          := AVISO;
				PAGE2.REC1.N_ARQUIV     := TD_nomeDoArquivo;
				PAGE2.REC1.PARCELA      := FormatNumeric((parcela),'##');
			WriteRecord(PAGE2,REC1);
			EndPage(PAGE2);
			TP_numPage:=TP_numPage+1;	
		end;	
		{ parcela 2 }
		if parcela = 02 then begin
			BeginPage(PAGE3);
			ClearFields(PAGE3,REC1);     
				PAGE3.REC1.PARC         := PARC;
				PAGE3.REC1.CODIGO       := CODIGO;
				PAGE3.REC1.INSCRICAO    := INSCRICAO;
				PAGE3.REC1.NOME         := PROPRIETARIO;
				PAGE3.REC1.DESC_IMO     := DESCRICAO_IMO;
				PAGE3.REC1.NUM_IMO      := NUM_IMO;
				PAGE3.REC1.COMPL_IMO    := COMPL_IMO;
				PAGE3.REC1.BAIRR_IMO    := BAIRR_IMO;
				PAGE3.REC1.LOGR_ENT     := LOGR_ENT;
				PAGE3.REC1.NUM_ENT      := NUM_ENT;
				PAGE3.REC1.COMPL_ENT    := COMPL_ENT;
				PAGE3.REC1.BAIRR_ENT    := BAIRR_ENT;
				PAGE3.REC1.CID_ENT      := CID_ENT;
				PAGE3.REC1.UF_ENT       := UF_ENT;
				PAGE3.REC1.CEP_ENT      := CEP_ENT;
				PAGE3.REC1.IPTU         := IPTU;
				PAGE3.REC1.IPTU_VL      := IPTU_VL;
				PAGE3.REC1.EXPEDIENTE   := EXPEDIENTE;
				PAGE3.REC1.EXPED_VL     := EXPED_VL;
				PAGE3.REC1.DESC_TRIB1   := DESC_TRIB1;
				PAGE3.REC1.VL_TRIB1     := VL_TRIB1;
				PAGE3.REC1.AREA_TERRE   := AREA_TERRE;
				PAGE3.REC1.VL_TERREN    := VL_TERREN;
				PAGE3.REC1.VL_M2_TERR   := VL_M2_TERR;
				PAGE3.REC1.AREA_EDIFI   := AREA_EDIFI;
				PAGE3.REC1.VL_CONSTRU   := VL_CONSTRU;
				PAGE3.REC1.VL_M2_CONS   := VL_M2_CONS;
				PAGE3.REC1.VL_IMOVEL    := VL_IMOVEL;
				PAGE3.REC1.TOTAL        := TOTAL;
				PAGE3.REC1.CODIGO       := CODIGO;
				PAGE3.REC1.INSCRICAO    := INSCRICAO;
				PAGE3.REC1.NOME         := PROPRIETARIO;
				PAGE3.REC1.MSG          := MENSAGEM;
				PAGE3.REC1.MSG_UNICA    := MENSAGEM_UNIC;				
				PAGE3.REC1.VL_UNICA     := FormatFloat((VALOR_UNICA),'9.999,99');
				PAGE3.REC1.VENCTO_UNI   := FormatDate((VENCTO_UNI),'DD/MM/AAAA');
				PAGE3.REC1.BARRA_UNI    := BARRA_UNI;
				PAGE3.REC1.LINHA_UNI    := LINHA_UNI;
				PAGE3.REC1.COD_PARC     := COD_PARC;
				PAGE3.REC1.AVS          := AVISO;
				PAGE3.REC1.N_ARQUIV     := TD_nomeDoArquivo;
				PAGE3.REC1.PARCELA      := FormatNumeric((parcela),'##');
				PAGE3.REC1.COD_PARC1    := COD_PARC1;
				PAGE3.REC1.VL_PARC1     := FormatFloat((VALOR_PARC1),'9.999,99');
				PAGE3.REC1.VENCTO_PC1   := FormatDate((VENCTO_PC1),'DD/MM/AAAA');
				PAGE3.REC1.BARRA_PC1    := BARRA_PC1;
				PAGE3.REC1.LINHA_PC1    := LINHA_PC1;
				PAGE3.REC1.COD_PARC2    := COD_PARC2;
				PAGE3.REC1.VLPARC2      := FormatFloat((VALOR_PARC2),'9.999,99');
				PAGE3.REC1.VENCT_PC2    := FormatDate((VENCTO_PC2),'DD/MM/AAAA');
				PAGE3.REC1.BARRA_PC2    := BARRA_PC2;
				PAGE3.REC1.LINHA_PC2    :=LINHA_PC2 ;			
			WriteRecord(PAGE3,REC1);
			EndPage(PAGE3);
			TP_numPage:=TP_numPage+1;
		end;
		{ parcela 1 }
		if parcela = 01 then begin
			BeginPage(PAGE4);
			ClearFields(PAGE4,REC1); 			
				PAGE4.REC1.PARC         := PARC;
				PAGE4.REC1.CODIGO       := CODIGO;
				PAGE4.REC1.INSCRICAO    := INSCRICAO;
				PAGE4.REC1.NOME         := PROPRIETARIO;
				PAGE4.REC1.DESC_IMO     := DESCRICAO_IMO;
				PAGE4.REC1.NUM_IMO      := NUM_IMO;
				PAGE4.REC1.COMPL_IMO    := COMPL_IMO;
				PAGE4.REC1.BAIRR_IMO    := BAIRR_IMO;
				PAGE4.REC1.LOGR_ENT     := LOGR_ENT;
				PAGE4.REC1.NUM_ENT      := NUM_ENT;
				PAGE4.REC1.COMPL_ENT    := COMPL_ENT;
				PAGE4.REC1.BAIRR_ENT    := BAIRR_ENT;
				PAGE4.REC1.CID_ENT      := CID_ENT;
				PAGE4.REC1.UF_ENT       := UF_ENT;
				PAGE4.REC1.CEP_ENT      := CEP_ENT;
				PAGE4.REC1.IPTU         := IPTU;
				PAGE4.REC1.IPTU_VL      := IPTU_VL;
				PAGE4.REC1.EXPEDIENTE   := EXPEDIENTE;
				PAGE4.REC1.EXPED_VL     := EXPED_VL;
				PAGE4.REC1.DESC_TRIB1   := DESC_TRIB1;
				PAGE4.REC1.VL_TRIB1     := VL_TRIB1;
				PAGE4.REC1.AREA_TERRE   := AREA_TERRE;
				PAGE4.REC1.VL_TERREN    := VL_TERREN;
				PAGE4.REC1.VL_M2_TERR   := VL_M2_TERR;
				PAGE4.REC1.AREA_EDIFI   := AREA_EDIFI;
				PAGE4.REC1.VL_CONSTRU   := VL_CONSTRU;
				PAGE4.REC1.VL_M2_CONS   := VL_M2_CONS;
				PAGE4.REC1.VL_IMOVEL    := VL_IMOVEL;
				PAGE4.REC1.TOTAL        := TOTAL;
				PAGE4.REC1.MSG          := MENSAGEM;
				PAGE4.REC1.MSG_UNICA    := MENSAGEM_UNIC;
				PAGE4.REC1.PARCELA      := FormatNumeric((parcela),'##');				
				PAGE4.REC1.VL_UNICA     := VALOR_UNICA;
				PAGE4.REC1.VENCTO_UNI   := FormatDate((VENCTO_UNI),'DD/MM/AAAA');
				PAGE4.REC1.BARRA_UNI    := BARRA_UNI;
				PAGE4.REC1.LINHA_UNI    := LINHA_UNI;
				PAGE4.REC1.COD_PARC     := COD_PARC;			
				PAGE4.REC1.COD_PARC1    := COD_PARC1;
				PAGE4.REC1.VL_PARC1     := VALOR_PARC1;
				PAGE4.REC1.VENCTO_PC1   := FormatDate((VENCTO_PC1),'DD/MM/AAAA');
				PAGE4.REC1.BARRA_PC1    := BARRA_PC1;
				PAGE4.REC1.LINHA_PC1    := LINHA_PC1;
				PAGE4.REC1.AVS          := AVISO;
				PAGE4.REC1.N_ARQUIV     := TD_nomeDoArquivo;				
			WriteRecord(PAGE4,REC1);
			EndPage(PAGE4);
			TP_numPage:=TP_numPage+1;
		 end;
		{---Relatorio TD_registro CX ID 4.0----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------}
			If TD_relatorios <> 0 then begin If TD_relatorios = 1 then begin totalNumeroPagina:=0; totalNumeroPagina:=TD_paginaExtra+TP_numPage; quantidadePorLote:= FloatToInt((Ceil(((TD_folhasPorCaixa/(totalNumeroPagina))))*TD_qtdPorFolha)*TD_tipoImpresso); if (numeroDeCliente mod quantidadePorLote) = 0 then begin numeroDoLote :=numeroDoLote+1; end; TD_conteudoRegistro:=FormatFloat(numeroDoLote,'9')+';'+barraDeControle+';'+TD_idArquivo+';'+TD_idExtra+';'+FormatNumeric(TP_aviso,'000.000')+';'+TD_idNumeroBanco+';'+TD_idCodigoBanco+';'+posicaoBarraSeg;    WritelnFileLog(TD_registro,TD_conteudoRegistro); numeroDeCliente:=numeroDeCliente+1; TP_aviso:=numeroDeCliente+1; end; end;
		{--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------}
	markup;
End;
{---Ordenacaoo por profundidade 6.0  & Relatorio - Resumo Prefeitura-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------}
if TP_numPage = 0 then begin abort('NUMERO DE PARCELAS INVALIDO OU NÃO ENCONTRADO!') end else begin totalNumeroPaginaOrdenacao := TD_paginaExtra+TP_numPage; impressoPorCaixa :=0; impressoPorCaixa := FloatToInt((Ceil(((TD_folhasPorCaixa/(totalNumeroPaginaOrdenacao))))*TD_qtdPorFolha)*TD_tipoImpresso);
Convert(TD_qtdPorFolha,true,false,false,impressoPorCaixa,false); end; If TD_relatorios<> 0 then begin if TD_relatorios= 1 then begin If TD_tipoImpresso = 2 then begin impressoFrenteVerso:='(Impresso frente e verso)'; end else begin impressoFrenteVerso:=''; end; TD_conteudoResumo:=''; WritelnFileLog(TD_resumo, TD_conteudoResumo); TD_conteudoResumo:='- Informacao Geral'; WritelnFileLog(TD_resumo, TD_conteudoResumo); TD_conteudoResumo:='Data e Hora do ODA         '+FormatDate(SYS_DATE,'DD/MM/AAAA')+' '+SubStr(StrNumeric(FormatTime(SYS_TIME,'HH:MM'),4),1,2)+':'+SubStr(StrNumeric(FormatTime(SYS_TIME,'HH:MM'),4),3,2); WritelnFileLog(TD_resumo, TD_conteudoResumo); TD_conteudoResumo:='Numero de paginas:         '+FormatFloat(totalNumeroPaginaOrdenacao,'9'); WritelnFileLog(TD_resumo, TD_conteudoResumo); TD_conteudoResumo:='Numero de Impresso p/ fls: '+FormatFloat(TD_qtdPorFolha,'9')+' '+impressoFrenteVerso; WritelnFileLog(TD_resumo, TD_conteudoResumo); TD_conteudoResumo:='Numero de Registro:        '+FormatFloat(numeroDeCliente,'9'); WritelnFileLog(TD_resumo, TD_conteudoResumo); TD_conteudoResumo:=''; WritelnFileLog(TD_resumo, TD_conteudoResumo); TD_conteudoResumo:='- Informacao do Lote'; WritelnFileLog(TD_resumo, TD_conteudoResumo); TD_conteudoResumo:='Numero de Caixas:          '+FormatFloat(Ceil(numeroDeCliente/impressoPorCaixa),'9'); WritelnFileLog(TD_resumo, TD_conteudoResumo); TD_conteudoResumo:='Impressos p/ Caixa:        '+FormatFloat(impressoPorCaixa,'9'); WritelnFileLog(TD_resumo, TD_conteudoResumo); TD_conteudoResumo:='Numero de Fls p/ Caixa:    '+FormatFloat((((totalNumeroPaginaOrdenacao-TD_paginaExtra)*impressoPorCaixa)/TD_qtdPorFolha)/TD_tipoImpresso,'9'); WritelnFileLog(TD_resumo, TD_conteudoResumo); TD_conteudoResumo:=''; WritelnFileLog(TD_resumo, TD_conteudoResumo); TD_conteudoResumo:='- Informacao Extras'; WritelnFileLog(TD_resumo, TD_conteudoResumo); TD_conteudoResumo:='Nome do arquivo:          '+TD_nomeDoArquivo; WritelnFileLog(TD_resumo, TD_conteudoResumo); if TD_idNumeroBanco <> '' then begin TD_conteudoResumo:='Referencia do bando:      '+TD_idNumeroBanco; WritelnFileLog(TD_resumo, TD_conteudoResumo); end; if TD_idCodigoBanco <> '' then begin TD_conteudoResumo:='Referencia do Cliente:    '+TD_idCodigoBanco; WritelnFileLog(TD_resumo, TD_conteudoResumo); end; if posicaoBarraSeg <> '' then begin TD_conteudoResumo:='Referencia Barra Segurança:'+posicaoBarraSeg; WritelnFileLog(TD_resumo, TD_conteudoResumo); end; CloseFileLog(TD_resumo); If (TD_relatorios= 1) then begin WritelnFileLog(TD_registro,'*'); CloseFileLog(TD_registro); end; end; end;
{------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------}
