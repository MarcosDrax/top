// +-----------------------------------------+
// | Desenvolvedor: MARCOS                   |
// | Atualização:  27/04/2023                |
// | Programa:  COQUEIRAL                    |
// +-----------------------------------------+ 
{---SB 6.0 / BARRA_TP_aviso 1.0 -----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------Max char line 3500} TD_plugin:=0;x:=0; for i := 0 to 99 do begin if substr(RetornaNomeArqEntrada(0),i,1) <> '.' then begin x:= x+1; end else begin break; end; end; x:= x; if substr(RetornaNomeArqEntrada(0),x-1,1) = 'T' then x:= x-1; validaNome := substr(RetornaNomeArqEntrada(0),x-10,10); validaNomeDia := 0; validaNomeMes := 0; validaNomeAno := 0; validaNomeHor := 0; ValidaNomeMin := 0; if (StrTofloat(substr(validaNome,1,2)) > 0) and (StrTofloat(substr(validaNome,1,2)) < 32) then validaNomeDia := 1; if (StrTofloat(substr(validaNome,3,2)) > 0) and (StrTofloat(substr(validaNome,3,2)) < 13) then validaNomeMes := 1; if (StrTofloat(substr(validaNome,5,2)) > 20) and (StrTofloat(substr(validaNome,5,2)) < 30) then validaNomeAno := 1; if (StrTofloat(substr(validaNome,7,2)) >= 0) and (StrTofloat(substr(validaNome,7,2)) < 24) then validaNomeHor := 1; if (StrTofloat(substr(validaNome,9,2)) >= 0) and (StrTofloat(substr(validaNome,9,2)) < 60) then ValidaNomeMin := 1; if (validaNomeDia = 0 ) or (validaNomeMes = 0) or (validaNomeAno = 0) or (validaNomeHor = 0) or (ValidaNomeMin = 0) then abort ('ATENCAO: Nome de arquivo com formatacao INVALIDA! Formatacao correta (DDMMAAHHMM)'); TD_nomeDoArquivo := substr(RetornaNomeArqEntrada(0),1,x); fls_cx:= 0; n_arq:='';{----Pré-Configurações---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------}


{---Configurações--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------}
    TD_cliente                    := 'P.M. COQUEIRAL - CLIENTE'; //Nome parcialmente completo
    TD_tipoImpresso               := 1;      // 1 = Carnes | 2 = Carta/Boletos |
    TD_qtdPorFolha                := 4;      //Quantidade de impresso por folha
    TD_paginaExtra                := 1;      //Quantidade de paginas nao inclusa no visual (contra-capa/encarte/etc)
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
If TD_relatorios <> 0 then begin If (TD_relatorios= 1) then begin TD_resumo:= CreateFileLog('Resumo_'+TD_cliente+'_dt'+SubStr(StrNumeric(FormatTime(SYS_TIME,'HH:MM'),4),1,4)+'_'+RetornaNomeArqEntrada(0)); TD_conteudoResumo:=TD_cliente; WritelnFileLog(TD_resumo,TD_conteudoResumo); TD_registro:= CreateFileLog('Arquivo_Relatorio&Etiqueta_'+TD_cliente+'_'+SubStr(StrNumeric(FormatTime(SYS_TIME,'HH:MM'),4),1,4)+'_'+RetornaNomeArqEntrada(0)); TD_conteudoRegistro:='0;'+TD_cliente+';'++';'+FormatDate(SYS_DATE,'DD/MM/AAAA')+';'+SubStr(StrNumeric(FormatTime(SYS_TIME,'HH:MM'),4),1,2)+':'+SubStr(StrNumeric(FormatTime(SYS_TIME,'HH:MM'),4),3,2); WritelnFileLog(TD_registro,TD_conteudoRegistro); end; If TD_relatorios > 1 then begin    abort('RELATORIO - VALOR INFORMADO INVALIDO'); end; numeroDeCliente:=0; numeroDoLote:=0; end; {VAL.ANT.MRKISI} If TD_tipoImpresso > 2 then begin abort('ATENÇÃO - TIPO DE IMPRESSO INVALIDO'); end; If TD_qtdPorFolha < 1 then begin abort('ATENÇÃO - QUANTIDADE DE IMPRESSO POR FOLHA INVALIDO'); end; If fls_cx > 0 then begin abort('ATENÇÃO - SCRIPT PADRAO INVALIDO, VERSAO DESATUALIZADA INFERIOR A 5.0'); end; If n_arq <>'' then begin abort('ATENÇÃO - SCRIPT BARRA_TP_aviso 1.0 INVALIDO, VERSAO DESATUALIZADA INFERIOR A 2.0'); end; TP_numPage:=1; TP_aviso:=1; TD_idExtra:=''; TD_idCodigoBanco:=''; TD_idNumeroBanco:=''; barraSeg:=''; posicaoBarraSeg:='';
{---Variaveis Global Ini-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------}
While ReadLn(S) <> EOF do Begin
    {---Variaveis comuns Ini---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------}  
    AVISO          := FormatNumeric(TP_aviso,'000.000'); //Aviso gerado pelo script, convertido p String.
	inscricao          := GetString(S,5,20);
	cadastro           := GetString(S,25,6);
	name               := GetString(S,31,60);
	rua_imovel         := GetString(S,131,60);
	complemento_imovel := GetString(S,191,20);
	baiiro_imovel      := GetString(S,211,20);
	lote_imovel        := GetString(S,231,30);
	endereco_entrega   := TrimStr(GetString(S,261,60));
	complemento_entrega:= TrimStr(GetString(S,321,20));
	bairro_entrega     := GetString(S,341,25);
	cidade_entrega     := GetString(S,366,25);
	estado_entrega     := GetString(S,391,2);
	cep_entrega        := GetNumeric(S,393,8);
    {---Variaveis comuns Fim---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------}  

   Qt := GetNumeric(S,1932,2);
   if Qt = PARCELAS then begin
    {---Variaveis comuns Fim---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------}  
    {---Configurações Referencia do contribuinte no Registro | Barra de TD_registro 3.0 ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------}
        TD_idArquivo        := GetString(S,25,6);    //Identificação do arquivo maximo ate 12 numeros
        TD_idNumeroBanco    := GetString(S,393,8);    //Referencia do Banco
        TD_idCodigoBanco    := GetString(S,1209,21);    //Referencia do contribuinte para com o banco (ex: nossonumero)
        //TD_idExtra          := GetString(S,0,0);   //Identificação extra 
    {--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------}  
    barraDeControle:=''; ctbs:= '0'; ctbi:= '0'; ctbf:= '0'; ctbn:= '0'; ctb := '99'; if ctb = '99' then begin ctbs := '1'; end; ctb2:=random(999)+1; if ctb2 >= 1 then begin ctbi:='1'; end; ctb3:=IntToFloat(random(999))+1.1; if ctb3 >= 1.1 then begin ctbf:='1'; end; ctb4:=IntToNumeric(random(999))+1.0; if ctb4 >= 1.0 then begin ctbn:='1'; end; barraDeControle:=ctbs+ctbi+ctbf+ctbn+StrNumeric(TD_idArquivo,12); barraDeControle := barraDeControle; TP_numPage:=0; if TD_seguranca = 1 then begin maximoRandom := tamanhoBarraSegurancaRandom; posicaoRandom1 := Random(maximoRandom); if posicaoRandom1 = 0 then begin posicaoRandom1:= 1; end; posicaoRandom2 := Random(maximoRandom); if posicaoRandom2 = 0 then begin posicaoRandom2:= 1; end; posicaoRandom3 := Random(maximoRandom); if posicaoRandom3 = 0 then begin posicaoRandom3:= 1; end; posicaoRandom4 := Random(maximoRandom); if posicaoRandom4 = 0 then begin posicaoRandom4:= 1; end; If (posicaoRandom1 = posicaoRandom2) or (posicaoRandom1 = posicaoRandom3) or (posicaoRandom1 = posicaoRandom4) then begin posicaoRandom1 := posicaoRandom1 + 1; end; If (posicaoRandom2 = posicaoRandom1) or (posicaoRandom2 = posicaoRandom3) or (posicaoRandom2 = posicaoRandom4) then begin posicaoRandom2 := posicaoRandom2 + 1; end; If (posicaoRandom3 = posicaoRandom2) or (posicaoRandom3 = posicaoRandom1) or (posicaoRandom3 = posicaoRandom4) then begin posicaoRandom3 := posicaoRandom3 + 1; end; If (posicaoRandom4 = posicaoRandom2) or (posicaoRandom4 = posicaoRandom1) or (posicaoRandom4 = posicaoRandom3) then begin posicaoRandom4 := posicaoRandom4 + 1; end; marcaDeSeguranca1 := FormatNumeric(Random(tamanhomarcaDeSeguranca),'0000'); marcaDeSeguranca2 := FormatNumeric(Random(tamanhomarcaDeSeguranca),'0000'); marcaDeSeguranca3 := FormatNumeric(Random(tamanhomarcaDeSeguranca),'0000'); marcaDeSeguranca4 := FormatNumeric(Random(tamanhomarcaDeSeguranca),'0000'); barraSeg := ''; for i := 1 to tamanhoBarraSegurancaLooping do begin if i = posicaoRandom1 then begin composicaoBarraSeg := marcaDeSeguranca1 + ' '; end else begin if i = posicaoRandom2 then begin composicaoBarraSeg := marcaDeSeguranca2 + ' '; end else begin if i = posicaoRandom3 then begin composicaoBarraSeg := marcaDeSeguranca3 + ' '; end else begin if i = posicaoRandom4 then begin composicaoBarraSeg := marcaDeSeguranca4 + ' '; end else begin composicaoBarraSeg := marcaDaguaNome + ' '; end; end; end; end; barraSeg := barraSeg + composicaoBarraSeg; end; posicaoBarraSeg := FormatFloat(posicaoRandom1,'9')+'='+marcaDeSeguranca1+'_'+FormatFloat(posicaoRandom2,'9')+'='+marcaDeSeguranca2+'_'+FormatFloat(posicaoRandom3,'9')+'='+marcaDeSeguranca3+'_'+FormatFloat(posicaoRandom4,'9')+'='+marcaDeSeguranca4; end;
    {--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------}
//PAGE 1
	BeginPage(PAGE1);
	ClearFields(PAGE1,REC1);
    //QTDE_PARC := GetNumeric(S,1932,2);
    PAGE1.REC1.CBARRA     := barraDeControle;
    PAGE1.REC1.SBARRA     := barraDeControle;
    PAGE1.REC1.INSCRICAO  := inscricao;
    PAGE1.REC1.CADASTRO   := cadastro;
    PAGE1.REC1.NOME       := name;
    PAGE1.REC1.RUA_IMO    := rua_imovel;
    PAGE1.REC1.COMPL_IMO  := complemento_imovel;
    PAGE1.REC1.BAI_IMO    := baiiro_imovel;
    PAGE1.REC1.LOTE_IMO   := lote_imovel;
    PAGE1.REC1.END_ENT    := endereco_entrega;
    PAGE1.REC1.COMPL_ENT  := complemento_entrega;
    PAGE1.REC1.BAI_ENT    := bairro_entrega;
    PAGE1.REC1.CID_ENT    := cidade_entrega;
    PAGE1.REC1.UF_ENT     := estado_entrega;
    PAGE1.REC1.CEP_ENT    := cep_entrega;
    PAGE1.REC1.AVS          := AVISO;
    PAGE1.REC1.N_ARQUIV     := TD_nomeDoArquivo;	
    WriteRecord(PAGE1,REC1);
    EndPage(PAGE1);
    TP_numPage:=TP_numPage+1;
{
//PAGE 5
BeginPage(PAGE5);
ClearFields(PAGE5,REC1);

    PAGE5.REC1.INSCRICAO := GetString(S,5,20);
    PAGE5.REC1.CADASTRO := GetString(S,25,6);
    PAGE5.REC1.AVS          := AVISO;
    PAGE5.REC1.N_ARQUIV     := TD_nomeDoArquivo;
    WriteRecord(PAGE5,REC1);
    EndPage(PAGE5);
    TP_numPage:=TP_numPage+1;
}
//PAGE 1
BeginPage(PAGE2);
ClearFields(PAGE2,REC1);
    PAGE2.REC1.RUA_IMO    := rua_imovel;
    PAGE2.REC1.COMPL_IMO  := complemento_imovel;
    PAGE2.REC1.BAI_IMO    := baiiro_imovel;
    PAGE2.REC1.LOTE_IMO   := lote_imovel;
    PAGE2.REC1.INSCRICAO   := inscricao;
    PAGE2.REC1.CADASTRO    := cadastro;
    PAGE2.REC1.NOME        := name;
    PAGE2.REC1.AREA_TERRE  := GetString(S,429,14);
    PAGE2.REC1.VL_M2_TERR  := GetString(S,443,14);
    PAGE2.REC1.FATOR_TERR  := GetString(S,457,14);
    PAGE2.REC1.VENAL_TERR  := GetString(S,471,14);
    PAGE2.REC1.AREA_CONST  := GetString(S,485,14);
    PAGE2.REC1.VL_M2_CONS  := GetString(S,513,14);
    PAGE2.REC1.FATOR_CONS  := GetString(S,527,14);
    PAGE2.REC1.CATEG_CONS  := GetString(S,541,5);
    PAGE2.REC1.VENAL_CONS  := GetString(S,546,14);
    PAGE2.REC1.VENAL_TOTA  := GetString(S,560,14);
    PAGE2.REC1.ALIQUOTA    := GetString(S,588,14);
    PAGE2.REC1.NOMETAXA1   := GetString(S,809,20);
    PAGE2.REC1.NOMETAXA3   := GetString(S,861,20);
    PAGE2.REC1.NOMETAXA6   := GetString(S,895,20);
    PAGE2.REC1.NOMETAXA8   := GetString(S,929,20);
    //PAGE2.REC1.NOMETAXA5 := GetString(S,963,20);
    //PAGE2.REC1.NOMETAXA6 := GetString(S,997,20);
    //PAGE2.REC1.NOMETAXA7 := GetString(S,1031,20);
    //PAGE2.REC1.NOMETAXA8 := GetString(S,1065,20);
    //PAGE2.REC1.NOMETAXA9 := GetString(S,1099,20);
    //PAGE2.REC1.NOMETAXA9 := GetString(S,1133,20);
    PAGE2.REC1.VL_TAXA1    := GetString(S,847,14);
    PAGE2.REC1.VL_TAXA3    := GetString(S,881,14);
    PAGE2.REC1.VL_TAXA6    := GetString(S,915,14);
    PAGE2.REC1.VL_TAXA8    := GetString(S,949,14);
    //PAGE2.REC1.VL_TAXA5  := GetString(S,983,14);
    //PAGE2.REC1.VL_TAXA6  := GetString(S,1017,14);
    //PAGE2.REC1.VL_TAXA7  := GetString(S,1051,14);
    //PAGE2.REC1.VL_TAXA8  := GetString(S,1085,14);
    //PAGE2.REC1.VL_TAXA9  := GetString(S,1119,14);
    PAGE2.REC1.VL_TAXAS    := GetString(S,1153,14);
    PAGE2.REC1.VL_IMPOSTO  := GetString(S,847,14);
    PAGE2.REC1.VL_TAXAS    := GetString(S,1167,14);
    PAGE2.REC1.TOTAL       := GetString(S,1195,14);
    PAGE2.REC1.AVS          := AVISO;
    PAGE2.REC1.N_ARQUIV     := TD_nomeDoArquivo;
    WriteRecord(PAGE2,REC1);
    EndPage(PAGE2);
    TP_numPage:=TP_numPage+1;

//PAGE 3 UNICA
BeginPage(PAGE3);
ClearFields(PAGE3,REC1);
    PAGE3.REC1.CADASTRO   := cadastro;
    PAGE3.REC1.INSCRICAO  := inscricao;
    PAGE3.REC1.NOME       := name;
    PAGE3.REC1.PARCELA    := 'Única';
    PAGE3.REC1.ATIVIDADE  := 'COM 5% DE DESCONTO NA COTA ÚNICA E MAIS 5% PARA OS ADIMPLENTES ATÉ 31/12/2021 CONF. DECRETO N. 2.738/2022.';    
    PAGE3.REC1.VL_IMPOSTO := GetString(S,847,14);
    PAGE3.REC1.VL_TAXAS   := GetString(S,1167,14);
    PAGE3.REC1.TOTAL      := GetString(S,1195,14);
    PAGE3.REC1.NSS_NUM    := GetString(S,1209,21);
    PAGE3.REC1.VENCTO     := GetString(S,1412,10);
    PAGE3.REC1.VL_PARC    := GetString(S,1398,14);
    PAGE3.REC1.LINHA      := GetString(S,3344,55);
    PAGE3.REC1.BARRA      := GetString(S,3344,11) + GetString(S,3358,11) + GetString(S,3372,11) + GetString(S,3386,11);
    PAGE3.REC1.AVS          := AVISO;
    PAGE3.REC1.N_ARQUIV     := TD_nomeDoArquivo;
    WriteRecord(PAGE3,REC1);
    EndPage(PAGE3);
    TP_numPage:=TP_numPage+1;

//page 4 PC 01
 for i:= 0 to (qt-1) do begin
BeginPage(PAGE4);
ClearFields(PAGE4,REC1);
   j:=215;
   e:=79;
    PAGE4.REC1.CADASTRO   := cadastro;
    PAGE4.REC1.INSCRICAO  := inscricao;
    PAGE4.REC1.NOME       := name;
    PAGE4.REC1.PARCELA    := FormatNumeric((i+1),'00');
    PAGE4.REC1.ATIVIDADE  := GetString(S,703,60);    
    PAGE4.REC1.VL_IMPOSTO := GetString(S,1967+(i*j),14);
    PAGE4.REC1.VL_TAXAS   := GetString(S,2121+(i*j),14);
    PAGE4.REC1.TOTAL      := GetString(S,2135+(i*j),14);
    PAGE4.REC1.VENCTO     := GetString(S,1957+(i*j),10);
    PAGE4.REC1.VL_PARC    := GetString(S,2107+(i*j),14);
    PAGE4.REC1.LINHA      := GetString(S,3581+(i*e),55);
    PAGE4.REC1.BARRA      := GetString(S,3581+(i*e),11) + GetString(S,3595+(i*e),11) + GetString(S,3609+(i*e),11) + GetString(S,3623+(i*e),11);
    PAGE4.REC1.AVS          := AVISO;
    PAGE4.REC1.N_ARQUIV     := TD_nomeDoArquivo;
    WriteRecord(PAGE4,REC1);
    EndPage(PAGe4);
    TP_numPage:=TP_numPage+1;	
    end;
    {---Relatorio TD_registro CX ID 4.0----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------}
        If TD_relatorios <> 0 then begin If TD_relatorios = 1 then begin totalNumeroPagina:=0; totalNumeroPagina:=TD_paginaExtra+TP_numPage; quantidadePorLote:= FloatToInt((Ceil(((TD_folhasPorCaixa/(totalNumeroPagina))))*TD_qtdPorFolha)*TD_tipoImpresso); if (numeroDeCliente mod quantidadePorLote) = 0 then begin numeroDoLote :=numeroDoLote+1; end; TD_conteudoRegistro:=FormatFloat(numeroDoLote,'9')+';'+barraDeControle+';'+TD_idArquivo+';'+TD_idExtra+';'+FormatNumeric(TP_aviso,'000.000')+';'+TD_idNumeroBanco+';'+TD_idCodigoBanco+';'+posicaoBarraSeg;    WritelnFileLog(TD_registro,TD_conteudoRegistro); numeroDeCliente:=numeroDeCliente+1; TP_aviso:=numeroDeCliente+1; end; end;
    {--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------}
markup;
end;
end;
{---Ordenacaoo por profundidade 6.0  & Relatorio - Resumo Prefeitura-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------}
if TP_numPage = 0 then begin abort('NUMERO DE PARCELAS INVALIDO OU NÃO ENCONTRADO!') end else begin totalNumeroPaginaOrdenacao := TD_paginaExtra+TP_numPage; impressoPorCaixa :=0; impressoPorCaixa := FloatToInt((Ceil(((TD_folhasPorCaixa/(totalNumeroPaginaOrdenacao))))*TD_qtdPorFolha)*TD_tipoImpresso);
Convert(TD_qtdPorFolha,true,false,false,impressoPorCaixa,false); end; If TD_relatorios<> 0 then begin if TD_relatorios= 1 then begin If TD_tipoImpresso = 2 then begin impressoFrenteVerso:='(Impresso frente e verso)'; end else begin impressoFrenteVerso:=''; end; TD_conteudoResumo:=''; WritelnFileLog(TD_resumo, TD_conteudoResumo); TD_conteudoResumo:='- Informacao Geral'; WritelnFileLog(TD_resumo, TD_conteudoResumo); TD_conteudoResumo:='Data e Hora do ODA         '+FormatDate(SYS_DATE,'DD/MM/AAAA')+' '+SubStr(StrNumeric(FormatTime(SYS_TIME,'HH:MM'),4),1,2)+':'+SubStr(StrNumeric(FormatTime(SYS_TIME,'HH:MM'),4),3,2); WritelnFileLog(TD_resumo, TD_conteudoResumo); TD_conteudoResumo:='Numero de paginas:         '+FormatFloat(totalNumeroPaginaOrdenacao,'9'); WritelnFileLog(TD_resumo, TD_conteudoResumo); TD_conteudoResumo:='Numero de Impresso p/ fls: '+FormatFloat(TD_qtdPorFolha,'9')+' '+impressoFrenteVerso; WritelnFileLog(TD_resumo, TD_conteudoResumo); TD_conteudoResumo:='Numero de Registro:        '+FormatFloat(numeroDeCliente,'9'); WritelnFileLog(TD_resumo, TD_conteudoResumo); TD_conteudoResumo:=''; WritelnFileLog(TD_resumo, TD_conteudoResumo); TD_conteudoResumo:='- Informacao do Lote'; WritelnFileLog(TD_resumo, TD_conteudoResumo); TD_conteudoResumo:='Numero de Caixas:          '+FormatFloat(Ceil(numeroDeCliente/impressoPorCaixa),'9'); WritelnFileLog(TD_resumo, TD_conteudoResumo); TD_conteudoResumo:='Impressos p/ Caixa:        '+FormatFloat(impressoPorCaixa,'9'); WritelnFileLog(TD_resumo, TD_conteudoResumo); TD_conteudoResumo:='Numero de Fls p/ Caixa:    '+FormatFloat((((totalNumeroPaginaOrdenacao-TD_paginaExtra)*impressoPorCaixa)/TD_qtdPorFolha)/TD_tipoImpresso,'9'); WritelnFileLog(TD_resumo, TD_conteudoResumo); TD_conteudoResumo:=''; WritelnFileLog(TD_resumo, TD_conteudoResumo); TD_conteudoResumo:='- Informacao Extras'; WritelnFileLog(TD_resumo, TD_conteudoResumo); TD_conteudoResumo:='Nome do arquivo:          '+TD_nomeDoArquivo; WritelnFileLog(TD_resumo, TD_conteudoResumo); if TD_idNumeroBanco <> '' then begin TD_conteudoResumo:='Referencia do bando:      '+TD_idNumeroBanco; WritelnFileLog(TD_resumo, TD_conteudoResumo); end; if TD_idCodigoBanco <> '' then begin TD_conteudoResumo:='Referencia do Cliente:    '+TD_idCodigoBanco; WritelnFileLog(TD_resumo, TD_conteudoResumo); end; if posicaoBarraSeg <> '' then begin TD_conteudoResumo:='Referencia Barra Segurança:'+posicaoBarraSeg; WritelnFileLog(TD_resumo, TD_conteudoResumo); end; CloseFileLog(TD_resumo); If (TD_relatorios= 1) then begin WritelnFileLog(TD_registro,'*'); CloseFileLog(TD_registro); end; end; end;
{------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------}
