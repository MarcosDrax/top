// +-----------------------------------------+
// | Desenvolvedor: MARCOS                   |
// | Atualização:  18/01/2023                |
// | Programa:  PREFEITURA ITANHAEM          |
// +-----------------------------------------+ 
{---SB MultLine 5.0 / BARRA_TP_aviso 1.0 -----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------char3500} TD_plugin:=0;  x:=0; for i := 0 to 99 do begin  if substr(RetornaNomeArqEntrada(0),i,1) <> '.' then begin  x:= x+1; end else begin break; end; end; TD_nomeDoArquivo := substr(RetornaNomeArqEntrada(0),1,x-1); fls_cx:= 0; n_arq:='';
{----Pré-Configurações---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------}


{---Configurações--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------}
    TD_cliente                    := 'P.M. ITANHAEM'; //Nome parcialmente completo
    TD_tipoImpresso               := 2;      // 1 = Carnes | 2 = Carta/Boletos |
    TD_qtdPorFolha                := 2;      //Quantidade de impresso por folha
    TD_paginaExtra                := 0;      //Quantidade de paginas nao inclusa no visual (contra-capa/encarte/etc)
    TD_folhasPorCaixa             := 1000;   //Quantidade de Folhar por caixa (carnes = 1500 caixa grande / 500 caixa pequena| Envelope 1000 A4 Caixa grande)
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
While ReadLn(S) <> EOF do Begin

      AVISO      := FormatNumeric(TP_aviso,'000.000'); //Aviso gerado pelo script, convertido p String.
      PARC       := GetNumeric(S,32,0);
      NOME       := TrimStr(GetString(S,1,0));
	  FUNCAO     := GetString(S,4,0);
	  END_ENTR1  := GetString(S,16,0) +' '+ Getstring(S,18,0);
      END_ENTR2  := 'CEP: '+FormatNumeric(GetNumeric(S,19,0),'00000-000')+' '+GetString(S,17,0) +' - '+GetString(S,20,0);
	  COMPETENC  := GetString(S,7,0);
	  REGISTRO   := GetString(S,3,0)

//Lista de teste fornecido pelo cliente	  
ListaNome := '|000295|002001|000651|000418|003003|003005|000706|000779|000575|000125|000625|000899|000576|000024|000772|000766|000966|002007|001026|003051|000613|000688|000574|008593|000164|000588|000294|000409|000620|000589|000832|000103|000539|000907|000126|000916|000213|000673|008616|001051|000782|008671|000489|008673|000515|000591|000763|000099|000700|000598|001866|000903|000645|001867|000811|008667|008637|000474|001045|003084|000363|000555|001096|000867|000600|000807|003040|000827|000798|';

If TESTE = 1 then begin
  If Pos(REGISTRO,ListaNome) <> 0 then Begin
    next:=1;
    end else begin
    next:=0;
    end;
    end else begin
If Pos(REGISTRO,ListaNome) <> 0 then Begin
    next:=0;
    end else begin
    next:=1;
    end;
end;
IF NEXT = 1 THEN BEGIN


         {---Variaveis comuns Fim---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------}  
         {---Configurações Referencia do contribuinte no Registro | Barra de TD_registro 3.0 ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------}
             TD_idArquivo        := GetString(S,1,5);    //Identificação do arquivo maximo ate 12 numeros
             TD_idNumeroBanco    := GetString(S,0,0);    //Referencia do Banco
             TD_idCodigoBanco    := GetString(S,0,0);    //Referencia do contribuinte para com o banco (ex: nossonumero)
           //TD_idExtra          := GetString(S,,);   //Identificação extra 
         {--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------}  
         {--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------}  
         barraDeControle:=''; ctbs:= '0'; ctbi:= '0'; ctbf:= '0'; ctbn:= '0'; ctb := '99'; if ctb = '99' then begin ctbs := '1'; end; ctb2:=random(999)+1; if ctb2 >= 1 then begin ctbi:='1'; end; ctb3:=IntToFloat(random(999))+1.1; if ctb3 >= 1.1 then begin ctbf:='1'; end; ctb4:=IntToNumeric(random(999))+1.0; if ctb4 >= 1.0 then begin ctbn:='1'; end; barraDeControle:=ctbs+ctbi+ctbf+ctbn+StrNumeric(TD_idArquivo,12); barraDeControle := barraDeControle; TP_numPage:=0; if TD_seguranca = 1 then begin maximoRandom := tamanhoBarraSegurancaRandom; posicaoRandom1 := Random(maximoRandom); if posicaoRandom1 = 0 then begin posicaoRandom1:= 1; end; posicaoRandom2 := Random(maximoRandom); if posicaoRandom2 = 0 then begin posicaoRandom2:= 1; end; posicaoRandom3 := Random(maximoRandom); if posicaoRandom3 = 0 then begin posicaoRandom3:= 1; end; posicaoRandom4 := Random(maximoRandom); if posicaoRandom4 = 0 then begin posicaoRandom4:= 1; end; If (posicaoRandom1 = posicaoRandom2) or (posicaoRandom1 = posicaoRandom3) or (posicaoRandom1 = posicaoRandom4) then begin posicaoRandom1 := posicaoRandom1 + 1; end; If (posicaoRandom2 = posicaoRandom1) or (posicaoRandom2 = posicaoRandom3) or (posicaoRandom2 = posicaoRandom4) then begin posicaoRandom2 := posicaoRandom2 + 1; end; If (posicaoRandom3 = posicaoRandom2) or (posicaoRandom3 = posicaoRandom1) or (posicaoRandom3 = posicaoRandom4) then begin posicaoRandom3 := posicaoRandom3 + 1; end; If (posicaoRandom4 = posicaoRandom2) or (posicaoRandom4 = posicaoRandom1) or (posicaoRandom4 = posicaoRandom3) then begin posicaoRandom4 := posicaoRandom4 + 1; end; marcaDeSeguranca1 := FormatNumeric(Random(tamanhomarcaDeSeguranca),'0000'); marcaDeSeguranca2 := FormatNumeric(Random(tamanhomarcaDeSeguranca),'0000'); marcaDeSeguranca3 := FormatNumeric(Random(tamanhomarcaDeSeguranca),'0000'); marcaDeSeguranca4 := FormatNumeric(Random(tamanhomarcaDeSeguranca),'0000'); barraSeg := ''; for i := 1 to tamanhoBarraSegurancaLooping do begin if i = posicaoRandom1 then begin composicaoBarraSeg := marcaDeSeguranca1 + ' '; end else begin if i = posicaoRandom2 then begin composicaoBarraSeg := marcaDeSeguranca2 + ' '; end else begin if i = posicaoRandom3 then begin composicaoBarraSeg := marcaDeSeguranca3 + ' '; end else begin if i = posicaoRandom4 then begin composicaoBarraSeg := marcaDeSeguranca4 + ' '; end else begin composicaoBarraSeg := marcaDaguaNome + ' '; end; end; end; end; barraSeg := barraSeg + composicaoBarraSeg; end; posicaoBarraSeg := FormatFloat(posicaoRandom1,'9')+'='+marcaDeSeguranca1+'_'+FormatFloat(posicaoRandom2,'9')+'='+marcaDeSeguranca2+'_'+FormatFloat(posicaoRandom3,'9')+'='+marcaDeSeguranca3+'_'+FormatFloat(posicaoRandom4,'9')+'='+marcaDeSeguranca4; end;
         {--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------}

// PAGE1
BeginPage(PAGE1); 
ClearFields(PAGE1,REC1); 
   PAGE1.REC1.NOME := NOME;
   PAGE1.REC1.FUNCAO := FUNCAO;
   PAGE1.REC1.END[1] := END_ENTR1
   PAGE1.REC1.END[2] := END_ENTR2;
   PAGE1.REC1.COMPETENC  := COMPETENC;
   PAGE1.REC1.AVS:=AVISO;
   PAGE1.REC1.N_ARQUIV:=TD_nomeDoArquivo;	
WriteRecord(PAGE1,REC1);
EndPage(PAGE1);
TP_numPage:=TP_numPage+1;

// PAGE1
BeginPage(PAGE2); 
ClearFields(PAGE2,REC1); 
   PAGE2.REC1.NOME       := NOME;
   PAGE2.REC1.SALBASE    := GetString(S,2,0);
   PAGE2.REC1.REGISTRO   := REGISTRO;
   PAGE2.REC1.FUNCAO     := FUNCAO;
   PAGE2.REC1.ADMISSAO   := GetString(S,5,0);
   PAGE2.REC1.COMPETENC  := GetString(S,7,0);
   PAGE2.REC1.VENCBASE   := GetString(S,8,0);
   PAGE2.REC1.DEPIRRF    := GetString(S,9,0);
   PAGE2.REC1.DEPSF      := GetString(S,10,0);
   PAGE2.REC1.BANCO      := GetString(S,11,0);
   PAGE2.REC1.AGENCIA    := GetString(S,12,0);
   PAGE2.REC1.CONTA      := GetString(S,13,0);
   PAGE2.REC1.LOCAL      := GetString(S,14,0);
   PAGE2.REC1.FUNCEXE    := GetString(S,15,0);
for i := 0 to 19 do begin

PAGE2.REC1.VERBA[i+1]    := FormatNumeric(Getnumeric(S,21+(i*4),0),'########');
PAGE2.REC1.HISTORICO[i+1]:= TrimStr(GetString(S,22+(i*4),0));
PAGE2.REC1.DIA[i+1]      := GetString(S,23+(i*4),0);
PAGE2.REC1.VENC[i+1]     := FormatFloat(Getfloat(S,24+(i*4),0),'#.###,##');
PAGE2.REC1.DESCONTOS[i+1]:= FormatFloat(Getfloat(S,25+(i*4),0),'#.###,##');
end;

   PAGE2.REC1.BASEIRRF   := GetString(S,121,0);
   PAGE2.REC1.TOTVENC    := GetString(S,122,0);
   PAGE2.REC1.TOTDESC    := GetString(S,123,0);
   PAGE2.REC1.BASEFGTS   := GetString(S,124,0);
   PAGE2.REC1.VALORFGTS  := GetString(S,125,0);
   PAGE2.REC1.LIQUIDO    := GetString(S,126,0);
   PAGE2.REC1.MENSAGEM1  := GetString(S,127,0);
   PAGE2.REC1.MENSAGEM2  := GetString(S,128,0);
   PAGE2.REC1.SEQUENCIA  := GetString(S,129,0);
   PAGE2.REC1.COMPCESTA  := GetString(S,130,0);
   PAGE2.REC1.SERVIDOR   := GetString(S,131,0);
   PAGE2.REC1.AVS:=AVISO;
   PAGE2.REC1.N_ARQUIV:=TD_nomeDoArquivo;
    WriteRecord(PAGE2,REC1);
    EndPage(PAGE2);
    TP_numPage:=TP_numPage+1;

{---Relatorio TD_registro CX ID 4.0----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------}
	If TD_relatorios <> 0 then begin If TD_relatorios = 1 then begin totalNumeroPagina:=0; totalNumeroPagina:=TD_paginaExtra+TP_numPage; quantidadePorLote:= FloatToInt((Ceil(((TD_folhasPorCaixa/(totalNumeroPagina))))*TD_qtdPorFolha)*TD_tipoImpresso); if (numeroDeCliente mod quantidadePorLote) = 0 then begin numeroDoLote :=numeroDoLote+1; end; TD_conteudoRegistro:=FormatFloat(numeroDoLote,'9')+';'+barraDeControle+';'+TD_idArquivo+';'+TD_idExtra+';'+FormatNumeric(TP_aviso,'000.000')+';'+TD_idNumeroBanco+';'+TD_idCodigoBanco+';'+posicaoBarraSeg;	WritelnFileLog(TD_registro,TD_conteudoRegistro); numeroDeCliente:=numeroDeCliente+1; TP_aviso:=numeroDeCliente+1; end; end;
{--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------}
markup;	
end;
end;
{---Ordenacaoo por profundidade 6.0  & Relatorio - Resumo Prefeitura-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------}
if TP_numPage = 0 then begin abort('NUMERO DE PARCELAS INVALIDO OU NÃO ENCONTRADO!') end else begin totalNumeroPaginaOrdenacao := TD_paginaExtra+TP_numPage; impressoPorCaixa :=0; impressoPorCaixa := FloatToInt((Ceil(((TD_folhasPorCaixa/(totalNumeroPaginaOrdenacao))))*TD_qtdPorFolha)*TD_tipoImpresso);
Convert(TD_qtdPorFolha,true,false,false,impressoPorCaixa,false); end; If TD_relatorios<> 0 then begin if TD_relatorios= 1 then begin If TD_tipoImpresso = 2 then begin impressoFrenteVerso:='(Impresso frente e verso)'; end else begin impressoFrenteVerso:=''; end; TD_conteudoResumo:=''; WritelnFileLog(TD_resumo, TD_conteudoResumo); TD_conteudoResumo:='- Informacao Geral'; WritelnFileLog(TD_resumo, TD_conteudoResumo); TD_conteudoResumo:='Data e Hora do ODA         '+FormatDate(SYS_DATE,'DD/MM/AAAA')+' '+SubStr(StrNumeric(FormatTime(SYS_TIME,'HH:MM'),4),1,2)+':'+SubStr(StrNumeric(FormatTime(SYS_TIME,'HH:MM'),4),3,2); WritelnFileLog(TD_resumo, TD_conteudoResumo); TD_conteudoResumo:='Numero de paginas:         '+FormatFloat(totalNumeroPaginaOrdenacao,'9'); WritelnFileLog(TD_resumo, TD_conteudoResumo); TD_conteudoResumo:='Numero de Impresso p/ fls: '+FormatFloat(TD_qtdPorFolha,'9')+' '+impressoFrenteVerso; WritelnFileLog(TD_resumo, TD_conteudoResumo); TD_conteudoResumo:='Numero de Registro:        '+FormatFloat(numeroDeCliente,'9'); WritelnFileLog(TD_resumo, TD_conteudoResumo); TD_conteudoResumo:=''; WritelnFileLog(TD_resumo, TD_conteudoResumo); TD_conteudoResumo:='- Informacao do Lote'; WritelnFileLog(TD_resumo, TD_conteudoResumo); TD_conteudoResumo:='Numero de Caixas:          '+FormatFloat(Ceil(numeroDeCliente/impressoPorCaixa),'9'); WritelnFileLog(TD_resumo, TD_conteudoResumo); TD_conteudoResumo:='Impressos p/ Caixa:        '+FormatFloat(impressoPorCaixa,'9'); WritelnFileLog(TD_resumo, TD_conteudoResumo); TD_conteudoResumo:='Numero de Fls p/ Caixa:    '+FormatFloat((((totalNumeroPaginaOrdenacao-TD_paginaExtra)*impressoPorCaixa)/TD_qtdPorFolha)/TD_tipoImpresso,'9'); WritelnFileLog(TD_resumo, TD_conteudoResumo); TD_conteudoResumo:=''; WritelnFileLog(TD_resumo, TD_conteudoResumo); TD_conteudoResumo:='- Informacao Extras'; WritelnFileLog(TD_resumo, TD_conteudoResumo); TD_conteudoResumo:='Nome do arquivo:          '+TD_nomeDoArquivo; WritelnFileLog(TD_resumo, TD_conteudoResumo); if TD_idNumeroBanco <> '' then begin TD_conteudoResumo:='Referencia do bando:      '+TD_idNumeroBanco; WritelnFileLog(TD_resumo, TD_conteudoResumo); end; if TD_idCodigoBanco <> '' then begin TD_conteudoResumo:='Referencia do Cliente:    '+TD_idCodigoBanco; WritelnFileLog(TD_resumo, TD_conteudoResumo); end; if posicaoBarraSeg <> '' then begin TD_conteudoResumo:='Referencia Barra Segurança:'+posicaoBarraSeg; WritelnFileLog(TD_resumo, TD_conteudoResumo); end; CloseFileLog(TD_resumo); If (TD_relatorios= 1) then begin WritelnFileLog(TD_registro,'*'); CloseFileLog(TD_registro); end; end; end;
{------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------}
