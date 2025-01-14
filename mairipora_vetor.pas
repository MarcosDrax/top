Readln(s);
AVS:= 0;
folha:= 0;
DtVenc:='';
CodBarra:= '';
LInhaDigit:='';
LInhaPix := '';
option := 0;
	//<-----------------------------------Condição por Seleção de Lote------------------------------------------>
    IF trimStr(getstring(s,190,0)) = 'CORREIO'  then begin option := 1; end;
	IF trimStr(getstring(s,190,0)) = 'FISCAL'  then begin option := 2; end;
	IF trimStr(getstring(s,190,0)) = 'NAO ENVIAR'  then begin option := 3; end;
	IF trimStr(getstring(s,190,0)) = 'REMANESCENTE'  then begin option := 4; end;
	IF trimStr(getstring(s,190,0)) = 'REMANESCENTE'  then begin option := 5; end;
	//<-----------------------------------variaveis Multiline INI------------------------------------------>
//<-----------------------------------Script Simplex INI------------------------------------------>
While ReadLn(S) <> EOF do Begin
		//<-----------------------------------variaveis Vetor------------------------------------------>
		for i:= 0 to 11 do begin
			IF trimStr(getstring(s,31+(i*5),0)) <> '' then begin
				vencimento        := getstring(s,31+(i+5),0);        DtVenc            := multlineadd(DtVenc,vencimento);
				barra             := getstring(s,195+(i+5),0);       CodBarra          := multlineadd(CodBarra,barra);
				linha             := getstring(s,198+(i+5),0);       LinhaDigit        := multlineadd(LinhaDigit,linha);
				pix               := getstring(s,196+(i+5),0);       LInhaPix          := multlineadd(LInhaPix,pix);
			end else begin
				break;
			end;
		end;
		qtdVenc    := MultLineCount(DtVenc); 
		qtdBarra   := MultLineCount(CodBarra); 
		qtdDigit   := MultLineCount(LinhaDigit); 
		qtdpix     := MultLineCount(LInhaPix); 
		//<-----------------------------------variaveis Multiline INI------------------------------------------>
		AVS                 := AVS+1;
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
		//<-----------------------------------variaveis Multiline FIM------------------------------------------>
 		If LOTE = option then Begin
			//Parcelas variaveis		
					BeginPage(PAGE1);
					ClearFields(PAGE1,REC1);
						PAGE1.REC1.CONTRIBUIN      := contribuinte;
						PAGE1.REC1.INSCRIC         := inscricao;
						PAGE1.REC1.IPTU_PREMI      := num_premiado;
						PAGE1.REC1.CADASTRO        := cadastro;
						PAGE1.REC1.AVISO_TOP       := AVS;
						for a:= 0 to 4 do begin
							PAGE1.REC1.DT_UNICA        := DtVenc;
							PAGE1.REC1.LINHA_DIGI      := LinhaDigit;
							PAGE1.REC1.COD_BARRAS      := CodBarra;
							PAGE1.REC1.PIX             := LinhaPix;
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
		End;
			markup();
end;
//<-----------------------------------Script Simplex FIM------------------------------------------>
