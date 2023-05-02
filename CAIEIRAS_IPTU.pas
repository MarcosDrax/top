{---SB 5.0 / BARRA_TP_aviso 1.0 ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------char3500} TD_plugin:=0;  x:=0; for i := 0 to 99 do begin  if substr(RetornaNomeArqEntrada(0),i,1) <> '.' then begin  x:= x+1; end else begin break; end; end; TD_nomeDoArquivo := substr(RetornaNomeArqEntrada(0),1,x-1); fls_cx:= 0; n_arq:='';
// +-----------------------------------------+
// | Desenvolvedor: MARCOS                   |
// | Atualização:  24/11/2022                |
// | Programa:  PREFEITURA MUN CAIEIRAS      |
// +-----------------------------------------+ 
{----Pré-Configurações---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------}

{---Configurações--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------}
    TD_cliente                    := 'PM CAIEIRAS';     //Nome parcialmente completo
    TD_tipoImpresso               := 1;                // 1 = Carnes | 2 = Carta/Boletos |
    TD_qtdPorFolha                := 4;                //Quantidade de impresso por folha
    TD_paginaExtra                := 2;                //Quantidade de paginas nao inclusa no visual (contra-capa/encarte/etc)
    TD_folhasPorCaixa             := 1500;             //Quantidade de Folhar por caixa (carnes = 1500 caixa grande / 500 caixa pequena| Envelope 1000 A4 Caixa grande)
    TD_relatorios                 := 1;                //Desativar Relatorio = 0 | Ativar Relatorios = 1 
    TD_seguranca                  := 0;                //Desativa Barra de segurança = 0 | Ativa Barra de segurança = 1
{---Configurações de segurança-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------}
    marcaDaguaNome                := 'P.M.C'; //Marca dagua prefixo do cliente 
    tamanhoBarraSegurancaRandom   := 60;      //Numero maximo de codigo de segurança gerado com base no tamanhdo da marcadagua+1
    tamanhoBarraSegurancaLooping  := 65;      //Tamanho que da barra
    tamanhomarcaDeSeguranca       := 9999;    //Limite randomico do codigo de segurança
{---Plugin Inicio--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------}



{---Plugins Fim-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
----Relatorios 4.0-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------}
If TD_relatorios <> 0 then begin If (TD_relatorios= 1) then begin TD_resumo:= CreateFileLog('Resumo_'+TD_cliente+'_dt'+SubStr(StrNumeric(FormatTime(SYS_TIME,'HH:MM'),4),1,4)+'_'+RetornaNomeArqEntrada(0)); TD_conteudoResumo:=TD_cliente; WritelnFileLog(TD_resumo,TD_conteudoResumo); TD_registro:= CreateFileLog('Arquivo_Relatorio&Etiqueta_'+TD_cliente+'_'+SubStr(StrNumeric(FormatTime(SYS_TIME,'HH:MM'),4),1,4)+'_'+RetornaNomeArqEntrada(0)); TD_conteudoRegistro:='0;'+TD_cliente+';'++';'+FormatDate(SYS_DATE,'DD/MM/AAAA')+';'+SubStr(StrNumeric(FormatTime(SYS_TIME,'HH:MM'),4),1,2)+':'+SubStr(StrNumeric(FormatTime(SYS_TIME,'HH:MM'),4),3,2); WritelnFileLog(TD_registro,TD_conteudoRegistro); end; If TD_relatorios > 1 then begin	abort('RELATORIO - VALOR INFORMADO INVALIDO'); end; numeroDeCliente:=0; numeroDoLote:=0; end; {VAL.ANT.MRKISI} If TD_tipoImpresso > 2 then begin abort('ATENÇÃO - TIPO DE IMPRESSO INVALIDO'); end; If TD_qtdPorFolha < 1 then begin abort('ATENÇÃO - QUANTIDADE DE IMPRESSO POR FOLHA INVALIDO'); end; If fls_cx > 0 then begin abort('ATENÇÃO - SCRIPT PADRAO INVALIDO, VERSAO DESATUALIZADA INFERIOR A 5.0'); end; If n_arq <>'' then begin abort('ATENÇÃO - SCRIPT BARRA_TP_aviso 1.0 INVALIDO, VERSAO DESATUALIZADA INFERIOR A 2.0'); end; TP_numPage:=1; TP_aviso:=1; TD_idExtra:=''; TD_idCodigoBanco:=''; TD_idNumeroBanco:=''; barraSeg:=''; posicaoBarraSeg:='';
{---Variaveis Global Ini-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------}



{---Variaveis Global Fim-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------}
parcela := 0.0;
ReadLn(S);
While ReadLn(S) <> EOF do Begin
//--------Variaveis comuns Ini-------- 
AVISO         := FormatNumeric(TP_aviso,'000.000'); //Aviso gerado pelo script, convertido p String.
vlrUnica      := GetFloat(S,47,0);vlrParc       := GetFloat(S,40,0);AVISO_AVS     := GetString(S,1,0);REGISTRO      := GetString(S,2,0); 
INSCRICAO     := GetString(S,3,0);PROPRIETARIO  := GetString(S,4,0);COMPROMISSARIO:= GetString(S,5,0);END_ENTREGA   := GetString(S,6,0);
COMPL_ENTREGA := GetString(S,7,0);BAIRRO_ENTREGA:= GetString(S,8,0);CIDADE_ENTREGA:= GetString(S,9,0);UF_ENTREGA    := GetString(S,10,0);
CEP_ENTREGA   := GetString(S,11,0);END_IMOVEL    := GetString(S,12,0);LOTE          := GetString(S,13,0);QUADRA        := GetString(S,14,0);
LOTEAMENTO    := GetString(S,15,0);FACE          := GetString(S,61,0);SACADO        := GetString(S,62,0);ITBI          := GetString(S,68,0);
COD_FEBRABAN  := GetString(S,67,0);
DATA_UNICA    := GetString(S,16,0);DATA_1        := GetString(S,17,0);DATA_2        := GetString(S,18,0);DATA_3        := GetString(S,19,0);
DATA_4        := GetString(S,20,0);DATA_5        := GetString(S,21,0);DATA_6        := GetString(S,22,0);DATA_7        := GetString(S,23,0);
DATA_8        := GetString(S,24,0);DATA_9        := GetString(S,25,0);DATA_10       := GetString(S,26,0);DATA_11       := GetString(S,27,0);
DATA_12       := GetString(S,28,0);
TESTADA       := GetString(S,29,0);AREA_CONSTRU  := GetString(S,30,0);AREA_TERREN   := GetString(S,31,0);M2_TERRENO    := GetString(S,32,0);
M2_CONSTRUC   := GetString(S,33,0);VL_PREDIAL    := GetString(S,34,0);VL_TERRITORIA := GetString(S,35,0);VENAL_TERRE   := GetString(S,36,0);
VENAL_CONST   := GetString(S,37,0);VENAL_TOTAL   := GetString(S,38,0);TOTAL_TOT     := GetString(S,39,0);TOT_UNICA     := GetFloat(S,40,0);
VALOR_PC      := GetFloat(S,41,0);VALOR_UNICA_1  := GetFloat(S,42,0);VALOR_UNICA_2  := GetFloat(S,43,0);VALOR_UNICA_3  := GetFloat(S,44,0);
{---Variaveis comuns Fim---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------}  

{---Configurações Referencia do contribuinte no Registro | Barra de TD_registro 3.0 ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------}
	    TD_idArquivo        := REGISTRO;           //Identificação do arquivo maximo ate 12 numeros
	    TD_idNumeroBanco    := COD_FEBRABAN;       //Referencia do Banco
	    TD_idCodigoBanco    := GetString(S,46,0);  //Referencia do contribuinte para com o banco (ex: nossonumero)
	    TD_idExtra          := CEP_ENTREGA;        //Identificação extra 
{--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------}  
barraDeControle:=''; ctbs:= '0'; ctbi:= '0'; ctbf:= '0'; ctbn:= '0'; ctb := '99'; if ctb = '99' then begin ctbs := '1'; end; ctb2:=random(999)+1; if ctb2 >= 1 then begin ctbi:='1'; end; ctb3:=IntToFloat(random(999))+1.1; if ctb3 >= 1.1 then begin ctbf:='1'; end; ctb4:=IntToNumeric(random(999))+1.0; if ctb4 >= 1.0 then begin ctbn:='1'; end; barraDeControle:=ctbs+ctbi+ctbf+ctbn+StrNumeric(TD_idArquivo,12); barraDeControle := barraDeControle;	TP_numPage:=0; if TD_seguranca = 1 then begin maximoRandom := tamanhoBarraSegurancaRandom; posicaoRandom1 := Random(maximoRandom); if posicaoRandom1 = 0 then begin posicaoRandom1:= 1; end; posicaoRandom2 := Random(maximoRandom); if posicaoRandom2 = 0 then begin posicaoRandom2:= 1; end; posicaoRandom3 := Random(maximoRandom); if posicaoRandom3 = 0 then begin posicaoRandom3:= 1; end; posicaoRandom4 := Random(maximoRandom); if posicaoRandom4 = 0 then begin posicaoRandom4:= 1; end; If (posicaoRandom1 = posicaoRandom2) or (posicaoRandom1 = posicaoRandom3) or (posicaoRandom1 = posicaoRandom4) then begin posicaoRandom1 := posicaoRandom1 + 1; end; If (posicaoRandom2 = posicaoRandom1) or (posicaoRandom2 = posicaoRandom3) or (posicaoRandom2 = posicaoRandom4) then begin posicaoRandom2 := posicaoRandom2 + 1; end; If (posicaoRandom3 = posicaoRandom2) or (posicaoRandom3 = posicaoRandom1) or (posicaoRandom3 = posicaoRandom4) then begin posicaoRandom3 := posicaoRandom3 + 1; end; If (posicaoRandom4 = posicaoRandom2) or (posicaoRandom4 = posicaoRandom1) or (posicaoRandom4 = posicaoRandom3) then begin posicaoRandom4 := posicaoRandom4 + 1; end; marcaDeSeguranca1 := FormatNumeric(Random(tamanhomarcaDeSeguranca),'0000'); marcaDeSeguranca2 := FormatNumeric(Random(tamanhomarcaDeSeguranca),'0000'); marcaDeSeguranca3 := FormatNumeric(Random(tamanhomarcaDeSeguranca),'0000'); marcaDeSeguranca4 := FormatNumeric(Random(tamanhomarcaDeSeguranca),'0000'); barraSeg := ''; for i := 1 to tamanhoBarraSegurancaLooping do begin if i = posicaoRandom1 then begin composicaoBarraSeg := marcaDeSeguranca1 + ' '; end else begin if i = posicaoRandom2 then begin composicaoBarraSeg := marcaDeSeguranca2 + ' '; end else begin if i = posicaoRandom3 then begin composicaoBarraSeg := marcaDeSeguranca3 + ' '; end else begin if i = posicaoRandom4 then begin composicaoBarraSeg := marcaDeSeguranca4 + ' '; end else begin composicaoBarraSeg := marcaDaguaNome + ' '; end; end; end; end; barraSeg := barraSeg + composicaoBarraSeg; end; posicaoBarraSeg := FormatFloat(posicaoRandom1,'9')+'='+marcaDeSeguranca1+'_'+FormatFloat(posicaoRandom2,'9')+'='+marcaDeSeguranca2+'_'+FormatFloat(posicaoRandom3,'9')+'='+marcaDeSeguranca3+'_'+FormatFloat(posicaoRandom4,'9')+'='+marcaDeSeguranca4; end;
{--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------}
//PROTOCOLO DE ENTREGA
BeginPage(PAGE1);
ClearFields(PAGE1,REC1);
    PAGE1.REC1.AVISO := AVISO_AVS;
    PAGE1.REC1.REGISTRO := REGISTRO; 
    PAGE1.REC1.INSCRICAO :=  INSCRICAO;
    PAGE1.REC1.PROPRIETAR :=  PROPRIETARIO;
    PAGE1.REC1.COMPROMISS :=  COMPROMISSARIO;
    PAGE1.REC1.END_ENTREG :=  END_ENTREGA;
    PAGE1.REC1.COMPL_ENTR :=  COMPL_ENTREGA;
    PAGE1.REC1.BAIRRO_ENT :=  BAIRRO_ENTREGA;
    PAGE1.REC1.ESTADO_ENT :=  CIDADE_ENTREGA;
    PAGE1.REC1.UF_ENTREGA :=  UF_ENTREGA;
    PAGE1.REC1.CEP_ENTREG :=  CEP_ENTREGA;
	PAGE1.REC1.CBARRA         := barraDeControle;
	PAGE1.REC1.SBARRA         := barraDeControle;
	PAGE1.REC1.BAR_SEG[1]     := barraSeg;
	PAGE1.REC1.AVS            := AVISO;
	PAGE1.REC1.N_ARQUIV       := TD_nomeDoArquivo;	   
WriteRecord(PAGE1,REC1);
EndPage(PAGE1);
TP_numPage:=TP_numPage+1;

//PROTOCOLO DE ENTREGA
BeginPage(CAPA);
ClearFields(CAPA,REC1);
	CAPA.REC1.CBARRA         := barraDeControle;
	CAPA.REC1.SBARRA         := barraDeControle;
	CAPA.REC1.BAR_SEG[1]     := barraSeg;
	CAPA.REC1.AVS            := AVISO;
	CAPA.REC1.N_ARQUIV       := TD_nomeDoArquivo;	   
WriteRecord(CAPA,REC1);
EndPage(CAPA);
TP_numPage:=TP_numPage+1;

//INFORMAÇÕES
BeginPage(PAGE2);
ClearFields(PAGE2,REC1);
    PAGE2.REC1.AVISO := AVISO_AVS;
    PAGE2.REC1.REGISTRO := REGISTRO; 
    PAGE2.REC1.INSCRICAO :=  INSCRICAO;
    PAGE2.REC1.PROPRIETAR :=  PROPRIETARIO;
    PAGE2.REC1.COMPROMISS :=  COMPROMISSARIO;
    PAGE2.REC1.END_ENTREG :=  END_ENTREGA;
    PAGE2.REC1.COMPL_ENTR :=  COMPL_ENTREGA;
    PAGE2.REC1.BAIRRO_ENT :=  BAIRRO_ENTREGA;
    PAGE2.REC1.ESTADO_ENT :=  CIDADE_ENTREGA;
    PAGE2.REC1.UF_ENTREGA :=  UF_ENTREGA;
    PAGE2.REC1.CEP_ENTREG :=  CEP_ENTREGA;
    PAGE2.REC1.QUADRA :=  QUADRA;
    PAGE2.REC1.LOTE :=  LOTE;
    PAGE2.REC1.LOTEAMENTO :=  LOTEAMENTO;
    PAGE2.REC1.END_IMOV :=  END_IMOVEL;
    PAGE2.REC1.FACE :=  FACE;
    PAGE2.REC1.FIDUCIARIO :=  GetString(S,0,0); 
	PAGE2.REC1.AVS            := AVISO;
	PAGE2.REC1.N_ARQUIV       := TD_nomeDoArquivo;	
WriteRecord(PAGE2,REC1);
EndPage(PAGE2);
TP_numPage:=TP_numPage+1;

//PAGE 3	
BeginPage(PAGE3);
ClearFields(PAGE3,REC1);
    PAGE3.REC1.INSCRICAO := INSCRICAO;
    PAGE3.REC1.REGISTRO := REGISTRO;
    PAGE3.REC1.LOTE := LOTE;
    PAGE3.REC1.QUADRA := QUADRA;
    PAGE3.REC1.CONTRIBUIN := PROPRIETARIO;
    PAGE3.REC1.LOGRA_CORR := END_ENTREGA;
    //PAGE3.REC1.NM_CORR := GetString(S,0,0);
    PAGE3.REC1.COMP_CORR := COMPL_ENTREGA;
    PAGE3.REC1.BAIRR_CORR := BAIRRO_ENTREGA;
    PAGE3.REC1.CID_CORR := CIDADE_ENTREGA;
    PAGE3.REC1.CEP_E := CEP_ENTREGA;
    PAGE3.REC1.EST_CORR :=  UF_ENTREGA;
	PAGE3.REC1.AVS            := AVISO;
	PAGE3.REC1.N_ARQUIV       := TD_nomeDoArquivo;	    
WriteRecord(PAGE3,REC1);
EndPage(PAGE3); 
TP_numPage:=TP_numPage+1;
	
//DEMONSTRATIVO
BeginPage(PAGE4);
ClearFields(PAGE4,REC1);
    PAGE4.REC1.AVISO := AVISO_AVS;
    PAGE4.REC1.REGISTRO := REGISTRO; 
    PAGE4.REC1.INSCRICAO :=  INSCRICAO;
    PAGE4.REC1.PROPRIETAR :=  PROPRIETARIO;
    PAGE4.REC1.COMPROMISS :=  COMPROMISSARIO;
    PAGE4.REC1.END_IMOV :=  END_IMOVEL;
    PAGE4.REC1.FACE :=  GetString(S,61,0);
    PAGE4.REC1.QUADRA :=  QUADRA;
    PAGE4.REC1.LOTE :=   LOTE;
    PAGE4.REC1.LOTEAMENTO :=   LOTEAMENTO;
    PAGE4.REC1.MSG :=  GetString(S,0,0);
    PAGE4.REC1.AREATERREN :=  AREA_TERREN;
    PAGE4.REC1.M2TERRENO :=  M2_TERRENO;
    PAGE4.REC1.VENALTERRE := VENAL_TERRE;
    PAGE4.REC1.TESTADA :=   TESTADA;
    PAGE4.REC1.AREACONSTR :=  AREA_CONSTRU;
    PAGE4.REC1.M2CONSTRUC :=  M2_CONSTRUC;
    PAGE4.REC1.VENALEXCES :=  GetString(S,59,0); 
    PAGE4.REC1.VENALCONST :=  VENAL_CONST;
    PAGE4.REC1.VENALTOTAL :=  VENAL_TOTAL;
    PAGE4.REC1.TERRITORIA :=  VL_TERRITORIA;
    PAGE4.REC1.PREDIAL :=  VL_PREDIAL;
    PAGE4.REC1.TOTALPARC :=   GetString(S,41,0);
    PAGE4.REC1.TOTALTOT :=  TOTAL_TOT;
    PAGE4.REC1.DATAUN :=  DATA_UNICA ;
    PAGE4.REC1.DATA1 :=  DATA_1 ;
    PAGE4.REC1.DATA2 :=  DATA_2 ;
    PAGE4.REC1.DATA3 :=   DATA_3 ;
    PAGE4.REC1.DATA4 :=   DATA_4 ; 
    PAGE4.REC1.DATA5 :=  DATA_5 ;
    PAGE4.REC1.DATA6 :=  DATA_6 ;
    PAGE4.REC1.DATA7 :=  DATA_7 ;
    PAGE4.REC1.DATA8 :=  DATA_8 ;
    PAGE4.REC1.DATA9 := DATA_9 ; 
    PAGE4.REC1.DATA10 := DATA_10 ; 
    PAGE4.REC1.DATA11 :=  DATA_11 ;
    PAGE4.REC1.DATA12 :=  DATA_12 ;
    PAGE4.REC1.DATAEMISSA := SYS_DATE;
    PAGE4.REC1.ITBI :=   ITBI;
	PAGE4.REC1.AVS            := AVISO;
	PAGE4.REC1.N_ARQUIV       := TD_nomeDoArquivo;	
WriteRecord(PAGE4,REC1);
EndPage(PAGE4);
TP_numPage:=TP_numPage+1;

//UNICA
BeginPage(PAGE5);
ClearFields(PAGE5,REC1);
    PAGE5.REC1.SACADO := SACADO ;
    PAGE5.REC1.REGISTRO := REGISTRO; 
    PAGE5.REC1.DATE :=  GetDate(S,16,0);  
    PAGE5.REC1.NOSSNUMUNI :=  GetString(S,46,0);  
    PAGE5.REC1.TOTUNICA:=  TOT_UNICA;
    PAGE5.REC1.CODFEBRA :=  COD_FEBRABAN;
	PAGE5.REC1.AVS            := AVISO;
	PAGE5.REC1.N_ARQUIV       := TD_nomeDoArquivo;	        
WriteRecord(PAGE5,REC1);
EndPage(PAGE5);
TP_numPage:=TP_numPage+1;

//PARCELA 1 até 3 COM DESCONTO
BeginPage(PAGE6);
ClearFields(PAGE6,REC1);
    PAGE6.REC1.SACADO := SACADO ;
    PAGE6.REC1.PARCELA := parcela;
    PAGE6.REC1.DATE :=  GetDate(S,17,0);
	PAGE6.REC1.VALOR :=  VALOR_UNICA_1;
    PAGE6.REC1.NOSSNUM :=  GetString(S,47,0); 
    PAGE6.REC1.REGISTRO := REGISTRO; 
    PAGE6.REC1.CODFEBRA := COD_FEBRABAN; 
	PAGE6.REC1.AVS            := AVISO;
	PAGE6.REC1.N_ARQUIV       := TD_nomeDoArquivo;	    
WriteRecord(PAGE6,REC1);
EndPage(PAGE6);
TP_numPage:=TP_numPage+1;

//PARCELA 2 COM DESCONTO
BeginPage(PAGE7);
ClearFields(PAGE7,REC1);
    PAGE7.REC1.SACADO := SACADO ;
    PAGE7.REC1.PARCELA := parcela;
    PAGE7.REC1.DATE :=  GetDate(S,18,0);
	PAGE7.REC1.VALOR :=  VALOR_UNICA_2;
    PAGE7.REC1.NOSSNUM :=  GetString(S,48,0); 
    PAGE7.REC1.REGISTRO := REGISTRO; 
    PAGE7.REC1.CODFEBRA := COD_FEBRABAN; 
	PAGE7.REC1.AVS            := AVISO;
	PAGE7.REC1.N_ARQUIV       := TD_nomeDoArquivo;	
WriteRecord(PAGE7,REC1);
EndPage(PAGE7);
TP_numPage:=TP_numPage+1;

//PARCELA 3 DESCONTO
BeginPage(PAGE8);
ClearFields(PAGE8,REC1);
    PAGE8.REC1.SACADO := SACADO ;
    PAGE8.REC1.PARCELA := parcela;
    PAGE8.REC1.DATE :=  GetDate(S,19,0);
	PAGE8.REC1.VALOR :=  VALOR_UNICA_3;
    PAGE8.REC1.NOSSNUM :=  GetString(S,49,0); 
    PAGE8.REC1.REGISTRO := REGISTRO; 
    PAGE8.REC1.CODFEBRA := COD_FEBRABAN; 
	PAGE8.REC1.AVS            := AVISO;
	PAGE8.REC1.N_ARQUIV       := TD_nomeDoArquivo;	
WriteRecord(PAGE8,REC1);
EndPage(PAGE8);
TP_numPage:=TP_numPage+1;
 
//PARCELA 4 
for i := 0 to 8 do begin
	BeginPage(PAGE9);
	ClearFields(PAGE9,REC1);
    PAGE9.REC1.SACADO := SACADO ;
    PAGE9.REC1.PARCELA := parcela;
    PAGE9.REC1.DATE :=  GetDate(S,20+(i*1),0);
	PAGE9.REC1.VALOR :=  GetFloat(S,41,0);
    PAGE9.REC1.NOSSNUM :=  GetString(S,50+(i*1),0); 
    PAGE9.REC1.REGISTRO := REGISTRO; 
    PAGE9.REC1.CODFEBRA := COD_FEBRABAN; 
    PAGE9.REC1.PARCELA := parcela+4+(i*01);
	PAGE9.REC1.AVS            := AVISO;
	PAGE9.REC1.N_ARQUIV       := TD_nomeDoArquivo;	    
WriteRecord(PAGE9,REC1);
EndPage(PAGE9);
TP_numPage:=TP_numPage+1;
end;


//PARCELA 8
BeginPage(PAGE10);
ClearFields(PAGE10,REC1);
    PAGE10.REC1.AVISO := AVISO_AVS;
		PAGE10.REC1.AVS            := AVISO;
		PAGE10.REC1.N_ARQUIV       := TD_nomeDoArquivo;	    
WriteRecord(PAGE10,REC1);
EndPage(PAGE10);
TP_numPage:=TP_numPage+1;

//CONTRACAPA
BeginPage(CONTRACAPA);
ClearFields(CAPA,REC1);
	CONTRACAPA.REC1.CBARRA         := barraDeControle;
	CONTRACAPA.REC1.SBARRA         := barraDeControle;
	CONTRACAPA.REC1.BAR_SEG[1]     := barraSeg;
	CONTRACAPA.REC1.AVS            := AVISO;
	CONTRACAPA.REC1.N_ARQUIV       := TD_nomeDoArquivo;	   
WriteRecord(CONTRACAPA,REC1);
EndPage(CONTRACAPA);
TP_numPage:=TP_numPage+1;

{---Relatorio TD_registro CX ID 4.0----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------}
	If TD_relatorios <> 0 then begin If TD_relatorios = 1 then begin totalNumeroPagina:=0; totalNumeroPagina:=TD_paginaExtra+TP_numPage; quantidadePorLote:= FloatToInt((Ceil(((TD_folhasPorCaixa/(totalNumeroPagina))))*TD_qtdPorFolha)*TD_tipoImpresso); if (numeroDeCliente mod quantidadePorLote) = 0 then begin numeroDoLote :=numeroDoLote+1; end; TD_conteudoRegistro:=FormatFloat(numeroDoLote,'9')+';'+barraDeControle+';'+TD_idArquivo+';'+TD_idExtra+';'+FormatNumeric(TP_aviso,'000.000')+';'+TD_idNumeroBanco+';'+TD_idCodigoBanco+';'+posicaoBarraSeg;	WritelnFileLog(TD_registro,TD_conteudoRegistro); numeroDeCliente:=numeroDeCliente+1; TP_aviso:=numeroDeCliente+1; end; end;
{--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------}
markup;
end;
{---Ordenacaoo por profundidade 6.0  & Relatorio - Resumo Prefeitura-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------}
if TP_numPage = 0 then begin abort('NUMERO DE PARCELAS INVALIDO OU NÃO ENCONTRADO!') end else begin totalNumeroPaginaOrdenacao := TD_paginaExtra+TP_numPage; impressoPorCaixa :=0; impressoPorCaixa := FloatToInt((Ceil(((TD_folhasPorCaixa/(totalNumeroPaginaOrdenacao))))*TD_qtdPorFolha)*TD_tipoImpresso);
Convert(TD_qtdPorFolha,true,false,false,impressoPorCaixa,false); end; If TD_relatorios<> 0 then begin if TD_relatorios= 1 then begin If TD_tipoImpresso = 2 then begin impressoFrenteVerso:='(Impresso frente e verso)'; end else begin impressoFrenteVerso:=''; end; TD_conteudoResumo:=''; WritelnFileLog(TD_resumo, TD_conteudoResumo); TD_conteudoResumo:='- Informacao Geral'; WritelnFileLog(TD_resumo, TD_conteudoResumo); TD_conteudoResumo:='Data e Hora do ODA         '+FormatDate(SYS_DATE,'DD/MM/AAAA')+' '+SubStr(StrNumeric(FormatTime(SYS_TIME,'HH:MM'),4),1,2)+':'+SubStr(StrNumeric(FormatTime(SYS_TIME,'HH:MM'),4),3,2); WritelnFileLog(TD_resumo, TD_conteudoResumo); TD_conteudoResumo:='Numero de paginas:         '+FormatFloat(totalNumeroPaginaOrdenacao,'9'); WritelnFileLog(TD_resumo, TD_conteudoResumo); TD_conteudoResumo:='Numero de Impresso p/ fls: '+FormatFloat(TD_qtdPorFolha,'9')+' '+impressoFrenteVerso; WritelnFileLog(TD_resumo, TD_conteudoResumo); TD_conteudoResumo:='Numero de Registro:        '+FormatFloat(numeroDeCliente,'9'); WritelnFileLog(TD_resumo, TD_conteudoResumo); TD_conteudoResumo:=''; WritelnFileLog(TD_resumo, TD_conteudoResumo); TD_conteudoResumo:='- Informacao do Lote'; WritelnFileLog(TD_resumo, TD_conteudoResumo); TD_conteudoResumo:='Numero de Caixas:          '+FormatFloat(Ceil(numeroDeCliente/impressoPorCaixa),'9'); WritelnFileLog(TD_resumo, TD_conteudoResumo); TD_conteudoResumo:='Impressos p/ Caixa:        '+FormatFloat(impressoPorCaixa,'9'); WritelnFileLog(TD_resumo, TD_conteudoResumo); TD_conteudoResumo:='Numero de Fls p/ Caixa:    '+FormatFloat((((totalNumeroPaginaOrdenacao-TD_paginaExtra)*impressoPorCaixa)/TD_qtdPorFolha)/TD_tipoImpresso,'9'); WritelnFileLog(TD_resumo, TD_conteudoResumo); TD_conteudoResumo:=''; WritelnFileLog(TD_resumo, TD_conteudoResumo); TD_conteudoResumo:='- Informacao Extras'; WritelnFileLog(TD_resumo, TD_conteudoResumo); TD_conteudoResumo:='Nome do arquivo:          '+TD_nomeDoArquivo; WritelnFileLog(TD_resumo, TD_conteudoResumo); if TD_idNumeroBanco <> '' then begin TD_conteudoResumo:='Referencia do bando:      '+TD_idNumeroBanco; WritelnFileLog(TD_resumo, TD_conteudoResumo); end; if TD_idCodigoBanco <> '' then begin TD_conteudoResumo:='Referencia do Cliente:    '+TD_idCodigoBanco; WritelnFileLog(TD_resumo, TD_conteudoResumo); end; if posicaoBarraSeg <> '' then begin TD_conteudoResumo:='Referencia Barra Segurança:'+posicaoBarraSeg; WritelnFileLog(TD_resumo, TD_conteudoResumo); end; CloseFileLog(TD_resumo); If (TD_relatorios= 1) then begin WritelnFileLog(TD_registro,'*'); CloseFileLog(TD_registro); end; end; end;
{------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------}
