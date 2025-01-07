Readln(s);
impr := 0;
close := 0;
linhas :='';
linha_pix:='';
qtdlinhas := 0;
qtd_pix:= 0;
bloco_parc := 330;
bloco_pix := 503;

while true do Begin
	ident        := TrimStr(GetString(S,1,1));
	If (ident = '1') and (impr = 1) then Begin
		cadastro            := GetString(linha_Cad,3,16);
		contribuinte        := GetString(linha_Cad,19,150);
		inscricao           := GetString(linha_Cad,283,17);
		responsavel         := GetString(linha_Cad,300,150);
		endereco            := GetString(linha_Cad,360,50);
		num_entrega         := GetString(linha_Cad,420,6);
		bairro_entrega      := GetString(linha_Cad,427,6);
		cid_entrega         := GetString(linha_Cad,527,40);
		uf_entrega          := GetString(linha_Cad,567,2);
		cep_entrega         := GetString(linha_Cad,569,8);
		num_premiado        := GetString(linha_Cad,602,5);
		end_imovel          := GetString(linha_Cad,169,50);
		num_imovel          := GetString(linha_Cad,219,6);
		bairro_imovel       := GetString(linha_Cad,225,40);
		quadra              := GetString(linha_Cad,265,8);
		lote                := GetString(linha_Cad,273,10);
		area_terreno        := GetString(linha_Cad,577,9);
		testada_principal   := GetString(linha_Cad,586,8);
		area_edificada      := getfloat(linha_Cad,594,8);
		venal_terreno       := getfloat(linha_taxa,19,11);
		venal_predio        := getfloat(linha_taxa,30,11);
		venal_imovel        := getfloat(linha_taxa,41,11);


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
			WriteRecord(PAGE1,REC1);
			EndPage(PAGE1);

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
			WriteRecord(PAGE2,REC1);
			EndPage(PAGE2);

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
				PAGE3.REC1.VV_TERRENO := FormatFloat(venal_terreno,'#.###,##');
				PAGE3.REC1.VV_EDIFICA := FormatFloat(venal_predio,'#.###,##');
				PAGE3.REC1.VV_TOTAL := FormatFloat(venal_imovel,'#.###,##');
				PAGE3.REC1.CADASTRO := cadastro;
				{PAGE3.REC1.VLR_IPU
				PAGE3.REC1.VALOR_ITU
				PAGE3.REC1.VLR_TOTAL
				PAGE3.REC1.TAXAS[1]
				PAGE3.REC1.TAXAS[2]
				PAGE3.REC1.TAXAS[3]
				PAGE3.REC1.TAXAS[4]}
			WriteRecord(PAGE3,REC1);
			EndPage(PAGE3);

			
			BeginPage(PAGE4);
			ClearFields(PAGE4,REC1);
				PAGE4.REC1.CONTRIBUIN      := contribuinte;
				PAGE4.REC1.INSCRIC         := inscricao;
				PAGE4.REC1.IPTU_PREMI:= num_premiado;
				PAGE4.REC1.CADASTRO := cadastro;
				PAGE4.REC1.PIX                      := trimStr(getstring(multlineItem(linha_pix,0),31,200));
			WriteRecord(PAGE4,REC1);
			EndPage(PAGE4);
			c:= 0;
			d:=  0;
			for a:= 0 to qtdlinhas-1 do begin
				for b := 0 to 4  do begin
					BeginPage(PAGE5);
					ClearFields(PAGE5,REC1);
						PAGE5.REC1.CONTRIBUIN      := contribuinte;
						PAGE5.REC1.INSCRIC             := inscricao;
						PAGE5.REC1.IPTU_PREMI      := num_premiado;
						PAGE5.REC1.CADASTRO        := cadastro;
						PAGE5.REC1.DT_UNICA          := FormatDate(getdate(multlineItem(linhas,a),48+(b*bloco_parc),8),'DD/MM/AAAA');
						PAGE5.REC1.LINHA_DIGI        := getstring(multlineItem(linhas,a),259+(b*bloco_parc),55);
								if qtd_pix >= 0 then begin
									if (a = 0) and (b = 0) then begin c := 1; d:= 0;end; // parcela pix 1
									if (a = 0) and (b = 1) then begin c := 1; d:= 1;end; // parcela pix 2
									if (a = 0) and (b = 2) then begin c := 1; d:= 2;end; // parcela pix 3
									if (a = 0) and (b = 3) then begin c := 2; d:= 0;end; // parcela pix 4
									if (a = 0) and (b = 4) then begin c := 2; d:= 1;end; // parcela pix 5
									if (a = 1) and (b = 0) then begin c := 2; d:= 2;end; // parcela pix 6
									if (a = 1) and (b = 1) then begin c := 3; d:= 0;end; // parcela pix 7
									if (a = 1) and (b = 2) then begin c := 3; d:= 1;end; // parcela pix 8
									if (a = 1) and (b = 3) then begin c := 3; d:= 2;end; // parcela pix 9
									if (a = 1) and (b = 4) then begin c := 4; d:= 0;end; // parcela pix 10
									PAGE5.REC1.PIX                      := trimStr(getstring(multlineItem(linha_pix,c),31+(d*bloco_pix),200));
								end;
					WriteRecord(PAGE5,REC1);
					EndPage(PAGE5);
				end;
			end;
		markup;
		linhas         := '';
		linha_pix    :='';
		qtdlinhas   := 0;
		qtd_pix       := 0;
		impr           := 0;
	End;
	
		If ident = '1' then begin
			linha_Cad    := S; 
			impr         := 1;
		End;// linha de cadastro
		
		If ident = '2' then begin
			linha_taxa   := S; 
			impr         := 1;
		End;//linha valores de taxas

		If ident = '3' then begin
			linha_unica  := S; 
			impr         := 1;
		End;//linha parcela única
		
		If ident = '4' then begin
			linhas       := MultLineAdd(linhas,S);
			qtdlinhas    := MultLineCount(linhas);
			impr         := 1;
		End;//linha demais parcelas

		If ident = '9' then begin
			linha_pix    := MultLineAdd(linha_pix,S);
			qtd_pix      := MultLineCount(linha_pix);
			impr         := 1;
		End;//linhas pix única e demais parcelas
		
	if close =  1 then Break;
	if ReadLn(S) = eof then close := 1;
End;
Convert(4,true,false,false,250,false);
