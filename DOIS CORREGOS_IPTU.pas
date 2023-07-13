{---SB 5.0 / BARRA_TP_aviso 1.0 ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------char3500} TD_plugin:=0;  x:=0; for i := 0 to 99 do begin  if substr(RetornaNomeArqEntrada(0),i,1) <> '.' then begin  x:= x+1; end else begin break; end; end; TD_nomeDoArquivo := substr(RetornaNomeArqEntrada(0),1,x-1); fls_cx:= 0; n_arq:='';
{----Pré-Configurações---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------}


{---Configurações--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------}
    TD_cliente                    := 'P.M. DOIS CORREGOS'; //Nome parcialmente completo
    TD_tipoImpresso               := 1;      // 1 = Carnes | 2 = Carta/Boletos |
    TD_qtdPorFolha                := 3;      //Quantidade de impresso por folha
    TD_paginaExtra                := 2;      //Quantidade de paginas nao inclusa no visual (contra-capa/encarte/etc)
    TD_folhasPorCaixa             := 1500;   //Quantidade de Folhar por caixa (carnes = 1500 caixa grande / 500 caixa pequena| Envelope 1000 A4 Caixa grande)
    TD_relatorios                 := 0;      // Desativar Relatorio = 0 | Ativar Relatorios = 1 
    TD_seguranca                  := 0;      // Desativa Barra de segurança = 0 | Ativa Barra de segurança = 1
{---Configurações de segurança-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------}
    marcaDaguaNome                := 'P.M.D.C'; //Marca dagua prefixo do cliente 
    tamanhoBarraSegurancaRandom   := 98;     //Numero maximo de codigo de segurança gerado com base no tamanhdo da marcadagua+1
    tamanhoBarraSegurancaLooping  := 110;    //Tamanho que da barra
    tamanhomarcaDeSeguranca       := 9999;   //Limite randomico do codigo de segurança

{---Plugin Inicio--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------}



{---Plugins Fim-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
----Relatorios 4.0-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------}
If TD_relatorios <> 0 then begin If (TD_relatorios= 1) then begin TD_resumo:= CreateFileLog('Resumo_'+TD_cliente+'_dt'+SubStr(StrNumeric(FormatTime(SYS_TIME,'HH:MM'),4),1,4)+'_'+RetornaNomeArqEntrada(0)); TD_conteudoResumo:=TD_cliente; WritelnFileLog(TD_resumo,TD_conteudoResumo); TD_registro:= CreateFileLog('Arquivo_Relatorio&Etiqueta_'+TD_cliente+'_'+SubStr(StrNumeric(FormatTime(SYS_TIME,'HH:MM'),4),1,4)+'_'+RetornaNomeArqEntrada(0)); TD_conteudoRegistro:='0;'+TD_cliente+';'++';'+FormatDate(SYS_DATE,'DD/MM/AAAA')+';'+SubStr(StrNumeric(FormatTime(SYS_TIME,'HH:MM'),4),1,2)+':'+SubStr(StrNumeric(FormatTime(SYS_TIME,'HH:MM'),4),3,2); WritelnFileLog(TD_registro,TD_conteudoRegistro); end; If TD_relatorios > 1 then begin	abort('RELATORIO - VALOR INFORMADO INVALIDO'); end; numeroDeCliente:=0; numeroDoLote:=0; end; {VAL.ANT.MRKISI} If TD_tipoImpresso > 2 then begin abort('ATENÇÃO - TIPO DE IMPRESSO INVALIDO'); end; If TD_qtdPorFolha < 1 then begin abort('ATENÇÃO - QUANTIDADE DE IMPRESSO POR FOLHA INVALIDO'); end; If fls_cx > 0 then begin abort('ATENÇÃO - SCRIPT PADRAO INVALIDO, VERSAO DESATUALIZADA INFERIOR A 5.0'); end; If n_arq <>'' then begin abort('ATENÇÃO - SCRIPT BARRA_TP_aviso 1.0 INVALIDO, VERSAO DESATUALIZADA INFERIOR A 2.0'); end; TP_numPage:=1; TP_aviso:=1; TD_idExtra:=''; TD_idCodigoBanco:=''; TD_idNumeroBanco:=''; barraSeg:=''; posicaoBarraSeg:='';
{---Variaveis Global Ini-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------}
ReadLn(s);


{---Variaveis Global Fim-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------}
While ReadLn(S) <> EOF do Begin
	{---Variaveis comuns Ini---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------}  
 	AVISO := FormatNumeric(TP_aviso,'000.000'); //Aviso gerado pelo script, convertido p String.
	insc  := TrimStr(GetString(S,9,9));
	ano   := TrimStr(GetString(S,1414,4));
	imp   := TrimStr(GetString(S,1478,25));
	contr := TrimStr(GetString(S,52,60));
	ncarn := TrimStr(GetString(S,1,8));
	e_log := TrimStr(GetString(S,112,100));
	e_com := TrimStr(GetString(S,221,50));
	e_blc := TrimStr(GetString(S,262,6));
	e_apt := TrimStr(GetString(S,268,8));
	e_bai := TrimStr(GetString(S,276,50));
	e_cid := TrimStr(GetString(S,326,50));
	e_est := TrimStr(GetString(S,376,2));
	e_cep := FormatNumeric(GetNumeric(S,378,8),'00000-000');
	i_log := TrimStr(GetString(S,386,100));
	i_com := TrimStr(GetString(S,486,50));
	i_bai := TrimStr(GetString(S,536,50));
	i_cep := FormatNumeric(GetNumeric(S,586,8),'00000-000');
	lotea := TrimStr(GetString(S,594,6));
	qdra  := TrimStr(GetString(S,664,12));
	lote  := TrimStr(GetString(S,676,12));
	dv    := TrimStr(GetString(S,7414,40));
	{---Variaveis comuns Fim---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------}  

	qtd   := 0;
	j     := 462;
	for i:= 0 to 12 do Begin
		If TrimStr(GetString(S,1408+(i*j),2)) = '' then break;
		qtd := qtd +1;
	end;
	{---Variaveis seleção Ini---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------}  
	
		ListaTeste := '000036200|000077421|000077423|000086170|000088530|0000101500|';

		If SEPARAR = 1 then begin
		  If Pos(insc,ListaTeste) <> 0 then Begin
			next:=1;
			end else begin
			next:=0;
			end;
			end else begin
		If Pos(insc,ListaTeste) <> 0 then Begin
			next:=0;
			end else begin
			next:=1;
			end;
		end;
	IF NEXT = 1 THEN BEGIN
		{---Variaveis seleção Fim---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------}  



		{---Configurações Referencia do contribuinte no Registro | Barra de TD_registro 3.0 ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------}
			TD_idArquivo        := GetString(S,9,9);    //Identificação do arquivo maximo ate 12 numeros
			TD_idNumeroBanco    := GetString(S,1515,12);    //Referencia do Banco
			TD_idCodigoBanco    := GetString(S,1,8);    //Referencia do contribuinte para com o banco (ex: nossonumero)
			//TD_idExtra          := GetString(S,,);   //Identificação extra 
		{--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------}  
		barraDeControle:=''; ctbs:= '0'; ctbi:= '0'; ctbf:= '0'; ctbn:= '0'; ctb := '99'; if ctb = '99' then begin ctbs := '1'; end; ctb2:=random(999)+1; if ctb2 >= 1 then begin ctbi:='1'; end; ctb3:=IntToFloat(random(999))+1.1; if ctb3 >= 1.1 then begin ctbf:='1'; end; ctb4:=IntToNumeric(random(999))+1.0; if ctb4 >= 1.0 then begin ctbn:='1'; end; barraDeControle:=ctbs+ctbi+ctbf+ctbn+StrNumeric(TD_idArquivo,12); barraDeControle := barraDeControle;	TP_numPage:=0; if TD_seguranca = 1 then begin maximoRandom := tamanhoBarraSegurancaRandom; posicaoRandom1 := Random(maximoRandom); if posicaoRandom1 = 0 then begin posicaoRandom1:= 1; end; posicaoRandom2 := Random(maximoRandom); if posicaoRandom2 = 0 then begin posicaoRandom2:= 1; end; posicaoRandom3 := Random(maximoRandom); if posicaoRandom3 = 0 then begin posicaoRandom3:= 1; end; posicaoRandom4 := Random(maximoRandom); if posicaoRandom4 = 0 then begin posicaoRandom4:= 1; end; If (posicaoRandom1 = posicaoRandom2) or (posicaoRandom1 = posicaoRandom3) or (posicaoRandom1 = posicaoRandom4) then begin posicaoRandom1 := posicaoRandom1 + 1; end; If (posicaoRandom2 = posicaoRandom1) or (posicaoRandom2 = posicaoRandom3) or (posicaoRandom2 = posicaoRandom4) then begin posicaoRandom2 := posicaoRandom2 + 1; end; If (posicaoRandom3 = posicaoRandom2) or (posicaoRandom3 = posicaoRandom1) or (posicaoRandom3 = posicaoRandom4) then begin posicaoRandom3 := posicaoRandom3 + 1; end; If (posicaoRandom4 = posicaoRandom2) or (posicaoRandom4 = posicaoRandom1) or (posicaoRandom4 = posicaoRandom3) then begin posicaoRandom4 := posicaoRandom4 + 1; end; marcaDeSeguranca1 := FormatNumeric(Random(tamanhomarcaDeSeguranca),'0000'); marcaDeSeguranca2 := FormatNumeric(Random(tamanhomarcaDeSeguranca),'0000'); marcaDeSeguranca3 := FormatNumeric(Random(tamanhomarcaDeSeguranca),'0000'); marcaDeSeguranca4 := FormatNumeric(Random(tamanhomarcaDeSeguranca),'0000'); barraSeg := ''; for i := 1 to tamanhoBarraSegurancaLooping do begin if i = posicaoRandom1 then begin composicaoBarraSeg := marcaDeSeguranca1 + ' '; end else begin if i = posicaoRandom2 then begin composicaoBarraSeg := marcaDeSeguranca2 + ' '; end else begin if i = posicaoRandom3 then begin composicaoBarraSeg := marcaDeSeguranca3 + ' '; end else begin if i = posicaoRandom4 then begin composicaoBarraSeg := marcaDeSeguranca4 + ' '; end else begin composicaoBarraSeg := marcaDaguaNome + ' '; end; end; end; end; barraSeg := barraSeg + composicaoBarraSeg; end; posicaoBarraSeg := FormatFloat(posicaoRandom1,'9')+'='+marcaDeSeguranca1+'_'+FormatFloat(posicaoRandom2,'9')+'='+marcaDeSeguranca2+'_'+FormatFloat(posicaoRandom3,'9')+'='+marcaDeSeguranca3+'_'+FormatFloat(posicaoRandom4,'9')+'='+marcaDeSeguranca4; end;
		{--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------}
			
			BeginPage(PAGE1);
			ClearFields(PAGE1,REC1);		
				PAGE1.REC1.AVS            := AVISO;
				PAGE1.REC1.N_ARQUIV       := TD_nomeDoArquivo;
				PAGE1.REC1.CONTRIBUIN     := contr;
				PAGE1.REC1.INSCRICAO      := insc;
				PAGE1.REC1.ANO            := ano;
				PAGE1.REC1.IMPOSTO        := imp;

				PAGE1.REC1.ENDE_IMOV[1]   := i_log+' '+i_com;
				PAGE1.REC1.ENDE_IMOV[2]   := i_bai;
				PAGE1.REC1.ENDE_IMOV[3]   := '';
				PAGE1.REC1.ENDE_IMOV[4]   := 'CEP: '+i_cep+' - DOIS CORREGOS SP';
				PAGE1.REC1.ENDE_IMOV[5]   := 'QUADRA: '+qdra+'    LOTE: '+lote;
				if e_log = i_log then begin 
				PAGE1.REC1.ENDE_ENTR[1]   := e_log+' '+e_com+' '+e_blc+' '+e_apt;
				PAGE1.REC1.ENDE_ENTR[2]   := e_bai;
				PAGE1.REC1.ENDE_ENTR[3]   := '';
				PAGE1.REC1.ENDE_ENTR[4]   := 'CEP: '+e_cep+' - '+e_cid+' '+e_est;
				PAGE1.REC1.ENDE_ENTR[5]   := 'QUADRA: '+qdra+'    LOTE: '+lote;
				end else begin
				PAGE1.REC1.ENDE_ENTR[1]   := i_log+' '+i_com;
				PAGE1.REC1.ENDE_ENTR[2]   := i_bai;
				PAGE1.REC1.ENDE_ENTR[3]   := '';
				PAGE1.REC1.ENDE_ENTR[4]   := 'CEP: '+i_cep+' - DOIS CORREGOS SP';
				PAGE1.REC1.ENDE_ENTR[5]   := 'QUADRA: '+qdra+'    LOTE: '+lote;
                           end;
			WriteRecord(PAGE1,REC1);
			EndPage(PAGE1);
			TP_numPage:=TP_numPage+1;


			BeginPage(CAPA);
			ClearFields(CAPA,REC1);
				CAPA.REC1.AVS             := AVISO;
				CAPA.REC1.N_ARQUIV       := TD_nomeDoArquivo;
				CAPA.REC1.ENDE_CAPA[1]    := contr;
				CAPA.REC1.ENDE_CAPA[2]    := i_log+' '+i_com;
				CAPA.REC1.ENDE_CAPA[3]    := i_bai;
				CAPA.REC1.ENDE_CAPA[4]    := '';
				CAPA.REC1.ENDE_CAPA[5]    := 'CEP: '+i_cep+' - DOIS CORREGOS SP';
				CAPA.REC1.INSCRICAO       := insc;
			WriteRecord(CAPA,REC1);
			EndPage(CAPA);
			TP_numPage:=TP_numPage+1;	

	
			BeginPage(VERSO);
			ClearFields(VERSO,REC1);
			WriteRecord(VERSO,REC1);
			EndPage(VERSO);
			TP_numPage:=TP_numPage+1;
	

			BeginPage(PAGE3);
			ClearFields(PAGE3,REC1);
				PAGE3.REC1.CONTRIBUIN      := contr;
				PAGE3.REC1.INSCRICAO       := insc;
				PAGE3.REC1.IMPOSTO         := imp;
				PAGE3.REC1.AVS             := AVISO;
				PAGE3.REC1.N_ARQUIV        := TD_nomeDoArquivo;
				PAGE3.REC1.ANO             := ano;
				PAGE3.REC1.LOTEAMENTO      := e_bai;
				PAGE3.REC1.QUADRA          := qdra;
				PAGE3.REC1.LOTE            := lote;
				PAGE3.REC1.TOTAL           := FormatFloat(GetFloat(S,1503,12),'9.999,99');
				PAGE3.REC1.VLR_PARCEL      := FormatFloat(GetFloat(S,1880,12),'9.999,99');
				PAGE3.REC1.VLR_DESCON      := FormatFloat(GetFloat(S,1515,12),'9.999,99');

				PAGE3.REC1.ENDE_IMOV[1]    := i_log+' '+i_com;
				PAGE3.REC1.ENDE_IMOV[2]    := i_bai;
				PAGE3.REC1.ENDE_IMOV[3]    := '';
				PAGE3.REC1.ENDE_IMOV[4]    := 'CEP: '+i_cep+' - DOIS CORREGOS SP';
				PAGE3.REC1.ENDE_ENTR[1]    := e_log+' '+e_com+' '+e_blc+' '+e_apt;
				PAGE3.REC1.ENDE_ENTR[2]    := e_bai;
				PAGE3.REC1.ENDE_ENTR[3]    := '';
				PAGE3.REC1.ENDE_ENTR[4]    := 'CEP: '+e_cep+' - '+e_cid+' '+e_est;			
				PAGE3.REC1.VLR_NOT1[1]     := FormatFloat(GetFloat(S,868,30),'9.999,99');//ALIQOTA
				PAGE3.REC1.VLR_NOT1[2]     := FormatFloat(GetFloat(S,688,30),'9.999,99');//AREA TERRENO
				PAGE3.REC1.VLR_NOT1[3]     := FormatFloat(GetFloat(S,778,30),'9.999,99');//VLR VENAL TERRENO
				PAGE3.REC1.VLR_NOT2[1]     := '';//----
				PAGE3.REC1.VLR_NOT2[2]     := FormatFloat(GetFloat(S,718,30),'9.999,99');//AREA CONSTRUIDA
				PAGE3.REC1.VLR_NOT2[3]     := FormatFloat(GetFloat(S,808,30),'9.999,99');//VLR VENAL CONSTRUCAO
				PAGE3.REC1.VLR_NOT3[1]     := '';//----
				PAGE3.REC1.VLR_NOT3[2]     := FormatFloat(GetFloat(S,748,30),'9.999,99');//TESTADA
				PAGE3.REC1.VLR_NOT3[3]     := FormatFloat(GetFloat(S,838,30),'9.999,99');//VLR VENAL TOTAL
				PAGE3.REC1.TRIBUBT[1]      := TrimStr(GetString(S,1478,25));
				PAGE3.REC1.TRIB_VLR[1]     := FormatFloat(GetFloat(S,1503,12),'9.999,99');
			WriteRecord(PAGE3,REC1);
			EndPage(PAGE3);
			TP_numPage:=TP_numPage+1;	


			For i := 0 to qtd-1 do begin
				BeginPage(PAGE4);
				ClearFields(PAGE4,REC1);
					PAGE4.REC1.CONTRIBUIN     := contr;
					PAGE4.REC1.ENDERECO[1]    := i_log+' '+i_com;
					PAGE4.REC1.ENDERECO[2]    := i_bai+' CEP: '+i_cep+' - DOIS CORREGOS SP';
					PAGE4.REC1.ANO            := ano;
					PAGE4.REC1.AVS            := AVISO;
					PAGE4.REC1.N_ARQUIV       := TD_nomeDoArquivo;
					PAGE4.REC1.CARN_INSC[1]   := ncarn;
					PAGE4.REC1.CARN_INSC[2]   := insc;

						If i = 0 then begin
							PAGE4.REC1.PARCELA        := 'ÚNICA';
							PAGE4.REC1.MSG[1]         := 'PARCELA ÚNICA PARA PAGAMENTO À VISTA VÁLIDA SOMENTE ATE O VENCIMENTO';
							PAGE4.REC1.MSG[2]         := 'NÃO RECEBER APÓS A DATA DO VENCIMENTO';
							end else begin
							PAGE4.REC1.PARCELA        := TrimStr(GetString(S,1408+(i*j),2))+'/'+FormatNumeric(qtd-1,'00');
							PAGE4.REC1.MSG[1]         := 'NÃO RECEBER APÓS A DATA DO VENCIMENTO';
							PAGE4.REC1.MSG[2]         := '';
						end;

						If dv <> '' then begin
							PAGE4.REC1.MSG[3]         := '';
							PAGE4.REC1.MSG[4]         := 'O PAGAMENTO DESTE CARNÊ NÃO QUITA DÉBITO ANTERIORES.';
							PAGE4.REC1.MSG[5]         := 'PARA PAGAMENTO DOS DÉBITOS, DIRIJA-SE À PREFEITURA MUNICIPAL';
						end;

					
					PAGE4.REC1.VENCIMENTO     := FormatDate(GetDate(S,1410+(i*j),8),'DD/MM/AAAA');
					PAGE4.REC1.TOTAL          := FormatFloat(GetFloat(S,1418+(i*j),12),'9.999,99');
					PAGE4.REC1.TRIBUBT[1]     := TrimStr(GetString(S,1478+(i*j),25));
					PAGE4.REC1.TRIB_VLR[1]    := FormatFloat(GetFloat(S,1515+(i*j),12),'9.999,99');

					COD                       := TrimStr(GetString(S,1430+(i*j),48));
					PAGE4.REC1.LINHA          := SubStr(COD,1,11)+'-'+SubStr(COD,12,1)+' '+SubStr(COD,13,11)+'-'+SubStr(COD,24,1)+' '+SubStr(COD,25,11)+'-'+SubStr(COD,36,1)+' '+SubStr(COD,37,11)+'-'+SubStr(COD,48,1);
					PAGE4.REC1.BARRA          := SubStr(COD,1,11)+SubStr(COD,13,11)+SubStr(COD,25,11)+SubStr(COD,37,11);
				WriteRecord(PAGE4,REC1);
				EndPage(PAGE4);
				TP_numPage:=TP_numPage+1;	
			end;

			
		{---Relatorio TD_registro CX ID 4.0----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------}
		If TD_relatorios <> 0 then begin If TD_relatorios = 1 then begin totalNumeroPagina:=0; totalNumeroPagina:=TD_paginaExtra+TP_numPage; quantidadePorLote:= FloatToInt((Ceil(((TD_folhasPorCaixa/(totalNumeroPagina))))*TD_qtdPorFolha)*TD_tipoImpresso); if (numeroDeCliente mod quantidadePorLote) = 0 then begin numeroDoLote :=numeroDoLote+1; end; TD_conteudoRegistro:=FormatFloat(numeroDoLote,'9')+';'+barraDeControle+';'+TD_idArquivo+';'+TD_idExtra+';'+FormatNumeric(TP_aviso,'000.000')+';'+TD_idNumeroBanco+';'+TD_idCodigoBanco+';'+posicaoBarraSeg;	WritelnFileLog(TD_registro,TD_conteudoRegistro); numeroDeCliente:=numeroDeCliente+1; TP_aviso:=numeroDeCliente+1; end; end;
		{--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------}
		markup();
	end;	
end;

{---Ordenacaoo por profundidade 6.0  & Relatorio - Resumo Prefeitura-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------}
if TP_numPage = 0 then begin abort('NUMERO DE PARCELAS INVALIDO OU NÃO ENCONTRADO!') end else begin totalNumeroPaginaOrdenacao := TD_paginaExtra+TP_numPage; impressoPorCaixa :=0; impressoPorCaixa := FloatToInt((Ceil(((TD_folhasPorCaixa/(totalNumeroPaginaOrdenacao))))*TD_qtdPorFolha)*TD_tipoImpresso);
Convert(TD_qtdPorFolha,true,false,false,impressoPorCaixa,false); end; If TD_relatorios<> 0 then begin if TD_relatorios= 1 then begin If TD_tipoImpresso = 2 then begin impressoFrenteVerso:='(Impresso frente e verso)'; end else begin impressoFrenteVerso:=''; end; TD_conteudoResumo:=''; WritelnFileLog(TD_resumo, TD_conteudoResumo); TD_conteudoResumo:='- Informacao Geral'; WritelnFileLog(TD_resumo, TD_conteudoResumo); TD_conteudoResumo:='Data e Hora do ODA         '+FormatDate(SYS_DATE,'DD/MM/AAAA')+' '+SubStr(StrNumeric(FormatTime(SYS_TIME,'HH:MM'),4),1,2)+':'+SubStr(StrNumeric(FormatTime(SYS_TIME,'HH:MM'),4),3,2); WritelnFileLog(TD_resumo, TD_conteudoResumo); TD_conteudoResumo:='Numero de paginas:         '+FormatFloat(totalNumeroPaginaOrdenacao,'9'); WritelnFileLog(TD_resumo, TD_conteudoResumo); TD_conteudoResumo:='Numero de Impresso p/ fls: '+FormatFloat(TD_qtdPorFolha,'9')+' '+impressoFrenteVerso; WritelnFileLog(TD_resumo, TD_conteudoResumo); TD_conteudoResumo:='Numero de Registro:        '+FormatFloat(numeroDeCliente,'9'); WritelnFileLog(TD_resumo, TD_conteudoResumo); TD_conteudoResumo:=''; WritelnFileLog(TD_resumo, TD_conteudoResumo); TD_conteudoResumo:='- Informacao do Lote'; WritelnFileLog(TD_resumo, TD_conteudoResumo); TD_conteudoResumo:='Numero de Caixas:          '+FormatFloat(Ceil(numeroDeCliente/impressoPorCaixa),'9'); WritelnFileLog(TD_resumo, TD_conteudoResumo); TD_conteudoResumo:='Impressos p/ Caixa:        '+FormatFloat(impressoPorCaixa,'9'); WritelnFileLog(TD_resumo, TD_conteudoResumo); TD_conteudoResumo:='Numero de Fls p/ Caixa:    '+FormatFloat((((totalNumeroPaginaOrdenacao-TD_paginaExtra)*impressoPorCaixa)/TD_qtdPorFolha)/TD_tipoImpresso,'9'); WritelnFileLog(TD_resumo, TD_conteudoResumo); TD_conteudoResumo:=''; WritelnFileLog(TD_resumo, TD_conteudoResumo); TD_conteudoResumo:='- Informacao Extras'; WritelnFileLog(TD_resumo, TD_conteudoResumo); TD_conteudoResumo:='Nome do arquivo:          '+TD_nomeDoArquivo; WritelnFileLog(TD_resumo, TD_conteudoResumo); if TD_idNumeroBanco <> '' then begin TD_conteudoResumo:='Referencia do bando:      '+TD_idNumeroBanco; WritelnFileLog(TD_resumo, TD_conteudoResumo); end; if TD_idCodigoBanco <> '' then begin TD_conteudoResumo:='Referencia do Cliente:    '+TD_idCodigoBanco; WritelnFileLog(TD_resumo, TD_conteudoResumo); end; if posicaoBarraSeg <> '' then begin TD_conteudoResumo:='Referencia Barra Segurança:'+posicaoBarraSeg; WritelnFileLog(TD_resumo, TD_conteudoResumo); end; CloseFileLog(TD_resumo); If (TD_relatorios= 1) then begin WritelnFileLog(TD_registro,'*'); CloseFileLog(TD_registro); end; end; end;
{------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------}
