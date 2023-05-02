//PREFEITURA MUNICIPAL DE CUNHA
//EMPRESA: BETHA
//ATULIZAÇÃO: 29/03/2022 - MARCOS
{---SB 5.0 / BARRA_TP_aviso 1.0 ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------char3500} TD_plugin:=0;  x:=0; for i := 0 to 99 do begin  if substr(RetornaNomeArqEntrada(0),i,1) <> '.' then begin  x:= x+1; end else begin break; end; end; TD_nomeDoArquivo := substr(RetornaNomeArqEntrada(0),1,x-1); fls_cx:= 0; n_arq:='';
{----Pré-Configurações---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------}
if post = 1 then begin 	correio := ' - (PAC. CLIENTE).txt';//PREFEITURA MUNICIPAL DE CUNHA
//EMPRESA: BETHA
//ATULIZAÇÃO: 29/03/2022 - MARCOS
{---SB 5.0 / BARRA_TP_aviso 1.0 ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------char3500} TD_plugin:=0;  x:=0; for i := 0 to 99 do begin  if substr(RetornaNomeArqEntrada(0),i,1) <> '.' then begin  x:= x+1; end else begin break; end; end; TD_nomeDoArquivo := substr(RetornaNomeArqEntrada(0),1,x-1); fls_cx:= 0; n_arq:='';
{----Pré-Configurações---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------}


{---Configurações--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------}
    TD_cliente                    := 'P.M.CUNHA'; //Nome parcialmente completo
    TD_tipoImpresso               := 1;      // 1 = Carnes | 2 = Carta/Boletos |
    TD_qtdPorFolha                := 3;      //Quantidade de impresso por folha
    TD_paginaExtra                := 2;      //Quantidade de paginas nao inclusa no visual (contra-capa/encarte/etc)
    TD_folhasPorCaixa             := 1500;   //Quantidade de Folhar por caixa (carnes = 1500 caixa grande / 500 caixa pequena| Envelope 1000 A4 Caixa grande)
    TD_relatorios                 := 0;      // Desativar Relatorio = 0 | Ativar Relatorios = 1 
    TD_seguranca                  := 0;      // Desativa Barra de segurança = 0 | Ativa Barra de segurança = 1
{---Configurações de segurança-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------}
    marcaDaguaNome                := 'P.M.C'; //Marca dagua prefixo do cliente 
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
	AVISO              := FormatNumeric(TP_aviso,'000.000'); //Aviso gerado pelo script, convertido p String.
	inscricao          := TrimStr(GetString(S,27,25));
	cadastro           := TrimStr(GetString(S,9,9));
	zona               := TrimStr(GetString(S,838,30)); 
	name               := TrimStr(GetString(S,52,60));
	compromissario     := TrimStr(GetString(S,0,0));
	Cod_prop           := TrimStr(GetString(S,18,9));
	endereco_entrega   := TrimStr(GetString(S,112,100));
	bairro_entrega     := TrimStr(GetString(S,276,50));
	complemento_entrega:= TrimStr(GetString(S,212,50)); 
	cidade_entrega     := TrimStr(GetString(S,326,50));
	estado_entrega     := TrimStr(GetString(S,376,2));  
	cep_entrega        := SubStr(GetString(S,378,8),1,5) + '-' + SubStr(GetString(S,378,8),6,3);
	rua_imovel         := TrimStr(GetString(S,386,100))+', '+TrimStr(GetString(S,84,6));
	complemento_imovel := TrimStr(GetString(S,486,50));
	bairro_imovel      := TrimStr(GetString(S,536,50));
	cep_imovel         := TrimStr(GetString(S,586,8)); 
	tipo_carne         := TrimStr(GetString(S,868,30));
	quadra             := TrimStr(GetString(S,664,12)); 
	lote               := TrimStr(GetString(S,676,12));
	PARCELAS           := 0;
	
	uf := estado_entrega;
    if uf = '' then begin	UF_ENT_1 := '';
	end  else begin UF_ENT_1  := estado_entrega;end;  
	{---Variaveis comuns Fim---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------}  
IF PARC = 7 then begin
	{---Configurações Referencia do contribuinte no Registro | Barra de TD_registro 3.0 ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------}
	    TD_idArquivo        := GetString(S,9,9);    //Identificação do arquivo maximo ate 12 numeros
	    TD_idNumeroBanco    := GetString(S,1410,8);    //Referencia do Banco
	    TD_idCodigoBanco    := PAGE4.REC1.CAMPO_LIVR;    //Referencia do contribuinte para com o banco (ex: nossonumero)
	    //TD_idExtra          := GetString(S,0,0);   //Identificação extra 
	{--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------}  
	barraDeControle:=''; ctbs:= '0'; ctbi:= '0'; ctbf:= '0'; ctbn:= '0'; ctb := '99'; if ctb = '99' then begin ctbs := '1'; end; ctb2:=random(999)+1; if ctb2 >= 1 then begin ctbi:='1'; end; ctb3:=IntToFloat(random(999))+1.1; if ctb3 >= 1.1 then begin ctbf:='1'; end; ctb4:=IntToNumeric(random(999))+1.0; if ctb4 >= 1.0 then begin ctbn:='1'; end; barraDeControle:=ctbs+ctbi+ctbf+ctbn+StrNumeric(TD_idArquivo,12); barraDeControle := barraDeControle;	TP_numPage:=0; if TD_seguranca = 1 then begin maximoRandom := tamanhoBarraSegurancaRandom; posicaoRandom1 := Random(maximoRandom); if posicaoRandom1 = 0 then begin posicaoRandom1:= 1; end; posicaoRandom2 := Random(maximoRandom); if posicaoRandom2 = 0 then begin posicaoRandom2:= 1; end; posicaoRandom3 := Random(maximoRandom); if posicaoRandom3 = 0 then begin posicaoRandom3:= 1; end; posicaoRandom4 := Random(maximoRandom); if posicaoRandom4 = 0 then begin posicaoRandom4:= 1; end; If (posicaoRandom1 = posicaoRandom2) or (posicaoRandom1 = posicaoRandom3) or (posicaoRandom1 = posicaoRandom4) then begin posicaoRandom1 := posicaoRandom1 + 1; end; If (posicaoRandom2 = posicaoRandom1) or (posicaoRandom2 = posicaoRandom3) or (posicaoRandom2 = posicaoRandom4) then begin posicaoRandom2 := posicaoRandom2 + 1; end; If (posicaoRandom3 = posicaoRandom2) or (posicaoRandom3 = posicaoRandom1) or (posicaoRandom3 = posicaoRandom4) then begin posicaoRandom3 := posicaoRandom3 + 1; end; If (posicaoRandom4 = posicaoRandom2) or (posicaoRandom4 = posicaoRandom1) or (posicaoRandom4 = posicaoRandom3) then begin posicaoRandom4 := posicaoRandom4 + 1; end; marcaDeSeguranca1 := FormatNumeric(Random(tamanhomarcaDeSeguranca),'0000'); marcaDeSeguranca2 := FormatNumeric(Random(tamanhomarcaDeSeguranca),'0000'); marcaDeSeguranca3 := FormatNumeric(Random(tamanhomarcaDeSeguranca),'0000'); marcaDeSeguranca4 := FormatNumeric(Random(tamanhomarcaDeSeguranca),'0000'); barraSeg := ''; for i := 1 to tamanhoBarraSegurancaLooping do begin if i = posicaoRandom1 then begin composicaoBarraSeg := marcaDeSeguranca1 + ' '; end else begin if i = posicaoRandom2 then begin composicaoBarraSeg := marcaDeSeguranca2 + ' '; end else begin if i = posicaoRandom3 then begin composicaoBarraSeg := marcaDeSeguranca3 + ' '; end else begin if i = posicaoRandom4 then begin composicaoBarraSeg := marcaDeSeguranca4 + ' '; end else begin composicaoBarraSeg := marcaDaguaNome + ' '; end; end; end; end; barraSeg := barraSeg + composicaoBarraSeg; end; posicaoBarraSeg := FormatFloat(posicaoRandom1,'9')+'='+marcaDeSeguranca1+'_'+FormatFloat(posicaoRandom2,'9')+'='+marcaDeSeguranca2+'_'+FormatFloat(posicaoRandom3,'9')+'='+marcaDeSeguranca3+'_'+FormatFloat(posicaoRandom4,'9')+'='+marcaDeSeguranca4; end;
	{--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------}
		//Correio
		BeginPage(PAGE1);
		ClearFields(PAGE1,REC1);
			PAGE1.REC1.CBARRA      := barraDeControle;
			PAGE1.REC1.SBARRA	   := barraDeControle;
			PAGE1.REC1.AVISO_1     := GetNumeric(S,0,0);
			PAGE1.REC1.INSCRIC_1   := inscricao;
			PAGE1.REC1.IMOVEL_1    := cadastro;
			PAGE1.REC1.PROPRIET_1  := Cod_prop+' - '+name;
			PAGE1.REC1.COMPROM_1   := compromissario;
			PAGE1.REC1.END_ENT_1   := endereco_entrega;
			PAGE1.REC1.BAIR_ENT_1  := bairro_entrega;
			PAGE1.REC1.COMP_ENT_1  := complemento_entrega;
			PAGE1.REC1.CID_ENT_1   := cidade_entrega;
			PAGE1.REC1.CEP_ENT_1   := cep_entrega;
			PAGE1.REC1.UF_ENT_1    := UF_ENT_1;
			PAGE1.REC1.END_IMOVEL  := rua_imovel;
			PAGE1.REC1.COMPL_IMOV  := complemento_imovel;
			PAGE1.REC1.BAIRRO      := bairro_imovel +' CEP: '+cep_imovel;
			PAGE1.REC1.TIP_CARN_1  := tipo_carne;
			PAGE1.REC1.TOTALQL     := 'QUADRA:' + '  ' + TrimStr(quadra) + '      ' + 'LOTE:' + '  ' + TrimStr(lote);
			PAGE1.REC1.END_1       := TrimStr(endereco_entrega) + '    ' +  TrimStr(bairro_entrega);
			PAGE1.REC1.END_2       := cidade_entrega + 'CEP:' + '' + cep_entrega + '    ' +  PAGE1.REC1.UF_ENT_1;
			PAGE1.REC1.END_3       := rua_imovel + complemento_imovel + bairro_imovel; 
			PAGE1.REC1.AVS:=AVISO;
			PAGE1.REC1.N_ARQUIV:=TD_nomeDoArquivo;
		WriteRecord(PAGE1,REC1);
		EndPage(PAGE1);
		TP_numPage:=TP_numPage+1; //Variavel deve se repetir abaixo de todos os EndPage

		//CAPA
		BeginPage(PAGE2);
		ClearFields(PAGE2,REC1);
			PAGE2.REC1.CBARRA      := barraDeControle;
			PAGE2.REC1.SBARRA	   := barraDeControle;
			PAGE2.REC1.AVISO_1     := GetNumeric(S,0,0);
			PAGE2.REC1.INSCRIC_1   := inscricao;
			PAGE2.REC1.IMOVEL_1    := cadastro;
			PAGE2.REC1.PROPRIET_1  := Cod_prop+' - '+name;
			PAGE2.REC1.COMPROM_1   := compromissario;
			PAGE2.REC1.END_ENT_1   := endereco_entrega;
			PAGE2.REC1.BAIR_ENT_1  := bairro_entrega;
			PAGE2.REC1.COMP_ENT_1  := complemento_entrega;
			PAGE2.REC1.CID_ENT_1   := cidade_entrega;
			PAGE2.REC1.CEP_ENT_1   := cep_entrega;
			PAGE2.REC1.UF_ENT_1    := UF_ENT_1;
			PAGE2.REC1.END_IMOVEL  := rua_imovel;
			PAGE2.REC1.COMPL_IMOV  := complemento_imovel;
			PAGE2.REC1.BAIRRO      := bairro_imovel +' CEP: '+cep_imovel;
			PAGE2.REC1.TIP_CARN_1  := tipo_carne;
			PAGE2.REC1.TOTALQL     := 'QUADRA:' + '  ' + TrimStr(quadra) + '      ' + 'LOTE:' + '  ' + TrimStr(lote);
			PAGE2.REC1.END_1       := TrimStr(endereco_entrega) + '    ' +  TrimStr(bairro_entrega);
			PAGE2.REC1.END_2       := cidade_entrega + 'CEP:' + '' + cep_entrega + '    ' +  PAGE1.REC1.UF_ENT_1;
			PAGE2.REC1.END_3       := rua_imovel + complemento_imovel + bairro_imovel; 
			PAGE2.REC1.AVS:=AVISO;
			PAGE2.REC1.N_ARQUIV:=TD_nomeDoArquivo;
		WriteRecord(PAGE2,REC1);
		EndPage(PAGE2);
		TP_numPage:=TP_numPage+1;

		//DEMOSNTRATIVO
		BeginPage(PAGE3);
		ClearFields(PAGE3,REC1);
			{for i := 1 to QTD_PARC-1 do begin PAGE3.REC1.VL_PARC0_1  := GetFloat(MultLineItem(S,i),216,17)/100;end;}
			cip := GetString(S,1527,25);
			if cip = 'CONTRIB. ILUMINACAO PUBLI' then begin 
				PAGE3.REC1.T_R_LIX0_1 := GetFloat(S,1552,12);
				PAGE3.REC1.CIP_1 := GetFloat(S,2014,12);
				PAGE3.REC1.CIP_2 := GetFloat(S,2014,12);
			end else begin 
				PAGE3.REC1.T_R_LIX0_1  := 0.0;
				PAGE3.REC1.CIP_1  := 0.0;
				PAGE3.REC1.CIP_2  := 0.0;
			end;  
			PAGE3.REC1.COD_PROP    := GetString(S,18,9);
			PAGE3.REC1.ZONA        := zona;
			PAGE3.REC1.INSCRIC_1   := inscricao;
			PAGE3.REC1.ANO_EXE_    := '2023';
			PAGE3.REC1.TIP_CARN_1  := tipo_carne;
			PAGE3.REC1.IMOVEL_1    := cadastro;
			PAGE3.REC1.ENDER_1     := rua_imovel;
			PAGE3.REC1.COMPLEM_1   := complemento_imovel;
			PAGE3.REC1.BAIRRO_1    := bairro_imovel;
			PAGE3.REC1.END_3       := TrimStr(rua_imovel) + ' -  ' +  TrimStr(complemento_imovel) + '    ' + TrimStr(bairro_imovel) + '    ' + cep_imovel; 
			PAGE3.REC1.QUADRA      := quadra;
			PAGE3.REC1.LOTE        := lote;
			PAGE3.REC1.PROPRIET_1  := Cod_prop+' - '+name;
			PAGE3.REC1.FIC_1       := inscricao;
			PAGE3.REC1.TESTADA_1   := GetFloat(S,808,30);
			PAGE3.REC1.VNAL_TER_1  := GetFloat(S,748,30);
			PAGE3.REC1.VNAL_CONS_  := GetFloat(S,1048,30);
			PAGE3.REC1.VNAL_IMO_1  := GetFloat(S,778,30);
			PAGE3.REC1.AREA_TER_1  := GetFloat(S,688,30);
			PAGE3.REC1.A_T_CONS_1  := GetFloat(S,1078,30);	   
			{PAGE3.REC1.VENCTO0_1   := GetDate(S,1410,8);
			PAGE3.REC1.VENCTO1_1   := GetDate(S,1872,8);
			PAGE3.REC1.VENCTO2_1   := GetDate(S,2334,8);
			PAGE3.REC1.VENCTO3_1   := GetDate(S,2796,8);
			PAGE3.REC1.VENCTO4_1   := GetDate(S,3258,8);
			PAGE3.REC1.VENCTO5_1   := GetDate(S,3720,8);
			PAGE3.REC1.VENCTO6_1   := GetDate(S,4182,8);
			PAGE3.REC1.VENCTO7_1   := GetDate(S,4644,8);
			PAGE3.REC1.VENCTO8_1   := GetDate(S,5106,8);
			PAGE3.REC1.VENCTO9_1   := GetDate(S,5568,8);
			PAGE3.REC1.VENCTO10_1  := GetDate(S,6030,8);}
			PAGE3.REC1.CAT_EDIFIC  := GetString(S,1168,30);
			PAGE3.REC1.VL_PARC0_1  := GetFloat(S,2342,12);
			PAGE3.REC1.1_PARCELA   := GetFloat(S,1880,12);
			PAGE3.REC1.VL_PSD0_1   := GetFloat(S,1503,12)+GetFloat(S,1552,12)+GetFloat(S,1601,12)+GetFloat(S,1650,12);
			PAGE3.REC1.PR_DES_1    := GetFloat(S,1418,12);       
			PAGE3.REC1.VL_PARCDES  := (GetFloat(S,1503,12)+GetFloat(S,1552,12)+GetFloat(S,1601,12)+GetFloat(S,1650,12)) - GetFloat(S,1418,12);	   
			PAGE3.REC1.TRIBUT_1    := GetFloat(S,1503,12);
			PAGE3.REC1.TRIBUT_2    := GetFloat(S,1552,12);
			PAGE3.REC1.TRIBUT_3  := GetFloat(S,1601,12);
			PAGE3.REC1.ISENCAO   := GetString(S,1138,30);
			PAGE3.REC1.CND     := GetString(S,868,30);
			PAGE3.REC1.ESQUINA   := GetString(S,718,30);	
			PAGE3.REC1.PADRAO   := GetString(S,1108,30);
			PAGE3.REC1.AVS:=AVISO;
			PAGE3.REC1.N_ARQUIV:=TD_nomeDoArquivo;	   
		WriteRecord(PAGE3,REC1);
		EndPage(PAGE3);
		TP_numPage:=TP_numPage+1;


		//PARCELAS UNICA
		BeginPage(PAGE4);
		ClearFields(PAGE4,REC1);
			COD   := TrimStr(GetString(S,1430,48));
			//LIVRE :=  TrimStr(GetString(S,1430,48));
			PAGE4.REC1.ZONA        := zona;
			PAGE4.REC1.TIP_CARN_1  := tipo_carne;          
			PAGE4.REC1.PROPRIET_1  := Cod_prop+' - '+name;
			PAGE4.REC1.COMPROM_1   := compromissario;
			PAGE4.REC1.INSCRIC_1   := inscricao;
			PAGE4.REC1.VL_PARCDES  := GetFloat(S,199,17)/100;
			PAGE4.REC1.PARCELA0_1  := 'Ùnica';
			PAGE4.REC1.IMOVEL_1    := cadastro;
			PAGE4.REC1.QUADRA      := quadra;
			PAGE4.REC1.LOTE        := lote;
			PAGE4.REC1.VL_PARC0_1  := GetFloat(S,1418,12);	
			PAGE4.REC1.VENCTO0_1   := GetDate(S,1410,8);
			PAGE4.REC1.BARRA       := GetString(S,1430,47);
			PAGE4.REC1.VL_PSD0_1   := GetFloat(S,1503,12)+GetFloat(S,1552,12)+GetFloat(S,1601,12)+GetFloat(S,1650,12);
			PAGE4.REC1.VL_PARCDES  := (GetFloat(S,1503,12)+GetFloat(S,1552,12)+GetFloat(S,1601,12)+GetFloat(S,1650,12)) - GetFloat(S,1418,12);	   
			PAGE4.REC1.LINHA0_1    := SubStr(COD,1,5)+'.'+SubStr(COD,6,5)+' '+SubStr(COD,11,5)+'.'+SubStr(COD,16,6)+' '+SubStr(COD,22,5)+'.'+SubStr(COD,27,6)+' '+SubStr(COD,33,1)+' '+SubStr(COD,34,14);
			PAGE4.REC1.TRIBUT_1    := GetFloat(S,1503,12);
			PAGE4.REC1.TRIBUTO_1   := GetString(S,1478,25);
			PAGE4.REC1.TRIBUT_2    := GetFloat(S,1552,12);
			PAGE4.REC1.TRIBUTO_2   := GetString(S,1527,25);
			PAGE4.REC1.TRIBUT_3  := GetFloat(S,1601,12);
			PAGE4.REC1.TRIBUTO_3   := GetString(S,1576,25);
			PAGE4.REC1.TRIBUT_4   := GetFloat(S,1650,12);
			PAGE4.REC1.TRIBUTO_4   := GetString(S,1625,25);	   	   
			{PAGE4.REC1.IP          := GetString(MultLineItem(S,0),233,1);
			PAGE4.REC1.IS          := GetString(MultLineItem(S,0),234,1);
			PAGE4.REC1.IDT         := GetString(MultLineItem(S,0),235,1);}
			PAGE4.REC1.CPF_CNPJ    := GetString(S,7604,14);
			PAGE4.REC1.CAMPO_LIVR  := SubStr(COD,13,3)+SubStr(COD,17,3)+SubStr(COD,22,9);
			PAGE4.REC1.END_3       := TrimStr(rua_imovel) + ' -  ' +  TrimStr(complemento_imovel) + '    ' + TrimStr(bairro_imovel) + '    ' + cep_imovel; 
			PAGE4.REC1.AVS:=AVISO;
			PAGE4.REC1.N_ARQUIV:=TD_nomeDoArquivo; 
		WriteRecord(PAGE4,REC1);
		EndPage(PAGE4);
		TP_numPage:=TP_numPage+1;
			   
		//PARCELAS 
		For i := 0 to 7 do Begin 
			BeginPage(PAGE5);
			ClearFields(PAGE5,REC1);	
				COD                    := TrimStr(GetString(S,1892+(i*462),48));  
				PAGE5.REC1.ZONA        := zona;
				PAGE5.REC1.TIP_CARN_1  := tipo_carne; 
				PAGE5.REC1.PROPRIET_1  := Cod_prop+' - '+name;
				PAGE5.REC1.COMPROM_1   := '';
				PAGE5.REC1.INSCRIC_1   := inscricao;
				PAGE5.REC1.PARCELA0_1  := GetString(S,1870+(i*462),2);
				PAGE5.REC1.IMOVEL_1    := cadastro;
				PAGE5.REC1.QUADRA      := quadra;
				PAGE5.REC1.LOTE        := lote;
				PAGE5.REC1.VL_PARC0_1  := GetFloat(S,1880+(i*462),12);		 
				PAGE5.REC1.VENCTO0_1   := GetDate(S,1872+(i*462),8);
				PAGE5.REC1.VL_PSD0_1   := GetFloat(S,1965+(i*462),12)+GetFloat(S,2014+(i*462),12)+GetFloat(S,2063+(i*462),12)+GetFloat(S,2112+(i*462),12);
				PAGE5.REC1.BARRA       := GetString(S,1892+(i*462),47);
				PAGE5.REC1.LINHA0_1    := SubStr(COD,1,5)+'.'+SubStr(COD,6,5)+' '+SubStr(COD,11,5)+'.'+SubStr(COD,16,6)+' '+SubStr(COD,22,5)+'.'+SubStr(COD,27,6)+' '+SubStr(COD,33,1)+' '+SubStr(COD,34,14);
				PAGE5.REC1.TX_EXP0_1   := GetFloat(S,1965+(i*462),12);
				PAGE5.REC1.TRIBUTO_1   := GetString(S,1940,25);	   
				PAGE5.REC1.TRIBUT_1    := GetFloat(S,1965+(i*462),12);
				PAGE5.REC1.TRIBUTO_2   := GetString(S,1989,25);		   
				PAGE5.REC1.TRIBUT_2    := GetFloat(S,2014+(i*462),12);
				PAGE5.REC1.TRIBUTO_3   := GetString(S,2038,25);		   
				PAGE5.REC1.TRIBUT_3    := GetFloat(S,2063+(i*462),12);
				PAGE5.REC1.TRIBUTO_4   := GetString(S,2087,25); 		   
				PAGE5.REC1.TRIBUT_4    := GetFloat(S,2112+(i*462),12);	 		 
				{PAGE5.REC1.IP          := GetString(MultLineItem(S,i),233,1);
				PAGE5.REC1.IS          := GetString(MultLineItem(S,i),234,1);
				PAGE5.REC1.IDT         := GetString(MultLineItem(S,i),235,1);}
				PAGE5.REC1.CPF_CNPJ    := GetString(S,7604,14);
				PAGE5.REC1.CAMPO_LIVR  := SubStr(COD,13,3)+SubStr(COD,17,3)+SubStr(COD,22,9);
				PAGE5.REC1.END_3       := TrimStr(rua_imovel) + ' -  ' +  TrimStr(complemento_imovel) + '    ' + TrimStr(bairro_imovel) + '    ' + cep_imovel; 
				PAGE5.REC1.AVS:=AVISO;
				PAGE5.REC1.N_ARQUIV:=TD_nomeDoArquivo;
			WriteRecord(PAGE5,REC1);
			EndPage(PAGE5);
			TP_numPage:=TP_numPage+1;
		end;

		//CONTRA CAPA 
		   
		BeginPage(PAGE6);
		ClearFields(PAGE6,REC1);	
			PAGE6.REC1.AVS:=AVISO;
			PAGE6.REC1.N_ARQUIV:=TD_nomeDoArquivo;	   
		WriteRecord(PAGE6,REC1);
		EndPage(PAGE6);
		TP_numPage:=TP_numPage+1;
		
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
