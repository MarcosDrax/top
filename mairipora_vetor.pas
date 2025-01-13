AVS:= 0;
folha:= 0;
ReadLn(S);
DtVenc:='';
    for i:=0 to 11 do begin
        vencimento        := getstring(s,31+(i*5),0);
        DtVenc            := multlineadd(DtVenc,vencimento);
        qtdVetor          := MultLineCount(DtVenc); 
    end;
	//abort(FormatFloat(qtdVetor,'9'));
//<-----------------------------------Script Simplex INI------------------------------------------>
While ReadLn(S) <> EOF do Begin

	//<-----------------------------------variaveis Multiline INI------------------------------------------>
		cadastro            := GetString(S,2,0);
		contribuinte        := GetString(S,7,0);
		inscricao           := GetString(S,4,0);
		responsavel         := GetString(S,8,0);
		endereco            := GetString(S,19,0);
		num_entrega         := GetString(S,20,0);
		bairro_entrega      := GetString(S,22,0);
		cid_entrega         := GetString(S,23,0);
		uf_entrega          := GetString(S,24,0);
		cep_entrega         := GetString(S,25,0);
		num_premiado        := GetString(S,602,0);
		end_imovel          := GetString(S,12,0);
		num_imovel          := GetString(S,13,0);
		bairro_imovel       := GetString(S,15,0);
		//quadra              := GetString(S,265,0);
		//lote                := GetString(S,273,0);
		//area_terreno        := GetString(S,577,0);
		//testada_principal   := GetString(S,586,0);
		//area_edificada      := getfloat(S,594,0);
		AVS                 := AVS+1;
	//<-----------------------------------variaveis Multiline FIM------------------------------------------>

			//Parcelas variaveis		
					BeginPage(PAGE1);
					ClearFields(PAGE1,REC1);
						PAGE1.REC1.CONTRIBUIN      := contribuinte;
						PAGE1.REC1.INSCRIC         := inscricao;
						PAGE1.REC1.IPTU_PREMI      := num_premiado;
						PAGE1.REC1.CADASTRO        := cadastro;
						PAGE1.REC1.AVISO_TOP       := AVS;
						for a:= 0 to 4 do begin
							PAGE1.REC1.DT_UNICA        := TrimStr(getstring(s,31+(a*5),0));
							PAGE1.REC1.LINHA_DIGI      := TrimStr(getstring(s,198+(a*5),0));
							PAGE1.REC1.COD_BARRAS      := TrimStr(getstring(s,195+(a*5),0));
							PAGE1.REC1.PIX             := TrimStr(getstring(s,196+(a*5),0));
						end;
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
			markup();
End;
//<-----------------------------------Script Simplex FIM------------------------------------------>
