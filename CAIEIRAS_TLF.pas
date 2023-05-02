{---SB 5.0 / BARRA_TP_aviso 1.0 ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------char3500} TD_plugin:=0;  x:=0; for i := 0 to 99 do begin  if substr(RetornaNomeArqEntrada(0),i,1) <> '.' then begin  x:= x+1; end else begin break; end; end; TD_nomeDoArquivo := substr(RetornaNomeArqEntrada(0),1,x-1); fls_cx:= 0; n_arq:='';
{----Pré-Configurações---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------}


{---Configurações--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------}
    TD_cliente                    := 'P.M.'; //Nome parcialmente completo
    TD_tipoImpresso               := 1;      // 1 = Carnes | 2 = Carta/Boletos |
    TD_qtdPorFolha                := ;      //Quantidade de impresso por folha
    TD_paginaExtra                := 0;      //Quantidade de paginas nao inclusa no visual (contra-capa/encarte/etc)
    TD_folhasPorCaixa             := 1500;   //Quantidade de Folhar por caixa (carnes = 1500 caixa grande / 500 caixa pequena| Envelope 1000 A4 Caixa grande)
    TD_relatorios                 := 0;      // Desativar Relatorio = 0 | Ativar Relatorios = 1 
    TD_seguranca                  := 0;      // Desativa Barra de segurança = 0 | Ativa Barra de segurança = 1
{---Configurações de segurança-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------}
    marcaDaguaNome                := 'N.N.'; //Marca dagua prefixo do cliente 
    tamanhoBarraSegurancaRandom   := 98;     //Numero maximo de codigo de segurança gerado com base no tamanhdo da marcadagua+1
    tamanhoBarraSegurancaLooping  := 110;    //Tamanho que da barra
    tamanhomarcaDeSeguranca       := 9999;   //Limite randomico do codigo de segurança

{---Plugin Inicio--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------}



{---Plugins Fim-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
----Relatorios 4.0-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------}
If TD_relatorios <> 0 then begin If (TD_relatorios= 1) then begin TD_resumo:= CreateFileLog('Resumo_'+TD_cliente+'_dt'+SubStr(StrNumeric(FormatTime(SYS_TIME,'HH:MM'),4),1,4)+'_'+RetornaNomeArqEntrada(0)); TD_conteudoResumo:=TD_cliente; WritelnFileLog(TD_resumo,TD_conteudoResumo); TD_registro:= CreateFileLog('Arquivo_Relatorio&Etiqueta_'+TD_cliente+'_'+SubStr(StrNumeric(FormatTime(SYS_TIME,'HH:MM'),4),1,4)+'_'+RetornaNomeArqEntrada(0)); TD_conteudoRegistro:='0;'+TD_cliente+';'++';'+FormatDate(SYS_DATE,'DD/MM/AAAA')+';'+SubStr(StrNumeric(FormatTime(SYS_TIME,'HH:MM'),4),1,2)+':'+SubStr(StrNumeric(FormatTime(SYS_TIME,'HH:MM'),4),3,2); WritelnFileLog(TD_registro,TD_conteudoRegistro); end; If TD_relatorios > 1 then begin	abort('RELATORIO - VALOR INFORMADO INVALIDO'); end; numeroDeCliente:=0; numeroDoLote:=0; end; {VAL.ANT.MRKISI} If TD_tipoImpresso > 2 then begin abort('ATENÇÃO - TIPO DE IMPRESSO INVALIDO'); end; If TD_qtdPorFolha < 1 then begin abort('ATENÇÃO - QUANTIDADE DE IMPRESSO POR FOLHA INVALIDO'); end; If fls_cx > 0 then begin abort('ATENÇÃO - SCRIPT PADRAO INVALIDO, VERSAO DESATUALIZADA INFERIOR A 5.0'); end; If n_arq <>'' then begin abort('ATENÇÃO - SCRIPT BARRA_TP_aviso 1.0 INVALIDO, VERSAO DESATUALIZADA INFERIOR A 2.0'); end; TP_numPage:=1; TP_aviso:=1; TD_idExtra:=''; TD_idCodigoBanco:=''; TD_idNumeroBanco:=''; barraSeg:=''; posicaoBarraSeg:='';
{---Variaveis Global Ini-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------}

ReadLn(S);
{---Variaveis Global Fim-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------}
While ReadLn(S) <> EOF do Begin
	{---Variaveis comuns Ini---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------}  
	AVISO         := FormatNumeric(TP_aviso,'000.000'); //Aviso gerado pelo script, convertido p String.
	parcela       := 0.0;
	AVISO_SIST    := GetString(S,70,0);
	REGISTRO      := GetString(S,1,0); 
	INSCRICAO     := GetString(S,3,0);
	PROPRIETARIO  := GetString(S,5,0);
	END_ENTREGA   := TrimStr(GetString(S,14,0)) + '  ' + TrimStr(GetString(S,15,0));
	COMPL_ENTREGA := GetString(S,16,0);
	BAIRRO_ENTREGA:= TrimStr(GetString(S,17,0));
	CIDADE_ENTREGA:= TrimStr(GetString(S,18,0)); 
	UF_ENTREGA    := TrimStr(GetString(S,19,0));
	CEP_ENTREGA   := GetString(S,20,0);
	ATIVIDADE     := GetString(S,6,0);
	ALVARA        := GetString(S,29,0);
	LIC_FUNCIO    := GetString(S,26,0);
	ISS_ANUAL     := GetString(S,28,0);
	{---Variaveis comuns Fim---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------}  

	{---Configurações Referencia do contribuinte no Registro | Barra de TD_registro 3.0 ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------}
			TD_idArquivo        :=  GetString(S,1,0);           //Identificação do arquivo maximo ate 12 numeros
			TD_idNumeroBanco    :=  GetString(S,62,0);       //Referencia do Banco
			TD_idCodigoBanco    :=  GetString(S,63,0);  //Referencia do contribuinte para com o banco (ex: nossonumero)
			TD_idExtra          :=  GetString(S,20,0);        //Identificação extra 
	{--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------}  
	barraDeControle:=''; ctbs:= '0'; ctbi:= '0'; ctbf:= '0'; ctbn:= '0'; ctb := '99'; if ctb = '99' then begin ctbs := '1'; end; ctb2:=random(999)+1; if ctb2 >= 1 then begin ctbi:='1'; end; ctb3:=IntToFloat(random(999))+1.1; if ctb3 >= 1.1 then begin ctbf:='1'; end; ctb4:=IntToNumeric(random(999))+1.0; if ctb4 >= 1.0 then begin ctbn:='1'; end; barraDeControle:=ctbs+ctbi+ctbf+ctbn+StrNumeric(TD_idArquivo,12); barraDeControle := barraDeControle;	TP_numPage:=0; if TD_seguranca = 1 then begin maximoRandom := tamanhoBarraSegurancaRandom; posicaoRandom1 := Random(maximoRandom); if posicaoRandom1 = 0 then begin posicaoRandom1:= 1; end; posicaoRandom2 := Random(maximoRandom); if posicaoRandom2 = 0 then begin posicaoRandom2:= 1; end; posicaoRandom3 := Random(maximoRandom); if posicaoRandom3 = 0 then begin posicaoRandom3:= 1; end; posicaoRandom4 := Random(maximoRandom); if posicaoRandom4 = 0 then begin posicaoRandom4:= 1; end; If (posicaoRandom1 = posicaoRandom2) or (posicaoRandom1 = posicaoRandom3) or (posicaoRandom1 = posicaoRandom4) then begin posicaoRandom1 := posicaoRandom1 + 1; end; If (posicaoRandom2 = posicaoRandom1) or (posicaoRandom2 = posicaoRandom3) or (posicaoRandom2 = posicaoRandom4) then begin posicaoRandom2 := posicaoRandom2 + 1; end; If (posicaoRandom3 = posicaoRandom2) or (posicaoRandom3 = posicaoRandom1) or (posicaoRandom3 = posicaoRandom4) then begin posicaoRandom3 := posicaoRandom3 + 1; end; If (posicaoRandom4 = posicaoRandom2) or (posicaoRandom4 = posicaoRandom1) or (posicaoRandom4 = posicaoRandom3) then begin posicaoRandom4 := posicaoRandom4 + 1; end; marcaDeSeguranca1 := FormatNumeric(Random(tamanhomarcaDeSeguranca),'0000'); marcaDeSeguranca2 := FormatNumeric(Random(tamanhomarcaDeSeguranca),'0000'); marcaDeSeguranca3 := FormatNumeric(Random(tamanhomarcaDeSeguranca),'0000'); marcaDeSeguranca4 := FormatNumeric(Random(tamanhomarcaDeSeguranca),'0000'); barraSeg := ''; for i := 1 to tamanhoBarraSegurancaLooping do begin if i = posicaoRandom1 then begin composicaoBarraSeg := marcaDeSeguranca1 + ' '; end else begin if i = posicaoRandom2 then begin composicaoBarraSeg := marcaDeSeguranca2 + ' '; end else begin if i = posicaoRandom3 then begin composicaoBarraSeg := marcaDeSeguranca3 + ' '; end else begin if i = posicaoRandom4 then begin composicaoBarraSeg := marcaDeSeguranca4 + ' '; end else begin composicaoBarraSeg := marcaDaguaNome + ' '; end; end; end; end; barraSeg := barraSeg + composicaoBarraSeg; end; posicaoBarraSeg := FormatFloat(posicaoRandom1,'9')+'='+marcaDeSeguranca1+'_'+FormatFloat(posicaoRandom2,'9')+'='+marcaDeSeguranca2+'_'+FormatFloat(posicaoRandom3,'9')+'='+marcaDeSeguranca3+'_'+FormatFloat(posicaoRandom4,'9')+'='+marcaDeSeguranca4; end;
	{--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------}
		//PROTOCOLO DE ENTREGA
		BeginPage(PAGE1);
		ClearFields(PAGE1,REC1);
			PAGE1.REC1.AVISO := AVISO;
			PAGE1.REC1.INSCRICAO :=  INSCRICAO;
			PAGE1.REC1.PROPRIETAR :=  PROPRIETARIO;
			PAGE1.REC1.END_ENTREG :=  END_ENTREGA;
			PAGE1.REC1.COMPL_ENTR :=  COMPL_ENTREGA;
			PAGE1.REC1.BAIRRO_ENT :=  BAIRRO_ENTREGA;
			PAGE1.REC1.CIDADE_ENT :=  CIDADE_ENTREGA;
			PAGE1.REC1.UF_ENTREGA :=  UF_ENTREGA;
			PAGE1.REC1.CEP_ENTREG :=  CEP_ENTREGA;
			PAGE1.REC1.BARRA  := barraDeControle;
			PAGE1.REC1.AVS:= AVISO;
			PAGE1.REC1.N_ARQUIV:= TD_nomeDoArquivo;    
		WriteRecord(PAGE1,REC1);
		EndPage(PAGE1);
		TP_numPage:=TP_numPage+1;
	 
		//INFORMAÇÕES
		BeginPage(PAGE2);
		ClearFields(PAGE2,REC1);
			PAGE2.REC1.AVISO := AVISO_SIST;
			PAGE2.REC1.REGISTRO := REGISTRO; 
			PAGE2.REC1.INSCR_ISS := INSCRICAO;
			PAGE2.REC1.PROPRIETAR :=  PROPRIETARIO;
			PAGE2.REC1.END_ENTREG :=  END_ENTREGA;
			PAGE2.REC1.COMPL_ENTR :=  COMPL_ENTREGA;
			PAGE2.REC1.BAIRRO_ENT :=  BAIRRO_ENTREGA;
			PAGE2.REC1.CIDADE_ENT :=  CIDADE_ENTREGA;
			PAGE2.REC1.UF_ENTREGA :=  UF_ENTREGA;
			PAGE2.REC1.CEP_ENTREG :=  CEP_ENTREGA;
			PAGE2.REC1.ATIVIDADE := ATIVIDADE;
			PAGE2.REC1.ALVARA :=  ALVARA;
			PAGE2.REC1.LIC_FUNCIO :=  LIC_FUNCIO;
			PAGE2.REC1.ISS_ANUAL :=  ISS_ANUAL;
			PAGE2.REC1.AVS:= AVISO;
			PAGE2.REC1.N_ARQUIV:= TD_nomeDoArquivo;
		WriteRecord(PAGE2,REC1);
		EndPage(PAGE2);
		TP_numPage:=TP_numPage+1;

		//ÚNICA
		BeginPage(PAGE3);
		ClearFields(PAGE3,REC1);
			PAGE3.REC1.REGISTRO := REGISTRO; 
			PAGE3.REC1.DATAUN :=  GetDate(S,67,0);  
			PAGE3.REC1.NSSNUMERO :=  GetString(S,68,0);  
			PAGE3.REC1.TOTALUNICA :=  GetFloat(S,69,0); 
			PAGE3.REC1.SACADO := PROPRIETARIO;
			PAGE3.REC1.CODIGO := '0789';
			PAGE3.REC1.AVS:= AVISO;
			PAGE3.REC1.N_ARQUIV:= TD_nomeDoArquivo; 	
		WriteRecord(PAGE3,REC1);
		EndPage(PAGE3);
		TP_numPage:=TP_numPage+1;

		//PARCELA 1 até 09

		for i := 0 to 08 do begin
			BeginPage(PAGE4);
			ClearFields(PAGE4,REC1);
				PAGE4.REC1.REGISTRO := REGISTRO; 
				PAGE4.REC1.DATAPAC :=  GetDate(S,31+(i*3),0);  
				PAGE4.REC1.NSSNUMERO :=  GetString(S,32+(i*3),0);  
				PAGE4.REC1.TOTALPARC :=  GetFloat(S,33+(i*3),0); 
				PAGE4.REC1.SACADO := PROPRIETARIO;
				PAGE4.REC1.CODIGO := '0789';
				PAGE4.REC1.PARCELA := parcela + 01 + (i*1);
				PAGE4.REC1.AVS:= AVISO;
				PAGE4.REC1.N_ARQUIV:= TD_nomeDoArquivo; 
			WriteRecord(PAGE4,REC1);
			EndPage(PAGE4);
			TP_numPage:=TP_numPage+1;
		end;

		//PAGE 5
		BeginPage(PAGE5);
		ClearFields(PAGE5,REC1);
		PAGE5.REC1.AVISO := AVISO;
		PAGE5.REC1.AVS:= AVISO;
		PAGE5.REC1.N_ARQUIV:= TD_nomeDoArquivo; 
		WriteRecord(PAGE5,REC1);
		EndPage(PAGE5);
		TP_numPage:=TP_numPage+1;
	{---Relatorio TD_registro CX ID 4.0----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------}
	If TD_relatorios <> 0 then begin If TD_relatorios = 1 then begin totalNumeroPagina:=0; totalNumeroPagina:=TD_paginaExtra+TP_numPage; quantidadePorLote:= FloatToInt((Ceil(((TD_folhasPorCaixa/(totalNumeroPagina))))*TD_qtdPorFolha)*TD_tipoImpresso); if (numeroDeCliente mod quantidadePorLote) = 0 then begin numeroDoLote :=numeroDoLote+1; end; TD_conteudoRegistro:=FormatFloat(numeroDoLote,'9')+';'+barraDeControle+';'+TD_idArquivo+';'+TD_idExtra+';'+FormatNumeric(TP_aviso,'000.000')+';'+TD_idNumeroBanco+';'+TD_idCodigoBanco+';'+posicaoBarraSeg;	WritelnFileLog(TD_registro,TD_conteudoRegistro); numeroDeCliente:=numeroDeCliente+1; TP_aviso:=numeroDeCliente+1; end; end;
	{--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------}
	markup();
end;

{---Ordenacaoo por profundidade 6.0  & Relatorio - Resumo Prefeitura-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------}
if TP_numPage = 0 then begin abort('NUMERO DE PARCELAS INVALIDO OU NÃO ENCONTRADO!') end else begin totalNumeroPaginaOrdenacao := TD_paginaExtra+TP_numPage; impressoPorCaixa :=0; impressoPorCaixa := FloatToInt((Ceil(((TD_folhasPorCaixa/(totalNumeroPaginaOrdenacao))))*TD_qtdPorFolha)*TD_tipoImpresso);
Convert(TD_qtdPorFolha,true,false,false,impressoPorCaixa,false); end; If TD_relatorios<> 0 then begin if TD_relatorios= 1 then begin If TD_tipoImpresso = 2 then begin impressoFrenteVerso:='(Impresso frente e verso)'; end else begin impressoFrenteVerso:=''; end; TD_conteudoResumo:=''; WritelnFileLog(TD_resumo, TD_conteudoResumo); TD_conteudoResumo:='- Informacao Geral'; WritelnFileLog(TD_resumo, TD_conteudoResumo); TD_conteudoResumo:='Data e Hora do ODA         '+FormatDate(SYS_DATE,'DD/MM/AAAA')+' '+SubStr(StrNumeric(FormatTime(SYS_TIME,'HH:MM'),4),1,2)+':'+SubStr(StrNumeric(FormatTime(SYS_TIME,'HH:MM'),4),3,2); WritelnFileLog(TD_resumo, TD_conteudoResumo); TD_conteudoResumo:='Numero de paginas:         '+FormatFloat(totalNumeroPaginaOrdenacao,'9'); WritelnFileLog(TD_resumo, TD_conteudoResumo); TD_conteudoResumo:='Numero de Impresso p/ fls: '+FormatFloat(TD_qtdPorFolha,'9')+' '+impressoFrenteVerso; WritelnFileLog(TD_resumo, TD_conteudoResumo); TD_conteudoResumo:='Numero de Registro:        '+FormatFloat(numeroDeCliente,'9'); WritelnFileLog(TD_resumo, TD_conteudoResumo); TD_conteudoResumo:=''; WritelnFileLog(TD_resumo, TD_conteudoResumo); TD_conteudoResumo:='- Informacao do Lote'; WritelnFileLog(TD_resumo, TD_conteudoResumo); TD_conteudoResumo:='Numero de Caixas:          '+FormatFloat(Ceil(numeroDeCliente/impressoPorCaixa),'9'); WritelnFileLog(TD_resumo, TD_conteudoResumo); TD_conteudoResumo:='Impressos p/ Caixa:        '+FormatFloat(impressoPorCaixa,'9'); WritelnFileLog(TD_resumo, TD_conteudoResumo); TD_conteudoResumo:='Numero de Fls p/ Caixa:    '+FormatFloat((((totalNumeroPaginaOrdenacao-TD_paginaExtra)*impressoPorCaixa)/TD_qtdPorFolha)/TD_tipoImpresso,'9'); WritelnFileLog(TD_resumo, TD_conteudoResumo); TD_conteudoResumo:=''; WritelnFileLog(TD_resumo, TD_conteudoResumo); TD_conteudoResumo:='- Informacao Extras'; WritelnFileLog(TD_resumo, TD_conteudoResumo); TD_conteudoResumo:='Nome do arquivo:          '+TD_nomeDoArquivo; WritelnFileLog(TD_resumo, TD_conteudoResumo); if TD_idNumeroBanco <> '' then begin TD_conteudoResumo:='Referencia do bando:      '+TD_idNumeroBanco; WritelnFileLog(TD_resumo, TD_conteudoResumo); end; if TD_idCodigoBanco <> '' then begin TD_conteudoResumo:='Referencia do Cliente:    '+TD_idCodigoBanco; WritelnFileLog(TD_resumo, TD_conteudoResumo); end; if posicaoBarraSeg <> '' then begin TD_conteudoResumo:='Referencia Barra Segurança:'+posicaoBarraSeg; WritelnFileLog(TD_resumo, TD_conteudoResumo); end; CloseFileLog(TD_resumo); If (TD_relatorios= 1) then begin WritelnFileLog(TD_registro,'*'); CloseFileLog(TD_registro); end; end; end;
{------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------}
