{---SB 5.0 / BARRA_TP_aviso 1.0 ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------char3500} TD_plugin:=0;  x:=0; for i := 0 to 99 do begin  if substr(RetornaNomeArqEntrada(0),i,1) <> '.' then begin  x:= x+1; end else begin break; end; end; TD_nomeDoArquivo := substr(RetornaNomeArqEntrada(0),1,x-1); fls_cx:= 0; n_arq:='';
{----Pré-Configurações---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------}


{---Configurações--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------}
    TD_cliente                    := 'P.M. IPÉRO'; //Nome parcialmente completo
    TD_tipoImpresso               := 1;      // 1 = Carnes | 2 = Carta/Boletos |
    TD_qtdPorFolha                := 3;      //Quantidade de impresso por folha
    TD_paginaExtra                := 2;      //Quantidade de paginas nao inclusa no visual (contra-capa/encarte/etc)
    TD_folhasPorCaixa             := 1500;   //Quantidade de Folhar por caixa (carnes = 1500 caixa grande / 500 caixa pequena| Envelope 1000 A4 Caixa grande)
    TD_relatorios                 := 0;      // Desativar Relatorio = 0 | Ativar Relatorios = 1 
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



{---Plugins Fim-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
----Relatorios 4.0-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------}
If TD_relatorios <> 0 then begin If (TD_relatorios= 1) then begin TD_resumo:= CreateFileLog('Resumo_'+TD_cliente+'_dt'+SubStr(StrNumeric(FormatTime(SYS_TIME,'HH:MM'),4),1,4)+'_'+RetornaNomeArqEntrada(0)); TD_conteudoResumo:=TD_cliente; WritelnFileLog(TD_resumo,TD_conteudoResumo); TD_registro:= CreateFileLog('Arquivo_Relatorio&Etiqueta_'+TD_cliente+'_'+SubStr(StrNumeric(FormatTime(SYS_TIME,'HH:MM'),4),1,4)+'_'+RetornaNomeArqEntrada(0)); TD_conteudoRegistro:='0;'+TD_cliente+';'++';'+FormatDate(SYS_DATE,'DD/MM/AAAA')+';'+SubStr(StrNumeric(FormatTime(SYS_TIME,'HH:MM'),4),1,2)+':'+SubStr(StrNumeric(FormatTime(SYS_TIME,'HH:MM'),4),3,2); WritelnFileLog(TD_registro,TD_conteudoRegistro); end; If TD_relatorios > 1 then begin	abort('RELATORIO - VALOR INFORMADO INVALIDO'); end; numeroDeCliente:=0; numeroDoLote:=0; end; {VAL.ANT.MRKISI} If TD_tipoImpresso > 2 then begin abort('ATENÇÃO - TIPO DE IMPRESSO INVALIDO'); end; If TD_qtdPorFolha < 1 then begin abort('ATENÇÃO - QUANTIDADE DE IMPRESSO POR FOLHA INVALIDO'); end; If fls_cx > 0 then begin abort('ATENÇÃO - SCRIPT PADRAO INVALIDO, VERSAO DESATUALIZADA INFERIOR A 5.0'); end; If n_arq <>'' then begin abort('ATENÇÃO - SCRIPT BARRA_TP_aviso 1.0 INVALIDO, VERSAO DESATUALIZADA INFERIOR A 2.0'); end; TP_numPage:=1; TP_aviso:=1; TD_idExtra:=''; TD_idCodigoBanco:=''; TD_idNumeroBanco:=''; barraSeg:=''; posicaoBarraSeg:='';
{---Variaveis Global Ini-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------}



{---Variaveis Global Fim-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------}
While ReadLn(S) <> EOF do Begin
	{---Variaveis comuns Ini---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------}  
	AVISO            := FormatNumeric(TP_aviso,'000.000'); //Aviso gerado pelo script, convertido p String.
	total            := Getfloat(S,3637,12)/100+Getfloat(S,3649,12)/100+Getfloat(S,3661,12)/100+Getfloat(S,3673,12)/100+Getfloat(S,3685,12)/100+Getfloat(S,3697,12)/100+Getfloat(S,3709,12)/100+Getfloat(S,3721,12)/100+Getfloat(S,3733,12)/100+Getfloat(S,3745,12)/100;
	REGISTRO         := FormatNumeric(GetNumeric(S,1,10),'##########');
	INSCRICAO        := GetString(S,27,30);
	PROPRIETARIO     := GetString(S,157,60);
	COMPROMISSARIO   := GetString(S,235,100);
	LOTEAMENTO       := GetString(S,938,50);
	LOTE             := GetString(S,998,20);
	QUADRA           := GetString(S,988,10);
	END_ENTREG       := TrimStr(GetString(S,353,75));
	NUM_ENTREG       := TrimStr(GetString(S,428,20));
	BAIRRO_ENTREG    := TrimStr(GetString(S,448,50));
	COMPL_ENTREG     := TrimStr(GetString(S,498,57)) +', '+TrimStr(GetString(S,616,17)) +', '+TrimStr(GetString(S,633,16));
	CEP_ENTREG       := GetString(S,555,9);
	CID_ENTREG       := TrimStr(GetString(S,564,50));
	UF_ENTREG        := TrimStr(GetString(S,614,2));
	TIP_IMOVEL       := TrimStr(GetString(S,649,10));
	END_IMOVEL       := TrimStr(GetString(S,668,150));
	BAIRRO_IMOVEL    := TrimStr(GetString(S,827,50));
	CID_IMOVEL       := TrimStr(GetString(S,877,50));
	UF_IMOVEL        := TrimStr(GetString(S,927,2));
	CEP_IMOVEL       := GetString(S,929,9);
	M2_TERRENO       := FormatFloat(GetFloat(S,1047,8)/100,'9.999,99');
	M2_CONSTRUCAO    := FormatFloat(GetFloat(S,1055,8)/100,'9.999,99');
	ALIQUOTA         := FormatFloat(GetFloat(S,1063,8)/100,'9.999,99');
	AREA_TERRENO     := FormatFloat(GetFloat(S,1071,12)/100,'9.999,99');
	AREA_CONSTRUIDA  := FormatFloat(GetFloat(S,1155,12)/100,'9.999,99');
	VENAL_TERRENO    := FormatFloat(GetFloat(S,1131,12)/100,'9.999,99');
	VENAL_CONSTRUIDA := FormatFloat(GetFloat(S,1167,12)/100,'9.999,99');
	VENAL_TOTAL      := FormatFloat(GetFloat(S,1359,12)/100,'9.999,99');
	IMP_PREDIAL      := FormatFloat(GetFloat(S,2349,12)/100,'9.999,99');
	IMP_TERREITORIAL := FormatFloat(GetFloat(S,2337,12)/100,'9.999,99');
	COLETA_TOTAL     := FormatFloat(GetFloat(S,2397,12)/100,'9.999,99');
	CONSER_TOTAL     := FormatFloat(GetFloat(S,2385,12)/100,'9.999,99');			 
	LIMPE_TOTAL      := FormatFloat(GetFloat(S,2361,12)/100,'9.999,99');
	VL_ANO_PC        := FormatFloat(Getfloat(S,3637,12)/100,'9.999,99');
	TOTAL_UNICA      := FormatFloat(GetFloat(S,3613,12)/100,'9.999,99');
	TESTADA          := FormatFloat(GetFloat(S,1083,12)/100,'9.999,99');
	CIP              := FormatFloat(GetFloat(S,2373,12)/100,'9.999,99');
	NR_PARCELA       := GetFloat(S,2481,2);
	if TrimStr(GetString(S,235,60)) = '' then begin 
		SACADO := PROPRIETARIO;
		CPF_CNPJ := TrimStr(GetString(S,217,18));
	end else begin 
		SACADO := COMPROMISSARIO;
		CPF_CNPJ :=TrimStr(GetString(S,335,18));
	end;
	If PARCELA = 8 then Begin
		{---Variaveis comuns Fim---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------}  

		{---Configurações Referencia do contribuinte no Registro | Barra de TD_registro 3.0 ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------}
			TD_idArquivo        := GetString(S,1,10);    //Identificação do arquivo maximo ate 12 numeros
			TD_idNumeroBanco    := GetString(S,3797,8);    //Referencia do Banco
			TD_idCodigoBanco    := GetString(S,6053,20);    //Referencia do contribuinte para com o banco (ex: nossonumero)
			//TD_idExtra          := GetString(S,0,0);   //Identificação extra 
		{--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------}  
		barraDeControle:=''; ctbs:= '0'; ctbi:= '0'; ctbf:= '0'; ctbn:= '0'; ctb := '99'; if ctb = '99' then begin ctbs := '1'; end; ctb2:=random(999)+1; if ctb2 >= 1 then begin ctbi:='1'; end; ctb3:=IntToFloat(random(999))+1.1; if ctb3 >= 1.1 then begin ctbf:='1'; end; ctb4:=IntToNumeric(random(999))+1.0; if ctb4 >= 1.0 then begin ctbn:='1'; end; barraDeControle:=ctbs+ctbi+ctbf+ctbn+StrNumeric(TD_idArquivo,12); barraDeControle := barraDeControle;	TP_numPage:=0; if TD_seguranca = 1 then begin maximoRandom := tamanhoBarraSegurancaRandom; posicaoRandom1 := Random(maximoRandom); if posicaoRandom1 = 0 then begin posicaoRandom1:= 1; end; posicaoRandom2 := Random(maximoRandom); if posicaoRandom2 = 0 then begin posicaoRandom2:= 1; end; posicaoRandom3 := Random(maximoRandom); if posicaoRandom3 = 0 then begin posicaoRandom3:= 1; end; posicaoRandom4 := Random(maximoRandom); if posicaoRandom4 = 0 then begin posicaoRandom4:= 1; end; If (posicaoRandom1 = posicaoRandom2) or (posicaoRandom1 = posicaoRandom3) or (posicaoRandom1 = posicaoRandom4) then begin posicaoRandom1 := posicaoRandom1 + 1; end; If (posicaoRandom2 = posicaoRandom1) or (posicaoRandom2 = posicaoRandom3) or (posicaoRandom2 = posicaoRandom4) then begin posicaoRandom2 := posicaoRandom2 + 1; end; If (posicaoRandom3 = posicaoRandom2) or (posicaoRandom3 = posicaoRandom1) or (posicaoRandom3 = posicaoRandom4) then begin posicaoRandom3 := posicaoRandom3 + 1; end; If (posicaoRandom4 = posicaoRandom2) or (posicaoRandom4 = posicaoRandom1) or (posicaoRandom4 = posicaoRandom3) then begin posicaoRandom4 := posicaoRandom4 + 1; end; marcaDeSeguranca1 := FormatNumeric(Random(tamanhomarcaDeSeguranca),'0000'); marcaDeSeguranca2 := FormatNumeric(Random(tamanhomarcaDeSeguranca),'0000'); marcaDeSeguranca3 := FormatNumeric(Random(tamanhomarcaDeSeguranca),'0000'); marcaDeSeguranca4 := FormatNumeric(Random(tamanhomarcaDeSeguranca),'0000'); barraSeg := ''; for i := 1 to tamanhoBarraSegurancaLooping do begin if i = posicaoRandom1 then begin composicaoBarraSeg := marcaDeSeguranca1 + ' '; end else begin if i = posicaoRandom2 then begin composicaoBarraSeg := marcaDeSeguranca2 + ' '; end else begin if i = posicaoRandom3 then begin composicaoBarraSeg := marcaDeSeguranca3 + ' '; end else begin if i = posicaoRandom4 then begin composicaoBarraSeg := marcaDeSeguranca4 + ' '; end else begin composicaoBarraSeg := marcaDaguaNome + ' '; end; end; end; end; barraSeg := barraSeg + composicaoBarraSeg; end; posicaoBarraSeg := FormatFloat(posicaoRandom1,'9')+'='+marcaDeSeguranca1+'_'+FormatFloat(posicaoRandom2,'9')+'='+marcaDeSeguranca2+'_'+FormatFloat(posicaoRandom3,'9')+'='+marcaDeSeguranca3+'_'+FormatFloat(posicaoRandom4,'9')+'='+marcaDeSeguranca4; end;
		{--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------}

		//pagina 1
		BeginPage(PAGE1);
		ClearFields(PAGE1,REC1);
			PAGE1.REC1.CBARRA       := barraDeControle;
			PAGE1.REC1.SBARRA    := barraDeControle;
			PAGE1.REC1.REGISTRO := REGISTRO;
			PAGE1.REC1.INSCRICAO := INSCRICAO;
			PAGE1.REC1.PROPRIETAR := PROPRIETARIO;
			PAGE1.REC1.COMPROMISS := COMPROMISSARIO;
			PAGE1.REC1.LOTEAMENTO := LOTEAMENTO;
			PAGE1.REC1.LOTE := LOTE;
			PAGE1.REC1.QUADRA := QUADRA;
			PAGE1.REC1.END_ENTREG[1]:= END_ENTREG +', '+ NUM_ENTREG;
			PAGE1.REC1.END_ENTREG[2] := BAIRRO_ENTREG +'  '+ COMPL_ENTREG;
			PAGE1.REC1.END_ENTREG[3] := 'CEP: '+ CEP_ENTREG+' - '+ CID_ENTREG+' / '+ UF_ENTREG;
			//PAGE1.REC1.AVISO := GetString(S,61,0);
			PAGE1.REC1.DATA := SYS_DATE;
			PAGE1.REC1.AVS:=AVISO;
			PAGE1.REC1.N_ARQUIV:=TD_nomeDoArquivo;	
		WriteRecord(PAGE1,REC1);
		EndPage(PAGE1);
		TP_numPage:=TP_numPage+1; //Variavel deve se repetir abaixo de todos os EndPage
		{//pagina 2 - notificação 
		BeginPage(PAGE2);
		ClearFields(PAGE2,REC1);
			PAGE2.REC1.AVS:=AVISO;
			PAGE2.REC1.N_ARQUIV:=TD_nomeDoArquivo;	
		WriteRecord(PAGE2,REC1);
		EndPage(PAGE2);
		TP_numPage:=TP_numPage+1;}
		//pagina 4
		BeginPage(PAGE3);
		ClearFields(PAGE3,REC1);
			PAGE3.REC1.REGISTRO := REGISTRO;
			PAGE3.REC1.INSCRICAO := INSCRICAO;
			PAGE3.REC1.PROPRIETAR := PROPRIETARIO;
			PAGE3.REC1.COMPROMISS := COMPROMISSARIO;
			PAGE3.REC1.END_IMOVEL := TIP_IMOVEL+'   '+END_IMOVEL+' - '+BAIRRO_IMOVEL+' - '+CID_IMOVEL+'/'+UF_IMOVEL;
			PAGE3.REC1.CEP_IMOV := CEP_IMOVEL;
			PAGE3.REC1.LOTE := LOTE;
			PAGE3.REC1.QUADRA := QUADRA;
			PAGE3.REC1.LOTEAMENTO := LOTEAMENTO;
			PAGE3.REC1.M2_TERR := M2_TERRENO;
			PAGE3.REC1.M2_CONSTR := M2_CONSTRUCAO;
			PAGE3.REC1.ALIQUOTA := ALIQUOTA;
			PAGE3.REC1.AREA_TERR := AREA_TERRENO;
			PAGE3.REC1.AREA_CONST := AREA_CONSTRUIDA;
			PAGE3.REC1.VENAL_TERR := VENAL_TERRENO;
			PAGE3.REC1.VENAL_CONS := VENAL_CONSTRUIDA;
			PAGE3.REC1.VENAL_TOT := VENAL_TOTAL;
			PAGE3.REC1.IMP_PRED := IMP_PREDIAL;
			PAGE3.REC1.IMP_TERR := IMP_TERREITORIAL;
			PAGE3.REC1.COLETA_TOT := COLETA_TOTAL;
			PAGE3.REC1.CONSER_TOT := CONSER_TOTAL;			 
			PAGE3.REC1.NR_PARCELA := NR_PARCELA;
			PAGE3.REC1.LIMPE_TOT := LIMPE_TOTAL;
			PAGE3.REC1.TOTAL_TOT := total;
			PAGE3.REC1.TESTADA := TESTADA;
			PAGE3.REC1.VL_ANO_PC := VL_ANO_PC;
			PAGE3.REC1.TOT_UN := TOTAL_UNICA;
			PAGE3.REC1.DATA_UN := SubStr(Getstring(S,3797,8),7,2)+'/'+SubStr(Getstring(S,3797,8),5,2)+'/'+SubStr(Getstring(S,3797,8),1,4);
			PAGE3.REC1.DATA_1 := SubStr(Getstring(S,3813,8),7,2)+'/'+SubStr(Getstring(S,3813,8),5,2)+'/'+SubStr(Getstring(S,3813,8),1,4);
			PAGE3.REC1.DATA_2 := SubStr(Getstring(S,3821,8),7,2)+'/'+SubStr(Getstring(S,3821,8),5,2)+'/'+SubStr(Getstring(S,3821,8),1,4);
			PAGE3.REC1.DATA_3 := SubStr(Getstring(S,3829,8),7,2)+'/'+SubStr(Getstring(S,3829,8),5,2)+'/'+SubStr(Getstring(S,3829,8),1,4);
			PAGE3.REC1.DATA_4 := SubStr(Getstring(S,3837,8),7,2)+'/'+SubStr(Getstring(S,3837,8),5,2)+'/'+SubStr(Getstring(S,3837,8),1,4);
			PAGE3.REC1.DATA_5 := SubStr(Getstring(S,3845,8),7,2)+'/'+SubStr(Getstring(S,3845,8),5,2)+'/'+SubStr(Getstring(S,3845,8),1,4);
			PAGE3.REC1.DATA_6 := SubStr(Getstring(S,3853,8),7,2)+'/'+SubStr(Getstring(S,3853,8),5,2)+'/'+SubStr(Getstring(S,3853,8),1,4);
			PAGE3.REC1.DATA_7 := SubStr(Getstring(S,3861,8),7,2)+'/'+SubStr(Getstring(S,3861,8),5,2)+'/'+SubStr(Getstring(S,3861,8),1,4);
			PAGE3.REC1.DATA_8 := SubStr(Getstring(S,3869,8),7,2)+'/'+SubStr(Getstring(S,3869,8),5,2)+'/'+SubStr(Getstring(S,3869,8),1,4);
			PAGE3.REC1.DATA_9 := SubStr(Getstring(S,3877,8),7,2)+'/'+SubStr(Getstring(S,3877,8),5,2)+'/'+SubStr(Getstring(S,3877,8),1,4);
			PAGE3.REC1.DATA_10 := SubStr(Getstring(S,3885,8),7,2)+'/'+SubStr(Getstring(S,3885,8),5,2)+'/'+SubStr(Getstring(S,3885,8),1,4);
			//PAGE3.REC1.AVISO := GetString(S,61,0);
			PAGE3.REC1.CIP := CIP;
			PAGE3.REC1.AVS:=AVISO;
			PAGE3.REC1.N_ARQUIV:=TD_nomeDoArquivo;	
		WriteRecord(PAGE3,REC1);
		EndPage(PAGE3);
		TP_numPage:=TP_numPage+1;
		// BEM ESTAR ANIMAL Unica
		BeginPage(PAGE4);
		ClearFields(PAGE4,REC1);
			PAGE4.REC1.SACADO := SACADO;
			PAGE4.REC1.CPF_CNPJ := CPF_CNPJ;
			PAGE4.REC1.REGISTRO := REGISTRO;
			PAGE4.REC1.INSCRICAO := INSCRICAO;
			PAGE4.REC1.END_IMOVEL := TIP_IMOVEL+'   '+END_IMOVEL+' - '+BAIRRO_IMOVEL+' - '+CID_IMOVEL+'/'+UF_IMOVEL+' - CEP: '+CEP_IMOVEL;
			PAGE4.REC1.CEP_IMOV := CEP_IMOVEL;
			PAGE4.REC1.TOT_ANO_PC := GetFloat(S,3541,12);
			PAGE4.REC1.DATA_PARC := SubStr(Getstring(S,3781,8),1,2)+'/'+SubStr(Getstring(S,3781,8),3,2)+'/'+SubStr(Getstring(S,3781,8),5,4);
			PAGE4.REC1.NOSS_NR_PC := GetString(S,6013,20);
			PAGE4.REC1.DATA_PROC := SYS_DATE;
			PAGE4.REC1.RED_PARC:= GetString(S,7037,58);
			PAGE4.REC1.BARRA_PARC:= GetString(S,6333,44);
			PAGE4.REC1.PIX:= TrimStr(GetString(S,9325,188));
			PAGE4.REC1.AVS:=AVISO;
			PAGE4.REC1.N_ARQUIV:=TD_nomeDoArquivo;	
		WriteRecord(PAGE4,REC1);
		EndPage(PAGE4);
		TP_numPage:=TP_numPage+1;
		// Unica
		BeginPage(PAGE5);
		ClearFields(PAGE5,REC1);
			PAGE5.REC1.SACADO := SACADO;
			PAGE5.REC1.CPF_CNPJ := CPF_CNPJ;
			PAGE5.REC1.REGISTRO := REGISTRO;
			PAGE5.REC1.INSCRICAO := INSCRICAO;
			PAGE5.REC1.END_IMOVEL := TIP_IMOVEL+'   '+END_IMOVEL+' - '+BAIRRO_IMOVEL+' - '+CID_IMOVEL+'/'+UF_IMOVEL+' - CEP: '+CEP_IMOVEL;
			PAGE5.REC1.CEP_IMOV := CEP_IMOVEL;
			PAGE5.REC1.TOT_ANO_PC := FormatFloat(GetFloat(S,3613,12)/100,'9.999,99');
			PAGE5.REC1.DATA_PARC := SubStr(Getstring(S,3797,8),7,2)+'/'+SubStr(Getstring(S,3797,8),5,2)+'/'+SubStr(Getstring(S,3797,8),1,4);
			PAGE5.REC1.NOSS_NR_PC := GetString(S,6053,20);
			PAGE5.REC1.DATA_PROC := SYS_DATE;
			PAGE5.REC1.RED_PARC:= GetString(S,7153,58);
			PAGE5.REC1.BARRA_PARC:= GetString(S,6421,44);
			PAGE5.REC1.PIX:= TrimStr(GetString(S,10325,188));
			PAGE5.REC1.AVS:=AVISO;
			PAGE5.REC1.N_ARQUIV:=TD_nomeDoArquivo;	
		WriteRecord(PAGE5,REC1);
		EndPage(PAGE5);
		TP_numPage:=TP_numPage+1;
		//Parcelas
		For i := 0 to (PARCELA-1) do Begin
		BeginPage(PAGE6);
		ClearFields(PAGE6,REC1);
			PAGE6.REC1.SACADO := SACADO;
			PAGE6.REC1.CPF_CNPJ := CPF_CNPJ;
			PAGE6.REC1.NR_PARCELA := i+1.0;
			PAGE6.REC1.REGISTRO := REGISTRO;
			PAGE6.REC1.INSCRICAO := INSCRICAO;
			PAGE6.REC1.END_IMOVEL := TIP_IMOVEL+'   '+END_IMOVEL+' - '+BAIRRO_IMOVEL+' - '+CID_IMOVEL+'/'+UF_IMOVEL+' - CEP: '+CEP_IMOVEL;
			PAGE6.REC1.CEP_IMOV := CEP_IMOVEL;
			PAGE6.REC1.TOT_ANO_PC := FormatFloat(Getfloat(S,3637+(i*12),12)/100,'9.999,99');
			PAGE6.REC1.DATA_PARC := SubStr(Getstring(S,3813+(i*8),8),7,2)+'/'+SubStr(Getstring(S,3813+(i*8),8),5,2)+'/'+SubStr(Getstring(S,3813+(i*8),8),1,4);
			PAGE6.REC1.NOSS_NR_PC := GetString(S,6093+(i*20),20);
			PAGE6.REC1.DATA_PROC := SYS_DATE;
			PAGE6.REC1.RED_PARC:= GetString(S,7269+(i*58),58);
			PAGE6.REC1.BARRA_PARC:= GetString(S,6509+(i*44),44);
			PAGE6.REC1.PIX:= TrimStr(GetString(S,11825+(i*500),188));
			PAGE6.REC1.AVS:=AVISO;
			PAGE6.REC1.N_ARQUIV:=TD_nomeDoArquivo;	
		WriteRecord(PAGE6,REC1);
		EndPage(PAGE6);
		TP_numPage:=TP_numPage+1;
		End;
		
		{//pagina 8
		BeginPage(PAGE7);
		ClearFields(PAGE7,REC1);
			PAGE7.REC1.REGISTRO := FormatNumeric(GetNumeric(S,1,10),'##########');
			PAGE7.REC1.INSCRICAO := INSCRICAO;
			PAGE7.REC1.COMPROMISS := COMPROMISSARIO;
			PAGE7.REC1.END_ENTREG[1]:= END_ENTREG +', '+ NUM_ENTREG;
			PAGE7.REC1.END_ENTREG[2] := BAIRRO_ENTREG +'  '+ COMPL_ENTREG;
			PAGE7.REC1.END_ENTREG[3] := 'CEP: '+ CEP_ENTREG+' - '+ CID_ENTREG+' / '+ UF_ENTREG;
			PAGE7.REC1.LOTE := LOTE;
			PAGE7.REC1.QUADRA := QUADRA;
			PAGE7.REC1.LOTEAMENTO := LOTEAMENTO;
			PAGE7.REC1.SACADO := PROPRIETARIO;
			PAGE7.REC1.AVISO := GetString(S,61,0);
		WriteRecord(PAGE7,REC1);
		EndPage(PAGE7);
		TP_numPage:=TP_numPage+1;}
	
		{---Relatorio TD_registro CX ID 4.0----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------}
		If TD_relatorios <> 0 then begin If TD_relatorios = 1 then begin totalNumeroPagina:=0; totalNumeroPagina:=TD_paginaExtra+TP_numPage; quantidadePorLote:= FloatToInt((Ceil(((TD_folhasPorCaixa/(totalNumeroPagina))))*TD_qtdPorFolha)*TD_tipoImpresso); if (numeroDeCliente mod quantidadePorLote) = 0 then begin numeroDoLote :=numeroDoLote+1; end; TD_conteudoRegistro:=FormatFloat(numeroDoLote,'9')+';'+barraDeControle+';'+TD_idArquivo+';'+TD_idExtra+';'+FormatNumeric(TP_aviso,'000.000')+';'+TD_idNumeroBanco+';'+TD_idCodigoBanco+';'+posicaoBarraSeg;	WritelnFileLog(TD_registro,TD_conteudoRegistro); numeroDeCliente:=numeroDeCliente+1; TP_aviso:=numeroDeCliente+1; end; end;
		{--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------}
		markup();
	end;
End;
{---Ordenacaoo por profundidade 6.0  & Relatorio - Resumo Prefeitura-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------}
if TP_numPage = 0 then begin abort('NUMERO DE PARCELAS INVALIDO OU NÃO ENCONTRADO!') end else begin totalNumeroPaginaOrdenacao := TD_paginaExtra+TP_numPage; impressoPorCaixa :=0; impressoPorCaixa := FloatToInt((Ceil(((TD_folhasPorCaixa/(totalNumeroPaginaOrdenacao))))*TD_qtdPorFolha)*TD_tipoImpresso);
Convert(TD_qtdPorFolha,true,false,false,impressoPorCaixa,false); end; If TD_relatorios<> 0 then begin if TD_relatorios= 1 then begin If TD_tipoImpresso = 2 then begin impressoFrenteVerso:='(Impresso frente e verso)'; end else begin impressoFrenteVerso:=''; end; TD_conteudoResumo:=''; WritelnFileLog(TD_resumo, TD_conteudoResumo); TD_conteudoResumo:='- Informacao Geral'; WritelnFileLog(TD_resumo, TD_conteudoResumo); TD_conteudoResumo:='Data e Hora do ODA         '+FormatDate(SYS_DATE,'DD/MM/AAAA')+' '+SubStr(StrNumeric(FormatTime(SYS_TIME,'HH:MM'),4),1,2)+':'+SubStr(StrNumeric(FormatTime(SYS_TIME,'HH:MM'),4),3,2); WritelnFileLog(TD_resumo, TD_conteudoResumo); TD_conteudoResumo:='Numero de paginas:         '+FormatFloat(totalNumeroPaginaOrdenacao,'9'); WritelnFileLog(TD_resumo, TD_conteudoResumo); TD_conteudoResumo:='Numero de Impresso p/ fls: '+FormatFloat(TD_qtdPorFolha,'9')+' '+impressoFrenteVerso; WritelnFileLog(TD_resumo, TD_conteudoResumo); TD_conteudoResumo:='Numero de Registro:        '+FormatFloat(numeroDeCliente,'9'); WritelnFileLog(TD_resumo, TD_conteudoResumo); TD_conteudoResumo:=''; WritelnFileLog(TD_resumo, TD_conteudoResumo); TD_conteudoResumo:='- Informacao do Lote'; WritelnFileLog(TD_resumo, TD_conteudoResumo); TD_conteudoResumo:='Numero de Caixas:          '+FormatFloat(Ceil(numeroDeCliente/impressoPorCaixa),'9'); WritelnFileLog(TD_resumo, TD_conteudoResumo); TD_conteudoResumo:='Impressos p/ Caixa:        '+FormatFloat(impressoPorCaixa,'9'); WritelnFileLog(TD_resumo, TD_conteudoResumo); TD_conteudoResumo:='Numero de Fls p/ Caixa:    '+FormatFloat((((totalNumeroPaginaOrdenacao-TD_paginaExtra)*impressoPorCaixa)/TD_qtdPorFolha)/TD_tipoImpresso,'9'); WritelnFileLog(TD_resumo, TD_conteudoResumo); TD_conteudoResumo:=''; WritelnFileLog(TD_resumo, TD_conteudoResumo); TD_conteudoResumo:='- Informacao Extras'; WritelnFileLog(TD_resumo, TD_conteudoResumo); TD_conteudoResumo:='Nome do arquivo:          '+TD_nomeDoArquivo; WritelnFileLog(TD_resumo, TD_conteudoResumo); if TD_idNumeroBanco <> '' then begin TD_conteudoResumo:='Referencia do bando:      '+TD_idNumeroBanco; WritelnFileLog(TD_resumo, TD_conteudoResumo); end; if TD_idCodigoBanco <> '' then begin TD_conteudoResumo:='Referencia do Cliente:    '+TD_idCodigoBanco; WritelnFileLog(TD_resumo, TD_conteudoResumo); end; if posicaoBarraSeg <> '' then begin TD_conteudoResumo:='Referencia Barra Segurança:'+posicaoBarraSeg; WritelnFileLog(TD_resumo, TD_conteudoResumo); end; CloseFileLog(TD_resumo); If (TD_relatorios= 1) then begin WritelnFileLog(TD_registro,'*'); CloseFileLog(TD_registro); end; end; end;
{------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------}




