{---SB 4.0 --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------} plg:=0;
ReadLn(s);
If IMPRE = 1 then begin tipoimpr := 'I'; end;
If IMPRE = 2 then begin tipoimpr := 'C'; end;
//--Extra----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- 
	cliente   := 'P.M.GUARAREMA '+FormatFloat(PARC,'9')+tipoimpr; //Nome parcialmente completo
	tp_imp    := 1;      // 1 = Carnes | 2 = Carta/Boletos |
	carne_fls := 3;      //Quantidade de carnes por folha
	page_ex   := 2;      //Quantidade de paginas nao inclusa no visual (contra-capa/encarte/etc)
	fls_cx    := 1500;   //Quantidade de Folhar por caixa (carnes = 1500 caixa grande / 500 caixa pequena| Envelope 1000 A4 Caixa grande)
	relat     := 1;     //Ativo 2 Relatorios = 0 | Desativar Relatorio = 1 | Ativo Resumo = 2 | Ativo Controle Barra = 3 | 
//--Plugins Ini-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
{Plugin - BARRA_AVS 1.0 = EXTRAI NOME DO ARQUIVO DE ENTRADA E SALVA EM N_ARQ EX:P02DDMMAAHHMM} x:=0; for i := 0 to 99 do begin  if substr(RetornaNomeArqEntrada(0),i,1) <> '.' then begin  x:= x+1; end else begin break; end; end; n_arq := substr(RetornaNomeArqEntrada(0),1,x-1);

//RLT := CreateFileLog('TOTAL_CONTRIBUINTE'+n_arq+'.txt');
//--Plugins Fim-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
//--Relatorios 3.1--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
If relat <> 1 then begin If (relat = 0) then begin relatorio:= CreateFileLog('Resumo_'+cliente+'_'+SubStr(StrNumeric(FormatTime(SYS_TIME,'HH:MM'),4),1,4)+'_'+RetornaNomeArqEntrada(0)); Conteudo:=cliente; 	WritelnFileLog(relatorio,conteudo);	controle:= CreateFileLog('Relatorio_IDBarra_'+cliente+'_'+SubStr(StrNumeric(FormatTime(SYS_TIME,'HH:MM'),4),1,4)+'_'+RetornaNomeArqEntrada(0)); idbarra:='0;'+cliente+';'+FormatDate(SYS_DATE,'DD/MM/AAAA')+';'+SubStr(StrNumeric(FormatTime(SYS_TIME,'HH:MM'),4),1,2)+':'+SubStr(StrNumeric(FormatTime(SYS_TIME,'HH:MM'),4),3,2);	WritelnFileLog(controle,idbarra); end; If (relat = 2) then begin relatorio:= CreateFileLog('Resumo_'+cliente+'_'+SubStr(StrNumeric(FormatTime(SYS_TIME,'HH:MM'),4),1,4)+'_'+RetornaNomeArqEntrada(0)); Conteudo:=cliente; 	WritelnFileLog(relatorio,conteudo);	end; If (relat = 3) then begin controle:= CreateFileLog('Relatorio_IDBarra_'+cliente+'_'+SubStr(StrNumeric(FormatTime(SYS_TIME,'HH:MM'),4),1,4)+'_'+RetornaNomeArqEntrada(0)); idbarra:='0;'+cliente+';'+FormatDate(SYS_DATE,'DD/MM/AAAA')+';'+SubStr(StrNumeric(FormatTime(SYS_TIME,'HH:MM'),4),1,2)+':'+SubStr(StrNumeric(FormatTime(SYS_TIME,'HH:MM'),4),3,2);	WritelnFileLog(controle,idbarra); end; If relat > 3 then begin	abort('RELATORIO - VALOR INFORMADO INVALIDO');	end; NContrib:=0; nlt:=0;	end; npgc:=1;AVS:=1; 
//--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
//--------Variaveis Global Ini-------- 

P                 := '';
ID_LINHA_ATUAL    := '';
ID_LINHA_ANTERIOR := '';
PRINT             := 0;
PCL               := 0;
//ERRO_POS          := 0;
XFG                 := 0;
PR        := 0;
//--------Variaveis Global Fim-------- 
while true do Begin
//Var Idenficadora de cada contribuinte 
ID_LINHA_ATUAL := Trimstr(GetString(S,500,24));

	If (ID_LINHA_ATUAL <> ID_LINHA_ANTERIOR) and (PRINT = 1) then begin

		


		//--------Variaveis comuns--------  
		LINHA1            := '';
		LINHA2            := '';
	 	AVISO             := FormatNumeric(AVS,'000.000'); //Aviso gerado pelo script, convertido p String.
	{ 	
	 	//CONDICAO RECUA UMA POSIÇÃO DE TODOS OS CAMPOS ( ARQUIVO ERRADO)
	 	If GetString(S,499,1) <> ' ' then Begin
	 		ERRO_POS := 1;
	 		PR        := -1;
	 		end else begin
	 		ERRO_POS := 0;
	 		PR        := 0;
	 	end;
}
	 	POS_ID            := 839+PR;
	 	ID                := TrimStr(GetString(MultLineItem(P,0),POS_ID,12));
	 	POS_PARCELA       := 851+PR;

	 	If LINHAS = 1 then begin
	 		If ID = '0' then Begin
	 			LINHA1    := MultLineItem(P,0);
	 			LINHA2    := MultLineItem(P,0);
		 		TIPO      := 'BOMBEIRO_S';
		 		IMPR      := 1;
		 		PCL       := 0;
	 		end; 
			If ID = 'ÚNICA' then Begin
				LINHA1    := MultLineItem(P,0);
	 			LINHA2    := MultLineItem(P,0);
				TIPO      := 'UNICA_S';
				IMPR      := 2;
				for i := 0 to 9 do begin If TrimStr(GetString(MultLineItem(P,0),POS_PARCELA+(i*13),13)) <> '' then begin PCL := PCL + 1;	end else begin 	break; end; end;
			end;	
		end;
		If LINHAS = 2 then begin
			If ID = '0' then Begin
				LINHA1    := MultLineItem(P,0);
	 			LINHA2    := MultLineItem(P,1);
				TIPO      := GetString(LINHA2,POS_ID,5);
				IMPR      := 3;
				for i := 0 to 9 do begin If TrimStr(GetString(MultLineItem(P,1),POS_PARCELA+(i*13),13)) <> '' then begin PCL := PCL + 1;	end else begin 	break; end; end;
			end;
			If ID = 'ÚNICA' then Begin
				LINHA1    := MultLineItem(P,1);
	 			LINHA2    := MultLineItem(P,0);
				TIPO      := GetString(LINHA1,POS_ID,5);
				IMPR      := 3;
				for i := 0 to 9 do begin If TrimStr(GetString(MultLineItem(P,0),POS_PARCELA+(i*13),13)) <> '' then begin PCL := PCL + 1;	end else begin 	break; end; end;
			end;
		end;


		
		// CALCULO CEPNET
		POS_CEPNET  := 1537+PR; //POSIÇÃO CEP
		VLR_CEPNET  := 0.0;
		For i := 0 to 7 do Begin
			VLR_CEPNET := GetFloat(LINHA2,POS_CEPNET+i,1) + VLR_CEPNET;
		end;
		CEPNET     := 0.0;
		If VLR_CEPNET <= 10 then Begin CEPNET := 10 - VLR_CEPNET; end;
		If (VLR_CEPNET > 10) and (VLR_CEPNET <= 20) then Begin CEPNET := 20 - VLR_CEPNET; end;
		If (VLR_CEPNET > 20) and (VLR_CEPNET <= 30) then Begin CEPNET := 30 - VLR_CEPNET; end;
		If (VLR_CEPNET > 30) and (VLR_CEPNET <= 40) then Begin CEPNET := 40 - VLR_CEPNET; end;
		If (VLR_CEPNET > 40) and (VLR_CEPNET <= 50) then Begin CEPNET := 50 - VLR_CEPNET; end;
		If (VLR_CEPNET > 50) and (VLR_CEPNET <= 60) then Begin CEPNET := 60 - VLR_CEPNET; end;
		If (VLR_CEPNET > 60) and (VLR_CEPNET <= 70) then Begin CEPNET := 70 - VLR_CEPNET; end;
		If (VLR_CEPNET > 70) and (VLR_CEPNET <= 80) then Begin CEPNET := 80 - VLR_CEPNET; end; 
		If (VLR_CEPNET > 80) and (VLR_CEPNET <= 90) then Begin CEPNET := 90 - VLR_CEPNET; end; 
		CAMPO_CEPNET := '/'+GetString(LINHA2,POS_CEPNET,8)+FormatFloat(CEPNET,'9')+'\';
		//CEPNET_MOD := 0.0;
		//CEPNET_MOD := (((FloatToInt(VLR_CEPNET) mod 10)*10) - VLR_CEPNET) - 10;


		PROP              := TrimStr(GetString(LINHA2,1,61));
		COMPR             := TrimStr(GetString(LINHA2,62,61));
		E_LOGR            := TrimStr(GetString(LINHA2,312,81+PR));
		E_NUME            := TrimStr(GetString(LINHA2,393+PR,5));
		E_BAIR            := TrimStr(GetString(LINHA2,405+PR,31));
		E_COMP            := TrimStr(GetString(LINHA2,1506+PR,31));
		E_CIDA            := TrimStr(GetString(LINHA2,436+PR,61));
		E_UF              := TrimStr(GetString(LINHA2,497+PR,3));
		E_CEP             := SubStr(GetString(LINHA2,POS_CEPNET,9),1,5)+'-'+SubStr(GetString(LINHA2,POS_CEPNET,9),6,3);
		I_LOGR            := TrimStr(GetString(LINHA2,123,81));
		I_NUME            := TrimStr(GetString(LINHA2,204,6));
		I_BAIR            := TrimStr(GetString(LINHA2,217,31));
		I_COMP            := TrimStr(GetString(LINHA2,799+PR,31));
		MSG               := TrimStr(GetString(LINHA2,3052+PR,37));
		INSC              := TrimStr(GetString(LINHA2,500+PR,23));
		LT                := TrimStr(GetString(LINHA2,1643+PR,31));
		QR                := TrimStr(GetString(LINHA2,581+PR,31));
		LTMENT            := TrimStr(GetString(LINHA2,693+PR,61));

{
		XFG:= XFG+1;
		WritelnFileLog(RLT,FormatFloat(PCL,'9')+'|'+INSC+'|'+PROP);
}


		IF (PARC = PCL) and (IMPRE = LINHAS) then begin
			//--------Variaveis comuns Fim--------
			//-----Barra de controle 2.0----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
			//Referencia do contribuinte contendo 
			//**********************************// 
			//**                                //
			idb:=     GetString(P,1566+PR,7);         //ate 12 numeros
			ifex:=    GetString(P,0,0);          // Informaçao extra 
			//**                                // 
			//**********************************//
			barracontroleit:='';	ctbs:= '0';	ctbi:= '0';	ctbf:= '0';	ctbn:= '0';	ctb := '99'; if ctb = '99' then begin ctbs := '1'; end; ctb2:=random(999)+1; if ctb2 >= 1 then begin ctbi:='1'; 	end; ctb3:=IntToFloat(random(999))+1.1; if ctb3 >= 1.1 then begin ctbf:='1'; end; ctb4:=IntToNumeric(random(999))+1.0; if ctb4 >= 1.0 then begin ctbn:='1'; end; barracontroleit:=ctbs+ctbi+ctbf+ctbn+StrNumeric(idb,12); barracontroleit := barracontroleit;	npgc:=0;//Var FIXA em cima da Pagina Inicial
			//--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

					BeginPage(PAGE1);
					ClearFields(PAGE1,REC1);
						PAGE1.REC1.PROPRIETAR    := PROP;
						PAGE1.REC1.COMPROMMIS    := COMPR;
						PAGE1.REC1.END_ENTREG[1] := E_LOGR +' '+ E_NUME;
						PAGE1.REC1.END_ENTREG[2] := E_BAIR +' '+ E_COMP;
						PAGE1.REC1.END_ENTREG[3] := 'CEP: '+E_CEP+' '+E_CIDA+'-'+E_UF;
						PAGE1.REC1.CEPNET        := CAMPO_CEPNET;
						PAGE1.REC1.AVS           := AVISO;
	    				PAGE1.REC1.N_ARQUIV      := n_arq;
					WriteRecord(PAGE1,REC1);
					EndPage(PAGE1);
					npgc:=npgc+1;//Var deve se repetir abaixo de todos os EndPage


					BeginPage(PAGE2);
					ClearFields(PAGE2,REC1);
				    if MSG <> 'COMUNICA A V.SA. QUE CONSTA EM ABERTO' then begin
					    PAGE2.REC1.MSG1         := '';
					    PAGE2.REC1.MSG2         := '';
					    PAGE2.REC1.MSG3         := '';
					    PAGE2.REC1.MSG4         := '';
						end else begin
					    PAGE2.REC1.MSG1         := 'A PREFEITURA MUNICIPAL DE GUARAREMA COMUNICA A V.SA QUE CONSTA EM ABERTO EM NOSSO SISTEMA';
					    PAGE2.REC1.MSG2         := 'DÉBITO, REFERENTE AO NÃO PAGAMENTO DE IPTU DO PRESENTE IMÓVEL. PARA EMISSÃO DE GUIA DE QUITAÇÃO ONLINE ';
					    PAGE2.REC1.MSG3         := 'SELECIONE OS ANOS DE DÉBITOS DESEJADOS ATRAVÉS DO LINK ';
					    PAGE2.REC1.MSG4         := 'http://portal.guararema.sp.gov.br/pmguararema/websis/siapegov/arrecadacao/geda/geda_consulta.php';
					end;
					PAGE2.REC1.AVS              := AVISO;
					PAGE2.REC1.N_ARQUIV	        := n_arq; 
				    WriteRecord(PAGE2,REC1);
				    EndPage(PAGE2);
				    npgc:=npgc+1;


				    If (IMPR = 1) OR (IMPR = 3) then begin
					    //LAMINA BOMBEIRO
						BeginPage(BO);
						ClearFields(BO,REC1);
						    BO.REC1.AVS           := AVISO;
						    BO.REC1.N_ARQUIV      := n_arq; 
						    BO.REC1.PROPRIETAR    := PROP;
						    BO.REC1.COMPROMMIS    := COMPR;
						    BO.REC1.END_ENTREG[1] := E_LOGR +' '+ E_NUME;
						    BO.REC1.END_ENTREG[2] := E_BAIR +' '+ E_COMP;
						    BO.REC1.END_ENTREG[3] := 'CEP: '+E_CEP+' '+E_CIDA+'-'+E_UF;
						    BO.REC1.INSCRICAO[1]  := INSC;
						    BO.REC1.DATA          := GetDate(LINHA1,1627+PR,8);
						    BO.REC1.VL_PARC       := GetFloat(LINHA1,1103+PR,15)/100;
						    BO.REC1.VENC_PARC     := GetDate(LINHA1,1261+PR,8);
						    BO.REC1.NUM_DOC       := GetString(LINHA1,1546+PR,10);
						    BO.REC1.IDENTIFICA    := GetString(LINHA1,1566+PR,7);
						    BO.REC1.NOSSNUM       := GetString(LINHA1,2831+PR,17);
						    BO.REC1.LINHAPARC     := GetString(LINHA1,2264+PR,55);
						    BO.REC1.BARRAPARC     := GetString(LINHA1,1769+PR,44);
						    WriteRecord(BO,REC1);
					    EndPage(BO);
					    npgc:=npgc+1;
				    end;


					BeginPage(PAGE3);
					ClearFields(PAGE3,REC1);
					    PAGE3.REC1.AVS           := AVISO;
					    PAGE3.REC1.N_ARQUIV      := n_arq; 
					    PAGE3.REC1.PROPRIETAR    := PROP;
					    PAGE3.REC1.COMPROMMIS    := COMPR;
					    PAGE3.REC1.END_ENTREG[1] := E_LOGR +' '+ E_NUME;
					    PAGE3.REC1.END_ENTREG[2] := E_BAIR +' '+ E_COMP;
					    PAGE3.REC1.END_ENTREG[3] := 'CEP: '+E_CEP+' '+E_CIDA+'-'+E_UF;
					    PAGE3.REC1.END_IMOV[1]   := I_LOGR; 
					    PAGE3.REC1.NUMERO        := I_NUME;
					    PAGE3.REC1.COMPLEMEN     := I_COMP;
					    PAGE3.REC1.BAIRRO        := I_BAIR;
					    PAGE3.REC1.LOTE          := LT;
					    PAGE3.REC1.QUADRA        := QR;
					    PAGE3.REC1.LOTEMANETO    := LTMENT;  
					    PAGE3.REC1.INSCRICAO     := INSC;
					    PAGE3.REC1.TESTADA       := GetFloat(LINHA2,769+PR,15)/100;
					    PAGE3.REC1.AREA_TERR     := GetFloat(LINHA2,754+PR,15)/100;
					    PAGE3.REC1.AREACONST     := GetFloat(LINHA2,784+PR,15)/100;
					    PAGE3.REC1.VENAL_TERR    := GetFloat(LINHA2,1401+PR,15)/100;
					    PAGE3.REC1.VENAL_PRED    := GetFloat(LINHA2,1416+PR,15)/100;
					    PAGE3.REC1.IMPTERRITO    := GetFloat(LINHA2,1341+PR,15)/100;
					    PAGE3.REC1.IMP_TOTAL     := GetFloat(LINHA2,1386+PR,15)/100;
					    PAGE3.REC1.IMP_EXCEDE    := GetFloat(LINHA2,1371+PR,15)/100;
					    PAGE3.REC1.IMP_PREDIA    := GetFloat(LINHA2,1356+PR,15)/100;
					    PAGE3.REC1.EXCEDENTE     := GetFloat(LINHA2,1431+PR,15)/100;
					    PAGE3.REC1.TOTAL         := GetFloat(LINHA2,1446+PR,15)/100;
					    PAGE3.REC1.DATAPARC      := GetDate(LINHA2,1253+PR,8);
					    PAGE3.REC1.VLPAR         := GetFloat(LINHA2,1088+PR,15)/100;
					    PAGE3.REC1.PARCELA       := GetString(LINHA2,976+PR,2);
						for i := 0 to PCL-1 do begin
						    PAGE3.REC1.VENCIMENTO[i+1] := FormatDate(GetDate(LINHA2,1261+(i*8)+PR,8),'DD/MM/AAAA');
						    PAGE3.REC1.PARCELAS[i+1]   := TrimStr(GetString(LINHA2,851+(i*13)+PR,13));
						    PAGE3.REC1.VLR_PARCEL[i+1] := FormatFloat(GetFloat(LINHA2,1103+(i*15)+PR,15)/100,'#.###.###.###,##');
						end;
				    WriteRecord(PAGE3,REC1);
				    EndPage(PAGE3);
				    npgc:=npgc+1;


				    BeginPage(PAGE6);
				    ClearFields(PAGE6,REC1);
						    PAGE6.REC1.AVS           := AVISO;
						    PAGE6.REC1.N_ARQUIV      := n_arq;	
				    WriteRecord(PAGE6,REC1);
				    EndPage(PAGE6);
				    npgc:=npgc+1;

				    If (IMPR = 2) OR (IMPR = 3) then begin
						//PAGINA 4 ÚNICA
						BeginPage(PAGE4);
						ClearFields(PAGE4,REC1);
						    PAGE4.REC1.AVS           := AVISO;
						    PAGE4.REC1.N_ARQUIV      := n_arq; 
						    PAGE4.REC1.PROPRIETAR    := PROP;
						    PAGE4.REC1.COMPROMMIS    := COMPR;
						    PAGE4.REC1.END_ENTREG[1] := E_LOGR +' '+ E_NUME;
						    PAGE4.REC1.END_ENTREG[2] := E_BAIR +' '+ E_COMP;
						    PAGE4.REC1.END_ENTREG[3] := 'CEP: '+E_CEP+' '+E_CIDA+'-'+E_UF;
						    PAGE4.REC1.VENC_UNI      := GetDate(LINHA2,1253,8);
						    PAGE4.REC1.INSCRICAO[1]  := GetString(LINHA2,500,23);
						    PAGE4.REC1.NUM_DOC       := GetString(LINHA2,1546,10);
						    PAGE4.REC1.IDENTIFICA    := GetString(LINHA2,1566,7);
								if GetFloat(LINHA2,1088,15) <> 0.0 then begin
								    PAGE4.REC1.VL_UNI        := GetFloat(LINHA2,1088,15)/100;
								end else begin
								    Exit;
								end;
						    PAGE4.REC1.NOSSNUM       := GetString(LINHA2,2814,17);
						    PAGE4.REC1.LINHAUNI      := GetString(LINHA2,2209,55);
						    PAGE4.REC1.BARRAUNI      := GetString(LINHA2,1725,44);
						    PAGE4.REC1.DATA          :=  GetDate(LINHA2,1627,8);
					    WriteRecord(PAGE4,REC1);
					    EndPage(PAGE4);
					    npgc:=npgc+1;


					    //PAGINA 5 PARCELAS
						for k := 0 to PCL-1 do begin
							BeginPage(PAGE5);
							ClearFields(PAGE5,REC1);
							    PAGE5.REC1.AVS           := AVISO;
							    PAGE5.REC1.N_ARQUIV      := n_arq; 
							    PAGE5.REC1.PROPRIETAR    := PROP;
							    PAGE5.REC1.COMPROMMIS    := COMPR;
							    PAGE5.REC1.END_ENTREG[1] := E_LOGR +' '+ E_NUME;
							    PAGE5.REC1.END_ENTREG[2] := E_BAIR +' '+ E_COMP;
							    PAGE5.REC1.END_ENTREG[3] := 'CEP: '+E_CEP+' '+E_CIDA+'-'+E_UF;
							    PAGE5.REC1.INSCRICAO[1]  := INSC;
							    PAGE5.REC1.DATA          := GetDate(LINHA2,1627,8);
							    PAGE5.REC1.VENC_PARC     := GetDate(LINHA2,1261+(k*8),8);
							    PAGE5.REC1.NUM_DOC       := GetString(LINHA2,1546,10);
							    PAGE5.REC1.IDENTIFICA    := GetString(LINHA2,1566,7);
									if GetFloat(LINHA2,1103+(k*15),15) <> 0.0 then begin
									    PAGE5.REC1.VL_PARC       := GetFloat(LINHA2,1103+(k*15),15)/100;
									end else begin
									    Exit;
									end;
							    PAGE5.REC1.NOSSNUM       := GetString(LINHA2,2831+(k*17),17);
							    PAGE5.REC1.LINHAPARC     := GetString(LINHA2,2264+(k*55),55);
							    PAGE5.REC1.BARRAPARC     := GetString(LINHA2,1769+(k*44),44);
							    PAGE5.REC1.PARCELA       := FormatFloat(k+1,'9');
						    WriteRecord(PAGE5,REC1);
						    EndPage(PAGE5);
						    npgc:=npgc+1;
						end;
					end;

			//-------Relatorio Controle CX ID 3.0--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
			If relat <> 1 then begin If (relat = 0) or ( relat = 2) then begin xym:=0;	xym:=page_ex+npgc; ltb:= FloatToInt((Ceil(((fls_cx/(xym))))*carne_fls)*tp_imp); if (NContrib mod ltb) = 0 then begin nlt :=nlt+1; end; idbarra:=FormatFloat(nlt,'9')+';'+barracontroleit+';'+ifex+';'+FormatNumeric(AVS,'000.000');	If (relat = 0) or ( relat = 3) then begin WritelnFileLog(controle,idbarra); end; NContrib:=NContrib+1; AVS:=NContrib+1; 	end; end;
			//------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------	
			markup();

		end;
		
		P     := '';	
		PRINT := 0;
		PCL   := 0;
	End;


	P                 := MultLineAdd(P,S);
	LINHAS            := MultLineCount(P);
	ID_LINHA_ANTERIOR := Trimstr(GetString(S,500,24));
	PRINT             := 1;

	If (ReadLn(S) = EOF) and (PRINT = 1)  and (ID_LINHA_ATUAL = '') then begin 
		break;
	end;
end;

{
WritelnFileLog(RLT,FormatFloat(XFG,'9'));
CloseFileLog(RLT);
}

//-------Ordenacaoo por profundidade 5.1  & Relatorio - Resumo Prefeitura---------------------------------------------------------------------------------------
if npgc = 0 then begin abort('NUMERO DE PARCELAS INVALIDO OU NÃO ENCONTRADO!') end else begin page_c := page_ex+npgc; rcv :=0; rcv := FloatToInt((Ceil(((fls_cx/(page_c))))*carne_fls)*tp_imp);
Convert(carne_fls,true,false,false,rcv,false);end;  If relat <> 1 then begin If (relat = 0) or ( relat = 2) then begin 	If tp_imp = 2 then begin imp_fv:='(Impresso frente e verso)'; end else begin 	imp_fv:='';  end; Conteudo:=''; WritelnFileLog(relatorio,conteudo); Conteudo:='- Informacao Geral'; WritelnFileLog(relatorio,conteudo); Conteudo:='Data e Hora do ODA         '+FormatDate(SYS_DATE,'DD/MM/AAAA')+' '+SubStr(StrNumeric(FormatTime(SYS_TIME,'HH:MM'),4),1,2)+':'+SubStr(StrNumeric(FormatTime(SYS_TIME,'HH:MM'),4),3,2); WritelnFileLog(relatorio,conteudo); Conteudo:='Numero de paginas:         '+FormatFloat(page_c,'9'); WritelnFileLog(relatorio,conteudo); Conteudo:='Numero de Impresso p/ fls: '+FormatFloat(carne_fls,'9')+' '+imp_fv;WritelnFileLog(relatorio,conteudo); Conteudo:='Numero de Registro:        '+FormatFloat(NContrib,'9'); 	WritelnFileLog(relatorio,conteudo); Conteudo:=''; WritelnFileLog(relatorio,conteudo); Conteudo:='- Informacao do Lote'; WritelnFileLog(relatorio,conteudo); Conteudo:='Numero de Caixas:          '+FormatFloat(Ceil(NContrib/rcv),'9'); WritelnFileLog(relatorio,conteudo);	Conteudo:='Impressos p/ Caixa:        '+FormatFloat(rcv,'9'); WritelnFileLog(relatorio,conteudo);	Conteudo:='Numero de Fls p/ Caixa:    '+FormatFloat((((page_c-page_ex)*rcv)/carne_fls)/tp_imp,'9'); WritelnFileLog(relatorio,conteudo); CloseFileLog(relatorio); If (relat = 0) or ( relat = 3) then begin WritelnFileLog(controle,'*'); 	CloseFileLog(controle);	end; end; end;
//-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------



