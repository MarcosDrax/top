{---SB MultLine 5.0 / BARRA_TP_aviso 1.0 -----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------char3500} TD_plugin:=0;  x:=0; for i := 0 to 99 do begin  if substr(RetornaNomeArqEntrada(0),i,1) <> '.' then begin  x:= x+1; end else begin break; end; end; TD_nomeDoArquivo := substr(RetornaNomeArqEntrada(0),1,x-1); fls_cx:= 0; n_arq:='';
{----Pré-Configurações---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------}


{---Configurações--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------}
    TD_cliente                    := 'P.M. IPUIUNA'; //Nome parcialmente completo
    TD_tipoImpresso               := 1;      // 1 = Carnes | 2 = Carta/Boletos |
    TD_qtdPorFolha                := 3;      //Quantidade de impresso por folha
    TD_paginaExtra                := 2;      //Quantidade de paginas nao inclusa no visual (contra-capa/encarte/etc)
    TD_folhasPorCaixa             := 1500;   //Quantidade de Folhar por caixa (carnes = 1500 caixa grande / 500 caixa pequena| Envelope 1000 A4 Caixa grande)
    TD_relatorios                 := 1;      // Desativar Relatorio = 0 | Ativar Relatorios = 1 
    TD_seguranca                  := 0;      // Desativa Barra de segurança = 0 | Ativa Barra de segurança = 1
{---Configurações de segurança-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------}
    marcaDaguaNome                := 'P.M.I'; //Marca dagua prefixo do cliente 
    tamanhoBarraSegurancaRandom   := 98;     //Numero maximo de codigo de segurança gerado com base no tamanhdo da marcadagua+1
    tamanhoBarraSegurancaLooping  := 110;    //Tamanho que da barra
    tamanhomarcaDeSeguranca       := 9999;   //Limite randomico do codigo de segurança

{---Plugin Inicio--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------}



{---Plugins Fim-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
----Relatorios 4.0-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------}
If TD_relatorios <> 0 then begin If (TD_relatorios= 1) then begin TD_resumo:= CreateFileLog('Resumo_'+TD_cliente+'_dt'+SubStr(StrNumeric(FormatTime(SYS_TIME,'HH:MM'),4),1,4)+'_'+RetornaNomeArqEntrada(0)); TD_conteudoResumo:=TD_cliente; WritelnFileLog(TD_resumo,TD_conteudoResumo); TD_registro:= CreateFileLog('Arquivo_Relatorio&Etiqueta_'+TD_cliente+'_'+SubStr(StrNumeric(FormatTime(SYS_TIME,'HH:MM'),4),1,4)+'_'+RetornaNomeArqEntrada(0)); TD_conteudoRegistro:='0;'+TD_cliente+';'++';'+FormatDate(SYS_DATE,'DD/MM/AAAA')+';'+SubStr(StrNumeric(FormatTime(SYS_TIME,'HH:MM'),4),1,2)+':'+SubStr(StrNumeric(FormatTime(SYS_TIME,'HH:MM'),4),3,2); WritelnFileLog(TD_registro,TD_conteudoRegistro); end; If TD_relatorios > 1 then begin	abort('RELATORIO - VALOR INFORMADO INVALIDO'); end; numeroDeCliente:=0; numeroDoLote:=0; end; {VAL.ANT.MRKISI} If TD_tipoImpresso > 2 then begin abort('ATENÇÃO - TIPO DE IMPRESSO INVALIDO'); end; If TD_qtdPorFolha < 1 then begin abort('ATENÇÃO - QUANTIDADE DE IMPRESSO POR FOLHA INVALIDO'); end; If fls_cx > 0 then begin abort('ATENÇÃO - SCRIPT PADRAO INVALIDO, VERSAO DESATUALIZADA INFERIOR A 5.0'); end; If n_arq <>'' then begin abort('ATENÇÃO - SCRIPT BARRA_TP_aviso 1.0 INVALIDO, VERSAO DESATUALIZADA INFERIOR A 2.0'); end; TP_numPage:=1; TP_aviso:=1; TD_idExtra:=''; TD_idCodigoBanco:=''; TD_idNumeroBanco:=''; barraSeg:=''; posicaoBarraSeg:='';
{---Variaveis Global Ini-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------}
ReadLn(S);
TD_linha1      := '';
TD_qtdLinha1   := 0;
TD_print       := 0;
close          := 0;
{---Variaveis Global Fim-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------}
while true do Begin
//Var Idenficadora de cada contribuinte 
TD_id        := TrimStr(GetString(S,1,1));

	{Logica aplicada no IF utilizada é variavel de acordo com o formato do arquivo multiline}
	If (TD_id = 'C') and (TD_print = 1) then begin

		{---Variaveis comuns Ini---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------}  
		AVISO           := FormatNumeric(TP_aviso,'000.000'); //Aviso gerado pelo script, convertido p String.
		INSCRICAO       := GetString(TD_linhaCad,3,0);
		PROPRIETARIO    := GetString(TD_linhaCad,5,0);
		COD_IMOVEL      := GetString(TD_linhaCad,2,0);
		LOTE            := GetString(TD_linhaCad,259,0);
		END_IMOVEL      := TrimStr(GetString(TD_linhaCad,7,0));
		NUM_IMOVEL      := FormatFloat(GetNumeric(TD_linhaCad,8,0),'9999');
		COMPL_IMOVEL    := TrimStr(GetString(TD_linhaCad,9,0));
		COMPLE_IMOVEL   := TrimStr(GetString(TD_linhaCad,9,0));
		BAIRRO_IMOVEL   := TrimStr(GetString(TD_linhaCad,11,0));
		END_ENTREGA     := TrimStr(GetString(TD_linhaCad,12,0));
		NUM_ENTREGA     := FormatFloat(StrToFloat(GetString(TD_linhaCad,13,0)),'9999');
		COMPL_ENTREGA   := TrimStr(GetString(TD_linhaCad,14,0));
		BAIRRO_ENTREGA  := TrimStr(GetString(TD_linhaCad,15,0));
		CID_ENTREGA     := TrimStr(GetString(TD_linhaCad,17,0));
		UF_ENTREGA      := TrimStr(GetString(TD_linhaCad,18,0));
		CEP_ENTREGA     := FormatNumeric(GetNumeric(TD_linhaCad,16,0),'00000-000');

		{---Variaveis comuns Fim---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------}  
		{---Configurações Referencia do contribuinte no Registro | Barra de TD_registro 3.0 ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------}
		    TD_idArquivo        := GetString(TD_linhaCad,3,0);    //Identificação do arquivo maximo ate 12 numeros
		    TD_idNumeroBanco    := GetString(TD_linha1,8,0);    //Referencia do Banco
		    TD_idCodigoBanco    := GetString(TD_linha1,5,0);    //Referencia do contribuinte para com o banco (ex: nossonumero)
		    //TD_idExtra          := GetString(S,0,0);   //Identificação extra 
		{--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------}  
		barraDeControle:=''; ctbs:= '0'; ctbi:= '0'; ctbf:= '0'; ctbn:= '0'; ctb := '99'; if ctb = '99' then begin ctbs := '1'; end; ctb2:=random(999)+1; if ctb2 >= 1 then begin ctbi:='1'; end; ctb3:=IntToFloat(random(999))+1.1; if ctb3 >= 1.1 then begin ctbf:='1'; end; ctb4:=IntToNumeric(random(999))+1.0; if ctb4 >= 1.0 then begin ctbn:='1'; end; barraDeControle:=ctbs+ctbi+ctbf+ctbn+StrNumeric(TD_idArquivo,12); barraDeControle := barraDeControle;	TP_numPage:=0; if TD_seguranca = 1 then begin maximoRandom := tamanhoBarraSegurancaRandom; posicaoRandom1 := Random(maximoRandom); if posicaoRandom1 = 0 then begin posicaoRandom1:= 1; end; posicaoRandom2 := Random(maximoRandom); if posicaoRandom2 = 0 then begin posicaoRandom2:= 1; end; posicaoRandom3 := Random(maximoRandom); if posicaoRandom3 = 0 then begin posicaoRandom3:= 1; end; posicaoRandom4 := Random(maximoRandom); if posicaoRandom4 = 0 then begin posicaoRandom4:= 1; end; If (posicaoRandom1 = posicaoRandom2) or (posicaoRandom1 = posicaoRandom3) or (posicaoRandom1 = posicaoRandom4) then begin posicaoRandom1 := posicaoRandom1 + 1; end; If (posicaoRandom2 = posicaoRandom1) or (posicaoRandom2 = posicaoRandom3) or (posicaoRandom2 = posicaoRandom4) then begin posicaoRandom2 := posicaoRandom2 + 1; end; If (posicaoRandom3 = posicaoRandom2) or (posicaoRandom3 = posicaoRandom1) or (posicaoRandom3 = posicaoRandom4) then begin posicaoRandom3 := posicaoRandom3 + 1; end; If (posicaoRandom4 = posicaoRandom2) or (posicaoRandom4 = posicaoRandom1) or (posicaoRandom4 = posicaoRandom3) then begin posicaoRandom4 := posicaoRandom4 + 1; end; marcaDeSeguranca1 := FormatNumeric(Random(tamanhomarcaDeSeguranca),'0000'); marcaDeSeguranca2 := FormatNumeric(Random(tamanhomarcaDeSeguranca),'0000'); marcaDeSeguranca3 := FormatNumeric(Random(tamanhomarcaDeSeguranca),'0000'); marcaDeSeguranca4 := FormatNumeric(Random(tamanhomarcaDeSeguranca),'0000'); barraSeg := ''; for i := 1 to tamanhoBarraSegurancaLooping do begin if i = posicaoRandom1 then begin composicaoBarraSeg := marcaDeSeguranca1 + ' '; end else begin if i = posicaoRandom2 then begin composicaoBarraSeg := marcaDeSeguranca2 + ' '; end else begin if i = posicaoRandom3 then begin composicaoBarraSeg := marcaDeSeguranca3 + ' '; end else begin if i = posicaoRandom4 then begin composicaoBarraSeg := marcaDeSeguranca4 + ' '; end else begin composicaoBarraSeg := marcaDaguaNome + ' '; end; end; end; end; barraSeg := barraSeg + composicaoBarraSeg; end; posicaoBarraSeg := FormatFloat(posicaoRandom1,'9')+'='+marcaDeSeguranca1+'_'+FormatFloat(posicaoRandom2,'9')+'='+marcaDeSeguranca2+'_'+FormatFloat(posicaoRandom3,'9')+'='+marcaDeSeguranca3+'_'+FormatFloat(posicaoRandom4,'9')+'='+marcaDeSeguranca4; end;
		{--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------}

			//PAGINA 1
			BeginPage(PAGE1);
			ClearFields(PAGE1,REC1);
				PAGE1.REC1.INSCRICAO[1]  := INSCRICAO;
				PAGE1.REC1.PROPRIETAR    := PROPRIETARIO;
				PAGE1.REC1.COD_IMOVEL    := COD_IMOVEL;
				PAGE1.REC1.LOTE          := LOTE ;
				PAGE1.REC1.END_IMOV[1]   := END_IMOVEL+', '+NUM_IMOVEL;
				PAGE1.REC1.END_IMOV[2]   := COMPL_IMOVEL+' '+ BAIRRO_IMOVEL;
				PAGE1.REC1.END_ENTREG[1] := END_ENTREGA+', '+NUM_ENTREGA+', '+COMPL_ENTREGA;
				PAGE1.REC1.END_ENTREG[2] := BAIRRO_ENTREGA+', '+CID_ENTREGA+', '+UF_ENTREGA;
				PAGE1.REC1.END_ENTREG[3] := 'CEP: '+CEP_ENTREGA;
				PAGE1.REC1.AVS:=AVISO;
				PAGE1.REC1.N_ARQUIV:=TD_nomeDoArquivo;
			WriteRecord(PAGE1,REC1);
			EndPage(PAGE1);
			TP_numPage:=TP_numPage+1; //Variavel deve se repetir abaixo de todos os EndPage

			//PAGE 6 
			BeginPage(PAGE6);
			ClearFields(PAGE6,REC1);
				PAGE6.REC1.AVS:=AVISO;
				PAGE6.REC1.N_ARQUIV:=TD_nomeDoArquivo;
			WriteRecord(PAGE6,REC1);
			EndPage(PAGE6);
			TP_numPage:=TP_numPage+1;

			//PAGINA 3
			BeginPage(PAGE3);
			ClearFields(PAGE3,REC1);			
				For  i :=1 to 7  do Begin
				  PAGE3.REC1.VENCIMENTO[1*i] := FormatDate(GetDate(MultLineItem(TD_linha1,i-1),4,0),'DD/MM/AAAA');
				End;
				PAGE3.REC1.COD_IMOV      := COD_IMOVEL;
				PAGE3.REC1.PROPRIETAR    := PROPRIETARIO;
				PAGE3.REC1.INSCRICAO     := INSCRICAO;
				PAGE3.REC1.TESTADA       := Getfloat(TD_linhaCad,19,0);
				PAGE3.REC1.AREA_TERR     := Getfloat(TD_linhaCad,20,0);
				PAGE3.REC1.AREACONST     := Getfloat(TD_linhaCad,21,0);
				PAGE3.REC1.VENAL_TERR    := Getfloat(TD_linhaCad,22,0);
				PAGE3.REC1.VENAL_PRED    := Getfloat(TD_linhaCad,23,0);
				PAGE3.REC1.EXPEDIENT     := Getfloat(TD_linhaCad,28,0);
				PAGE3.REC1.VENC_UNI      := Getdate(TD_linha1,4,0);
				PAGE3.REC1.TOTAL         := Getfloat(TD_linhaCad,24,0)+Getfloat(TD_linhaCad,25,0)+Getfloat(TD_linhaCad,26,0)+Getfloat(TD_linhaCad,27,0)+Getfloat(TD_linhaCad,28,0);
				PAGE3.REC1.IPTU          := Getfloat(TD_linhaCad,24,0);
				PAGE3.REC1.LIXO          := Getfloat(TD_linhaCad,25,0);
				PAGE3.REC1.CONSERVACA    := Getfloat(TD_linhaCad,26,0);
				PAGE3.REC1.LIMPEZA       := Getfloat(TD_linhaCad,27,0);
				PAGE3.REC1.VL_UNI        := Getfloat(TD_linha1,5,0);
				PAGE3.REC1.VL_PARC       := Getfloat(MultLineItem(TD_linha1,2),5,0);
				PAGE3.REC1.TIPO_IMPO     := 'I.P.T.U';
				PAGE3.REC1.END_IMOV[1]   := END_IMOVEL+', '+NUM_IMOVEL;
				PAGE3.REC1.END_IMOV[2]   := COMPL_IMOVEL+' '+ BAIRRO_IMOVEL;
				PAGE3.REC1.END_ENTREG[1] := END_ENTREGA+', '+NUM_ENTREGA+', '+COMPL_ENTREGA;
				PAGE3.REC1.END_ENTREG[2] := BAIRRO_ENTREGA+', '+CID_ENTREGA+', '+UF_ENTREGA;
				PAGE3.REC1.END_ENTREG[3] := 'CEP: '+CEP_ENTREGA;
				PAGE3.REC1.VENAL_TOTA    := Getfloat(TD_linhaCad,22,0)+Getfloat(TD_linhaCad,23,0);
				PAGE3.REC1.AVS:=AVISO;
				PAGE3.REC1.N_ARQUIV:=TD_nomeDoArquivo;
			WriteRecord(PAGE3,REC1);
			EndPage(PAGE3);
			TP_numPage:=TP_numPage+1;

			//PAGE UNICA
			BeginPage(PAGE4);
			ClearFields(PAGE4,REC1);
				VENCIMENTO:=SubStr(GetString(MultLineItem(TD_linha1,0),4,0),1,2)+SubStr(GetString(MultLineItem(TD_linha1,0),4,0),4,2)+SubStr(GetString(MultLineItem(TD_linha1,0),4,0),7,4);
				PAGE4.REC1.DATA        := VENCIMENTO;
				PAGE4.REC1.VENC_UNI    := Getdate(TD_linha1,4,0);
				PAGE4.REC1.VL_UNI      := Getfloat(TD_linha1,5,0);
				PAGE4.REC1.TIPO_IMPO   := 'I.P.T.U.';
				PAGE4.REC1.PROPRIETAR  := PROPRIETARIO;
				PAGE4.REC1.INSCRICAO[1]:= INSCRICAO;
				PAGE4.REC1.INSC        := GetString(TD_linhaCad,3,0);
				PAGE4.REC1.CAMPO_LIVR  := GetString(MultLineItem(TD_linha1,0),8,0)+GetString(MultLineItem(TD_linha1,0),9,0)+GetString(MultLineItem(TD_linha1,0),2,0)+'0';
				PAGE4.REC1.LIVRE_2     := VENCIMENTO+GetString(MultLineItem(TD_linha1,0),8,0)+GetString(MultLineItem(TD_linha1,0),9,0)+GetString(MultLineItem(TD_linha1,0),2,0)+'0';
				PAGE4.REC1.AVS:=AVISO;
				PAGE4.REC1.N_ARQUIV:=TD_nomeDoArquivo;
			WriteRecord(PAGE4,REC1);
			EndPage(PAGE4);
			TP_numPage:=TP_numPage+1;

			//PAGE 5 PARCELAS
			for j:= 0 to 6 do begin
			BeginPage(PAGE5);
			ClearFields(PAGE5,REC1);
				VENCIMENTO_1:=SubStr(GetString(MultLineItem(TD_linha1,j),4,0),1,2)+SubStr(GetString(MultLineItem(TD_linha1,j),4,0),4,2)+SubStr(GetString(MultLineItem(TD_linha1,j),4,0),7,4);		 
				PAGE5.REC1.TIPO_IMPO   := 'I.P.T.U.';
				PAGE5.REC1.VENC_PARC   := Getdate(MultLineItem(TD_linha1,j),4,0);
				PAGE5.REC1.VL_PARC     := Getfloat(MultLineItem(TD_linha1,j),5,0);
				PAGE5.REC1.PROPRIETAR  := PROPRIETARIO;
				PAGE5.REC1.INSCRICAO[1]:= INSCRICAO;
				PAGE5.REC1.PARCELA[1]  := FormatFloat(j,'9999')+' /6';
				PAGE5.REC1.INSC        := GetString(TD_linhaCad,3,0);
				PAGE5.REC1.DATE        := Getstring(MultLineItem(TD_linha1,j),4,0);
				PAGE5.REC1.CAMPO_LIVR  := VENCIMENTO_1+GetString(MultLineItem(TD_linha1,j),8,0)+GetString(MultLineItem(TD_linha1,j),9,0)+GetString(MultLineItem(TD_linha1,j),2,0)+'0';
				PAGE5.REC1.AVS         :=AVISO;
				PAGE5.REC1.N_ARQUIV    :=TD_nomeDoArquivo;
			WriteRecord(PAGE5,REC1);
			EndPage(PAGE5);
			TP_numPage:=TP_numPage+1;
			end;

		{---Relatorio TD_registro CX ID 4.0----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------}
		If TD_relatorios <> 0 then begin If TD_relatorios = 1 then begin totalNumeroPagina:=0; totalNumeroPagina:=TD_paginaExtra+TP_numPage; quantidadePorLote:= FloatToInt((Ceil(((TD_folhasPorCaixa/(totalNumeroPagina))))*TD_qtdPorFolha)*TD_tipoImpresso); if (numeroDeCliente mod quantidadePorLote) = 0 then begin numeroDoLote :=numeroDoLote+1; end; TD_conteudoRegistro:=FormatFloat(numeroDoLote,'9')+';'+barraDeControle+';'+TD_idArquivo+';'+TD_idExtra+';'+FormatNumeric(TP_aviso,'000.000')+';'+TD_idNumeroBanco+';'+TD_idCodigoBanco+';'+posicaoBarraSeg;	WritelnFileLog(TD_registro,TD_conteudoRegistro); numeroDeCliente:=numeroDeCliente+1; TP_aviso:=numeroDeCliente+1; end; end;
		{--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------}
		markup();

		TD_qtdLinha1   := 0;
		TD_linha1      :='';
		TD_print       := 0;
	End;


	{TD_print = 1; se for a ultima linha  }
	If TD_id = 'P' then begin
		TD_linha1      := MultLineAdd(TD_linha1,S);
		TD_qtdLinha1   := MultLineCount(TD_linha1);
		TD_print       := 1;
	End;

	If TD_id = 'C' then begin
		TD_linhaCad    := S; 
		TD_print       := 1;
	End;

{Logica aplicada no IF utilizada é variavel de acordo com o formato do arquivo multiline}
if close = 1 then break;
if ReadLn(S) = eof then close := 1;
end;

{---Ordenacaoo por profundidade 6.0  & Relatorio - Resumo Prefeitura-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------}
if TP_numPage = 0 then begin abort('NUMERO DE PARCELAS INVALIDO OU NÃO ENCONTRADO!') end else begin totalNumeroPaginaOrdenacao := TD_paginaExtra+TP_numPage; impressoPorCaixa :=0; impressoPorCaixa := FloatToInt((Ceil(((TD_folhasPorCaixa/(totalNumeroPaginaOrdenacao))))*TD_qtdPorFolha)*TD_tipoImpresso);
Convert(TD_qtdPorFolha,true,false,false,impressoPorCaixa,false); end; If TD_relatorios<> 0 then begin if TD_relatorios= 1 then begin If TD_tipoImpresso = 2 then begin impressoFrenteVerso:='(Impresso frente e verso)'; end else begin impressoFrenteVerso:=''; end; TD_conteudoResumo:=''; WritelnFileLog(TD_resumo, TD_conteudoResumo); TD_conteudoResumo:='- Informacao Geral'; WritelnFileLog(TD_resumo, TD_conteudoResumo); TD_conteudoResumo:='Data e Hora do ODA         '+FormatDate(SYS_DATE,'DD/MM/AAAA')+' '+SubStr(StrNumeric(FormatTime(SYS_TIME,'HH:MM'),4),1,2)+':'+SubStr(StrNumeric(FormatTime(SYS_TIME,'HH:MM'),4),3,2); WritelnFileLog(TD_resumo, TD_conteudoResumo); TD_conteudoResumo:='Numero de paginas:         '+FormatFloat(totalNumeroPaginaOrdenacao,'9'); WritelnFileLog(TD_resumo, TD_conteudoResumo); TD_conteudoResumo:='Numero de Impresso p/ fls: '+FormatFloat(TD_qtdPorFolha,'9')+' '+impressoFrenteVerso; WritelnFileLog(TD_resumo, TD_conteudoResumo); TD_conteudoResumo:='Numero de Registro:        '+FormatFloat(numeroDeCliente,'9'); WritelnFileLog(TD_resumo, TD_conteudoResumo); TD_conteudoResumo:=''; WritelnFileLog(TD_resumo, TD_conteudoResumo); TD_conteudoResumo:='- Informacao do Lote'; WritelnFileLog(TD_resumo, TD_conteudoResumo); TD_conteudoResumo:='Numero de Caixas:          '+FormatFloat(Ceil(numeroDeCliente/impressoPorCaixa),'9'); WritelnFileLog(TD_resumo, TD_conteudoResumo); TD_conteudoResumo:='Impressos p/ Caixa:        '+FormatFloat(impressoPorCaixa,'9'); WritelnFileLog(TD_resumo, TD_conteudoResumo); TD_conteudoResumo:='Numero de Fls p/ Caixa:    '+FormatFloat((((totalNumeroPaginaOrdenacao-TD_paginaExtra)*impressoPorCaixa)/TD_qtdPorFolha)/TD_tipoImpresso,'9'); WritelnFileLog(TD_resumo, TD_conteudoResumo); TD_conteudoResumo:=''; WritelnFileLog(TD_resumo, TD_conteudoResumo); TD_conteudoResumo:='- Informacao Extras'; WritelnFileLog(TD_resumo, TD_conteudoResumo); TD_conteudoResumo:='Nome do arquivo:          '+TD_nomeDoArquivo; WritelnFileLog(TD_resumo, TD_conteudoResumo); if TD_idNumeroBanco <> '' then begin TD_conteudoResumo:='Referencia do bando:      '+TD_idNumeroBanco; WritelnFileLog(TD_resumo, TD_conteudoResumo); end; if TD_idCodigoBanco <> '' then begin TD_conteudoResumo:='Referencia do Cliente:    '+TD_idCodigoBanco; WritelnFileLog(TD_resumo, TD_conteudoResumo); end; if posicaoBarraSeg <> '' then begin TD_conteudoResumo:='Referencia Barra Segurança:'+posicaoBarraSeg; WritelnFileLog(TD_resumo, TD_conteudoResumo); end; CloseFileLog(TD_resumo); If (TD_relatorios= 1) then begin WritelnFileLog(TD_registro,'*'); CloseFileLog(TD_registro); end; end; end;
{------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------}
