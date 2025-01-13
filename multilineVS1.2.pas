//<-----------------------------------Script Padrão Variaveis INI------------------------------------------>
{Criar um script que exiba um relatorio com o registro que estara em cada caixa e o numero da caixa, mais a quantidade total por caixa e a quantidade total do arquivo. 
 
- Todos devem estar por profundidade(OK), 
- não usar o script padrao, criar do zero. 
- Fazer logica que separa quantidades por caixa(OK)}
AVS := 0;
CaixaAvs :=0;
qtdcarne := 3;
totFls := 0;
flsCaixa := 1500; 
sep:= ';';
//<-----------------------------------Script Padrão Variaveis FIM------------------------------------------>
//<-----------------------------------variaveis Multiline INI------------------------------------------>
Readln(s);
impr := 0;
close := 0;
linha_parc  :='';
linhas_trib13 :='';
linhas_trib14 :='';
qtdlinhas := 0;
qtdlinhas1  := 0;
qtd_pix:= 0;
bloco_parc := 330;
bloco_pix := 503;
logTopdata      := CreateFileLog('Arquivo_RelatorioListagem.txt');
//<-----------------------------------Script Multiline INI------------------------------------------>
while true do Begin
folha := 0;
CxLote:=0;
	ident        := TrimStr(GetString(S,1,4));
	If (ident = 'D100') and (impr = 1) then Begin
	
	//<-----------------------------------variaveis Multiline INI------------------------------------------>
		cadastro            := GetString(linha_Cad11,21,12);
		contribuinte        := GetString(linha_Cad11,49,64);
		inscricao           := GetString(linha_Cad10,31,21);
		responsavel         := GetString(linha_Cad11,49,64);
		endereco            := GetString(linha_Cad10,360,50);
		num_entrega         := GetString(linha_Cad10,420,6);
		bairro_entrega      := GetString(linha_Cad10,427,6);
		cid_entrega         := GetString(linha_Cad10,527,40);
		uf_entrega          := GetString(linha_Cad10,567,2);
		cep_entrega         := GetString(linha_Cad10,569,8);
		num_premiado        := GetString(linha_Cad10,602,5);
		end_imovel          := GetString(linha_Cad10,169,50);
		num_imovel          := GetString(linha_Cad10,219,6);
		bairro_imovel       := GetString(linha_Cad10,225,40);
		quadra              := GetString(linha_Cad10,265,8);
		lote                := GetString(linha_Cad10,273,10);
		area_terreno        := GetString(linha_Cad10,577,9);
		testada_principal   := GetString(linha_Cad10,586,8);
		area_edificada      := getfloat(linha_Cad10,594,8);
		{venal_terreno       := getfloat(linha_taxa,19,11);
		venal_predio        := getfloat(linha_taxa,30,11);
		venal_imovel        := getfloat(linha_taxa,41,11);}
	//<-----------------------------------variaveis Multiline FIM------------------------------------------>
		if PARCELA = qtd_pix then begin
			AVS := AVS+1;
			//demonstrativo de entrega
			BeginPage(PAGE1);
			ClearFields(PAGE1,REC1);
				PAGE1.REC1.CONTRIBUIN      := contribuinte;
				PAGE1.REC1.INSCRIC         := cadastro;
				PAGE1.REC1.RESPONSAVE      := responsavel;
				PAGE1.REC1.PREMIADO        := num_premiado;
				PAGE1.REC1.ENDERECO[1]     := endereco+' '+num_entrega;
				PAGE1.REC1.ENDERECO[2]     := bairro_entrega+' '+num_entrega;
				PAGE1.REC1.ENDERECO[3]     := cid_entrega+' '+uf_entrega;
				PAGE1.REC1.ENDERECO[4]     := SubStr(cep_entrega,1,5)+'-'+SubStr(cep_entrega,6,3);
				PAGE1.REC1.AVISO_TOP          := AVS;
			WriteRecord(PAGE1,REC1);
			EndPage(PAGE1);
			folha := folha+1;
			
			//demonstrativo de entrega
			BeginPage(PAGE2);
			ClearFields(PAGE2,REC1);
				PAGE2.REC1.CONTRIBUIN      := contribuinte;
				PAGE2.REC1.INSCRIC         := cadastro;
				PAGE2.REC1.RESPONSAVE      := responsavel;
				PAGE2.REC1.PREMIADO        := num_premiado;
				PAGE2.REC1.ENDERECO[1]     := endereco+' '+num_entrega;
				PAGE2.REC1.ENDERECO[2]     := bairro_entrega+' '+num_entrega;
				PAGE2.REC1.ENDERECO[3]     := cid_entrega+' '+uf_entrega;
				PAGE2.REC1.ENDERECO[4]     := SubStr(cep_entrega,1,5)+'-'+SubStr(cep_entrega,6,3);
				PAGE2.REC1.AVISO_TOP          := AVS;
			WriteRecord(PAGE2,REC1);
			EndPage(PAGE2);
			folha := folha+1;
			
			BeginPage(PAGE3);
			ClearFields(PAGE3,REC1);
				PAGE3.REC1.CONTRIBUIN      := contribuinte;
				PAGE3.REC1.INSCRIC         := inscricao;
				PAGE3.REC1.IPTU_PREMI:= num_premiado;
				PAGE3.REC1.END_IMOVEL[1]     := end_imovel+' '+num_imovel;
				PAGE3.REC1.END_IMOVEL[2]     := bairro_imovel+' '+num_entrega;
				PAGE3.REC1.QUADRA := quadra;
				PAGE3.REC1.LOTE := lote;
				PAGE3.REC1.AR_TERRENO:= area_terreno;
				PAGE3.REC1.TESTADA:= testada_principal;
				PAGE3.REC1.AR_CONSTRU:= FormatFloat(area_edificada,'#.###,##');
				{PAGE3.REC1.VV_TERRENO := FormatFloat(venal_terreno,'#.###,##');
				PAGE3.REC1.VV_EDIFICA := FormatFloat(venal_predio,'#.###,##');
				PAGE3.REC1.VV_TOTAL := FormatFloat(venal_imovel,'#.###,##');}
				PAGE3.REC1.CADASTRO := cadastro;
				PAGE3.REC1.AVISO_TOP          := AVS;
			WriteRecord(PAGE3,REC1);
			EndPage(PAGE3);
			folha := folha+1;		
		
			for a:= 0 to qtd_pix-1 do begin
					BeginPage(PAGE4);
					ClearFields(PAGE4,REC1);
					if ((getString(multlineItem(linha_parc,0),21,10) =  '16/09/2024') and (getString(multlineItem(linha_parc,1),21,10) =  '16/10/2024'))then Begin
						parc:=parc+1;
						PAGE4.REC1.PARCELA         := 'Unica' + FormatFloat(parc,'9');
						end;
						PAGE4.REC1.PARCELA         := getString(multlineItem(linha_parc,a),31,1);
						PAGE4.REC1.CONTRIBUIN      := contribuinte;
						PAGE4.REC1.INSCRIC         := inscricao;
						PAGE4.REC1.IPTU_PREMI      := num_premiado;
						PAGE4.REC1.CADASTRO        := cadastro;
						PAGE4.REC1.DT_UNICA        := getString(multlineItem(linha_parc,a),21,10);
						PAGE4.REC1.LINHA_DIGI      := getstring(multlineItem(linha_parc,a),100,79);
						PAGE4.REC1.AVISO_TOP       := AVS;
						PAGE4.REC1.COD_BARRAS      := trimStr(getstring(multlineItem(linha_parc,a),56,200));
					WriteRecord(PAGE4,REC1);
					EndPage(PAGE4);
					folha := folha+1;
			end;
			
			BeginPage(PAGE6);
			ClearFields(PAGE6,REC1);
				PAGE6.REC1.CONTRIBUIN      := contribuinte;
				PAGE6.REC1.INSCRIC         := inscricao;
				PAGE6.REC1.AVISO_TOP          := AVS;
			WriteRecord(PAGE6,REC1);
			EndPage(PAGE6);
			folha := folha+1;
		end;	
		totFls:= folha; {folhas do miolo do carnê}
		CaixaAvs:= CaixaAvs+1;
		markup;
		//abort(FormatFloat(qtd_pix,'9'));
		linha_parc   :='';
		linhas_trib13:='';
		linhas_trib14:='';
		qtdlinhas   := 0;
		qtdlinhas1  := 0;
		qtd_pix     := 0;
		impr        := 0;
	End;
	
		If ident = 'D100' then begin
			linha_Cad10    := S; 
			impr         := 1;
		End;// linha de cadastro

		If ident = 'D110' then begin
			linha_Cad11    := S; 
			impr         := 1;
		End;// linha de cadastro

		If ident = 'D120' then begin
			linha_Cad12   := S; 
			impr         := 1;
		End;//linha valores de taxas

		If ident = 'D130' then begin
			linhas_trib13:= MultLineAdd(linhas_trib13,S);
			qtdlinhas    := MultLineCount(linhas_trib13);
			impr         := 1;
		End;//linha demais Tributos

		If ident = 'D141' then begin
			linhas_trib14:= MultLineAdd(linhas_trib13,S);
			qtdlinhas1    := MultLineCount(linhas_trib13);
			impr         := 1;
		End;//linha demais Tributos

		If ident = 'D210' then begin
			linha_parc   := MultLineAdd(linha_parc,S);
			qtd_pix      := MultLineCount(linha_parc);
			impr         := 1;
		End;//linhas pix única e demais parcelas		

		If ident = 'D200' then begin
			linha_Debito := S; 
			impr         := 1;
		End;//linha Débito

		If ident = 'D300' then begin
			linha_Cad30  := S; 
			impr         := 1;
		End;//linha Débito		

		If ident = 'D310' then begin
			linha_Cad31  := S; 
			impr         := 1;
		End;//linha Inscrição

	if close =  1 then Break;
	if ReadLn(S) = eof then close := 1;
End;
		//condição para numeração das caixas por lote
		{if  CaixaAvs = qtd_caixa then Begin 
			CxLote:=CxLote+1;
		end;
		CaixaAvs := 1;}
		
Resumo_logTopdata      := CreateFileLog('Arquivo_ResumoLog.txt');
qtd_caixa:= Ceil(flsCaixa / qtdcarne); {Quantidade de registros por Caixa}
qtdColun:= Ceil(qtd_caixa/qtdcarne); {Quantidade de registros por Coluna}
CaixaFls:= (qtdColun*totFls); {Quantidade de Folhas por Caixa}
Num_caixa:= Ceil(AVS/qtd_caixa); {Quantidade de Caixa}

Ln:= #13#10;
resumo:= '   '+ Ln +
' - Informação Geral '+ ln  +
'Número de Registros: '+FormatFloat(AVS,'#####')+ln +
'Quantidade de Caixa: '+FormatFloat(Num_caixa,'#####')+ln +
' - Informações Do Lote '+ln +
'Quantidade de Registro por Caixa: '+FormatFloat(qtd_caixa,'#####')+ln +
'Quantidade de Registro por Coluna: '+FormatFloat(qtdColun,'#####')+ln +
'Quantidade de Folhas por Caixa: '+FormatFloat(CaixaFls,'#####')+ln +
' '+  ln; 

		WritelnFileLog(logTopdata,FormatFloat(CxLote,'9')+sep+FormatNumeric(AVS,'000.000')+sep+cadastro);
		CloseFileLog(logTopdata);
		
		WritelnFileLog(Resumo_logTopdata, resumo);
		CloseFileLog(Resumo_logTopdata);
Convert(qtdcarne,true,false,false,qtd_caixa,false);
